require 'yaml'

class Arcanine::Config
	def initialize(config_file = 'config')
		@h = YAML::load File.read(config_file)
	end

	def to_h
		@h
	end
end

