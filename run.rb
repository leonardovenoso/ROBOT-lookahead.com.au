require 'pry'
require_relative 'robot'


robot = Robot.new
while command = gets do
  robot.execute(command)
end