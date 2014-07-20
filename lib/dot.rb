dotdir = File.dirname(File.absolute_path(__FILE__))
$:.unshift(dotdir) unless $:.include?(dotdir)

require 'dot/config'
require 'dot/command/runner'
require 'dot/file'
require 'dot/git'
require 'dot/git/submodule'
require 'dot/git/submodules'

module Dot
  def self.to_bool s
    return s if s.is_a?(TrueClass) or s.is_a?(FalseClass)
    return true if s =~ (/^(true|t|yes|y|1)$/i)
    return false if s.empty? || s =~ (/^(false|f|no|n|0)$/i)
    raise ArgumentError.new "invalid value: #{s.class}(#{s.to_s})"
  end
end
