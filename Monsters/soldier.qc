		// RAMPAGE Mod file. Last Updated 28 Jan 22
/*
==============================================================================

SOLDIER / PLAYER

==============================================================================
*/

$cd id1/models/soldier3
$origin 0 -6 24
$base base		
$skin skin

$frame stand1 stand2 stand3 stand4 stand5 stand6 stand7 stand8

$frame death1 death2 death3 death4 death5 death6 death7 death8
$frame death9 death10

$frame deathc1 deathc2 deathc3 deathc4 deathc5 deathc6 deathc7 deathc8
$frame deathc9 deathc10 deathc11

$frame load1 load2 load3 load4 load5 load6 load7 load8 load9 load10 load11

$frame pain1 pain2 pain3 pain4 pain5 pain6

$frame painb1 painb2 painb3 painb4 painb5 painb6 painb7 painb8 painb9 painb10
$frame painb11 painb12 painb13 painb14

$frame painc1 painc2 painc3 painc4 painc5 painc6 painc7 painc8 painc9 painc10
$frame painc11 painc12 painc13

$frame run1 run2 run3 run4 run5 run6 run7 run8

$frame shoot1 shoot2 shoot3 shoot4 shoot5 shoot6 shoot7 shoot8 shoot9

$frame prowl_1 prowl_2 prowl_3 prowl_4 prowl_5 prowl_6 prowl_7 prowl_8
$frame prowl_9 prowl_10 prowl_11 prowl_12 prowl_13 prowl_14 prowl_15 prowl_16
$frame prowl_17 prowl_18 prowl_19 prowl_20 prowl_21 prowl_22 prowl_23 prowl_24

/*
==============================================================================
SOLDIER CODE
==============================================================================
*/

//-------------------------------------------------------- New Code --------
void(entity grunt) PM_ArmySelect;
void() PM_ArmyAttack;
void() PM_ArmyGrenade;
void() PM_ArmyNail;
float() PM_ArmyHealth;
//--------------------------------------------------------------------------
void() army_fire;

void()	army_stand1	=[	$stand1,	army_stand2	] {ai_stand();};
void()	army_stand2	=[	$stand2,	army_stand3	] {ai_stand();};
void()	army_stand3	=[	$stand3,	army_stand4	] {ai_stand();};
void()	army_stand4	=[	$stand4,	army_stand5	] {ai_stand();};
void()	army_stand5	=[	$stand5,	army_stand6	] {ai_stand();};
void()	army_stand6	=[	$stand6,	army_stand7	] {ai_stand();};
void()	army_stand7	=[	$stand7,	army_stand8	] {ai_stand();};
void()	army_stand8	=[	$stand8,	army_stand1	] {ai_stand();};

void()	army_walk1	=[	$prowl_1,	army_walk2	] {
if (random() < 0.2)
	sound (self, CHAN_VOICE, "soldier/idle.wav", 1, ATTN_IDLE);
ai_walk(1);};
void()	army_walk2	=[	$prowl_2,	army_walk3	] {ai_walk(1);};
void()	army_walk3	=[	$prowl_3,	army_walk4	] {ai_walk(1);};
void()	army_walk4	=[	$prowl_4,	army_walk5	] {ai_walk(1);};
void()	army_walk5	=[	$prowl_5,	army_walk6	] {ai_walk(2);};
void()	army_walk6	=[	$prowl_6,	army_walk7	] {ai_walk(3);};
void()	army_walk7	=[	$prowl_7,	army_walk8	] {ai_walk(4);};
void()	army_walk8	=[	$prowl_8,	army_walk9	] {ai_walk(4);};
void()	army_walk9	=[	$prowl_9,	army_walk10	] {ai_walk(2);};
void()	army_walk10	=[	$prowl_10,	army_walk11	] {ai_walk(2);};
void()	army_walk11	=[	$prowl_11,	army_walk12	] {ai_walk(2);};
void()	army_walk12	=[	$prowl_12,	army_walk13	] {ai_walk(1);};
void()	army_walk13	=[	$prowl_13,	army_walk14	] {ai_walk(0);};
void()	army_walk14	=[	$prowl_14,	army_walk15	] {ai_walk(1);};
void()	army_walk15	=[	$prowl_15,	army_walk16	] {ai_walk(1);};
void()	army_walk16	=[	$prowl_16,	army_walk17	] {ai_walk(1);};
void()	army_walk17	=[	$prowl_17,	army_walk18	] {ai_walk(3);};
void()	army_walk18	=[	$prowl_18,	army_walk19	] {ai_walk(3);};
void()	army_walk19	=[	$prowl_19,	army_walk20	] {ai_walk(3);};
void()	army_walk20	=[	$prowl_20,	army_walk21	] {ai_walk(3);};
void()	army_walk21	=[	$prowl_21,	army_walk22	] {ai_walk(2);};
void()	army_walk22	=[	$prowl_22,	army_walk23	] {ai_walk(1);};
void()	army_walk23	=[	$prowl_23,	army_walk24	] {ai_walk(1);};
void()	army_walk24	=[	$prowl_24,	army_walk1	] {ai_walk(1);};

void()	army_run1	=[	$run1,		army_run2	] {
if (random() < 0.2)
	sound (self, CHAN_VOICE, "soldier/idle.wav", 1, ATTN_IDLE);
ai_run(11);};
void()	army_run2	=[	$run2,		army_run3	] {ai_run(15);};
void()	army_run3	=[	$run3,		army_run4	] {ai_run(10);};
void()	army_run4	=[	$run4,		army_run5	] {ai_run(10);};
void()	army_run5	=[	$run5,		army_run6	] {ai_run(8);};
void()	army_run6	=[	$run6,		army_run7	] {ai_run(15);};
void()	army_run7	=[	$run7,		army_run8	] {ai_run(10);};
void()	army_run8	=[	$run8,		army_run1	] {ai_run(8);};

void()	army_atk1	=[	$shoot1,	army_atk2	] {ai_face();};
void()	army_atk2	=[	$shoot2,	army_atk3	] {ai_face();};
void()	army_atk3	=[	$shoot3,	army_atk4	] {ai_face();};
void()	army_atk4	=[	$shoot4,	army_atk5	] {ai_face();};
void()	army_atk5	=[	$shoot5,	army_atk6	] {ai_face();army_fire();
self.effects = self.effects | EF_MUZZLEFLASH;
};
void()	army_atk6	=[	$shoot6,	army_atk7	] {ai_face();};
//-------------------------------------------------------- Code Change -----
void()  army_atk7       =[      $shoot7,        army_atk8       ]
{  ai_face(); SUB_CheckRefire (PM_ArmyAttack);  };
//--------------------------------------------------------------------------
void()	army_atk8	=[	$shoot8,	army_atk9	] {ai_face();};
void()	army_atk9	=[	$shoot9,	army_run1	] {ai_face();};

//============================================================================

//--------------------------------------------------------------------------
//  THE START OF EXTRA FUNCTIONS.
//--------------------------------------------------------------------------

//-------------------------------------------------------- New Code --------
//  A grunt loads his gun with a grenade.  Code based from GRNTRLD patch.
//--------------------------------------------------------------------------
void()  army_grenade1   =[  $load1,     army_grenade2   ] {ai_face();};
void()  army_grenade2   =[  $load2,     army_grenade3   ] {ai_face();};
void()  army_grenade3   =[  $load3,     army_grenade4   ] {ai_face();};
void()  army_grenade4   =[  $load4,     army_grenade5   ] {ai_face();};
void()  army_grenade5   =[  $load5,     army_grenade6   ] {ai_face();};
void()  army_grenade6   =[  $load6,     army_grenade7   ] {ai_face();};
void()  army_grenade7   =[  $load7,     army_grenade8   ] {ai_face();};
void()  army_grenade8   =[  $load8,     army_grenade9   ] {ai_face();};
void()  army_grenade9   =[  $load9,     army_grenade10  ]
{       ai_face();
        sound (self, CHAN_WEAPON, "weapons/lock4.wav", 1, ATTN_NORM);
};
void()  army_grenade10  =[  $load10,    army_grenade11  ] {ai_face();};
void()  army_grenade11  =[  $load11,    army_grenade12  ] {ai_face();};
void()  army_grenade12  =[  $shoot5,    army_atk6       ]
{       ai_face();
        self.ammo_rockets = self.ammo_rockets - 1;
        PM_ArmyGrenade();
};

//-------------------------------------------------------- New Code --------
//  A grunt attacks with a nailgun.
//--------------------------------------------------------------------------
void()  army_nail1;

void()  army_nail1      =[      $shoot1,        army_nail2      ] {ai_face();};
void()  army_nail2      =[      $shoot2,        army_nail3      ] {ai_face();};
void()  army_nail3      =[      $shoot3,        army_nail4      ] {ai_face();};
void()  army_nail4      =[      $shoot4,        army_nail5      ] {ai_face();};
void()  army_nail5      =[      $shoot5,        army_nail6      ]
{       ai_face();
// The if-statement fixes a rare bug which grunt has negative amt. of nails.
        if (self.ammo_nails > 0)
                self.ammo_nails = self.ammo_nails - 1;
        PM_ArmyNail();
        self.cnt = self.cnt + 1;
};
void()  army_nail6 =
{
        local   float   limit;  // Max # of shots before stopping.

        if (skill < 1)       limit = 2;
        else if (skill < 2)  limit = 4;
        else                 limit = 6;

        if (self.ammo_nails > 0)
            if (self.cnt < limit)
                if (CanDamage (self.enemy, self))
                    if (self.enemy.health > 0)
                    {   army_nail5();
                        return;
                    }
        if (self.ammo_nails < 1)
        {       self.weapon = 0;
                PM_ArmySelect(self);   // Change weapons.
        }
        self.cnt = 0;
        army_atk6();
};

//-------------------------------------------------------- New Code --------
//  A grunt will select the best weapon to use against his opponent.
//--------------------------------------------------------------------------
void(entity grunt) PM_ArmySelect =
{
        if (grunt.items & IT_NAILGUN)
                if (grunt.ammo_nails > 0)
                {       grunt.weapon = IT_NAILGUN;
                        return;
                }
        if (grunt.items & IT_SUPER_SHOTGUN)
                grunt.weapon = IT_SUPER_SHOTGUN;


//nlz: some grunts drop shotgun on dm3

	  else if ((world.model == "maps/dm3.bsp") && (grunt.items & IT_SHOTGUN))
                grunt.weapon = IT_SHOTGUN;


	  
};

//-------------------------------------------------------- New Code --------
//  A grunt will attack with extra weapons first before using
//  the basic shotgun.
//--------------------------------------------------------------------------
void()  PM_ArmyAttack =
{
        PM_ArmySelect(self);
        ai_face();
        if (self.enemy.health < 1)
        {       // cease fire!
                army_run1();
                return;
        }
        self.cnt = 0;

// Use nailgun first.
        if (self.weapon == IT_NAILGUN)
        {       army_nail1();
                return;
        }
//--------------------------------------------------------------------//
// There is a chance that a grunt will use grenades.  The higher the  //
// skill level and the more grenades a grunt has, the more likely he  //
// will use them.  (Grunts will not use grenades on Easy.)            //
//--------------------------------------------------------------------//
        if (random() < (skill * 0.05 * self.ammo_rockets))
        {
                local   float   dist;

                dist = vlen(self.enemy.origin - self.origin);
                if (dist > 120)
                {       army_grenade1();
                        return;
                }
        }

// The grunt uses a shotgun.
        army_atk1();
};

//--------------------------------------------------------  Code --------
//  A grunt shoots a grenade like an ogre.
//--------------------------------------------------------------------------
void() PM_ArmyGrenade =
{
	
local	entity missile;
	
	self.effects = self.effects | EF_MUZZLEFLASH;

	sound (self, CHAN_WEAPON, "weapons/grenade.wav", 1, ATTN_NORM);

	missile = spawn ();
	missile.classname = "ogre_grenade";
	missile.owner = self;
	missile.movetype = MOVETYPE_BOUNCE;
	missile.solid = SOLID_BBOX;
		
// set missile speed	

	makevectors (self.angles);

	missile.velocity = normalize(self.enemy.origin - self.origin);
	missile.velocity = missile.velocity * 600;
	missile.velocity_z = 200;

	missile.avelocity = '300 300 300';

	missile.angles = vectoangles(missile.velocity);
	
	missile.touch = OgreGrenadeTouch;

	missile.effects = missile.effects | EF_CANDLELIGHT; // give the grenades a weak glow
	
// set missile duration
	missile.nextthink = time + 2.5;
	missile.think = OgreGrenadeExplode;

	setmodel (missile, "progs/grenade.mdl");
	setsize (missile, '0 0 0', '0 0 0');		
	setorigin (missile, self.origin);
};

//-------------------------------------------------------- New Code --------
//  A grunt shoots nails from his nailgun.
//--------------------------------------------------------------------------
void() PM_ArmyNail =
{
        local   vector  org, vec;

        self.effects = self.effects | EF_MUZZLEFLASH;
	makevectors (self.angles);
        org = self.origin + v_forward * 30 + v_right * 6 + '0 0 14';
        vec = normalize (self.enemy.origin - org);

	launch_spike (org, vec);
        newmis.classname = "spike";
        setmodel (newmis, "progs/spike.mdl");
	setsize (newmis, VEC_ORIGIN, VEC_ORIGIN);		
        newmis.velocity = vec * 1000;
	sound (self, CHAN_WEAPON, "weapons/rocket1i.wav", 1, ATTN_NORM);
};

//-------------------------------------------------------- New Code --------
//  This returns the initial health of a fresh grunt.
//  50% = 30 hp;  25% = 50 hp;  15% = 80 hp;  10% = 100 hp.

//nlz: update hp ( Rampage version ) 30% = 30 (40) 45% = 45 (60) 20% = 75 (100) 5% = 150 (200)

//(eg.20% 50 x 1.5 = 75, 50 x 2 = 100)
//--------------------------------------------------------------------------
float() PM_ArmyHealth =
{
        local   float   r;

        r = random();

if (r < 0.05)  return 100 * monsters_health_modifier;
 
if (r < 0.20)  return 50 * monsters_health_modifier;

if (r < 0.45)   return 30 * monsters_health_modifier; 

        return 20 * monsters_health_modifier; 
};

//--------------------------------------------------------------------------
//  THE END OF EXTRA FUNCTIONS.
//--------------------------------------------------------------------------

//========================================================================


void()	army_pain1	=[	$pain1,		army_pain2	] {};
void()	army_pain2	=[	$pain2,		army_pain3	] {};
void()	army_pain3	=[	$pain3,		army_pain4	] {};
void()	army_pain4	=[	$pain4,		army_pain5	] {};
void()	army_pain5	=[	$pain5,		army_pain6	] {};
void()	army_pain6	=[	$pain6,		army_run1	] {ai_pain(1);};

void()	army_painb1	=[	$painb1,	army_painb2	] {};
void()	army_painb2	=[	$painb2,	army_painb3	] {ai_painforward(13);};
void()	army_painb3	=[	$painb3,	army_painb4	] {ai_painforward(9);};
void()	army_painb4	=[	$painb4,	army_painb5	] {};
void()	army_painb5	=[	$painb5,	army_painb6	] {};
void()	army_painb6	=[	$painb6,	army_painb7	] {};
void()	army_painb7	=[	$painb7,	army_painb8	] {};
void()	army_painb8	=[	$painb8,	army_painb9	] {};
void()	army_painb9	=[	$painb9,	army_painb10] {};
void()	army_painb10=[	$painb10,	army_painb11] {};
void()	army_painb11=[	$painb11,	army_painb12] {};
void()	army_painb12=[	$painb12,	army_painb13] {ai_pain(2);};
void()	army_painb13=[	$painb13,	army_painb14] {};
void()	army_painb14=[	$painb14,	army_run1	] {};

void()	army_painc1	=[	$painc1,	army_painc2	] {};
void()	army_painc2	=[	$painc2,	army_painc3	] {ai_pain(1);};
void()	army_painc3	=[	$painc3,	army_painc4	] {};
void()	army_painc4	=[	$painc4,	army_painc5	] {};
void()	army_painc5	=[	$painc5,	army_painc6	] {ai_painforward(1);};
void()	army_painc6	=[	$painc6,	army_painc7	] {ai_painforward(1);};
void()	army_painc7	=[	$painc7,	army_painc8	] {};
void()	army_painc8	=[	$painc8,	army_painc9	] {ai_pain(1);};
void()	army_painc9	=[	$painc9,	army_painc10] {ai_painforward(4);};
void()	army_painc10=[	$painc10,	army_painc11] {ai_painforward(3);};
void()	army_painc11=[	$painc11,	army_painc12] {ai_painforward(6);};
void()	army_painc12=[	$painc12,	army_painc13] {ai_painforward(8);};
void()	army_painc13=[	$painc13,	army_run1] {};

void(entity attacker, float damage)	army_pain =
{
	local float r;
	
	if (self.pain_finished > time)
		return;

//-------------------------------------------------------- New Code --------
        if (self.health > 30)
            if ((random() * 30) > damage)
            {   // didn't flinch.
                self.pain_finished = time + 0.5;
		sound (self, CHAN_VOICE, "soldier/pain1.wav", 1, ATTN_NORM);
                return;
            }       
//--------------------------------------------------------------------------

	r = random();

	if (r < 0.2)
	{
		self.pain_finished = time + 0.6;
		army_pain1 ();
		sound (self, CHAN_VOICE, "soldier/pain1.wav", 1, ATTN_NORM);
	}
	else if (r < 0.6)
	{
		self.pain_finished = time + 1.1;
		army_painb1 ();
		sound (self, CHAN_VOICE, "soldier/pain2.wav", 1, ATTN_NORM);
	}
	else
	{
		self.pain_finished = time + 1.1;
		army_painc1 ();
		sound (self, CHAN_VOICE, "soldier/pain2.wav", 1, ATTN_NORM);
	}
};


void() army_fire =
{
	local	vector	dir;
	local	entity	en;
	
	ai_face();
	
//-------------------------------------------------------- New Code --------
//  If the grunt has a double-barrelled shotgun, use it!
//--------------------------------------------------------------------------
        if (self.weapon == IT_SUPER_SHOTGUN)
        {   sound (self, CHAN_WEAPON, "weapons/shotgn2.wav", 1, ATTN_NORM);
            en = self.enemy;
            dir = en.origin - en.velocity*0.2;
            dir = normalize (dir - self.origin);
            FireBullets (10, dir, '0.28 0.16 0');
            return;
        }
//---------------------------------------------------------------------------

	sound (self, CHAN_WEAPON, "soldier/sattck1.wav", 1, ATTN_NORM);

// fire somewhat behind the player, so a dodging player is harder to hit
	en = self.enemy;
	
	dir = en.origin - en.velocity*0.2;
	dir = normalize (dir - self.origin);
	
	FireBullets (4, dir, '0.1 0.1 0');
};



void()	army_die1	=[	$death1,	army_die2	] {};
void()	army_die2	=[	$death2,	army_die3	] {};
void()	army_die3	=[	$death3,	army_die4	]
//-------------------------------------------------------- Code Change -----
{self.solid = SOLID_NOT;DropBackpack();};
//--------------------------------------------------------------------------
void()	army_die4	=[	$death4,	army_die5	] {};
void()	army_die5	=[	$death5,	army_die6	] {};
void()	army_die6	=[	$death6,	army_die7	] {};
void()	army_die7	=[	$death7,	army_die8	] {};
void()	army_die8	=[	$death8,	army_die9	] {};
void()	army_die9	=[	$death9,	army_die10	] {};
void()	army_die10	=[	$death10,	army_die10	] {};

void()	army_cdie1	=[	$deathc1,	army_cdie2	] {};
void()	army_cdie2	=[	$deathc2,	army_cdie3	] {ai_back(5);};
void()	army_cdie3	=[	$deathc3,	army_cdie4	]
//-------------------------------------------------------- Code Change -----
{self.solid = SOLID_NOT;ai_back(4);
if (world.model == "maps/dm3.bsp")
DropBackpack();
};

/* //nlz: Only 50% of Grunts drop Packs, too many packs in Rampage too Much Ammo Given : DropBackpack(); removed from above line | update all grunts drop backpacks on dm3 */
//--------------------------------------------------------------------------
void()	army_cdie4	=[	$deathc4,	army_cdie5	] {ai_back(13);};
void()	army_cdie5	=[	$deathc5,	army_cdie6	] {ai_back(3);};
void()	army_cdie6	=[	$deathc6,	army_cdie7	] {ai_back(4);};
void()	army_cdie7	=[	$deathc7,	army_cdie8	] {};
void()	army_cdie8	=[	$deathc8,	army_cdie9	] {};
void()	army_cdie9	=[	$deathc9,	army_cdie10	] {};
void()	army_cdie10	=[	$deathc10,	army_cdie11	] {};
void()	army_cdie11	=[	$deathc11,	army_cdie11	] {};


void() army_die =
{
// check for gib
	if (self.health < -35)
	{
		sound (self, CHAN_VOICE, "player/udeath.wav", 1, ATTN_NORM);
		ThrowHead ("progs/h_guard.mdl", self.health);
		ThrowGib ("progs/gib1.mdl", self.health);
		ThrowGib ("progs/gib2.mdl", self.health);
		ThrowGib ("progs/gib3.mdl", self.health);
		return;
	}

// regular death
	sound (self, CHAN_VOICE, "soldier/death1.wav", 1, ATTN_NORM);
	if (random() < 0.5)
		army_die1 ();
	else
		army_cdie1 ();
};


/*QUAKED monster_army (1 0 0) (-16 -16 -24) (16 16 40) Ambush
*/
void() monster_army =
{	
	if (deathmatch)
	{
		remove(self);
		return;
	}

//nlz: NightmarePlus

	if(!IsPrecacheDisallowed()) {


	precache_model ("progs/soldier.mdl");
	precache_model ("progs/h_guard.mdl");
	precache_model ("progs/gib1.mdl");
	precache_model ("progs/gib2.mdl");
	precache_model ("progs/gib3.mdl");

	precache_sound ("soldier/death1.wav");
	precache_sound ("soldier/idle.wav");
	precache_sound ("soldier/pain1.wav");
	precache_sound ("soldier/pain2.wav");
	precache_sound ("soldier/sattck1.wav");
	precache_sound ("soldier/sight1.wav");

	precache_sound ("player/udeath.wav");		// gib death

}

	NightmarePlus_CreateSpawnerIfNeeded();

	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;

	setmodel (self, "progs/soldier.mdl");

	setsize (self, '-16 -16 -24', '16 16 40');
//-------------------------------------------------------- Code Change -----
        self.health = PM_ArmyHealth();  // Grunts have variable health.

    //Osp - bonus health
    CMT_SetHealth(self);

// All grunts carry at least five shells.
        self.ammo_shells = 5;

//nlz: half of grunts have a shotgun on dm3. some grunts drop shotgun but not as many as I first hoped
if ((world.model == "maps/dm3.bsp") && (random() > 0.4))
	{
		if (self.health > 30)
		{
		self.items = self.items | IT_SHOTGUN;
		}
	}

// Grunts can have up to three grenades.  Most grunts carry grenades.
        self.ammo_rockets = floor(random() * 3 + 0.5);

// Some grunts are armed with a double-barreled shotgun plus extra shells.
        if (random() < 0.40)
                if (self.health > 30)
                {       self.weapon = IT_SUPER_SHOTGUN;
                        self.items = self.items | IT_SUPER_SHOTGUN;
                        self.ammo_shells = 10;
                }

// A few select grunts are armed with a nailgun plus 30-60 nails.
        if (random() < 0.30)
                if (self.health > 30)
                {       self.weapon = IT_NAILGUN;
                        self.items = self.items | IT_NAILGUN;
                        self.ammo_nails = 20 + floor(random() * 4) * 10;
                }
//--------------------------------------------------------------------------

	self.th_stand = army_stand1;
	self.th_walk = army_walk1;
	self.th_run = army_run1;
//-------------------------------------------------------- Code Change -----
        self.th_missile = PM_ArmyAttack;
//--------------------------------------------------------------------------
	self.th_pain = army_pain;
	self.th_die = army_die;

	walkmonster_start ();
};
