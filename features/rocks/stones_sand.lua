local objects = {
	"features/rocks_sand/stones1.s3o",
	"features/rocks_sand/stones2.s3o",
	"features/rocks_sand/stones3.s3o",
	"features/rocks_sand/stones4.s3o",
	"features/rocks_sand/stones5.s3o",
	"features/rocks_sand/stones6.s3o",
	"features/rocks_sand/stones7.s3o",
	"features/rocks_sand/stones8.s3o",
}

local BuildingModuleDef = {}
local function createBuildingModuleDef(i)
  BuildingModuleDef["stones_sand" .. i] = {
     description = [[Sandy stones]],
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
     footprintX  = 2,
     footprintZ  = 2,
	 customparams = { 
			normaltex 		= "unittextures/normalmaps/rocks_sand.png",
			normalmaps 		= "yes",			
		},  
  }
end

for i=1,8 do
  createBuildingModuleDef(i)
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

return lowerkeys( BuildingModuleDef )

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------