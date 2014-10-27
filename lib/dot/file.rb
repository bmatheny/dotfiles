require 'fileutils'
require 'pathname'
require 'tempfile'

require 'dot/config'
require 'dot/command/runner'

module Dot

  class FileOperation
    attr_accessor :options
    def initialize cfg, src, dest, options = {}
      @cfg = cfg
      @src = src
      @dst = dest
      @options = options
      @options[:dst_relative] = options.fetch(:dst_relative, true)
      @options[:src_relative] = options.fetch(:src_relative, true)
      @options[:src_base] = options.fetch(:src_base, Dir.pwd)
      @options[:dst_base] = options.fetch(:dst_base, File.expand_path('~'))
    end

    def clean! method
      return unless exists_or_broken_symlink?(dst)
      # If already a symlink, but not linked to us
      # Or, it's a symlink and shouldn't be
      unlink_dst_if_needed method
      rename_dst_if_needed method
    end # clean!

    def copy_or_link! method
      if method == :symlink then
        msg = "File.symlink(#{src}, #{dst})"
        Dot::Command::Runner.file_guard(@cfg, msg) do
          if not File.exists?(src) then
            raise ArgumentError.new("src file #{src} does not exist")
          end
          if not File.exists?(dst) then
            File.symlink(src, dst)
          end
        end
      else
        msg = "FileUtils.cp(#{src}, #{dst})"
        Dot::Command::Runner.file_guard(@cfg, msg) do
          FileUtils.cp(src, dst)
        end
      end
    end # copy_or_link!

    def dst
      return @dst if dst_is_absolute?
      File.join(@options[:dst_base], @dst)
    end
    def dst_is_absolute?
      !@options[:dst_relative]
    end
    def dst_is_absolute!
      @options[:dst_relative] = false
      self
    end

    def src
      return @src if src_is_absolute?
      File.join(@options[:src_base], @src)
    end
    def src_is_absolute?
      !@options[:src_relative]
    end
    def src_is_absolute!
      @options[:src_relative] = false
      self
    end

    protected
    def unlink_dst_if_needed method
      # No need to unlink dst if it doesn't exist
      return unless exists_or_broken_symlink?(dst)
      # If dst exists but is not a symlink we should rename it, not unlink it
      return unless symlink?(dst)
      # If dst is a symlink and already points to src, there's nothing to do
      return if (File.identical?(src, dst) && method == :symlink)

      begin
        lnk = Pathname.new(File.expand_path(dst)).realdirpath.to_s
      rescue Exception
        lnk = Pathname.new(File.expand_path(dst)).to_s
      end
      msg = "[UNLINK] #{dst} is symlink to #{lnk} "
      if method == :copy then
        msg += "but should be a copy. Unlinking."
      else
        msg += "not #{src}. Unlinking."
      end
      Dot::Command::Runner.file_guard(@cfg, msg, true) do
        File.unlink(dst)
      end
    end # unlink_dst_if_needed

    def rename_dst_if_needed method
      # Nothing to do if dst doesn't exist
      return if !File.exists?(dst)
      # We unlink symlink dst, not rename. see #unlink_dst_if_needed
      return if File.symlink?(dst)

      new_name = "#{dst}.bak"
      msg = "[MOVE] #{dst} is not a symlink, moving it to #{new_name}."
      Dot::Command::Runner.file_guard(@cfg, msg, true) do
        File.rename(dst, new_name)
      end
    end # rename_dst_if_needed

    def exists_or_broken_symlink? file
      p = Pathname.new(File.expand_path(file))
      p.exist? or p.symlink?
    end

    def symlink? file
      Pathname.new(File.expand_path(file)).symlink?
    end

  end # class FileOperation

  class FileMergeOperation
    def initialize dst, src, usrc, options = {}
      @dst = dst
      @src = src
      @tmp = nil
      @user_src = usrc
      @content = nil
    end

    def cleanup!
      return if @tmp.nil?
      @tmp.unlink
    end

    def with_file cfg, &block
      content = merge! cfg
      @tmp.unlink unless @tmp.nil?
      @tmp = Tempfile.new('dot')
      @tmp.write(content)
      @tmp.close
      begin
        file = Dot::FileOperation.new(cfg, @tmp.path, @dst)
        file.src_is_absolute!
        block.call(file)
      ensure
        @tmp.unlink
      end
    end # get_file

    protected
    def merge! cfg
      if @content.nil? then
        @content = ''
        # Generates a content string from:
        # ~/src/dotfiles/.original
        # ~/.original.private
        # ~/src/dotfiles/.original.private
        @content << read_file(cfg, cfg.root, @src)
        @content << read_file(cfg, File.expand_path('~'), @user_src)
        @content << read_file(cfg, cfg.root, @user_src)
      end
      @content
    end # merge!

    def read_file cfg, dir, file
      ffile = File.join(dir, file)
      if not File.exists?(ffile) then
        ''
      else
        File.read(ffile)
      end
    end
  end # class FileMergeOperation

end # module Dot
