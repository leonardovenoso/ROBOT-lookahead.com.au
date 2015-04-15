require_relative 'modules/orientation'
require_relative 'print'
require_relative 'modules/Utils'

class Base
	include Orientation
	include Utils

	ARRAY_SIZE_X = 5
	ARRAY_SIZE_Y = 5

	attr_accessor :current_position_x, 
								:current_position_y, 
								:current_orientation,
								:executed_valid_place_command,
								:table

  def initialize
		@current_orientation  = ""
		@current_position_x   = 0
		@current_position_y   = 0

		@table = Array.new(ARRAY_SIZE_X) { Array.new(ARRAY_SIZE_Y, 0) }
		@executed_valid_place_command = false
  end

	def was_executed_valid_place_command?
		@executed_valid_place_command
	end	
	
	def print_table
		Print.table(ARRAY_SIZE_X, ARRAY_SIZE_Y, @table)
	end

	def report
		puts "REPORT: (#{@current_position_x}, #{current_position_y}) #{@current_orientation}"
	end	

	def unknown
		puts "Unknown command..."
	end	
end
