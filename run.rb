require 'pry'
require_relative 'robot'


system "clear"
robot = Robot.new
while command = gets do
  robot.execute(command)
end