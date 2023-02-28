// RAMPAGE Mod file. Last Updated 24 Nov 22
/*
==============================================================================

WARD WEAVER

Mostly like a scragg, with specific behaviour for final battle.
==============================================================================
*/

$cd id1/models/a_wizard
$origin 0 0 24
$base wizbase	
$skin wizbase

$frame hover1 hover2 hover3 hover4 hover5 hover6 hover7 hover8
$frame hover9 hover10 hover11 hover12 hover13 hover14 hover15

$frame fly1 fly2 fly3 fly4 fly5 fly6 fly7 fly8 fly9 fly10
$frame fly11 fly12 fly13 fly14

$frame magatt1 magatt2 magatt3 magatt4 magatt5 magatt6 magatt7
$frame magatt8 magatt9 magatt10 magatt11 magatt12 magatt13

$frame pain1 pain2 pain3 pain4

$frame death1 death2 death3 death4 death5 death6 death7 death8


void() CastWardingProjectile;
void() Teleport_WardWeaver;
void() WardingSpell_Travel;
void() WW_Face;
void(float stop = FALSE) WW_SlowToStop;	//defined in shubbitbattle.qc

void() InvulnerabilityWard;
void() ww_run1;
void() ww_cast1;

.float beingBirthed;	//true while it is coming out of shub (slowing to stop)


//--------------------------------------------------------------------------

void()	ww_stand1	=[	$hover1,		ww_stand2	] {ai_stand();};
void()	ww_stand2	=[	$hover2,		ww_stand3	] {ai_stand();};
void()	ww_stand3	=[	$hover3,		ww_stand4	] {ai_stand();};
void()	ww_stand4	=[	$hover4,		ww_stand5	] {ai_stand();};
void()	ww_stand5	=[	$hover5,		ww_stand6	] {ai_stand();};
void()	ww_stand6	=[	$hover6,		ww_stand7	] {ai_stand();};
void()	ww_stand7	=[	$hover7,		ww_stand8	] {ai_stand();};
void()	ww_stand8	=[	$hover8,		ww_stand1	] {ai_stand();};

void()	ww_walk1	=[	$hover1,		ww_walk2	] {ai_walk(8);};
void()	ww_walk2	=[	$hover2,		ww_walk3	] {ai_walk(8);};
void()	ww_walk3	=[	$hover3,		ww_walk4	] {ai_walk(8);};
void()	ww_walk4	=[	$hover4,		ww_walk5	] {ai_walk(8);};
void()	ww_walk5	=[	$hover5,		ww_walk6	] {ai_walk(8);};
void()	ww_walk6	=[	$hover6,		ww_walk7	] {ai_walk(8);};
void()	ww_walk7	=[	$hover7,		ww_walk8	] {ai_walk(8);};
void()	ww_walk8	=[	$hover8,		ww_walk1	] {ai_walk(8);};

/*
void()	wiz_side1	=[	$hover1,		wiz_side2	] {ai_run(8);};
void()	wiz_side2	=[	$hover2,		wiz_side3	] {ai_run(8);};
void()	wiz_side3	=[	$hover3,		wiz_side4	] {ai_run(8);};
void()	wiz_side4	=[	$hover4,		wiz_side5	] {ai_run(8);};
void()	wiz_side5	=[	$hover5,		wiz_side6	] {ai_run(8);};
void()	wiz_side6	=[	$hover6,		wiz_side7	] {ai_run(8);};
void()	wiz_side7	=[	$hover7,		wiz_side8	] {ai_run(8);};
void()	wiz_side8	=[	$hover8,		wiz_side1	] {ai_run(8);};
*/


//Run used for spawning in
void()  ww_run1 =[  $fly1,      ww_run2		] { self.beingBirthed = TRUE; WW_SlowToStop(); };
void()	ww_run2	=[	$fly2,		ww_run3		] { WW_SlowToStop();};
void()	ww_run3	=[	$fly3,		ww_run4		] { WW_SlowToStop();};
void()	ww_run4	=[	$fly4,		ww_run5		] { WW_SlowToStop();};
void()	ww_run5	=[	$fly5,		ww_run6		] {WW_SlowToStop(); };
void()	ww_run6	=[	$fly6,		ww_run7		] { WW_SlowToStop();};
void()	ww_run7	=[	$fly7,		ww_run8		] { WW_SlowToStop();};
void()	ww_run8	=[	$fly8,		ww_run9		] { WW_SlowToStop();};
void()	ww_run9	=[	$fly9,		ww_run10	] { WW_SlowToStop();};
void()	ww_run10	=[	$fly10,		ww_run11	]  { WW_SlowToStop();};
void()	ww_run11	=[	$fly11,		ww_run12	]  { WW_SlowToStop();};
void()	ww_run12	=[	$fly12,		ww_run13	]  { WW_SlowToStop();};
void()	ww_run13	=[	$fly13,		ww_run14	]  { WW_SlowToStop();};
void()	ww_run14	=[	$fly14,		ww_run1	]
{
	WW_SlowToStop(TRUE);
	Teleport_WardWeaver();	//teleport is in shubpitbattle.qc
	ww_cast1();
	self.beingBirthed = FALSE;
	self.takedamage = DAMAGE_AIM;	//nlz: can be damaged now its in position
};	



void()  ww_cast1	=[  $hover1,		ww_cast2	] { WW_Face(); };
void()	ww_cast2	=[	$hover2,		ww_cast3	] { WW_Face(); };
void()	ww_cast3	=[	$hover3,		ww_cast4	] { WW_Face(); };
void()	ww_cast4	=[	$hover4,		ww_cast5	] { WW_Face(); };
void()	ww_cast5	=[	$hover5,		ww_cast6	] { WW_Face(); };
void()	ww_cast6	=[	$hover6,		ww_cast7	] { WW_Face(); };
void()	ww_cast7	=[	$hover7,		ww_cast8	] { WW_Face(); };
void()	ww_cast8	=[	$hover8,		ww_cast9	] { WW_Face(); };


void()  ww_cast9	=[  $magatt1,       ww_cast10	] { WW_Face(); };
void()	ww_cast10	=[	$magatt2,		ww_cast11	] { WW_Face(); };
void()	ww_cast11	=[	$magatt3,		ww_cast12	] { WW_Face(); };
void()	ww_cast12	=[	$magatt4,		ww_cast13	] { WW_Face(); };
void()	ww_cast13	=[	$magatt5,		ww_cast14	] { WW_Face(); };
void()	ww_cast14	=[	$magatt6,		ww_cast15	] { WW_Face(); };
void()	ww_cast15	=[	$magatt5,		ww_cast16	] { WW_Face(); };
void()	ww_cast16	=[	$magatt4,		ww_cast17	] { WW_Face(); };
void()	ww_cast17	=[	$magatt3,		ww_cast18	] { WW_Face(); };
void()	ww_cast18	=[	$magatt2,		ww_cast19	] { WW_Face(); CastWardingProjectile(); };
void()	ww_cast19	=[	$magatt1,		ww_cast1	] { WW_Face(); };



void()	ww_pain1	=[	$pain1,		ww_pain2	] { WW_SlowToStop(TRUE); };
void()	ww_pain2	=[	$pain2,		ww_pain3	] {};
void()	ww_pain3	=[	$pain3,		ww_pain4	] {};
void()	ww_pain4	=[	$pain4,		ww_cast1	] {};


//Removed - no death anim, only gibbed
/*
void()	ww_death1	=[	$death1,	ww_death2	]
{
	self.velocity_x = -200 + 400*random();
	self.velocity_y = -200 + 400*random();
	self.velocity_z = 100 + 100*random();
	self.flags = self.flags - (self.flags & FL_ONGROUND);
	sound (self, CHAN_VOICE, "wizard/wdeath.wav", 1, ATTN_NORM);
};
void()	ww_death2	=[	$death2,		ww_death3	] {};
void()	ww_death3	=[	$death3,		ww_death4	]{self.solid = SOLID_NOT;};
void()	ww_death4	=[	$death4,		ww_death5	] {};
void()	ww_death5	=[	$death5,		ww_death6	] {};
void()	ww_death6	=[	$death6,		ww_death7	] {};
void()	ww_death7	=[	$death7,		ww_death8	] {};
void()	ww_death8	=[	$death8,		ww_death8	] {};
*/




/*---------------------------------------------------------------------------
[DEATH]
 
Always gibs!
---------------------------------------------------------------------------*/
void() WW_Die =
{
	
	sound (self, CHAN_VOICE, "player/udeath.wav", 1, ATTN_NORM);
	ThrowHead ("progs/h_wizard.mdl", self.health);
	ThrowGib ("progs/gib2.mdl", self.health);
	ThrowGib ("progs/gib2.mdl", self.health);
	ThrowGib ("progs/gib2.mdl", self.health);

	//ww_death1 ();

	self.classname = "corpse";
	
	//Manual record of kill (as we don't use the killed(...) function and WW's are not considered true monsters)
	killed_monsters = killed_monsters + 1;
	WriteByte (MSG_ALL, SVC_KILLEDMONSTER);

	//remove entity
	self.think = SUB_Remove;
	self.nextthink = time + 0.2;
};


/*---------------------------------------------------------------------------
[PAIN]

**NOT YET USED
 
Triggers teleportation to another spell casting position/
---------------------------------------------------------------------------*/
void(entity attacker, float damage) WW_Pain =
{
	//if still being birthed, don't play any pain.
	if (self.beingBirthed == TRUE)
		return;
	
	sound (self, CHAN_VOICE, "wizard/wpain.wav", 1, ATTN_NORM);

	// Teleport away from danger.
    //PM_WizTripleBlink();    
	
	//if (random()*70 > damage)
	//	return;		// didn't flinch

	ww_pain1();
};


/*---------------------------------------------------------------------------
[TARGET SHUB]
 
Ensures ward weaver always has shub as target - prevents aggro towards player or 
other monsters.
Turn towards target.
---------------------------------------------------------------------------*/
void() WW_Face =
{
	//if shub isn't .owner, or shub is dead. Kill self.
	if (self.owner.classname != "monster_oldone" || (self.owner.classname == "monster_oldone" && self.owner.health <= 0))
		WW_Die();

	//if target is not shub, 
	if (self.enemy.classname != "monster_oldone")
		self.enemy = self.owner;

	//face enemy
	ai_face();
};


/*---------------------------------------------------------------------------
[CREATE WARDING SPELL PROJECTILE]
 
Creates the spell projectile and aims it towards shub.
Has no collision.
---------------------------------------------------------------------------*/
void() CastWardingProjectile =
{
	local	entity 	missile;
	local	vector	dir;

	dir = normalize((self.enemy.origin + '0 0 10') - self.origin);

	self.effects = self.effects | EF_MUZZLEFLASH;
	//sound (self, CHAN_WEAPON, "shalrath/attack2.wav", 1, ATTN_NORM);
	//sound (self, CHAN_VOICE, "misc/r_tele1.wav", 1, ATTN_NORM);
	//sound (self, CHAN_WEAPON, "hknight/attack1.wav", 1, ATTN_NORM);

	missile = spawn ();
    setmodel (missile, "progs/s_light.spr");
	setsize (missile, '0 0 0', '0 0 0');		
    setorigin (missile, self.origin + '0 0 10');

	missile.classname = "WardingSpell";
    missile.owner     = self;
    missile.solid     = SOLID_NOT; //SOLID_BBOX;
    missile.movetype  = MOVETYPE_NOCLIP; //MOVETYPE_FLYMISSILE;
    missile.velocity  = dir * 600; //450;

    missile.nextthink = time + 0.15;
    missile.think     = WardingSpell_Travel; //PM_VoreFireballTouch;

	missile.enemy = self.enemy;
};


/*---------------------------------------------------------------------------
[WARDING SPELL IN FLIGHT]

Creates a particle for visual look.
If close enough to shub, will remove self (no collision checking).
Loops to self continuously until destroyed.
---------------------------------------------------------------------------*/
void() WardingSpell_Travel =
{
	particle (self.origin, '0 0 0', 125, 30);
	
	//if shub is dead, destroy
	if (self.enemy.classname != "monster_oldone")
		SUB_Remove();
	
	//Not using Touch for impacts, as spell isn't physical. Check for range to target instead
	local vector vDist = self.owner.enemy.origin - self.origin;
	local float dist = vlen(vDist);

	//close enough to target, tell shub she's invulnerable
	if (dist < 100)
	{
		local entity oself = self;
		self = oself.enemy;
		InvulnerabilityWard();
		self = oself;

		remove(self);
	}

	self.nextthink = time + 0.1;
	self.think = WardingSpell_Travel;
};


/*---------------------------------------------------------------------------
[SETUP AS WARD WEAVER]

Fills all the required fields to make this entity a ward weaver wizard.
---------------------------------------------------------------------------*/
void(vector location, entity wardtarget) Monster_WardWeaver =
{
	//if (deathmatch)
	//{
		//remove(self);
		//return;
	//}

	//Shub is my only target
	//local entity wardingTarget = find(world, classname, "monster_oldone");

	self.classname = "monster_wardweaver";
	self.impulse = 1;
	
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;

	self.takedamage = DAMAGE_NO; //DAMAGE_AIM; //Osp: will start invulnerable now //nlz: invuln until teleported into position then DMG_AIM is set!

	self.flags = self.flags | FL_FLY;
	//self.flags = self.flags | FL_MONSTER;	//Osp: If considered a monster, will complain in console 


	setmodel (self, "progs/wizard.mdl");
	setsize(self, '-16 -16 -24', '16 16 40');
	setorigin(self, location);

	self.health = 70 * monsters_health_modifier; //nlz: try 70hp
	CMT_SetHealth(self); //nlz: Random Health Bonus
	

	self.th_stand = ww_cast1;	//ww_stand1;
	self.th_walk = ww_cast1;	//ww_walk1;
	self.th_run = ww_cast1;		//ww_run1;
	//self.th_missile = CastWardingSpell;
	self.th_pain = WW_Pain;
	self.th_die = WW_Die;
		
	self.enemy = wardtarget;
	self.owner = wardtarget;	//backup for when .enemy is changed from aggro
	
	self.nextthink = time + 0.1;
	self.think = ww_run1; //ww_cast1;
	total_monsters = total_monsters + 1;

	WriteByte(MSG_ALL, 3); //3 = SVC_UPDATESTAT
	WriteByte(MSG_ALL, 12); // 12 = STAT_TOTALMONSTERS
	WriteLong(MSG_ALL, total_monsters);

	self.yaw_speed = 15f;
};
