--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
--
--  file:    game_spawn.lua
--  brief:   spawns start unit and sets storage levels
--  author:  Tobi Vollebregt
--
--  Copyright (C) 2010.
--  Licensed under the terms of the GNU GPL, v2 or later.
--
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function gadget:GetInfo()
	return {
		name      = "Spawn",
		desc      = "spawns start unit and sets storage levels",
		author    = "azaremoth",
		date      = "January, 2010",
		license   = "GNU GPL, v2 or later",
		layer     = 0,
		enabled   = true  --  loaded by default?
	}
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

-- synced only
if (not gadgetHandler:IsSyncedCode()) then
	return false
end

local Gaia = Spring.GetGaiaTeamID
local modOptions = Spring.GetModOptions()
local cheatAItype = "0"
local cpvmode = false
local cpvstartbase = false
local luaSetStartPositions = {}
local MsgStartFaction = '^\138(%d+)$'
	
local ChickenAIs = VFS.Include("LuaRules/Configs/ai_chickenlist.lua")	

-- Spring.Echo("CPV mode " .. Spring.GetModOptions().scoremode)
-- Spring.Echo("CPV mode " .. Spring.GetModOptions().startbase)

if (Spring.GetModOptions().scoremode ~= nil) then
	if (Spring.GetModOptions().scoremode ~= "disabled") then
		cpvmode = true
	end
end

if (cpvmode and Spring.GetModOptions().startbase ~= nil) then
	if (Spring.GetModOptions().startbase == "1") then
		cpvstartbase = true
	else
		cpvstartbase = false
	end
end

function gadget:Initialize()
	GG.teamside = GG.teamside or {}
	
	local teams = Spring.GetTeamList()
	for i = 1,#teams do
		local teamID = teams[i]
		-- don't spawn a start unit for the Gaia team
		if (teamID ~= Gaia) then
			local side = select(5, Spring.GetTeamInfo(teamID))
			if (side ~= "imperials" and side ~= "cursed") then
				if (math.random() > 0.5) then
					side = "imperials"
				else
					side = "cursed"
				end
			end
			GG.teamside[teamID] = side
			Spring.SetTeamRulesParam(teamID, "side", side, {allied=true, public=false}) 
		end
	end	
end


----------------------------------------------------------------
-- LuaUI Interaction
----------------------------------------------------------------

function gadget:RecvLuaMsg(msg, playerID)
	-- these messages are only useful during pre-game placement
	if Spring.GetGameFrame() > 0 then
		return false
	end

	local code = string.sub(msg,1,1)
	if code ~= '\138' then
		return
	end
	local side = string.sub(msg,2,string.len(msg))
	-- Spring.Echo("start Faction:")
	-- Spring.Echo(side)
	
	local _, _, playerIsSpec, playerTeam = Spring.GetPlayerInfo(playerID)
	if not playerIsSpec then
		GG.teamside[playerTeam] = side
		Spring.SetTeamRulesParam(playerTeam, "side", side, {allied=true, public=false}) -- visible to allies only, set visible to all on GameStart
		side = select(5, Spring.GetTeamInfo(playerTeam))
		return true
	end
end


----------------------------------------------------------------

local function getMiddleOfStartBox(teamID)
	local x = Game.mapSizeX / 2
	local z = Game.mapSizeZ / 2

	local boxID = Spring.GetTeamRulesParam(teamID, "start_box_id")
	if boxID then
		local startposList = GG.startBoxConfig[boxID] and GG.startBoxConfig[boxID].startpoints
		if startposList then
			local startpos = startposList[1] -- todo: distribute afkers over them all instead of always using the 1st
			x = startpos[1]
			z = startpos[2]
		end
	else -- using middle of lobby pre-defined box
		local allyID = select(6, Spring.GetTeamInfo(teamID))
		local a,b,c,d = Spring.GetAllyTeamStartBox(allyID)
		x = (a+c)/2
		z = (b+d)/2
	end

	return x, Spring.GetGroundHeight(x,z), z
end

local function GetStartPos(teamID, teamInfo, isAI)
	if luaSetStartPositions[teamID] then
		return luaSetStartPositions[teamID].x, luaSetStartPositions[teamID].y, luaSetStartPositions[teamID].z
	end
	
	if fixedStartPos then
		local x, y, z
		if teamInfo then
			x, z = tonumber(teamInfo.start_x), tonumber(teamInfo.start_z)
		end
		if x then
			y = Spring.GetGroundHeight(x, z)
		else
			x, y, z = Spring.GetTeamStartPosition(teamID)
		end
		return x, y, z
	end
	
	if not (Spring.GetTeamRulesParam(teamID, "valid_startpos") or isAI) then
		local x, y, z = getMiddleOfStartBox(teamID)
		return x, y, z
	end
	
	local x, y, z = Spring.GetTeamStartPosition(teamID)
	-- clamp invalid positions
	-- AIs can place them -- remove this once AIs are able to be filtered through AllowStartPosition
	local boxID = isAI and Spring.GetTeamRulesParam(teamID, "start_box_id")
	if boxID and not GG.CheckStartbox(boxID, x, z) then
		x,y,z = getMiddleOfStartBox(teamID)
	end
	return x, y, z
end

local function SetStartLocation(teamID, x, z)
    luaSetStartPositions[teamID] = {x = x, y = Spring.GetGroundHeight(x,z), z = z}
end
GG.SetStartLocation = SetStartLocation

----  Spawns -------------------------------------------
local function Spawn (teamID, x, y, z)
	local zero = Spring.CreateUnit("pig", x-50,y,z+50, math.random(3), teamID)
end

----------------------------------------------------------------


local function SpawnstartFaction(teamID)
	-- get the team startup info
--	local side = select(5, Spring.GetTeamInfo(teamID))
	local side = GG.teamside[teamID] or "cursed"
	local ai = select(4, Spring.GetTeamInfo(teamID))
	local teamInfo = teamID and select(7, Spring.GetTeamInfo(teamID))
	local IsChickenAI = false
	if (ai and ChickenAIs[Spring.GetTeamLuaAI(teamID)]) then
		IsChickenAI = true
	end

	local x,y,z = Spring.GetTeamStartPosition(teamID)
	
	-- startPosType 0 = fixed / 1 = random / 2 = choose in game / 3 = choose before game (on map)
	if (Game.startPosType ~= 3) and (Spring.GetTeamRulesParam(teamID, "valid_startpos") ~= 2) then  --> Start Boxes active
		x,y,z = GetStartPos(teamID, teamInfo, ai)
	elseif	ai then
		x,y,z = getMiddleOfStartBox(teamID)
	end

	if Spring.GetModOptions().cheatingai ~= nil then
		cheatAItype = Spring.GetModOptions().cheatingai
	end 
	
	Spawn (teamID, x, y, z)				

end

local function SetStartingResources(teamID)
	-- set start resources, either from mod options or custom team keys
	local teamOptions = select(7, Spring.GetTeamInfo(teamID))
	local m = modOptions.startmetal or teamOptions.startmetal or 1000
	local e = modOptions.startenergy or teamOptions.startenergy or 2000
	-- using SetTeamResource to get rid of any existing resource without affecting stats
	-- using AddTeamResource to add starting resource and counting it as income
	if (m and tonumber(m) ~= 0) then
		-- remove the pre-existing storage
		--   must be done after the start unit is spawned,
		--   otherwise the starting resources are lost!
		Spring.SetTeamResource(teamID, "ms", tonumber(m))
		Spring.SetTeamResource(teamID, "m", 0)
		Spring.AddTeamResource(teamID, "m", tonumber(m))
	end
	if (e and tonumber(e) ~= 0) then
		-- remove the pre-existing storage
		--   must be done after the start unit is spawned,
		--   otherwise the starting resources are lost!
		Spring.SetTeamResource(teamID, "es", tonumber(e))
		Spring.SetTeamResource(teamID, "e", 0)
		Spring.AddTeamResource(teamID, "e", tonumber(e))
	end
end

function gadget:GameStart()
	local gaiaTeamID = Spring.GetGaiaTeamID()
	local teams = Spring.GetTeamList()
			
	for i = 1,#teams do
		local teamID = teams[i]
		-- don't spawn a start unit for the Gaia team
		if (teamID ~= gaiaTeamID) then
			SpawnstartFaction(teamID)
			SetStartingResources(teamID)
		end
	end	
end
