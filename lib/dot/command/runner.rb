require 'open3'
require 'dot/command/result'

module Dot; module Command
  class Runner
    # Run cmd using the specified Dot::Config
    def self.run cfg, cmd, force = false
      will_run = force || !cfg.debug?
      exec_info = will_run ? "executing command" : "not executing, DEBUG=true"
      if not will_run then
        result = Dot::Command::Result.new "", exec_info, 1
      else
        stdout, stderr, status = Open3.capture3(cmd)
        result = Dot::Command::Result.new stdout, stderr, status.exitstatus
      end
      msg = "Dot::Command::Runner.run(cwd='#{cfg.root}', cmd='#{cmd}'): result='#{result.inspect}'"
      cfg.logger.debug msg
      result
    end # def run

    def self.file_guard cfg, msg, danger = false, &block
      res = nil
      if cfg.debug? then
        msg += " In debug mode, refusing to perform operation"
      else
        res = block.call
      end
      if danger then
        cfg.logger.warn msg
      else
        cfg.logger.debug msg
      end
      res
    end

    private
    def initialize
    end
  end # class Runner
end; end # module Dot; module Command
