require 'pry'

class Robot
	attr_accessor :orientation, :current_position_x, :current_position_y, :current_orientation

	ARRAY_SIZE_X = 5
	ARRAY_SIZE_Y = 5

  def initialize
		@orientation = { 
			north: "NORTH", 
			north_west: "NORTH WEST", 
			north_east: "NORTH EAST",
			east: "EAST",											
			west: "WEST",
			south: "SOUTH", 
			south_west: "SOUTH WEST",
			south_east: "SOUTH EAST"
		}

		@current_orientation  = ""
		@current_position_x   = 0
		@current_position_y   = 0
		@table = Array.new(ARRAY_SIZE_Y) {Array.new(ARRAY_SIZE_X,0)}
  end

  # TODO: FIRST orientation should be NORTH, WEST, SOUTH, EAST
	def execute(commands_str)
		commands = separate_in_tokens(commands_str)
		case commands[0]
			when "PLACE"
				new_orientation = (commands[3].to_s + " " + commands[4].to_s).strip
			  if is_integer?(commands[1]) and is_integer?(commands[2]) and is_orientation_valid?(new_orientation)
			  	@current_orientation = new_orientation
			  	place_in(commands[1].to_i, commands[2].to_i)
			  end
			when "MOVE"
			  move
			when "LEFT"
			  puts "LEFT"
			when "RIGHT"
				puts "RIGHT"
			when "REPORT"
				puts "REPORT"			
		end
	end

	private
		def separate_in_tokens(commands)
			commands.upcase!		
			commands.scan(/[(A-Za-z)|(!0-5)]*\w/)
		end

		def move
			case @current_orientation
				when orientation[:north]
						place_in(@current_position_x - 1, @current_position_y)
				when orientation[:north_west]
				when orientation[:north_east]	
				when orientation[:south]					
					place_in(@current_position_x + 1, @current_position_y)
				when orientation[:south_west]
				when orientation[:south_east]	

				when orientation[:east]
				when orientation[:west]	
			end
		end

		def place_in(x, y)
			if x < ARRAY_SIZE_X and x >= 0 and y < ARRAY_SIZE_Y and y >= 0 
				@table[@current_position_x][@current_position_y] = 0
	  		@current_position_x = x
	  		@current_position_y = y
	  		@table[x][y] = 1
				
				print_matrix
	  		true
	  	else
	  		false	
	  	end	
		end

		def print_matrix
			print "\n\n----------------------------------\n\n"

			for i in 0..ARRAY_SIZE_X - 1
				print "\n"
				for j in 0..ARRAY_SIZE_Y - 1
					print "#{@table[i][j]}\t"
				end
			end		

			print "\n"
		end

		def is_orientation_valid?(orientation_command)
			@orientation.has_value?(orientation_command.strip)
		end

 		def is_integer?(number)
    	!!(number =~ /\A[+]?[0-9]+\z/)
    end		
end