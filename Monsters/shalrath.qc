		// RAMPAGE Mod file. Last Updated 1 Dec 22
/*
==============================================================================

SHAL-RATH

==============================================================================
*/
$cd id1/models/shalrath
$origin 0 0 24
$base base
$skin skin
$scale 0.7

$frame attack1 attack2 attack3 attack4 attack5 attack6 attack7 attack8
$frame attack9 attack10 attack11

$frame pain1 pain2 pain3 pain4 pain5 

$frame death1 death2 death3 death4 death5 death6 death7

$frame	walk1 walk2 walk3 walk4 walk5 walk6 walk7 walk8 walk9 walk10
$frame	walk11 walk12

//-------------------------------------------------------- New Code --------
void(float chace) PM_VoreCloak;
void() PM_VoreFireballTouch;
void() PM_VoreFireball;
void() PM_VoreGasThink;
void(vector spot, entity from) PM_SpawnVoreGas;
//--------------------------------------------------------------------------
void() shalrath_pain;
void() ShalMissile;
void() shal_stand     =[      $walk1,       shal_stand    ] {ai_stand();};
//-------------------------------------------------------- New Code --------
void() shal_invisible =
{       PM_VoreCloak((skill + 4)*40+10);        // may wait while cloaked
        shal_stand();
};
//--------------------------------------------------------------------------

void() shal_walk1     =[      $walk2,       shal_walk2    ] {
//-------------------------------------------------------- New Code --------
        local   float   chance;

// At higher skill levels, the invisibility of a wandering vore will blink.
        if (skill > 2)        chance = 100;
        else if (skill == 2)  chance = 100;
        else                  chance = 100;
        PM_VoreCloak(chance);
//--------------------------------------------------------------------------
if (random() < 0.2)
	sound (self, CHAN_VOICE, "shalrath/idle.wav", 1, ATTN_IDLE);
ai_walk(6);};
void() shal_walk2     =[      $walk3,       shal_walk3    ] {ai_walk(4);};
void() shal_walk3     =[      $walk4,       shal_walk4    ] {ai_walk(0);};
void() shal_walk4     =[      $walk5,       shal_walk5    ] {ai_walk(0);};
void() shal_walk5     =[      $walk6,       shal_walk6    ] {ai_walk(0);};
void() shal_walk6     =[      $walk7,       shal_walk7    ] {ai_walk(0);};
void() shal_walk7     =[      $walk8,       shal_walk8    ] {ai_walk(5);};
void() shal_walk8     =[      $walk9,       shal_walk9    ] {ai_walk(6);};
void() shal_walk9     =[      $walk10,       shal_walk10    ] {ai_walk(5);};
void() shal_walk10    =[      $walk11,       shal_walk11    ] {ai_walk(0);};
void() shal_walk11    =[      $walk12,       shal_walk12    ] {ai_walk(4);};
void() shal_walk12    =[      $walk1,       shal_walk1    ] {ai_walk(5);};

void() shal_run1     =[      $walk2,       shal_run2    ] {
//-------------------------------------------------------- New Code --------
PM_VoreCloak(0);         // An active vore is more likely to cloak.
//--------------------------------------------------------------------------
if (random() < 0.2)
	sound (self, CHAN_VOICE, "shalrath/idle.wav", 1, ATTN_IDLE);
ai_run(6);};
void() shal_run2     =[      $walk3,       shal_run3    ] {ai_run(4);};
void() shal_run3     =[      $walk4,       shal_run4    ] {ai_run(0);};
void() shal_run4     =[      $walk5,       shal_run5    ] {ai_run(0);};
void() shal_run5     =[      $walk6,       shal_run6    ] {ai_run(0);};
void() shal_run6     =[      $walk7,       shal_run7    ] {ai_run(0);};
void() shal_run7     =[      $walk8,       shal_run8    ] {ai_run(5);};
void() shal_run8     =[      $walk9,       shal_run9    ] {ai_run(6);};
void() shal_run9     =[      $walk10,       shal_run10    ] {ai_run(5);};
void() shal_run10    =[      $walk11,       shal_run11    ] {ai_run(0);};
void() shal_run11    =[      $walk12,       shal_run12    ] {ai_run(4);};
void() shal_run12    =[      $walk1,       shal_run1    ] {ai_run(5);};

void() shal_attack1     =[      $attack1,       shal_attack2    ] {
//-------------------------------------------------------- New Code --------
        local   float   chance;

// If invisible, there is a chance the vore will uncloak as it winds up.
        if (self.model == "")
        {       if (skill > 2)  chance = 100;
                else            chance = 100;
                PM_VoreCloak(chance);
        }
//--------------------------------------------------------------------------
sound (self, CHAN_VOICE, "shalrath/attack.wav", 1, ATTN_NORM);
ai_face();
};
void() shal_attack2     =[      $attack2,       shal_attack3    ] {ai_face();};
void() shal_attack3     =[      $attack3,       shal_attack4    ] {ai_face();};
void() shal_attack4     =[      $attack4,       shal_attack5    ] {ai_face();};
void() shal_attack5     =[      $attack5,       shal_attack6    ] {ai_face();};
void() shal_attack6     =[      $attack6,       shal_attack7    ] {ai_face();};
void() shal_attack7     =[      $attack7,       shal_attack8    ] {ai_face();};
void() shal_attack8     =[      $attack8,       shal_attack9    ] {ai_face();};
//-------------------------------------------------------- Code Change -----
//  The vore will definitely uncloak when the projectile is cast.
//  There is also a small chance that the projetile will be a
//  Chthon-like fireball instead of the purple homing spikes.
//--------------------------------------------------------------------------
void() shal_attack9     =[      $attack9,       shal_attack10   ]
{
        local   float   chance;

        PM_VoreCloak(0);
        chance = (skill * 0.06);
        if (chance > 0.2)  chance = 0.2;

        if (self.enemy != world)
        {       if (random() < chance)
                        PM_VoreFireball();
                else
                        ShalMissile();
        }
};
//--------------------------------------------------------------------------
void() shal_attack10    =[      $attack10,      shal_attack11   ] {ai_face();};
void() shal_attack11    =[      $attack11,      shal_run1   ] {};

void() shal_pain1       =[      $pain1, shal_pain2      ] {};
void() shal_pain2       =[      $pain2, shal_pain3      ] {};
void() shal_pain3       =[      $pain3, shal_pain4      ] {};
void() shal_pain4       =[      $pain4, shal_pain5      ] {};
void() shal_pain5       =[      $pain5, shal_run1      ] {};

//-------------------------------------------------------- Code Change -----
//  A dying vore will always be visible.
void() shal_death1      =[      $death1,        shal_death2     ]
{       PM_VoreCloak(0);        };
//--------------------------------------------------------------------------
void() shal_death2      =[      $death2,        shal_death3     ] {};
void() shal_death3      =[      $death3,        shal_death4     ] {};
void() shal_death4      =[      $death4,        shal_death5     ] {};
void() shal_death5      =[      $death5,        shal_death6     ] {};
void() shal_death6      =[      $death6,        shal_death7     ] {};
void() shal_death7      =[      $death7,        shal_death7    ] {};


void() shalrath_pain =
{
	if (self.pain_finished > time)
		return;

	sound (self, CHAN_VOICE, "shalrath/pain.wav", 1, ATTN_NORM);
	shal_pain1();
	self.pain_finished = time + 3;
};

void() shalrath_die =
{
// check for gib
	if (self.health < -90)
	{
		sound (self, CHAN_VOICE, "player/udeath.wav", 1, ATTN_NORM);
		ThrowHead ("progs/h_shal.mdl", self.health);
		ThrowGib ("progs/gib1.mdl", self.health);
		ThrowGib ("progs/gib2.mdl", self.health);
		ThrowGib ("progs/gib3.mdl", self.health);
		return;
	}

	sound (self, CHAN_VOICE, "shalrath/death.wav", 1, ATTN_NORM);
	shal_death1();
	self.solid = SOLID_NOT;
	// insert death sounds here
};

//--------------------------------------------------------------------------
//  THE START OF EXTRA FUNCTIONS.
//--------------------------------------------------------------------------

//-------------------------------------------------------- New Code --------
//  The vore has a chance to disappear so that a player cannot see it.
//
//  NOTE:  In this function, you will notice that the model is set with          //                                               //
//      self.model = <model file string>;
//
//  Although this is normally a big no-no and you should use 'setmodel'
//  to set or change models, disappearing monsters is an unusual case.
//
//  Using the following statement to cause the monster to disappear,
//      setmodel (self, "");
//
//  will reset the size of the monster to zero in all three dimensions,
//  which will cause the monster to become semi-ghostlike, something you
//  definitely do not want!  This is the one (and perhaps the only) case
//  where setting the model directly should and must be done.
//--------------------------------------------------------------------------
void(float chance) PM_VoreCloak =
{
        chance = chance * 0.01;
        if (random() < chance)
        { 
		self.model = "progs/shalrath.mdl";
      	self.alpha = 0.1; /* now invisible //nlz: almost changed to alpha, not no model at all*/

                self.takedamage = DAMAGE_YES;   /* can't auto-aim target */
        }
        else
		{
		self.model = "progs/shalrath.mdl";
           self.alpha = 1; /* now visible */
           self.takedamage = DAMAGE_AIM;   /* auto-aiming is possible */
        }
};

//-------------------------------------------------------- New Code --------
//  The fireball made contact.  The target takes severe damage.
//  The fireball packs as much power as one of the player's grenades. now lowered to 90
//--------------------------------------------------------------------------
void() PM_VoreFireballTouch =
{
        if (other == self.owner)  return;         // don't explode on owner

	if (pointcontents(self.origin) == CONTENT_SKY)
	{       remove(self);
		return;
	}

        // The vore that lobbed the fireball is unharmed by its explosion.
        T_RadiusDamage (self, self.owner, 90, self.owner); //nlz: 120>90 

	WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte (MSG_BROADCAST, TE_EXPLOSION);
	WriteCoord (MSG_BROADCAST, self.origin_x);
	WriteCoord (MSG_BROADCAST, self.origin_y);
	WriteCoord (MSG_BROADCAST, self.origin_z);

	BecomeExplosion ();
};

//-------------------------------------------------------- New Code --------
//  This spawns the vores' new fireball.  The fireball will not home in
//  on its intended target, but it flies faster than the purple homing
//  spikes.
//--------------------------------------------------------------------------
void() PM_VoreFireball =
{
	local	entity 	missile;
	local	vector	dir;

	dir = normalize((self.enemy.origin + '0 0 10') - self.origin);

	self.effects = self.effects | EF_MUZZLEFLASH;
	sound (self, CHAN_WEAPON, "shalrath/attack2.wav", 1, ATTN_NORM);

	missile = spawn ();
        setmodel (missile, "progs/lavaball.mdl");
	setsize (missile, '0 0 0', '0 0 0');		
        setorigin (missile, self.origin + '0 0 10');

        missile.owner     = self;
        missile.solid     = SOLID_BBOX;
        missile.movetype  = MOVETYPE_FLYMISSILE;
        missile.velocity  = dir * 600;
	missile.avelocity = '300 300 300';

        missile.nextthink = time + 5;
        missile.think     = PM_VoreFireballTouch;
        missile.touch     = PM_VoreFireballTouch;
};

//-------------------------------------------------------- New Code --------
//  The cloud has a constant radius of 80.  For every one-half of a
//  second, the mind gas takes effect.
//--------------------------------------------------------------------------
void() PM_VoreGasThink =
{
        PM_AlterMind (self, self.owner, 80);
        self.cnt = self.cnt - 1;
        if (self.cnt <= 0)
                remove(self);
        else
        {       self.nextthink = time + 0.5;
                self.think = PM_VoreGasThink;
        }
};

//-------------------------------------------------------- New Code --------
//  This creates a tarexplosion that represents the mind-gas cloud.
//  The cloud lasts about 1.5 seconds.  This is used by the vore.
//--------------------------------------------------------------------------
void(vector spot, entity from) PM_SpawnVoreGas =
{
        local entity cloud;

        WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
        WriteByte (MSG_BROADCAST, TE_TAREXPLOSION);
        WriteCoord (MSG_BROADCAST, spot_x);
        WriteCoord (MSG_BROADCAST, spot_y);
        WriteCoord (MSG_BROADCAST, spot_z);

        cloud = spawn();
        setmodel (cloud, "");   // invisible
        setsize (cloud, '0 0 0', '0 0 0');
        setorigin (cloud, spot);
        cloud.movetype  = MOVETYPE_NONE;
        cloud.solid     = SOLID_NOT;
        cloud.velocity  = '0 0 0';
        cloud.cnt       = 3;    // loop counter
        cloud.owner     = from;
        cloud.nextthink = time + 0.1;
        cloud.think     = PM_VoreGasThink;
        cloud.touch     = SUB_Null;

//nlz: add vore missile gas release snd here
sound (self, CHAN_WEAPON, "doors/airdoor2.wav", 0.7, ATTN_NORM);

};

//--------------------------------------------------------------------------
//  THE END OF EXTRA FUNCTIONS.
//--------------------------------------------------------------------------

/*
================
ShalMissile
================
*/
void() ShalMissileTouch;
void() ShalHome;
void() ShalMissile =
{
	local	entity 	missile;
	local	vector	dir;
	local	float	dist, flytime;

	dir = normalize((self.enemy.origin + '0 0 10') - self.origin);
	dist = vlen (self.enemy.origin - self.origin);
	flytime = dist * 0.002;
	if (flytime < 0.1)
		flytime = 0.1;

	self.effects = self.effects | EF_MUZZLEFLASH;
	sound (self, CHAN_WEAPON, "shalrath/attack2.wav", 1, ATTN_NORM);

	missile = spawn ();
	missile.owner = self;

	missile.solid = SOLID_BBOX;
	missile.movetype = MOVETYPE_FLYMISSILE;
	setmodel (missile, "progs/v_spike.mdl");

	setsize (missile, '0 0 0', '0 0 0');	

	

	missile.origin = self.origin + '0 0 10';
	missile.velocity = dir * 400;
	missile.avelocity = '300 300 300';
	missile.nextthink = flytime + time;
	missile.think = ShalHome;
	missile.enemy = self.enemy;
	missile.touch = ShalMissileTouch;
};

void() ShalHome =
{
	local vector	dir, vtemp;
	vtemp = self.enemy.origin + '0 0 10';

//nlz: explode on shubs death
if (world.model == "maps/end.bsp")
	{	
		if (shub.health < 1)
		{
		 ShalMissileTouch();
			return;
		}
	}
	if (self.enemy.health < 1)
	{
//-------------------------------------------------------- Code Change -----
                ShalMissileTouch();     // explode instead of vanish
//--------------------------------------------------------------------------
		return;
	}
	dir = normalize(vtemp - self.origin);

//nlz: noise while flying around? works try some diff sounds?

//sound (self, CHAN_BODY, "ambience/windfly.wav", 0.6, ATTN_NORM);


//-------------------------------------------------------- Code Change -----
        if (skill > 2)
//--------------------------------------------------------------------------
		self.velocity = dir * 280;
	else
		self.velocity = dir * 250;
	self.nextthink = time + 0.2;
	self.think = ShalHome;	
};

void() ShalMissileTouch =
{
	if (other == self.owner)
		return;		// don't explode on owner

	if (other.classname == "monster_zombie")
		T_Damage (other, self, self, 110);	
//-------------------------------------------------------- Code Change -----
//  The vore is immune to its own blasts -- it can't kill itself.
        T_RadiusDamage (self, self.owner, 40, self.owner);

        self.effects = self.effects | EF_MUZZLEFLASH;

        PM_SpawnVoreGas(self.origin, self.owner);
//--------------------------------------------------------------------------

	self.velocity = '0 0 0';
	self.touch = SUB_Null;
	setmodel (self, "progs/s_explod.spr");
	self.solid = SOLID_NOT;
	s_explode1 ();
};

//=================================================================

/*QUAKED monster_shalrath (1 0 0) (-32 -32 -24) (32 32 48) Ambush
*/
void() monster_shalrath =
{
	if (deathmatch)
	{
		remove(self);
		return;
	}

//nlz: NightmarePlus

	if(!IsPrecacheDisallowed()) {


	precache_model2 ("progs/shalrath.mdl");
	precache_model2 ("progs/h_shal.mdl");
	precache_model2 ("progs/v_spike.mdl");
	
	precache_sound2 ("shalrath/attack.wav");
	precache_sound2 ("shalrath/attack2.wav");
	precache_sound2 ("shalrath/death.wav");
	precache_sound2 ("shalrath/idle.wav");
	precache_sound2 ("shalrath/pain.wav");
	precache_sound2 ("shalrath/sight.wav");
//nlz:
	precache_sound2 ("doors/airdoor2.wav"); // new VoreMissile explosion
	precache_sound2 ("ambience/windfly.wav"); // while VoreMissile flys around




}

	NightmarePlus_CreateSpawnerIfNeeded();
	
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;
	
	setmodel (self, "progs/shalrath.mdl");
//-------------------------------------------------------- Code Change -----
        setsize (self, '-32 -32 -24', '32 32 40');  // Vore isn't that big.
//--------------------------------------------------------------------------
	self.health = 360 * monsters_health_modifier;

//-------------------------------------------------------- Code Change -----
        self.th_stand = shal_invisible;
//--------------------------------------------------------------------------
	self.th_walk = shal_walk1;
	self.th_run = shal_run1;
	self.th_die = shalrath_die;
	self.th_pain = shalrath_pain;
	self.th_missile = shal_attack1;

	self.think = walkmonster_start;
	self.nextthink = time + 0.1 + random ()*0.1;	

};
