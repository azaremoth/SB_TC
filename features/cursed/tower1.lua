local objectname= "tower1" 
local featureDef  =  {
   name           = "tower1",
   blocking       = true,	
   mass			   = 1000000000,
   collisionVolumeType 	= "Box",
   collisionVolumeScales 	= "60 575 60",
   collisionVolumeOffsets 	= "0 0 0", 
   damage            = 1000000000,
   description       = "Building",
   energy            = 0,
   flammable         = 0,
   nodrawundergray   = false,
   footprintX        = 6,
   footprintZ        = 6,
   upright          = true,
   height      		= "60",
   hitdensity       = "1000000000",
   metal            = 0,
   object           = "features/tower1.s3o",  
   reclaimable		= false,
   autoreclaimable	= false,
   world            = "allworld",
	customparams = { 
		normaltex 		= "unittextures/normalmaps/atlas_euf_buildings_normal.png",
		normalmaps 		= "yes",			
	},   
}
return lowerkeys({[featureDef.name] = featureDef})
