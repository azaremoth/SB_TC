local objects = {
	"features/rocks_brown/stones1.s3o",
	"features/rocks_brown/stones2.s3o",
	"features/rocks_brown/stones3.s3o",
	"features/rocks_brown/stones4.s3o",
	"features/rocks_brown/stones5.s3o",
	"features/rocks_brown/stones6.s3o",
	"features/rocks_brown/stones7.s3o",
	"features/rocks_brown/stones8.s3o",
}

local BuildingModuleDef = {}
local function createBuildingModuleDef(i)
  BuildingModuleDef["stones_brown" .. i] = {
     description = [[Brown stones]],
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
			normaltex 		= "unittextures/normalmaps/rocks_brown.png",
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