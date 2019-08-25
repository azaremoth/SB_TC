local objectname= "bldg_tunnel_low" 
local featureDef  =  {
   name           = "bldg_tunnel_low",
   blocking       = true,	
   mass			   = 1000000000,
   collisionVolumeType 	= "Box",
   collisionVolumeScales 	= "40 40 80",
   collisionVolumeOffsets 	= "0 0 0", 
   damage            = 1000000000,
   description       = "Tunnel",
   energy            = 0,
   flammable         = 0,
   nodrawundergray   = false,
   footprintX        = 4,
   footprintZ        = 8,
   upright          = true,
   height      		= "30",
   hitdensity       = "1000000000",
   metal            = 0,
   object           = "features/bldg_tunnel_low.s3o",  
   reclaimable		= false,
   autoreclaimable	= false,
   world            = "allworld",
	customparams = { 
		normaltex 		= "unittextures/normalmaps/atlas_euf_buildings_normal.png",
		normalmaps 		= "yes",			
	},   
}
return lowerkeys({[featureDef.name] = featureDef})