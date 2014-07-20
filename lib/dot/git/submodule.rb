require 'dot/git'

module Dot; module Git

  class Submodule

    def self.create_from_hash cfg, name, params = {}
      # FIXME handle case where path or url is missing or to_bool throws an exception
      recurse = params.fetch('fetchRecurseSubmodules', 'false')
      submod = Dot::Git::Submodule.new(cfg, name, params["path"], params["url"],
        params.fetch("update", "checkout"),
        params.fetch("branch", "master"),
        Dot.to_bool(recurse),
        params.fetch("ignore", "none"))
      begin
        submod.configure_branch
        submod
      rescue IOError => e
        msg = "Dot::Git::Submodule.create_from_hash: module #{name} does not exist, ignoring it"
        cfg.logger.warn msg
        nil
      end # rescue
    end

    attr_accessor :cfg, :name, :path, :url, :update, :branch, :fetch_recursive, :ignore
    def initialize cfg, name, path, url, update, branch, fetch_recursive, ignore
      @cfg = cfg
      @name = name
      @path = path
      @url = url
      @update = update
      @branch = branch
      @fetch_recursive = fetch_recursive
      @ignore = ignore
    end

    # Should optionally be called once after object initialization
    def configure_branch
      return if branch != 'master' and not branch.empty?
      begin
        in_submodule do
          result = Dot::Git.git cfg, 'rev-parse --abbrev-ref HEAD', true
          if result.sos != 'HEAD' then
            @branch = result.sos
          end
        end # in_submodule
      rescue IOError => e
        raise e
      rescue StandardError => e
        cfg.logger.warn e
      end
      if @branch.empty? then
        @branch = 'master'
      end
    end

    # Do something from in the module directory
    def in_submodule &block
      unless File.exists?(module_path) then
        raise IOError.new("Submodule '#{self}' with path '#{module_path}' does not exist")
      end
      begin
        Dir.chdir module_path
        block.call
      ensure
        Dir.chdir cfg.root
      end
    end

    def checkout_pull
      in_submodule do
        Dot::Git.git cfg, "checkout -q #{branch}"
        Dot::Git.git cfg, "pull -q origin #{branch}"
      end
    end

    def fetch_recursive?
      fetch_recursive
    end

    def module_path
      File.join(cfg.root, path)
    end

    def needs_init?
      not File.exists?(File.join(path, ".git"))
    end

    def to_s
      "Git::Submodule(name='#{name}', path='#{path}', url='#{url}', update='#{update}', branch='#{branch}', fetch_recursive=#{fetch_recursive?}, ignore='#{ignore}')"
    end

  end # class Submodule

end; end # module Dot; module Git
