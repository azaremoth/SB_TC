local objectname= "bldg_base2" 
local featureDef  =  {
   name           = "bldg_base2",
   blocking       = true,	
   mass			   = 1000000000,
   collisionVolumeType 	= "Box",
   collisionVolumeScales 	= "80 60 80",
   collisionVolumeOffsets 	= "0 0 0", 
   damage            = 1000000000,
   description       = "Building",
   energy            = 0,
   flammable         = 0,
   nodrawundergray   = false,
   footprintX        = 7,
   footprintZ        = 7,
   upright          = true,
   height      		= "60",
   hitdensity       = "1000000000",
   metal            = 0,
   object           = "features/bldg_base2.s3o",  
   reclaimable		= false,
   autoreclaimable	= false,
   world            = "allworld",
	customparams = { 
		normaltex 		= "unittextures/normalmaps/atlas_euf_buildings_normal.png",
		normalmaps 		= "yes",			
	},   
}
return lowerkeys({[featureDef.name] = featureDef})