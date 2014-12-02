--Configuration
--------------------------------


--Still useless
GREED_MODE=false
--Temporary var
--------------------------------

progress={cloumn=0,row=0,level=0}
progress.clear=function()
	progress.cloumn=0
	progress.row=0
	progress.level=0
end

--Level 1 functions
--------------------------------
log=function ( message )
  print("LOG:"..message)
end

dig=function()
  turtle.dig()
  log("dig")
end

digAbove=function()
	turtle.digUp()
	  log("digUp")
end

digUnder=function()
	turtle.digDown()
	  log("digUnder")
end

obstinateForward=function()
  local success = false
  while not success do
   success=turtle.forward()
  end
end

obstinateBack=function()
  local success = false
  while not success do
   success=turtle.back()
  end
end

obstinateUp=function()
  local success = false
  while not success do
   success=turtle.up()
  end
end

obstinateDown=function()
  local success = false
  while not success do
   success=turtle.down()
  end
end

forward=function(step)
  step=step or 1
  for i=1,step do
    obstinateForward()
    log("forward")
  end
end

back=function(step)
  step=step or 1
  for i=1,step do
    obstinateBack()
    log("back")
  end
end

up=function(step)
  step=step or 1
  for i=1,step do
    obstinateUp()
    log("up")
  end	
end

down=function(step)
  step=step or 1
  for i=1,step do
    obstinateDown()
    log("down")
  end	
end

turnLeft=function()
  turtle.turnLeft()
  log("turnLeft")
end

turnRight=function()
  turtle.turnRight()
  log("turnRight")
end

turnBack=function()
  turnLeft()
  turnLeft()
  log("turnBack")
end

obstinateSelectAnEmptySlot=function()
  	log("obstinateSelectAnEmptySlot...")
	while true do
		for i=1,16 do
			turtle.select(i)
			if turtle.getItemCount()==0 then
				return
			end
		end
	end
end

obstinateDropAll=function()
	log("obstinateDropAll...")
	local success = false
	while not success do
		for i=1,16 do
			turtle.select(i)
			success=turtle.drop(turtle.getItemCount())
		end
	end
end

obstinateFullFuel=function()
	obstinateSelectAnEmptySlot()
	log("obstinateFullFuel...")
	local success = false
	while not success do
		turtle.suck(1)
		turtle.refuel()
		success=turtle.getFuelLevel()==turtle.getFuelLimit()
	end
end
--Level 2 functions
--------------------------------
digForward=function( step )
  step=step or 1
  for i=1,step do
    dig()
    forward()
  end
end

digUp=function(step)
  step=step or 1
  for i=1,step do
    digAbove()
    up()
  end
end

digDown=function(step)
	step=step or 1
	for i=1,step do
		digUnder()
		down()
	end
end

digBack=function(step)
	step=step or 1
	turnBack()
	digForward(step)
	turnBack()
end

--Level 3 functions
--------------------------------
digColumn=function ( range )
	progress.clear()
	step=step or 1
	digForward(range)
	digBack(range)
end

digGrid=function ( cloumn,row )
  	progress.clear()
	cloumn=cloumn or 1
	row=row or 1

	digColumn(cloumn)

	for i=1,row do
		turnRight()
		digForward()
		turnLeft()
		digColumn(cloumn)
	end
	turnRight()
	digBack(row)
	turnLeft()
end

digCube=function(cloumn,row,level)
	cloumn=cloumn or 1
	row=row or 1
	level=level or 1

	digGrid(cloumn,row)

	for i=1,level do
		digUp()
		digGrid(cloumn,row)
	end
	digDown(level)
end
--------------------------------

cloumn=5
row=5
level=5

workingHight=0;
for i=1,2 do
	digUp(workingHight)
	digCube(cloumn,row,level)
	digDown(workingHight)

	workingHight=workingHight+level+1

	turnBack()
	obstinateDropAll()
	turnRight()
	obstinateFullFuel()
	turnRight()

end

obstinateFullFuel()
