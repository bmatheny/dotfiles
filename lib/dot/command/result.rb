module Dot; module Command

  class Result
    attr_accessor :stdout, :stderr, :exit_code
    def initialize stdout, stderr, exit_code
      self.stdout = stdout
      self.stderr = stderr
      self.exit_code = exit_code
    end
    def success?
      exit_code == 0
    end
    def sos # stdout stripped
      stdout.strip
    end
    def ses # stderr stripped
      stderr.strip
    end
    def to_s
      "Dot::Command::Result(stdout='#{stdout}', stderr='#{stderr}', exit=#{exit_code})"
    end
  end

end; end # module Dot; module Command
