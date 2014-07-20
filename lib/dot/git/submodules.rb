require 'dot/git'
require 'dot/git/submodule'

module Dot; module Git
  class Submodules

    include Enumerable

    # Return all submodules found in project
    def self.from_config cfg
      mods = parse_module_config(cfg).map do |name, params|
        Dot::Git::Submodule.create_from_hash cfg, name, params
      end.reject{|s| s.nil?}
      Dot::Git::Submodules.new cfg, mods
    end # def self.from_config

    attr_accessor :cfg, :submodules
    def initialize cfg, submodules
      @cfg = cfg
      @submodules = submodules
    end

    def each &block
      @submodules.each do |submodule|
        if block_given? then
          block.call submodule
        else
          yield submodule
        end
      end
    end

    def needs_init?
      select { |s| s.needs_init? }.size > 0
    end

    def pull
      if needs_init? then
        raise ArgumentError.new("Can't call Submodules.pull before Submodules.update")
      end
      each do |submodule|
        cfg.logger.info mk_msg('pull', "Submodule(#{submodule.name}): checkout and pull")
        begin
          submodule.checkout_pull
        rescue StandardError => e
          cfg.logger.warn e
        end
      end
    end

    def update
      if needs_init? then
        cfg.logger.info mk_msg('update', 'Initializing modules, this will take a minute')
        Dot::Git.git cfg, 'submodule update --init --quiet --recursive'
      else
        cfg.logger.info mk_msg('update', 'Updating modules')
        Dot::Git.git cfg, 'submodule update --quiet --rebase --remote'
      end
    end

    private
    def self.mk_msg method_name, msg
      "Dot::Got::Submodules.#{method_name}: #{msg}"
    end
    def mk_msg method_name, msg
      self.class.mk_msg method_name, msg
    end

    # Return the contents of the .gitmodules file
    def self.get_module_config cfg
      gitmodules = File.join(cfg.root, ".gitmodules")
      if not File.exists?(gitmodules) then
        ""
      else
        result = Dot::Git.git cfg, "config -f #{gitmodules} --list", true
        result.sos
      end
    end

    # Pulls submodules from config file and returns array as
    # [[name, param, value]*]
    def self.parse_module_config cfg
      result = get_module_config cfg
      modules = result.split("\n").select do |line|
        # Grab lines starting with the correct value
        line.start_with?("submodule.")
      end.map do |line|
        # Drop the submodule. from the start of the line
        line.gsub(/^submodule\./, "")
      end.map do |line|
        # Split the line into [name, param, value]
        line.scan(/(.*)\.(\w+)=(.*)/).first
      end.reduce({}) do |o, v|
        # Convert lines into hash
        map_module_line o, v
      end
    end # def parse_module_config

    # Helper for parse_module_config
    def self.map_module_line obj, vals
      if vals.size > 2 then
        name = vals[0]
        param = vals[1]
        value = vals[2]
        if not obj.key?(name) then
          obj[name] = {}
        end
        obj[name][param] = value
      else
        vs = vals.join(' ')
        cfg.logger.warn mk_msg('map_module_line', "invalid line value: '#{vs}'")
      end
      obj
    end # map_module_line

  end # class Submodules

end; end # module Dot; module Git; module Submodules
