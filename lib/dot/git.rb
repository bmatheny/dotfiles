require 'dot/command/runner'

module Dot; module Git
  # Execute a git command
  def self.git cfg, cmd, force = false
    Dot::Command::Runner.run(cfg, "#{cfg.gitcmd} #{cmd}", force)
  end
end; end # module Dot; module Git
