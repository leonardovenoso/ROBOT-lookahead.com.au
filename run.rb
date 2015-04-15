require 'pry'
require_relative 'robot'

system 'clear'
robot = Robot.new

while command = gets
  robot.execute(command)
end
