# Robot exercise
Is a robot walking in a board of 5x5 units. It moves in the ordinal directions like North, South, East, West, North East, etc. It also moves forward and rotates 90 degrees.

### Quality test tools:
Rubocop: to remove the offenses (gem install rubocop)

Rspec: to drive the design based on tests

### How to execute?
ruby run.rb

### Commands to move the robot?
The first command should be a valid place with the following syntax:

> It places the robot in the desired coordinates 
``` 
place 0,0, south
```

> It moves forward
```
move
```

It rotates 90 degrees to the left of the robot. Take into consideration the direction of the robot's face to choose the ordinal point.
```
left
```

> It rotates 90 degrees to the right of the robot. Take into consideration the direction of the robot's face to choose the ordinal point.
```
right
```

It shows where the robot is located.
```
report
```

> It exits the system
```
exit
```