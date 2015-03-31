
require 'spec_helper'
require_relative '../robot'

RSpec.describe Robot do 
	it 'splits the command token' do
		command = 'PLACE 0,11,NORTH WEST'
		token = Robot.new.tokenize()
		expect(token.size).to eq 5
	end
end