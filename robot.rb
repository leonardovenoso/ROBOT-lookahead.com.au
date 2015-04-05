require 'pry'

class Robot
	attr_accessor :orientation, :current_position_x, :current_position_y, :current_orientation

  def initialize
		@orientation = { 
			north: 'NORTH', 
			north_west: 'NORTH WEST', 
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


	def separate_in_tokens(commands)
		commands.upcase!		
		commands.scan(/[(A-Za-z)|(!0-5)]*\w/)
	end

  # TODO: FIRST orientation should be NORTH, WEST, SOUTH, EAST
	def execute(commands)
		case commands[0]
			when "PLACE"
				new_orientation = commands[3].to_s + " " + commands[4].to_s
			  if is_integer?(commands[1]) and is_integer?(commands[2]) and is_orientation_valid?(new_orientation)
			  	@current_orientation = new_orientation
			  	@current_position_x = commands[1].to_i
			  	@current_position_y = commands[2].to_i
			  end
			when "MOVE"
			  puts "MOVE"
			when "LEFT"
			  puts "LEFT"
			when "RIGHT"
				puts "RIGHT"
			when "REPORT"
				puts "REPORT"	
		end
	end

	private
		def is_orientation_valid?(orientation_command)
			orientation.has_value?(orientation_command)
		end

 		def is_integer?(number)
       !!(number =~ /\A[+]?[0-9]+\z/)
    end		
end