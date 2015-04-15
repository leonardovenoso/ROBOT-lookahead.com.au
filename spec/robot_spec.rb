
require 'spec_helper'
require_relative '../robot'

RSpec.describe Robot do 
	before do
		@full_command = 'PLACE 0,0,NORTH WEST'
		@robot = Robot.new
	end

	it "places the robot if the typed position is not out of the matrix range" do
		expect(@robot.send(:place, { x: 0, y: 0 })).to eq true
		expect(@robot.send(:place, { x: 1, y: 1 })).to eq true
		expect(@robot.send(:place, { x: 4, y: 4 })).to eq true
		expect(@robot.send(:place, { x: 4, y: 7 })).to eq false
		expect(@robot.send(:place, { x: 10, y: 10 })).to eq false
		expect(@robot.send(:place, { x: 5, y: 5 })).to eq false
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

	it "checks (with a valid place command) that the first command executed is a valid place" do
		@robot.execute("PLACE 4,0,NORTH WEST")
		expect(@robot.send(:was_executed_valid_place_command?)).to eq true
	end

	it "checks (with an invalid place command) that the first command executed is a valid place" do
		@robot.execute("MOVE")
		expect(@robot.send(:was_executed_valid_place_command?)).to eq false
	end
end