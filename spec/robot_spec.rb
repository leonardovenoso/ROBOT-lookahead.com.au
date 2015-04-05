
require 'spec_helper'
require_relative '../robot'

RSpec.describe Robot do 
	before do
		@full_command = 'PLACE 0,0,NORTH WEST'
		@robot = Robot.new
	end

	it 'splits the full command string in tokens' do
		token = @robot.separate_in_tokens(@full_command)
		expect(token.size).to eq 5
	end

	it 'changes the robot orientation and position' do
		commands = @robot.separate_in_tokens(@full_command)
		@robot.execute(commands)

		expect(@robot.current_orientation).to eq "NORTH WEST"
		expect(@robot.current_position_x).to eq 0
		expect(@robot.current_position_y).to eq 0
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

	it "checks that an string contains an integer number" do
		expect(@robot.send(:is_integer?, "-1")).to eq false
		expect(@robot.send(:is_integer?, "1")).to eq true
		expect(@robot.send(:is_integer?, "2")).to eq true
		expect(@robot.send(:is_integer?, " ")).to eq false
		expect(@robot.send(:is_integer?, nil)).to eq false
		expect(@robot.send(:is_integer?, "a")).to eq false
	end
end