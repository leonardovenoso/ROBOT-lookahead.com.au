require 'pry'

class Robot
	attr_accessor :orientation, :current_position_x, :current_position_y, :current_orientation

	ARRAY_SIZE_X = 5
	ARRAY_SIZE_Y = 5

  def initialize
		@orientation = { 
			north: { x: -1 }, 
			north_west: { x: 1, y: -1 }, 
			north_east: { x: -1, y: 1 },
			east: { y: -1 },
			west: { y: 1 },
			south: { x: 1 }, 
			south_west: { x: 1, y: -1 },
			south_east: { x: 1, y: 1 }
		}

				# 		when orientation[:north]
				# 	place_in(@current_position_x - 1, @current_position_y)
				# when orientation[:north_west]
				# 	place_in(@current_position_x + 1, @current_position_y - 1)					
				# when orientation[:north_east]	
				# 	place_in(@current_position_x - 1, @current_position_y + 1)
				# when orientation[:south]
				# 	place_in(@current_position_x + 1, @current_position_y)
				# when orientation[:south_west]
				# 	place_in(@current_position_x + 1, @current_position_y - 1)
				# when orientation[:south_east]
				# 	place_in(@current_position_x + 1, @current_position_y + 1)
				# when orientation[:east]
				# 	place_in(@current_position_x, @current_position_y - 1)					
				# when orientation[:west]	
				# 	place_in(@current_position_x, @current_position_y + 1)

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
				new_orientation_symbol = string_to_symbol(commands[3].to_s + " " + commands[4].to_s)
			  if is_integer?(commands[1]) and is_integer?(commands[2]) and is_orientation_symbol_valid?(new_orientation_symbol)
			  	@current_orientation = new_orientation_symbol
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
			x = @orientation[@current_orientation][:x].nil? ? @current_position_x : @current_position_x + @orientation[@current_orientation][:x]
			y = @orientation[@current_orientation][:y].nil? ? @current_position_y : @current_position_y + @orientation[@current_orientation][:y]

			place_in(x, y)
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

		def is_orientation_symbol_valid?(orientation_command)
			@orientation.has_key?(orientation_command) == true
		end

		def string_to_symbol(str)
			str.strip.gsub(/\s+/, "_").downcase.to_sym
		end

 		def is_integer?(number)
    	!!(number =~ /\A[+]?[0-9]+\z/)
    end		
end