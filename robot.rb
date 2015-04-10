require 'pry'

class Robot
	attr_accessor :orientation, :current_position_x, :current_position_y, :current_orientation

	ARRAY_SIZE_X = 5
	ARRAY_SIZE_Y = 5
	command_counter = 0

  def initialize
		@orientation = { 
			north: { x: -1 }, 
			north_east: { x: -1, y: 1 },
			east: { y: 1 },
			south_east: { x: 1, y: 1 },
			south: { x: 1 }, 
			south_west: { x: 1, y: -1 },
			west: { y: 1 },
			north_west: { x: 1, y: -1 }
		}

		@current_orientation  = ""
		@current_position_x   = 0
		@current_position_y   = 0
		@table = Array.new(ARRAY_SIZE_Y) {Array.new(ARRAY_SIZE_X,0)}
  end

  # TODO: FIRST orientation should be NORTH, WEST, SOUTH, EAST
	def execute(commands_str)
		commands = separate_in_tokens(commands_str)
		case commands[0].upcase
			when "PLACE"
				new_orientation_symbol = string_to_symbol(commands[3].to_s + " " + commands[4].to_s)
			  if is_integer?(commands[1]) and is_integer?(commands[2]) and is_orientation_symbol_valid?(new_orientation_symbol)
			  	@current_orientation = new_orientation_symbol
			  	place_in(commands[1].to_i, commands[2].to_i)
			  end
			when "MOVE"
			  move
			when "LEFT"				
				rotate -2 # 2=90 degrees, 1=45
			when "RIGHT"
				rotate 2						
			when "REPORT"
				report
		end
	end

	private
		def report
			puts "REPORT: (#{@current_position_x}, #{current_position_y}) #{@current_orientation}"
		end

		def abbreviate(orientation_symbol)
			orientation_symbol.to_s.split("_").map {|orientation| orientation[0].chr }.join.upcase
		end

		def rotate(direction)
			orientation_keys = @orientation.keys
			orientation_index = orientation_keys.index(@current_orientation) + direction
			@current_orientation = orientation_keys[orientation_index].nil? ? orientation_keys[0] : orientation_keys[orientation_index]
			@table[@current_position_x][@current_position_y] = abbreviate(@current_orientation)
			print_matrix
		end

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
	  		abbreviation = abbreviate(@current_orientation)
	  		@table[x][y] = abbreviation.empty? ? 'x' : abbreviation
				
				print_matrix
	  		true
	  	else
	  		false	
	  	end	
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

		def print_matrix
			system "clear"
			print "\n"
			for x in 0..ARRAY_SIZE_X-1
				print "#{x}\t"
			end
			print "\n----------------------------------\n"
			for i in 0..ARRAY_SIZE_X - 1
				print "\n"
				for j in 0..ARRAY_SIZE_Y - 1
					print "#{@table[i][j]}\t"
				end
			end		

			print "\n"
		end    	
end