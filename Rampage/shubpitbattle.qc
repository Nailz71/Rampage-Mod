		// RAMPAGE Mod file. Last Updated 14 Dec 23

/*
================================
TODO
 * Alter Shub-Missile so it is more akin to birthing of other entities, and looks/acts less like vore missile.

###================= nlz:Shub-Missile================###

  Update, now explodes like a rocket, Vore-Missile has purple particles that represent the mind gas.

 Changed the Vore Explosion sound (airdoor) so it sounds like gas released.

 Shub-Missile no longer has disorientation but it does give the player a good shove in one direction on impact. Dmg has been increased (49).

added snd + quadlight.

		-----------------------------------

 * Add CanDamage() check to sentinel attack

###================= nlz:Sentinel================###

BUGS
 * nlz: [14.01.2023]
The power sound played when sentinel fires continues to play out its (recharge sound) even if sentinel was destroyed.
UPDATE: Think I fixed it now plays null.wav in orb explode (death) on same channel (weapon)


RECENT FIXES & CHANGES

 * nlz: [14.01.2023]
 Changed waypoints higher/wider along main passage.
 Changed refire time to .25 was .15, short invividual zapps.
 Each zapp can do random DMG 0 > 5. If its 4 or 5, player      painsound() is also called, this along with the jolt should be enough to alert players they are getting hurt. 
* nlz: [14.01.2023]

Adding enfstop to zap with varios volumes depending on damage
a light effect might actually make sense here too (i couldnt get it to switch off)

 * [13.01.2023]
 * Reworked some parts of Sentinel movement and attack. Shouldn't stop when firing at corners.
 * Added Jolt() function. Used by sentinel attack but can be called for any entity.
 * [16.12.2022]
 * Wardweavers take longer to cast their spell (animations might need tweaking for looks). //nlz: this was reverted, I may slow the speed spell travels.
 * Wardweavers are invulnerable until after they teleport.
 * Shub's invulnerability from Wardweaver spell lasts 7 secs, was 5. //nlz: changed to 3.5 secs
 * Only 2 Sentinels can be patrolling at the same time (was 3). //nlz changed back to 3
 * Fixed the particles appearing at start. //nlz: broke again because I reveted back to earlier wardweaver.qc
 * [27.11.2022]
 * Player Name Scan shouldn't clear all centreprint messages anymore (except when a player is looked at).
 * Shub was incorrectly locking herself out of firing missiles once sentinels were unlocked (actually fixed now!).
 * [24.11.2022] 
 * Newly birthed wardweavers can't be pained until after they teleport (they won't get stuck above shub)
 * Wardweaver console message "Bot Entity Manager: Unknown monster..." for WardWeaver no longer shows; but the wardweaver does not have self.flags FL_MONSTER set anymore - doesn't seem to affect anything.
 * Wardweavers count towards total_monsters and killed_monsters (sentinels don't).


================================


==============================================================================
[SHUB NIGGURATH'S LAIR BATTLE]

Controls some of the extra battle mechanics that occur in the Rampage Mod for
the final fight.

The teleporter spikey thing and the telefragging gimmick is disabled for this version of the battle.
The goal is to kill shub with damage.

Shub gives birth to Ward Weavers - modified scraggs that will teleport to near the ceiling and
cast a warding spell at shub that makes her invulnerable. A maximum of 3 ward weavers can be in
play at once.
If the Wardweavers are killed before new ones can cast their spell, the invulnerability ward will fade
from shub and she can be directly harmed.

Shub will also birth Sentinels (spiked orbs) that will patrol around the map. They will zap nearby
players and explode if too close. Shub won't birth more then 3 at one time.

Shub still fires homing missiles when possible.
==============================================================================
*/

vector NO_VECTOR = '666 666 666';	//used to detect non-valid vector 
vector wardWeaver_spawnPoints[6];	//array of locations where the wardweavers can choose to teleport to
entity wardWeavers[3];				//array holding refereces for spawned wardweavers (max 3)

entity sentinels[3]; //array holding references for spawned sentinels 2 until 36 kills (this is when shub missile stops)

vector waypoints[11];				//sentinel path locations stored in this array

void(vector birthpoint) SpawnWardWeaver;
void() SpikedOrb_Combat;
void() SpikedOrb_Detonate;
vector() FindWWSpawn;
void() InvulnerabilityWard;
void(float stop = FALSE) WW_SlowToStop;
entity shub;

/*---------------------------------------------------------------------------
[SET WARD WEAVER SPAWN LOCATIONS & WAYPOINTS FOR SENTINELS]

Adds the listed coordinates as ward weaver spawn points.
Also does the waypoints.

*ALSO removes the spikey telefrag ball, and makes it's teleporter exit near the start.
---------------------------------------------------------------------------*/
void() SetSpawnAndWayPoints = 
{
	wardWeaver_spawnPoints[0] = '-1060 2507 500';	//above teleporter at end
	wardWeaver_spawnPoints[1] = '-442 2700 500';	//behind quad area
	wardWeaver_spawnPoints[2] = '-1286 1649 500';	//
	wardWeaver_spawnPoints[3] = '-1233 2162 500';	//halfway along path`
	wardWeaver_spawnPoints[4] = '-460 1783 500';	//near first sighting of shub
	wardWeaver_spawnPoints[5] = '-792 2813 500';	//behind quad area (teleporter side)

	//used for sentinel orbs
	
/*		OSP Original waypoints
	waypoints[0] = '-608 1436 272';
	waypoints[1] = '-1338 1363 320';
	waypoints[2] = '-1442 1448.6 336';
	waypoints[3] = '-1549 1888 336';
	waypoints[4] = '-1516 2068 336';
	waypoints[5] = '-1250 2108 368';
	waypoints[6] = '-991 2187.5 272';
	waypoints[7] = '-888 2462 344';
	waypoints[8] = '-482.5 2482 282';
	waypoints[9] = '-490 2133 272';
	waypoints[10] = '-506 1842 260';

*/

//nlz: higher / wider waypoints along path

	//used for sentinel orbs
	waypoints[0] = '-608 1436 360';
	waypoints[1] = '-1388 1363 480'; 
	waypoints[2] = '-1530 1448.6 440'; 
	waypoints[3] = '-1600 1888 420';
	waypoints[4] = '-1546 2068 336'; 
	waypoints[5] = '-1250 2108 368';
	waypoints[6] = '-991 2187.5 272';
	waypoints[7] = '-888 2462 344';
	waypoints[8] = '-482.5 2482 282';
	waypoints[9] = '-490 2133 272';
	waypoints[10] = '-506 1842 260';


/*nlz: now done in end.bsp
	//find entity for final teleporter; change its target to the begining area. 
	local entity e = find(world, target, "t33");
	e.target = "t32";
	
	//remove the spikey teleporter object
	e = find(world, classname, "misc_teleporttrain");
	remove (e);
*/
};



/*---------------------------------------------------------------------------
[SPAWN WARD WEAVER]
 
Creates a Ward Weaver wizard at the specified location.
References it in wardWeavers[].
wardtarget is set as the enemy, and also the owner (a back up incase the wardweaver
gets aggro)
---------------------------------------------------------------------------*/
void(vector birthpoint) SpawnWardWeaver = 
{
	// find the free spot for the ward weaver. If none found, abort.
	
	local float free = -1;
	for (float i = 0; i < wardWeavers.length; i++)
	{
		if (wardWeavers[i].classname != "monster_wardweaver")
		{
			free = i;
			break;
		}
	}

	if (free == -1)
		return;

	//Create new ward weaver
	local entity ww = spawn();
	local entity oself;

	//store reference in the free spot
	wardWeavers[free] = ww;

	oself = self;
    self = ww;
	Monster_WardWeaver(oself.origin + birthpoint, oself);	//turns ww into ward weaver at location

	//throw so as to appear it got squirted out...
	self.velocity = self.velocity + '0 0 1' *500;
	self.movetype = MOVETYPE_FLY;
	//self.solid = SOLID_NOT;

	self = oself;
};


/*---------------------------------------------------------------------------
[TELEPORT WARD WEAVER]
 
Finds an empty teleport(spawn) location and blinks to it. Mimics the scrag's teleport.
---------------------------------------------------------------------------*/
void() Teleport_WardWeaver = 
{
	local vector location = FindWWSpawn();
	

	//No valid empty spawn location, don't spawn.
	if (location == NO_VECTOR)
		return;
		
	spawn_tfog(self.origin);
	setorigin(self, location);
    spawn_tfog(location);
};


/*---------------------------------------------------------------------------
FIND VACANT LOCATION (FOR WARD WEAVER)
 
Returns a random vacant ward weaver spawn vector (if no ward weaver near it).

<!> Will randomly choose a spawn then check if it is free of existing ward weavers.
    This is inefficient, so if will only try 10 times.
---------------------------------------------------------------------------*/
vector() FindWWSpawn = 
{
	local float tries = 0;

	while (tries < 10)
	{
		float isEmpty = TRUE;
		local float index = random() * wardWeaver_spawnPoints.length;	//gets a random spawn point index

		//check if spawn i has a ward weaver within a small radius of it
		local entity head = findradius(wardWeaver_spawnPoints[index], 200);
		while (head)
		{
			//is head a ward weaver? if so we can't use this spawn. move on
			if (head.classname == "monster_wardweaver")
			{
				isEmpty = FALSE;
				break;
			}

			head = head.chain;
		}
		

		if (isEmpty == TRUE)
				return wardWeaver_spawnPoints[index];

		tries ++;
	}
	
	//no free spawn points...
	return NO_VECTOR;
};


/*---------------------------------------------------------------------------
[SLOW TO STOP]

Reduces the vertical speed of an entity by 20% of its current value.
Used to slow the eject speed on newly 'birthed' wardweavers and sentinels that pop out of shub.
(stop == true) will set the velocity to 0.
---------------------------------------------------------------------------*/
void(float stop = FALSE) WW_SlowToStop =
{
	if (stop)
		self.velocity = '0 0 0';
	else
		self.velocity = self.velocity - ('0 0 1' * ( self.velocity_z * 0.2f));


//nlz: add light effect WW's & sentinels once ejected
self.effects = self.effects | EF_DIMLIGHT;

};


/*---------------------------------------------------------------------------
[SENTINEL (SPIKEBALL) BEHAVIOUR]

MOVEMENT (BEHAVIOUR)
Relies on the the .waypoints vector[] for path.
Stores current target destination vector as .dest
Stores current waypoint index as .frags
When at destination, will ask for next destination.
Loops endlessly.

JOLT (Added 12.01.2023)
A non-damaging knockback with a vertical toss component. Similar to normal attack physics.
Not specific to Sentinels, can be called on any entity.
Knockback push direction is from inflictor. Toss power will throw into air (if positve).

BIRTH
Will be shot at speed upwards, but then slows almost to a stop.

COMBAT
Fires a lightning bolt at medium range.
Explodes when in melee range.

DETONATE
Explodes when destroyed or close to a player.
---------------------------------------------------------------------------*/

void(entity targ, entity inflictor, float power, float tossPower) Jolt = 
{
	local vector dir, airToss;
	
	dir = targ.origin - (inflictor.absmin + inflictor.absmax) * 0.5;
	dir = normalize(dir);
	airToss = '0 0 1' * tossPower;
	targ.velocity = targ.velocity + (dir * power) + airToss;
	
/*
	//Sourced from T_Damage(..) (segment here for reference while testing)
	//figure momentum add
	if ( (inflictor != world) && (targ.movetype == MOVETYPE_WALK) )
	{
		dir = targ.origin - (inflictor.absmin + inflictor.absmax) * 0.5;
		dir = normalize(dir);
		targ.velocity = targ.velocity + dir*damage*8;
	}
*/
}

void() SpikedOrb_Behaviour = 
{
	local vector dest;
	local float interval = 0.25; //nlz: was 0.15, slow rate of refire 
	local float len, traveltime;
	
	//Move to destination
	dest = waypoints[self.frags] - self.origin;

	// calculate length of vector
	len = vlen(dest);

	// divide by speed to get time to reach dest
	traveltime = len / 250f;

	//if close enough to current destination waypoint, set next.

//nlz: sound for sentinel as it floats around, basekey partial low vol, only want to hear if close
sound (self, CHAN_BODY, "misc/basekey.wav", 0.18, ATTN_NORM);


if (shub.health < 1) //nlz: Sentinels self destruct when shub is killed? delay would be better.
	{
	SpikedOrb_Detonate();
	}

	if (traveltime < interval)
	{
		self.velocity = '0 0 0';
		self.nextthink = time + interval;

		//if next index is > length of vector, go to 0
		if (self.frags + 1 >= waypoints.length)
			self.frags = 0;
		else
			self.frags = self.frags + 1;

		return;
	}

	// Set nextthink to the interval time (to check for enemies) unless the time to destination 
	// is less than interval (then set as traveltime).
	if (traveltime < interval)
		// set nextthink to trigger a think when dest is reached
		self.nextthink = time + traveltime;
	else
		self.nextthink = time + interval;

	// scale the dest vector by the time spent traveling to get velocity
	self.velocity = dest * (1/traveltime);	// qcc won't take vec/float

	SpikedOrb_Combat();
};


void() SpikedOrb_Birth = 
{
	//if vertical velocity is < 1, stop and change to normal behaviour
	self.nextthink = time + 0.1;
	
	if (self.velocity_z < 50)	//seemed about the right speed/time
	{
		WW_SlowToStop(TRUE);
		self.think = SpikedOrb_Behaviour;
		return;
	}

	WW_SlowToStop();
};



void() SpikedOrb_Combat =
{
	local vector org, dir;
	local entity head, victim;
	local float range = 400f;

	//Anyone in range?
	head = findradius(self.origin, range);

	//Cycles through the chain of entities linked to head (set by running findradius(...)) and iterated with head.chain
	//TODO - need to check if targets are in line of sight...currently it will shoot through a wall
	while (head)
	{
		//Checks against all players, but uses the last one as victim. The others are checked against incase one player
		//is close enough to cause the spikedorb to detonate.
		if (head.classname == "player" && head != self)
		{
			local vector detPoint = head.origin - self.origin;
			local float dist = vlen(detPoint);

			//Check line of sight. Ignore if can't see.
			if (visible(head))
			{
				//Close enough to player to blow up?
				if (dist <= 100)
					SpikedOrb_Detonate();

				//is in line of sight, so set as possible victim
				victim = head;
			}
		}

		head = head.chain;
	}


	//no victim found - end.
	if (victim.classname != "player")
		return;


	//ZAP!
	self.effects = self.effects | EF_MUZZLEFLASH;


    org = self.origin;

    dir = victim.origin + '0 0 8' - org;
    dir = normalize (dir);

    traceline (org, self.origin + (dir * range), TRUE, self);

    WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
    WriteByte (MSG_BROADCAST, TE_LIGHTNING1);
    WriteEntity (MSG_BROADCAST, self);
    WriteCoord (MSG_BROADCAST, org_x);
    WriteCoord (MSG_BROADCAST, org_y);
    WriteCoord (MSG_BROADCAST, org_z);
    WriteCoord (MSG_BROADCAST, trace_endpos_x);
    WriteCoord (MSG_BROADCAST, trace_endpos_y);
    WriteCoord (MSG_BROADCAST, trace_endpos_z);


//nlz: randomize damage between 0 & 4 + call player pain sound if dmg 3 or 4 35%

// 0 = 10% 1 = 25% 2 = 30% 4 = 25% 5 = 10%

//nlz: sentinel zaps are absorbed by suit(player is not hurt by sentinel lightning)

	if (victim.radsuit_finished > time)

		{
		LightningDamage (org, trace_endpos, self, 0);	
		sound (victim, CHAN_AUTO, "enforcer/enfstop.wav", 0.05, ATTN_NORM);
		
 
		}

	else if (random() > 0.9)
	{
    LightningDamage (org, trace_endpos, self, 5); //5 = 10%
	 
	PainSound();
	sound (victim, CHAN_AUTO, "enforcer/enfstop.wav", 0.6, ATTN_NORM);
	
	}

else if (random() < 0.25)
	{
    LightningDamage (org, trace_endpos, self, 1);	 //1 = 25%
	sound (victim, CHAN_AUTO, "enforcer/enfstop.wav", 0.2, ATTN_NORM);
	
	}

else if (random() < 0.55)
	{
    LightningDamage (org, trace_endpos, self, 2);	 //2 = 30%
	sound (victim, CHAN_AUTO, "enforcer/enfstop.wav", 0.3, ATTN_NORM);

	}

else if (random() < 0.8)
	{
    LightningDamage (org, trace_endpos, self, 4);	 //4 = 25%
	PainSound();
	sound (victim, CHAN_AUTO, "enforcer/enfstop.wav", 0.45, ATTN_NORM);
		
	}

else 
	{
    LightningDamage (org, trace_endpos, self, 0);	 //0 = 10%
	sound (victim, CHAN_AUTO, "enforcer/enfstop.wav", 0.1, ATTN_NORM);
	}


//Osp: jolt testing. Will jolt regardless of lightningdamage impact.
	Jolt(victim, self, 15, 10);

//nlz: add an electric snd
	//nlz: BUG  - the sound continues to play sound below even though it was exploded! FIXED
	sound (self, CHAN_WEAPON, "misc/power.wav", 1, ATTN_NORM);


};


void() SpikedOrb_Detonate = 
{
	T_RadiusDamage (self, self.owner, 80, world);	//lowered damage from 120

	WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte (MSG_BROADCAST, TE_EXPLOSION);
	WriteCoord (MSG_BROADCAST, self.origin_x);
	WriteCoord (MSG_BROADCAST, self.origin_y);
	WriteCoord (MSG_BROADCAST, self.origin_z);

	//change classname as sometimes Quake doesn't seem to remove entities on time
	self.classname = "detonation";


	BecomeExplosion();


//nlz: play null sound on weapon channel to mute firing sound if playing:

sound (self, CHAN_WEAPON, "misc/null.wav", 1, ATTN_NORM);

};



/*---------------------------------------------------------------------------
[SPAWN SENTINEL (SPIKEBALL)]
 

---------------------------------------------------------------------------*/
void(vector birthpoint) SpikedOrb =
{
	// find the free spot for the sentinel. If none found, abort.
	local float free = -1;
	for (float i = 0; i < sentinels.length; i++)
	{
		if (sentinels[i].classname != "sentinel")
		{
			free = i;
			break;
		}
	}

	if (free == -1)
		return;


	local entity orb = spawn();

	orb.classname = "sentinel";
	orb.owner = self;
	
	orb.solid = SOLID_SLIDEBOX;
	orb.movetype = MOVETYPE_FLYMISSILE; //MOVETYPE_PUSH;
	orb.takedamage = DAMAGE_YES;

	//nlz: add inv3 snd ?

sound (self, CHAN_WEAPON, "items/inv3.wav", 1, ATTN_NONE);
	
	orb.avelocity = '100 200 300';

	makevectors(self.v_angle);

	setmodel (orb, "progs/teleport.mdl");
	setsize (orb, '-24 -24 -24', '24 24 24');
	setorigin (orb, self.origin + birthpoint);
	
	orb.nextthink = time + 0.1;
	orb.think = SpikedOrb_Birth;

	orb.yaw_speed = 15f;

	orb.health = 190; //nlz: I think these should only be able to be destroyed by rockets (no blood) upped the hp for now
	orb.th_die = SpikedOrb_Detonate;

	//store reference in the free spot
	sentinels[free] = orb;


	//throw so as to appear it got squirted out...
	orb.velocity = self.velocity + '0 0 1' *500;
	//orb.movetype = MOVETYPE_FLY;
	//self.solid = SOLID_NOT;
};

