local objects = {
	"features/rocks_redsand/rock1.s3o",
	"features/rocks_redsand/rock2.s3o",
	"features/rocks_redsand/rock3.s3o",
	"features/rocks_redsand/rock4.s3o",
	"features/rocks_redsand/rock5.s3o",
}

local BuildingModuleDef = {}
local function createBuildingModuleDef(i)
  BuildingModuleDef["rock_redsand" .. i] = {
     description = [[Red rocks]],
	 autoreclaimable = false,
     blocking    = true,
     burnable    = false,
     nodrawundergray = false,
     reclaimable = true,
	 upright 	 = false,	 
     energy      = 0,
     damage      = 10000,
     metal       = 100,
     reclaimTime = 10000,
     mass        = 9999999999,
     object = objects[(i % #objects) + 1] ,
     footprintX  = 6,
     footprintZ  = 6,
	 customparams = { 
			normaltex 		= "unittextures/normalmaps/rocks_sand.png",
			normalmaps 		= "yes",			
		},  
  }
end

for i=1,5 do
  createBuildingModuleDef(i)
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

return lowerkeys( BuildingModuleDef )

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------