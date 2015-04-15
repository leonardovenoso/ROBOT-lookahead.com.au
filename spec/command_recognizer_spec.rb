require 'spec_helper'
require_relative '../command_recognizer'

RSpec.describe CommandRecognizer do
  before do
    @full_valid_command = 'PLACE 0,0,NORTH WEST'
    @full_invalid_coordinate_command = 'PLACE 0,N,NORTH WEST'
    @full_invalid_orientation_command = 'PLACE 0,0,CREDIT CARD'

    @commnad_recognizer = CommandRecognizer.new
  end

  it 'splits the full valid command string in a hash' do
    hash_with_command_and_parameters = @commnad_recognizer.get_params(@full_valid_command)
    expect(hash_with_command_and_parameters[:command]).to eq 'place'
    expect(hash_with_command_and_parameters[:options][:x]).to eq 0
    expect(hash_with_command_and_parameters[:options][:y]).to eq 0
  end

  it 'recieves an unknown command hash when coordinates are invalid' do
    hash_with_command_and_parameters = @commnad_recognizer.get_params(@full_invalid_coordinate_command)
    expect(hash_with_command_and_parameters[:command]).to eq 'unknown'
  end

  it 'recieves an unknown command hash when orientation is invalid' do
    hash_with_command_and_parameters = @commnad_recognizer.get_params(@full_invalid_orientation_command)
    expect(hash_with_command_and_parameters[:command]).to eq 'unknown'
  end

  it 'splits the move command string in a hash' do
    hash_with_command_and_parameters = @commnad_recognizer.get_params('move')
    expect(hash_with_command_and_parameters[:command]).to eq 'move'
    expect(hash_with_command_and_parameters[:options]).to eq nil
  end

  it 'validates orientation with a valid parameter' do
    expect(@commnad_recognizer.send(:orientation_valid?, 'NORTH')).to eq true
    expect(@commnad_recognizer.send(:orientation_valid?, 'SOUTH EAST')).to eq true
    expect(@commnad_recognizer.send(:orientation_valid?, 'WEST')).to eq true
  end

  it 'validates orientation with an invalid parameter' do
    expect(@commnad_recognizer.send(:orientation_valid?, 'NOORTH')).to eq false
    expect(@commnad_recognizer.send(:orientation_valid?, 'zOUTH EAST')).to eq false
    expect(@commnad_recognizer.send(:orientation_valid?, 'westtt')).to eq false
  end
end
