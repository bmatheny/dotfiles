require 'rake'
require 'pathname'
require 'pp'
require 'tempfile'

require File.join(File.dirname(__FILE__), 'lib', 'dot.rb')

config = Dot::Config.create_from_hash ENV, Rake.verbose == true
config.populate_info_from_yaml 'config.yaml'
Dot::Config.instance = config

desc "Synchronize dotfiles with $HOME"
task :setup => ['files:mkdirs', 'git:submodule:update', 'install:prereq'] do
  print_banner "Setup"

  # Install homebrew (osx only) - done in install:prereq
  # Install rbenv (different for osx vs linux) - done in install:prereq
  files_install config.simple_symlinks
  files_install config.subdir_symlinks
  file_merge config.merged_configs
  # Configure rbenv
  # Configure gem
  # Install fonts (osx only)
  # Install vim (different for osx vs linux)
  # Setup zsh
  Rake::Task['setup_zsh'].execute

  # Install gems
  Rake::Task['install:gems'].execute
end

task :setup_zsh do
  print_banner "zsh setup"

  # Should install or change shell maybe

  # Install zprezto runcom files (copies)
  fpath = File.join('.zprezto', 'runcoms', 'z*')
  files = Dir.glob(fpath).reject do |f|
    file = f.split('/').last
    %w{zshrc zpreztorc}.include?(file)
  end.map do |f|
    dir, base = File.split(f)
    base = ".#{base}"
    Dot::FileOperation.new(config, f, base)
  end
  files_install files, :copy

  # Install zsh files
  files_install config.zsh_symlinks
end

namespace :install do
  desc "Install/Update gems"
  task :gems do
    print_banner "Installing gems"
    config.gems.each do |gem|
      system("gem install #{gem}")
    end
  end

  desc "Install pre-requisite software"
  task :prereq do
    if Dot.is_darwin? then
      if Dot::Software.install_homebrew? config then
        print_banner "Installing Homebrew"
        Dot::Software.install_homebrew! config
      else
        config.logger.debug "Homebrew already installed"
      end

      # FIXME need to update path
      print_banner "Updating Homebrew"
      Dot::Software.update_homebrew! config

      print_banner "Installing/Updating Homebrew Packages"
      Dot::Software.install_homebrew_packages! config, config.homebrew_packages
    end
  end
end

namespace :files do
  task :mkdirs do
    dirs = config.create_dirs.map do |dir|
      File.expand_path(dir)
    end.reject do |dir|
      File.exists?(dir)
    end
    if dirs.size > 0 then
      print_banner "Creating required directories"
    end
    dirs.each do |dir|
      config.logger.info "files:mkdirs creating directory #{dir}"
      Dir.mkdir(dir)
    end
  end
end

namespace :git do
  namespace :submodule do
    submodules = nil
    desc "Update and optionally initialize submodules"
    task :update do
      unless config.nogit? then
        print_banner "Updating submodules"
        submodules ||= Dot::Git::Submodules.from_config config
        submodules.update
      end
    end

    desc "Checkout/pull on all submodules"
    task :pull => ['git:submodule:update'] do
      unless config.nogit? then
        print_banner "Checkout/pull on all submodules"
        submodules ||= Dot::Git::Submodules.from_config config
        submodules.pull
      end
    end
  end
end

task :default do
  puts "Available tasks:"
  puts ""
  begin
    Dir.chdir File.dirname(File.absolute_path(__FILE__))
    Kernel.system('rake -sT')
  ensure
    Dir.chdir config.root
  end
  puts ""
  puts "Hint: 'rake setup' is probably what you want"
  puts ""
  puts "Available options:"
  puts "  DOT_GITCMD=cmd - DOT_GITCMD='wrapper.sh git' to specify how to run git"
  puts "  DOT_DEBUG=bool - DOT_DEBUG=[true|false] if true don't execute commands"
  puts "  DOT_NOGIT=bool - DOT_NOGIT=[true|false] perform no git operations"
  puts "e.g. rake setup DOT_DEBUG=true"
end

def file_install file, method = :symlink
  files_install [file], method
end

def files_install files, method = :symlink
  config = Dot::Config.instance
  files.each do |f|
    config.logger.info "#{method}(from=#{f.src}, to=#{f.dst})"

    f.clean! method
    f.copy_or_link! method
  end # files.each
end # file_install

def file_merge files
  files.each do |merger|
    merger.with_file(Dot::Config.instance) do |file|
      file_install file, :copy
    end
  end
end # file_merge

def print_banner name
  cfg = Dot::Config.instance
  hd_ft = "=" * 80
  cfg.logger.info hd_ft
  cfg.logger.info "== #{name.center(74)} =="
  cfg.logger.info hd_ft
end
