-- UNITDEF -- tc_restless --
--------------------------------------------------------------------------------

local unitName = "tc_restless"

--------------------------------------------------------------------------------

local unitDef = {
  acceleration       = 1.0,
  activateWhenBuilt  = true,
  armortype          = "LIGHT",
  badTargetCategory  = "AIR",
  brakeRate          = 1.5,
  buildCostEnergy    = 110,
  buildCostMetal     = 110,
  buildDistance      = 200,
  builder            = true,
  buildPic           = "tc_restless.png",
  buildTime          = 110,
  canAssist          = true,
  canAttack          = false,
  canBeAssisted      = false,
  canCapture         = false,
  canGuard           = true,
  --canHover           = true,
  canMove            = true,
  canPatrol          = true,
  canReclaim         = true,
  canRepair          = true,
  canResurrect       = false,
  canstop            = true,
  cantBeTransported  = false, 
  capturable         = false,    
  captureSpeed       = 0,
  category           = "CURSED LAND LIGHTARMOR",
--  collisionVolumeOffsets = "0 0 0",
--  collisionVolumeScales = "20 50 20",
--  collisionVolumeType = "CylY",
  customParams          = {
	factionname		   = "cursed",
	area_mex_def = "tc_metalextractor_lvl1",	
	isinfantry = "true",
	isbones = "true",
    helptext = "A hovering structure summoner."			
  },
  defaultmissiontype = "Standby",
  description        = "summons structures",
  energyMake         = 2,
  energyStorage      = 0,
  explodeAs          = "SMOKE_EXPLOSION",
  firestandorders    = "1",
  footprintX         = 2,
  footprintZ         = 2,
  iconType           = "spanner",
  idleAutoHeal       = 2.5,
  idleTime           = 400,
  mass               = 3000,
  maxDamage          = 900,
  maxSlope           = 14,
  maxVelocity        = 2,
  maxWaterDepth      = 35,
  metalMake          = 0.25,
  metalStorage       = 0,
  mobilestandorders  = "1",
  movementClass      = "SMALLHOVER2x2",
  name               = "Restless",
  nanoColor          = "0.6 1 0.15",
  noChaseCategory    = "AIR",
  objectName         = "tc_restless.s3o",
  radarDistance      = 768,
  reclaimSpeed       = 5,
  repairSpeed        = 4,
  repairable         = false,     
  resurrectSpeed     = 0,
  selfDestructAs     = "SMOKE_EXPLOSION",
  showNanoFrame      = false,
  showNanoSpray      = false,
  side               = "cursed",
  sightDistance      = 512,
  smoothAnim         = false,
  sonarDistance      = 768,
  standingfireorder  = "2",
  standingmoveorder  = "0",
  terraformSpeed     = 1200,
  turnRate           = 1005,
  unitname           = "tc_restless",
  upright            = true,
  workerTime         = 25,
  buildoptions = {
    "tc_metalextractor_lvl1",
    "tc_soulstone",
    "tc_pyramid_ai",
    "tc_darkassembler",
    "tc_storage",	
    "tc_pitt",
    "tc_defender",
    "tc_hellfire",	
    "tc_seer",
    "tc_heart",
    "tc_bonebeast",
  },
  sfxtypes = {
    explosiongenerators = {
      "custom:SPIKES_NECROMANCER",
      "custom:REDGREENBLOOD_EXPLOSION",
    },
  },
  sounds = {
    build              = "",
    canceldestruct     = "",
    repair             = "",
    underattack        = "bell",
    working            = "",
    arrived = {
      "",
    },
    cant = {
      "",
    },
    count = {
      "",
      "",
      "",
      "",
      "",
      "",
    },
    ok = {
      "lich",
    },
    select = {
      "lich",
    },
  },
}


--------------------------------------------------------------------------------

return lowerkeys({ [unitName] = unitDef })

--------------------------------------------------------------------------------
