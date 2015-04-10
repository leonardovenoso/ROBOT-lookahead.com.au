
require 'spec_helper'
require_relative '../robot'

RSpec.describe Robot do 
	before do
		@full_command = 'PLACE 0,0,NORTH WEST'
		@robot = Robot.new
	end

	it 'splits the full command string in tokens' do
		tokens = @robot.send(:separate_in_tokens, @full_command)
		expect(tokens.size).to eq 5
	end

	it 'validates orientation with a valid parameter' do
		expect(@robot.send(:is_orientation_symbol_valid?, @robot.send(:string_to_symbol, "NORTH") )).to eq true
		expect(@robot.send(:is_orientation_symbol_valid?, @robot.send(:string_to_symbol, "SOUTH") )).to eq true		
	end	

	it 'validates orientation with a not valid parameter' do
		expect(@robot.send(:is_orientation_symbol_valid?, @robot.send(:string_to_symbol, "NORTH SOUTH") )).to eq false
		expect(@robot.send(:is_orientation_symbol_valid?, @robot.send(:string_to_symbol, "NORT SOUTH") )).to eq false	
		expect(@robot.send(:is_orientation_symbol_valid?, @robot.send(:string_to_symbol, "LEFT") )).to eq false	
	end	

	it "checks if string contains an integer positive coordinate" do
		expect(@robot.send(:is_integer?, "-1")).to eq false
		expect(@robot.send(:is_integer?, "1")).to eq true
		expect(@robot.send(:is_integer?, "2")).to eq true
		expect(@robot.send(:is_integer?, " ")).to eq false
		expect(@robot.send(:is_integer?, nil)).to eq false
		expect(@robot.send(:is_integer?, "a")).to eq false
	end

	it "places the robot if the typed position is not out of the matrix range" do
		expect(@robot.send(:place_in, 0, 0)).to eq true
		expect(@robot.send(:place_in, 1, 1)).to eq true
		expect(@robot.send(:place_in, 4, 7)).to eq false
		expect(@robot.send(:place_in, 10, 10)).to eq false
		expect(@robot.send(:place_in, 3, 1)).to eq true
		expect(@robot.send(:place_in, 3, 3)).to eq true
		expect(@robot.send(:place_in, 4, 4)).to eq true
		expect(@robot.send(:place_in, 5, 5)).to eq false
	end

	it "moves the robot from 0,0 to the SOUTHest direction" do
		@robot.execute("PLACE 0,0,SOUTH")
		@robot.execute("MOVE")
		expect(@robot.current_position_x).to eq 1 

		@robot.execute("MOVE")
		expect(@robot.current_position_x).to eq 2 

		@robot.execute("MOVE")
		expect(@robot.current_position_x).to eq 3 

		@robot.execute("MOVE")
		expect(@robot.current_position_x).to eq 4

		@robot.execute("MOVE")
		expect(@robot.current_position_x).to eq 4		 
	end

	it "moves the robot from 4,0 to the NORTHest direction" do
		@robot.execute("PLACE 4,0,NORTH")
		@robot.execute("MOVE")
		expect(@robot.current_position_x).to eq 3 

		@robot.execute("MOVE")
		expect(@robot.current_position_x).to eq 2 

		@robot.execute("MOVE")
		expect(@robot.current_position_x).to eq 1 

		@robot.execute("MOVE")
		expect(@robot.current_position_x).to eq 0

		@robot.execute("MOVE")
		expect(@robot.current_position_x).to eq 0		 
	end	

	it "moves the robot from 0,0 to the WESTest direction" do
		@robot.execute("PLACE 0,0,WEST")
		@robot.execute("MOVE")
		expect(@robot.current_position_y).to eq 1

		@robot.execute("MOVE")
		expect(@robot.current_position_y).to eq 2 

		@robot.execute("MOVE")
		expect(@robot.current_position_y).to eq 3 

		@robot.execute("MOVE")
		expect(@robot.current_position_y).to eq 4

		@robot.execute("MOVE")
		expect(@robot.current_position_y).to eq 4		 
	end		

	it "moves the robot from 0,0 to the EASTest direction" do
		@robot.execute("PLACE 0,0,EAST")
		@robot.execute("MOVE")
		expect(@robot.current_position_y).to eq 1

		@robot.execute("MOVE")
		expect(@robot.current_position_y).to eq 2 

		@robot.execute("MOVE")
		expect(@robot.current_position_y).to eq 3 

		@robot.execute("MOVE")
		expect(@robot.current_position_y).to eq 4

		@robot.execute("MOVE")
		expect(@robot.current_position_y).to eq 4
	end			

	it "moves the robot from 0,0 to SOUTH EAST direction" do
		@robot.execute("PLACE 0,0,SOUTH EAST")
		@robot.execute("MOVE")
		expect(@robot.current_position_y).to eq 1

		@robot.execute("MOVE")
		expect(@robot.current_position_y).to eq 2

		@robot.execute("MOVE")
		expect(@robot.current_position_y).to eq 3 

		@robot.execute("MOVE")
		expect(@robot.current_position_y).to eq 4

		@robot.execute("MOVE")
		expect(@robot.current_position_y).to eq 4
	end			

	it "moves the robot from 0,0 SOUTH WEST direction" do
		@robot.execute("PLACE 0,4,SOUTH WEST")
		@robot.execute("MOVE")
		expect(@robot.current_position_y).to eq 3

		@robot.execute("MOVE")
		expect(@robot.current_position_y).to eq 2

		@robot.execute("MOVE")
		expect(@robot.current_position_y).to eq 1 

		@robot.execute("MOVE")
		expect(@robot.current_position_y).to eq 0

		@robot.execute("MOVE")
		expect(@robot.current_position_y).to eq 0
	end	

	it "moves the robot from 4,0 NORTH EAST direction" do
		@robot.execute("PLACE 4,0,NORTH EAST")
		@robot.execute("MOVE")
		expect(@robot.current_position_x).to eq 3

		@robot.execute("MOVE")
		expect(@robot.current_position_x).to eq 2

		@robot.execute("MOVE")
		expect(@robot.current_position_x).to eq 1 

		@robot.execute("MOVE")
		expect(@robot.current_position_x).to eq 0

		@robot.execute("MOVE")
		expect(@robot.current_position_x).to eq 0
	end				

	it "moves the robot from 0,4 NORTH WEST direction" do
		@robot.execute("PLACE 0,4,NORTH WEST")
		@robot.execute("MOVE")
		expect(@robot.current_position_x).to eq 1

		@robot.execute("MOVE")
		expect(@robot.current_position_x).to eq 2

		@robot.execute("MOVE")
		expect(@robot.current_position_x).to eq 3 

		@robot.execute("MOVE")
		expect(@robot.current_position_x).to eq 4

		@robot.execute("MOVE")
		expect(@robot.current_position_x).to eq 4
	end	

	it "changes to the next orientation from north west to" do
		@robot.execute("PLACE 4,0,NORTH WEST")
		@robot.execute("RIGHT")
		expect(@robot.current_orientation).to eq :north
	end

	it "checks that the first command executed is a valid place" do
		
	end
end