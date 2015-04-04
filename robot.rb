require 'pry'

class Robot
	attr_accessor :orientation

  def initialize
		@orientation = { 
			north: 'NORTH', 
			north_west: 'NORHT WEST', 
			north_east: 'NORTH EAST',
			east: 'EAST',
			west: 'WEST', 
			south: 'SOUTH', 
			south_west: 'SOUTH WEST',
			south_east: 'SOUTH EAST'
		}

		@current_orientation  = ''
		@current_position_x   = -1
		@current_position_y   = -1
		@table = Array.new(5) {Array.new(5,0)}
  end

	


	def tokenize(commands)		
		commands.scan(/[(A-Za-z)|(!0-5)]*\w/)
	end

	def understand_token_commands(commands)

	end

	def is_orientation_valid?(orientation_command)
		self.orientation.has_value?(orientation_command.upcase)
	end
end