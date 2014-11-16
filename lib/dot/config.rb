require 'logger'
require 'ostruct'
require 'yaml'

require 'dot/file'

module Dot
  class Config
    def self.instance
      @instance
    end
    def self.instance=(i)
      @instance = i
    end
    def self.create_from_hash hash, verbose = false
      debug = hash.fetch('DOT_DEBUG', 'false')
      gitcmd = hash.fetch('DOT_GITCMD', 'git')
      root = hash.fetch('DOT_ROOT', Dir.pwd)
      nogit = hash.fetch('DOT_NOGIT', 'false')
      Dot::Config.new verbose, debug, gitcmd, root, nogit
    end

    attr_accessor :debug, :gitcmd, :logger, :nogit, :root
    def initialize verbose=false, debug=false, gitcmd='git', root=Dir.pwd, nogit=true
      @debug = Dot.to_bool(debug)
      @gitcmd = gitcmd
      @info = OpenStruct.new
      @logger = Logger.new(STDOUT)
      if verbose then
        @logger.level = Logger::DEBUG
      else
        @logger.level = Logger::INFO
      end
      @root = root
      @nogit = Dot.to_bool(nogit)
    end
    def debug?
      debug
    end
    def nogit?
      nogit
    end

    def create_dirs
      @info[:create_dirs]
    end
    def gems
      @info[:gems]
    end
    def homebrew_packages
      @info[:homebrew_packages]
    end
    def merged_configs
      @info[:merged_configs]
    end
    def simple_symlinks
      @info[:simple_symlinks]
    end
    def zsh_symlinks
      @info[:zsh_symlinks]
    end
    def subdir_symlinks
      @info[:subdir_symlinks]
    end

    def populate_info_from_yaml file_name
      yaml = get_yaml file_name
      @info[:create_dirs] = yaml[:create_dirs]
      @info[:gems] = yaml[:gems] || []
      @info[:homebrew_packages] = yaml[:homebrew_packages]
      @info[:simple_symlinks] = yaml[:simple_symlinks]
      @info[:zsh_symlinks] = yaml[:zsh_symlinks]
      @info[:subdir_symlinks] = yaml[:subdir_symlinks].map do |d|
        Dir.glob("#{d}/*")
      end.flatten
      [:simple_symlinks, :zsh_symlinks, :subdir_symlinks].each do |s|
        @info[s].map!{|f| Dot::FileOperation.new(self, f, f)}
      end
      @info[:merged_configs] = yaml[:merged_configs].map do |n, v|
        Dot::FileMergeOperation.new(v[:dst], v[:sys_src], v[:usr_src])
      end
    end

    def get_yaml file_name
      f1 = File.join(root, file_name)
      f2 = File.join(File.dirname(__FILE__), '..', '..', file_name)
      if File.exists?(f1) then
        logger.debug "Populating configs from #{f1}"
        YAML.load_file(f1)
      elsif File.exists?(f2) then
        logger.debug "Populating configs from #{f2}"
        YAML.load_file(f2)
      else
        raise ArgumentError.new("No config file with name #{file_name} found at #{f1} or #{f2}")
      end
    end
  end # class Config

end # module Dot
