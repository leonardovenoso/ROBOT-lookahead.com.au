
require 'spec_helper'
require_relative '../robot'

RSpec.describe Robot do 
	before do
		@full_command = 'PLACE 0,11,NORTH WEST'
		@robot = Robot.new
	end

	it 'splits the command token' do
		token = @robot.tokenize(@full_command)
		expect(token.size).to eq 5
	end

	it 'changes the robot orientation and position' do

	end

	it 'validates orientation with a valid attribute' do
		expect(@robot.is_orientation_valid?("NORTH")).to eq true
		expect(@robot.is_orientation_valid?("SOUTH")).to eq true		
		expect(@robot.is_orientation_valid?("south")).to eq true				
	end	


	it 'validates orientation with a not valid attribute' do
		expect(@robot.is_orientation_valid?("NORTH SOUTH")).to eq false
		expect(@robot.is_orientation_valid?("NORT SOUTH")).to eq false	
		expect(@robot.is_orientation_valid?("LEFT")).to eq false	
	end	
end