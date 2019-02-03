local objectname= "scaffold_6x6_high" 
local featureDef  =  {
   name           = "scaffold_6x6_high",
   blocking       = false,
    category         = [[corpses]],
   damage            = 100000,
   description       = "scaffold 6x6 high",
   energy            = 0,
   flammable         = 0,
   nodrawundergray   = true,  
   footprintX        = 6,
   footprintZ        = 6,
   upright           = true,
   height            = "0",
   hitdensity        = "100000",
   metal          = 0,
   object            = "features/euf_scaffold_6x6_high.s3o",
   flammable		= false,
   reclaimable		= false,
   autoreclaimable	= false,
   indestructible	= true,
   world          = "All Worlds",
}
return lowerkeys({[featureDef.name] = featureDef})
