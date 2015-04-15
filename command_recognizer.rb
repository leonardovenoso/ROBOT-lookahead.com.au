require 'pry'
require_relative 'modules/orientation'
require_relative 'modules/utils'

class CommandRecognizer
	include Orientation
	include Utils

	# Params:
	# - command_str: PLACE 0,0,NORTH / MOVE / LEFT / RIGHT / REPORT
	# Return:
	# - Hash type: { command: command[0], options: { direction: -2 } }
	def get_hash_with_command_and_parameters(command_str)
		command = separate_in_tokens(command_str)

		case command[0].downcase!
			when "place"
				x = command[1]
				y = command[2]
				new_orientation = command[3].to_s + " " + command[4].to_s

			  if is_integer?(x) and is_integer?(y) and is_orientation_valid?(new_orientation)
			  	command_to_execute = { command: command[0], 
			  												 options: { 
												 				 	 x: x.to_i, 
																	 y: y.to_i, 
																	 orientation: string_to_symbol(new_orientation)
																 } 
															 }
				 	return command_to_execute;  
				else	
					return unknown_command_hash	
			  end										
			when "move"
				return { command: command[0] }
			when "left"				
				return { command: command[0] }
			when "right"
				return { command: command[0] }
			when "report"
				return { command: command[0] }
			else
				return unknown_command_hash	
		end
	end	

	private
		def unknown_command_hash
			{ command: 'unknown' }	
		end

		def is_orientation_valid?(new_orientation)
			orientation_symbol = string_to_symbol(new_orientation)
			orientation.has_key?(orientation_symbol) == true
		end

		def separate_in_tokens(commands)
			commands.upcase!		
			commands.scan(/[(A-Za-z)|(!0-5)]*\w/)
		end
end