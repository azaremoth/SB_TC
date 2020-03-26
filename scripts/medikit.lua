--include "common.lua"
local base = piece 'base'
local medikit = piece 'medikit'


local radius = tonumber(UnitDefs[unitDefID].customParams.healradius) or 100
local x, y, z = Spring.GetUnitPosition(unitID)
local unittohealID = nil

local function Turn2(piecenum,axis, degrees, speed)
	local radians = degrees * 3.1415 / 180
	if speed then
		local speed1 = speed * 3.1415 / 180
		Turn(piecenum, axis, radians, speed1) 
	else
		Turn(piecenum, axis, radians ) 
	end
end

local function Checking()
	while true do
		local unitsAround = Spring.GetUnitsInSphere(x,y,z, radius)
		for _,aUnitID in ipairs(unitsAround) do
			local aLocalteam = Spring.GetUnitTeam(aUnitID)
			local aAi = select(4, Spring.GetTeamInfo(aLocalteam))
			local UnitHealth, UnitMaxHealth = Spring.GetUnitHealth(aUnitID)			
			if (not aAi) and (UnitHealth < UnitMaxHealth) then
				unittohealID = aUnitID
				Spring.DestroyUnit(unitID,false,false)
			end
		end
		Sleep(1000)
	end
end

local function Heal()
	if unittohealID ~= nil then
		local UnitHealth, UnitMaxHealth = Spring.GetUnitHealth(unittohealID)
		if (UnitHealth < UnitMaxHealth) then
			Spring.SetUnitHealth(unittohealID, UnitMaxHealth)
			local hx, hy, hz = Spring.GetUnitPosition(unittohealID)
			Spring.SpawnCEG('AURA_HEAL', hx+math.random(10)-math.random(10), hy+0, hz+math.random(10)-math.random(10))
			Spring.SpawnCEG('AURA_HEAL', hx+math.random(10)-math.random(10), hy+15, hz+math.random(10)-math.random(10))
			Spring.SpawnCEG('AURA_HEAL', hx+math.random(10)-math.random(10), hy+25, hz+math.random(10)-math.random(10))			
		end
	end
end

function script.Create( )
	Spring.SetUnitNeutral(unitID, true)
	SendToUnsynced('setselectable', unitID, false)	
	Turn2( medikit, y_axis, math.random(360), 100 )
	StartThread(Checking)
	Spring.SetUnitBlocking(unitID, false, false, false, false, false, false, false)
--	Spring.SetUnitCloak(unitID, 2, 0)	
end

function script.Killed()
	Spring.SpawnCEG('AURA_HEAL', x, y+10, z)
	Spring.SpawnCEG('BURROWING', x, y, z)	
	Heal()
	--return 0
end