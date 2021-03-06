---
-- Name: AID-A2A-100 - Demonstration
-- Author: FlightControl
-- Date Created: 30 May 2017

local HQ_Group = GROUP:FindByName( "HQ" )
local HQ_CC = COMMANDCENTER:New( HQ_Group, "HQ" )

-- Define a SET_GROUP object that builds a collection of groups that define the EWR network.
-- Here we build the network with all the groups that have a name starting with DF CCCP AWACS and DF CCCP EWR.
local DetectionSetGroup = SET_GROUP:New()
DetectionSetGroup:FilterPrefixes( { "DF CCCP AWACS", "DF CCCP EWR" } )
DetectionSetGroup:FilterStart()

local Detection = DETECTION_AREAS:New( DetectionSetGroup, 30000 )

-- Setup the A2A dispatcher, and initialize it.
A2ADispatcher = AI_A2A_DISPATCHER:New( Detection )
A2ADispatcher:SetCommandCenter( HQ_CC )

-- Enable the tactical display panel.
A2ADispatcher:SetTacticalDisplay( false )
A2ADispatcher:SetTacticalMenu( "Dispatchers", "A2A" )

-- Initialize the dispatcher, setting up a border zone. This is a polygon, 
-- which takes the waypoints of a late activated group with the name CCCP Border as the boundaries of the border area.
-- Any enemy crossing this border will be engaged.
CCCPBorderZone = ZONE_POLYGON:New( "CCCP Border", GROUP:FindByName( "CCCP Border" ) )
A2ADispatcher:SetBorderZone( CCCPBorderZone )

-- Initialize the dispatcher, setting up a radius of 100km where any airborne friendly 
-- without an assignment within 100km radius from a detected target, will engage that target.
A2ADispatcher:SetEngageRadius( 120000 )

-- Setup the squadrons.
A2ADispatcher:SetSquadron( "Mineralnye", AIRBASE.Caucasus.Mineralnye_Vody, { "SQ CCCP SU-27", "SQ CCCP SU-33", "SQ CCCP MIG-23MLD", "SQ CCCP MIG-25PD" }, 16 )
A2ADispatcher:SetSquadron( "Maykop", AIRBASE.Caucasus.Maykop_Khanskaya, { "SQ CCCP MIG-31" }, 20 )
A2ADispatcher:SetSquadron( "Mozdok", AIRBASE.Caucasus.Mozdok, { "SQ CCCP MIG-31" }, 16 )
A2ADispatcher:SetSquadron( "Sochi", AIRBASE.Caucasus.Sochi_Adler, { "SQ CCCP SU-27", "SQ CCCP SU-33", "SQ CCCP MIG-23MLD", "SQ CCCP MIG-25PD", "SQ CCCP SU-34", "SQ CCCP MIG-31", "SQ CCCP MIG-29S" }, 40 )
A2ADispatcher:SetSquadron( "Novo", AIRBASE.Caucasus.Novorossiysk, { "SQ CCCP SU-27" }, 16 )

-- Setup the overhead
A2ADispatcher:SetSquadronOverhead( "Mineralnye", 1.2 )
A2ADispatcher:SetSquadronOverhead( "Maykop", 1 )
A2ADispatcher:SetSquadronOverhead( "Mozdok", 1 )
A2ADispatcher:SetSquadronOverhead( "Sochi", 2 )
A2ADispatcher:SetSquadronOverhead( "Novo", 1.5 )

-- Setup the Grouping
A2ADispatcher:SetSquadronGrouping( "Mineralnye", 4 )
A2ADispatcher:SetSquadronGrouping( "Sochi", 2 )
A2ADispatcher:SetSquadronGrouping( "Novo", 3 )

-- Setup the Takeoff methods
A2ADispatcher:SetSquadronTakeoff( "Mineralnye", AI_A2A_DISPATCHER.Takeoff.Hot )
A2ADispatcher:SetSquadronTakeoffFromParkingHot( "Sochi" )
A2ADispatcher:SetSquadronTakeoffFromRunway( "Mozdok" )
A2ADispatcher:SetSquadronTakeoffFromParkingCold( "Maykop" )
A2ADispatcher:SetSquadronTakeoffFromParkingHot( "Novo" )

-- Setup the Landing methods
A2ADispatcher:SetSquadronLandingAtRunway( "Mineralnye" )
A2ADispatcher:SetSquadronLandingNearAirbase( "Sochi" )
A2ADispatcher:SetSquadronLandingAtEngineShutdown( "Mozdok" )
A2ADispatcher:SetSquadronLandingNearAirbase( "Maykop" )
A2ADispatcher:SetSquadronLanding( "Novo", AI_A2A_DISPATCHER.Landing.AtRunway )


-- CAP Squadron execution.
--CAPZoneEast = ZONE_POLYGON:New( "CAP Zone East", GROUP:FindByName( "CAP Zone East" ) )
--A2ADispatcher:SetSquadronCap( "Mineralnye", CAPZoneEast, 4000, 10000, 500, 600, 800, 900 )
--A2ADispatcher:SetSquadronCapInterval( "Mineralnye", 6, 30, 60, 1 )

--CAPZoneWest = ZONE_POLYGON:New( "CAP Zone West", GROUP:FindByName( "CAP Zone West" ) )
--A2ADispatcher:SetSquadronCap( "Sochi", CAPZoneWest, 4000, 8000, 600, 800, 800, 1200, "BARO" )
--A2ADispatcher:SetSquadronCapInterval( "Sochi", 2, 30, 120, 1 )

--CAPZoneMiddle = ZONE:New( "CAP Zone Middle")
--A2ADispatcher:SetSquadronCap( "Maykop", CAPZoneMiddle, 4000, 8000, 600, 800, 800, 1200, "RADIO" )
--A2ADispatcher:SetSquadronCapInterval( "Sochi", 2, 30, 120, 1 )

-- GCI Squadron execution.
A2ADispatcher:SetSquadronGci2( "Mozdok", 900, 1200, 100, 100, "RADIO" )
A2ADispatcher:SetSquadronGci2( "Novo", 900, 2100, 100, 100, "RADIO" )
A2ADispatcher:SetSquadronGci2( "Maykop", 900, 1200, 200, 200, "RADIO" )

-- Set the language of the squadrons to Russian.
A2ADispatcher:SetSquadronLanguage( "Mozdok", "RU" )
A2ADispatcher:SetSquadronLanguage( "Novo", "RU" )
A2ADispatcher:SetSquadronLanguage( "Maykop", "RU" )

A2ADispatcher:SetSquadronRadioFrequency( "Mozdok", 127.5 )
A2ADispatcher:SetSquadronRadioFrequency( "Novo", 127.5 )
A2ADispatcher:SetSquadronRadioFrequency( "Maykop", 127.5 )


-- Set the squadrons visible before startup.
--A2ADispatcher:SetSquadronVisible( "Mineralnye" )
--A2ADispatcher:SetSquadronVisible( "Sochi" )
--A2ADispatcher:SetSquadronVisible( "Mozdok" )
--A2ADispatcher:SetSquadronVisible( "Maykop" )
--A2ADispatcher:SetSquadronVisible( "Novo" )


--CleanUp = CLEANUP_AIRBASE:New( { AIRBASE.Caucasus.Novorossiysk } )


-- Blue attack simulation
local Frequency = 300

BlueSpawn1 = SPAWN
  :New( "RT NATO 1" )
  :InitLimit( 2, 10 )
  :InitRandomizeTemplate( { "SQ NATO A-10C", "SQ NATO F-15C", "SQ NATO F-16A", "SQ NATO F/A-18", "SQ NATO F-16C" } )
  :InitRandomizeRoute( 0, 0, 30000 )
  --:InitDelayOn()
  :SpawnScheduled( Frequency, 0.4 )

BlueSpawn2 = SPAWN
  :New( "RT NATO 2" )
  :InitLimit( 2, 10 )
  :InitRandomizeTemplate( { "SQ NATO A-10C", "SQ NATO F-15C", "SQ NATO F-16A", "SQ NATO F/A-18", "SQ NATO F-16C" } )
  :InitRandomizeRoute( 0, 0, 30000 )
  --:InitDelayOn()
  :SpawnScheduled( Frequency, 0.4 )

BlueSpawn3 = SPAWN
  :New( "RT NATO 3" )
  :InitLimit( 2, 10 )
  :InitRandomizeTemplate( { "SQ NATO A-10C", "SQ NATO F-15C", "SQ NATO F-16A", "SQ NATO F/A-18", "SQ NATO F-16C" } )
  :InitRandomizeRoute( 0, 0, 30000 )
  --:InitDelayOn()
  :SpawnScheduled( Frequency, 0.4 )

BlueSpawn4 = SPAWN
  :New( "RT NATO 4" )
  :InitLimit( 2, 10 )
  :InitRandomizeTemplate( { "SQ NATO A-10C", "SQ NATO F-15C", "SQ NATO F-16A", "SQ NATO F/A-18", "SQ NATO F-16C" } )
  :InitRandomizeRoute( 0, 0, 30000 )
  --:InitDelayOn()
  :SpawnScheduled( Frequency, 0.4 )

