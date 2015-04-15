require 'pry'
require_relative 'base'
require_relative 'command_recognizer'


class Robot < Base

	def initialize
		super
		@command_recognizer = CommandRecognizer.new
	end

	# Params:
	# - command_str: PLACE 0,0,NORTH / move / LEFT / right / REPORT
	def execute(command_str)
		command_hash = @command_recognizer.get_hash_with_command_and_parameters(command_str)
		command = command_hash[:command]
		options = command_hash[:options]

		if options.nil?
			send(command)
		else
			send(command, options)			
		end
	end

	private
		def left
			rotate(-2)
		end

		def right
			rotate(2)
		end

		# Params:
		# - direction: -2 or 2
		def rotate(direction)
			return unless was_executed_valid_place_command?	

			orientation_keys = orientation.keys
			orientation_index = orientation_keys.index(@current_orientation) + direction
			@current_orientation = orientation_keys[orientation_index].nil? ? orientation_keys[0] : orientation_keys[orientation_index]
			@table[@current_position_x][@current_position_y] = abbreviate(@current_orientation)

			print_table
		end

		def move
			return unless was_executed_valid_place_command?	

			x = orientation[@current_orientation][:x].nil? ? @current_position_x : @current_position_x + orientation[@current_orientation][:x]
			y = orientation[@current_orientation][:y].nil? ? @current_position_y : @current_position_y + orientation[@current_orientation][:y]

			options = { x: x, y: y }
			place(options)
		end

		# PARAMS:
		# - options: {x: 1, y: 1, orientation: :NORTH}
		def place(options)	
			x = options[:x]
			y = options[:y]

	  	@current_orientation = options[:orientation] unless options[:orientation].nil?
	  	@executed_valid_place_command = true

			if x < ARRAY_SIZE_X and x >= 0 and y < ARRAY_SIZE_Y and y >= 0 
				@table[@current_position_x][@current_position_y] = 0

	  		@current_position_x = x
	  		@current_position_y = y

	  		abbreviation = abbreviate(@current_orientation)
	  		@table[x][y] = abbreviation.empty? ? 'x' : abbreviation
				
				print_table
	  		true
	  	else
	  		false	
	  	end	
		end
end