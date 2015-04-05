
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

	it 'validates orientation with a valid attribute' do
		expect(@robot.send(:is_orientation_valid?, "NORTH")).to eq true
		expect(@robot.send(:is_orientation_valid?, "SOUTH")).to eq true		
	end	

	it 'validates orientation with a not valid attribute' do
		expect(@robot.send(:is_orientation_valid?, "NORTH SOUTH")).to eq false
		expect(@robot.send(:is_orientation_valid?, "NORT SOUTH")).to eq false	
		expect(@robot.send(:is_orientation_valid?, "LEFT")).to eq false	
	end	

	it "checks if string contains an integer positive number" do
		expect(@robot.send(:is_integer?, "-1")).to eq false
		expect(@robot.send(:is_integer?, "1")).to eq true
		expect(@robot.send(:is_integer?, "2")).to eq true
		expect(@robot.send(:is_integer?, " ")).to eq false
		expect(@robot.send(:is_integer?, nil)).to eq false
		expect(@robot.send(:is_integer?, "a")).to eq false
	end

	it 'changes the robot orientation' do
		@robot.execute(@full_command)
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

	it "moves the robot from the SOUTH direction" do
		@robot.execute("PLACE 0,0,SOUTH")
		@robot.execute("MOVE")
		expect(@robot.current_position_y).to eq 1 

		@robot.execute("MOVE")
		expect(@robot.current_position_y).to eq 2 
	end
end