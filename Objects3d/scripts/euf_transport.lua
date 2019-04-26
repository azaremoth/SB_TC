local base = piece 'base'
local hull = piece 'hull'
local flengine = piece 'flengine'
local frengine = piece 'frengine'
local rlengine = piece 'rlengine'
local rrengine = piece 'rrengine'
local rdoor = piece 'rdoor'
local ldoor = piece 'ldoor'
local transportpoint = piece 'transportpoint'
local transportpoint1 = piece 'transportpoint1'
local transportpoint2 = piece 'transportpoint2'
local transportpoint3 = piece 'transportpoint3'
local transportpoint4 = piece 'transportpoint4'
local transportpoint5 = piece 'transportpoint5'
local transportpoint6 = piece 'transportpoint6'
local thrust1 = piece 'thrust1'
local thrust2 = piece 'thrust2'
local thrust3 = piece 'thrust3'
local dthrust1 = piece 'dthrust1'
local dthrust2 = piece 'dthrust2'
local dthrust3 = piece 'dthrust3'
local dthrust4 = piece 'dthrust4'

local pID, moving, restore_delay

local BOOM	 = 1024+0
local BUILDINGFX	 = 1025+0

local AttachUnit = Spring.UnitScript.AttachUnit
local DropUnit = Spring.UnitScript.DropUnit

local loaded = 0
local unitLoaded = nil
local takeoffOrLanding = false

local function Turn2(piecenum,axis, degrees, speed)
	local radians = degrees * 3.1415 / 180
	if speed then
		local speed1 = speed * 3.1415 / 180
		Turn(piecenum, axis, radians, speed1) 
	else
		Turn(piecenum, axis, radians ) 
	end
end

local function closeDoors()
 	Turn2( rdoor, z_axis, 0, 200)
	Turn2( ldoor, z_axis, 0, 200)
end

local function openDoors()
 	Turn2( rdoor, z_axis, -90, 200)
	Turn2( ldoor, z_axis, 90, 200)
end

function script.Activate()
end

function script.Deactivate()
end

function script.QueryTransport ( passengerID )
		return (transportpoint)
end


function script.BeginTransport( passengerID )
	UnitScript.AttachUnit ( transportpoint, passengerID )
	loaded = loaded+1
	Sleep(500)
	if (loaded > 0) then 	
		StartThread(closeDoors)
	end	
end

function script.EndTransport() 
	for i,uid in pairs(Spring.GetUnitIsTransporting(unitID)) do 
		Spring.UnitScript.DropUnit (uid)	
		Sleep(200)
	end
	loaded = 0
 	SetUnitValue(COB.BUSY, 0)
	Sleep(500)
	if (loaded < 1) then 	
		StartThread(openDoors)
	end
end

function script.TransportPickup ( passengerID )
	UnitScript.AttachUnit ( transportpoint, passengerID )
	loaded = loaded+1
	Sleep(500)
	if (loaded > 0) then 	
		StartThread(closeDoors)
	end	
end

function script.Create()
	Turn2( base, y_axis, 250)	
	----------------------------------START BUILD CYCLE
	while (GetUnitValue(COB.BUILD_PERCENT_LEFT) > 0) do
		Sleep(100)
	end
	--------------------------------/END BUILD CYCLE	
	Sleep(500)
	Turn2( base, y_axis, 0, 100)		
	StartThread(openDoors)
	loaded = 0	
end

function script.StartMoving()
	moving = true
end

function script.StopMoving()
 	moving = false
end

function script.Killed(severity, corpsetype, smoketype)
		EmitSfx(base,BOOM)
		return (1)
end