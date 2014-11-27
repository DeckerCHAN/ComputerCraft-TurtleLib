--Auto miner
--Start Initialize
START_DIMENSION=
{
	axis="x",
	orientation="1"
}
DEBUG=false
--End Initialize
--Start Basement
Logger={useLog=DEBUG}
Logger.info=function (message)
	if Logger.useLog then
		print("INFO:"..message)
	end
end
Logger.info=function (message,result)
	if Logger.useLog then
		if result then
			print("INFO:".."Execute:"..message,result)
		else
		end
	end
end

Miner={}
Miner.position={x=0,y=0,z=0}
Miner.dimension=START_DIMENSION
Miner.forward=function ()
	Miner.position[Miner.dimension.axis]=Miner.position[Miner.dimension.axis]+1*Miner.dimension.orientation
	local result=turtle.forward()
	Logger.info("Miner.forward",result)
end
Miner.back=function ()
	Miner.position[Miner.dimension.axis]=Miner.position[Miner.dimension.axis]-1*Miner.dimension.orientation
	local result=turtle.back()
	Logger.info("Miner.back",result)
end
Miner.up=function ()
	Miner.position["y"]=Miner.position["y"]+1
	local result=turtle.up()
	Logger.info("Miner.up",result)
end
Miner.down=function ()
	Miner.position["y"]=Miner.position["y"]-1
	local result=turtle.down()
	Logger.info("Miner.down",result)
end
Miner.turnLeft=function ()
	if Miner.dimension.axis=="x" then
	Miner.dimension.axis="y"
	elseif Miner.dimension.axis=="y" then
		Miner.dimension.axis="x"
	else
	end
	local result=turtle.turnLeft()
	Logger.info("Miner.turnLeft",result)
end
Miner.turnRight=function ()
	if Miner.dimension.axis=="x" then
	Miner.dimension.axis="y"
	Miner.dimension.orientation=Miner.dimension.orientation*-1
	elseif Miner.dimension.axis=="y" then
			Miner.dimension.axis="x"
			Miner.dimension.orientation=Miner.dimension.orientation*-1
	else
	end
	local result=turtle.turnRight()
	Logger.info("Miner.turnRight",result)
end
--End Basement
--Start Runtime
Miner.forward()
--End 

