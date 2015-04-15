require 'spec_helper'
require_relative '../robot'

RSpec.describe Robot do
  before do
    @utils = Class.new do
      include Utils
    end.new
  end

  it 'checks if string contains an integer positive coordinate' do
    expect(@utils.integer? '-1').to eq false
    expect(@utils.integer? '1').to eq true
    expect(@utils.integer? '2').to eq true
    expect(@utils.integer? ' ').to eq false
    expect(@utils.integer? nil).to eq false
    expect(@utils.integer? 'a').to eq false
  end

  it 'abreviates a symbol to two characters' do
    expect(@utils.abbreviate :north).to eq 'N'
    expect(@utils.abbreviate :north_west).to eq 'NW'
  end

  it 'converts a string to symbol' do
    expect(@utils.string_to_symbol 'north west').to eq :north_west
    expect(@utils.string_to_symbol 'north').to eq :north
  end
end
