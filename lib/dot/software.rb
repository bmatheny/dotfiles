require 'dot'
require 'dot/command/runner'

module Dot
  module Software
    def self.install_homebrew? cfg
      !Dot::Command::Runner.run(cfg, 'which brew', true).success?
    end
    def self.install_homebrew! cfg
      cmd = 'ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)'
      Dot::Command::Runner.run(cfg, cmd)
    end # def self.install_homebrew!

    def self.homebrew_package_installed? cfg, package
      cmd = "brew ls --versions #{package}"
      res = Dot::Command::Runner.run(cfg, cmd)
      res.success? and !res.sos.empty?
    end

    def self.upgrade_homebrew_package! cfg, package
      cmd = "brew upgrade #{package}"
      cfg.logger.info "brew_upgrade(#{package})"
      Dot::Command::Runner.run(cfg, cmd)
    end

    def self.install_homebrew_package! cfg, package
      cmd = "brew install #{package}"
      cfg.logger.info "brew_install(#{package})"
      Dot::Command::Runner.run(cfg, cmd)
    end

    def self.install_homebrew_packages! cfg, packages
      packages.each do |pkg|
        if homebrew_package_installed? cfg, pkg then
          upgrade_homebrew_package! cfg, pkg
        else
          install_homebrew_package! cfg, pkg
        end
      end
      cmd = "brew install #{packages.join(' ')}"
      Dot::Command::Runner.run(cfg, cmd)
    end
    def self.update_homebrew! cfg
      Dot::Command::Runner.run(cfg, 'brew update')
    end
  end
end
