		// RAMPAGE Mod file. Last Updated 26 Jan 23
/*
==============================================================================
LATEST
OLD ONE

==============================================================================
*/
$cd id1/models/old_one
$origin 0 0 24
$base base
$skin skin
$scale 1

void() finale_1;
void() finale_2;
void() finale_3;
void() finale_4;

//nlz:
void() finale_5;
void() finale_6;


entity	shub;

//--- Osp stuff --------------------------------
void() InvulnerabilityWard;
void() InvulnerabilityWardFade;
void() ChooseAttack;
void() old_gibspew1;
void(vector offset, float playSound) GibSpew;
void() StartShub;
//----------------------------------------------


$frame old1 old2 old3 old4 old5 old6 old7 old8 old9 
$frame old10 old11 old12 old13 old14 old15 old16 old17 old18 old19 
$frame old20 old21 old22 old23 old24 old25 old26 old27 old28 old29 
$frame old30 old31 old32 old33 old34 old35 old36 old37 old38 old39 
$frame old40 old41 old42 old43 old44 old45 old46 

$frame shake1 shake2 shake3 shake4 shake5 shake6 shake7 shake8
$frame shake9 shake10 shake11 shake12 shake13 shake14
$frame shake15 shake16 shake17 shake18 shake19 shake20

//void() old_stand     =[      $old1,       old_stand    ] {};

//---------------------------------------------------------------------------
//  THE START OF EXTRA FUNCTIONS.
//---------------------------------------------------------------------------

//--------------------------------------------------------- New Code --------
//  If the missile connects, it explodes with the force of a grenade
//nlz: less Damage than a grenade
//  and releases a dose of mind-altering gas.
//---------------------------------------------------------------------------
void() PM_ShubMissileTouch =
{
	if (other == self.owner)
		return;		// don't explode on owner

        T_RadiusDamage (self, self, 45, shub);
	sound (self, CHAN_WEAPON, "weapons/r_exp3.wav", 1, ATTN_NORM);
        self.effects = self.effects | EF_MUZZLEFLASH;

        PM_SpawnMindGas(self.origin, shub);

	self.velocity = '0 0 0';
	self.touch = SUB_Null;
	setmodel (self, "progs/s_explod.spr");
	self.solid = SOLID_NOT;
	s_explode1 ();
};

//--------------------------------------------------------- New Code --------
//  Similar to id's ShalHome, except the missile adjusts its course
//  more frequently (like the revenant fireball in Doom][).
//---------------------------------------------------------------------------
void() PM_ShubHome =
{
	local vector	dir, vtemp;

	vtemp = self.enemy.origin + '0 0 10';
        if ((self.enemy.health < 1) || (shub.health < 1))
        {       PM_ShubMissileTouch();  // explode instead of vanish
		return;
	}
	dir = normalize(vtemp - self.origin);
        self.velocity = dir * 250;
        self.nextthink = time + 0.1;
        self.think = PM_ShubHome; 
};

//--------------------------------------------------------- New Code --------
//  Shub-Niggurath launchs a vore-like homing spikes at the player.
//  The homing spike emerges from the top of Shub-Niggurath's body.
//---------------------------------------------------------------------------
void(entity head) PM_ShubMissile =
{
        local   entity  missile;

	self.effects = self.effects | EF_MUZZLEFLASH;
	sound (self, CHAN_WEAPON, "blob/land1.wav", 1, ATTN_NONE);

	missile = spawn ();
        missile.owner = shub;

	missile.solid = SOLID_BBOX;
	missile.movetype = MOVETYPE_FLYMISSILE;
	setmodel (missile, "progs/v_spike.mdl");
        missile.classname = "shub";

	setsize (missile, '0 0 0', '0 0 0');		

        missile.origin = self.origin + '0 0 40';
        missile.velocity = '0 0 600';
	missile.avelocity = '300 300 300';
        missile.nextthink = time + 0.4;
        missile.think = PM_ShubHome;
        missile.enemy = head;
        missile.touch = PM_ShubMissileTouch;
};

//--------------------------------------------------------- New Code --------
//  Shub-Niggurath will attack every player it senses.  Walls and other
//  barriers will block her detection abilities, which is good.

//---------------------------------------------------------------------------
void() PM_ShubAttack =
{
    local entity  head;
        
	head = findradius((shub.origin + '0 0 128'), 1024);
	
	while (head)
	{
		if (head.classname == "player" && CanDamage(head, shub))
		{
			PM_ShubMissile(head);
		}
		
		head = head.chain;
	}
};

//---------------------------------------------------------------------------
//  THE END OF EXTRA FUNCTIONS.
//---------------------------------------------------------------------------




void() old_idle1        =[      $old1,  old_idle2       ] { InvulnerabilityWardFade(); };
void() old_idle2        =[      $old2,  old_idle3       ] {};
void() old_idle3        =[      $old3,  old_idle4       ] {};
void() old_idle4        =[      $old4,  old_idle5       ] { };
void() old_idle5        =[      $old5,  old_idle6       ] {};
void() old_idle6        =[      $old6,  old_idle7       ] {};
void() old_idle7        =[      $old7,  old_idle8       ] {};
void() old_idle8        =[      $old8,  old_idle9       ] {};
void() old_idle9        =[      $old9,  old_idle10      ] {};
void() old_idle10       =[      $old10, old_idle11      ] { InvulnerabilityWardFade(); };
void() old_idle11       =[      $old11, old_idle12      ] {};
void() old_idle12       =[      $old12, old_idle13      ] {};
void() old_idle13       =[      $old13, old_idle14      ] {};
void() old_idle14       =[      $old14, old_idle15      ] {};
void() old_idle15       =[      $old15, old_idle16      ] {};
void() old_idle16       =[      $old16, old_idle17      ] {};
void() old_idle17       =[      $old17, old_idle18      ] {};
void() old_idle18       =[      $old18, old_idle19      ] {   ChooseAttack();};
void() old_idle19       =[      $old19, old_idle20      ] {};
void() old_idle20       =[      $old20, old_idle21      ] { InvulnerabilityWardFade(); };
void() old_idle21       =[      $old21, old_idle22      ] {};
void() old_idle22       =[      $old22, old_idle23      ] {};
void() old_idle23       =[      $old23, old_idle24      ] 
{if (killed_monsters < 15) //nlz:15
	InvulnerabilityWard();
};
void() old_idle24       =[      $old24, old_idle25      ] {};
void() old_idle25       =[      $old25, old_idle26      ] {};
void() old_idle26       =[      $old26, old_idle27      ] {};
void() old_idle27       =[      $old27, old_idle28      ] {};
void() old_idle28       =[      $old28, old_idle29      ] {};
void() old_idle29       =[      $old29, old_idle30      ] {};
void() old_idle30       =[      $old30, old_idle31      ] { InvulnerabilityWardFade(); };
void() old_idle31       =[      $old31, old_idle32      ] {};
void() old_idle32       =[      $old32, old_idle33      ] {};
void() old_idle33       =[      $old33, old_idle34      ] {};
void() old_idle34       =[      $old34, old_idle35      ] {};
void() old_idle35       =[      $old35, old_idle36      ] {};
void() old_idle36       =[      $old36, old_idle37      ] {}; //GibMegaSpew(); };
void() old_idle37       =[      $old37, old_idle38      ] {};
void() old_idle38       =[      $old38, old_idle39      ] {};
void() old_idle39       =[      $old39, old_idle40      ] {};
void() old_idle40       =[      $old40, old_idle41      ] { InvulnerabilityWardFade(); };
void() old_idle41       =[      $old41, old_idle42      ] {};
void() old_idle42       =[      $old42, old_idle43      ] {};
void() old_idle43       =[      $old43, old_idle44      ] {};
void() old_idle44       =[      $old44, old_idle45      ] {};
void() old_idle45       =[      $old45, old_idle46      ] {};
//--------------------------------------------------------- Code Change -----
void() old_idle46       =[      $old46, old_idle1       ]
{      
	if (killed_monsters < 15) //nlz:15
	InvulnerabilityWard();
};
//---------------------------------------------------------------------------


void() old_thrash1        =[ $shake1,  old_thrash2       ] {lightstyle(0, "m");};
void() old_thrash2        =[      $shake2,  old_thrash3       ] {lightstyle(0, "k");};
void() old_thrash3        =[      $shake3,  old_thrash4       ] {lightstyle(0, "k");};
void() old_thrash4        =[      $shake4,  old_thrash5       ] {lightstyle(0, "i");};
void() old_thrash5        =[      $shake5,  old_thrash6       ] {lightstyle(0, "g");};
void() old_thrash6        =[      $shake6,  old_thrash7       ] {lightstyle(0, "e");};
void() old_thrash7        =[      $shake7,  old_thrash8       ] {lightstyle(0, "c");};
void() old_thrash8        =[      $shake8,  old_thrash9       ] {lightstyle(0, "a");};
void() old_thrash9        =[      $shake9,  old_thrash10      ] {lightstyle(0, "c");};
void() old_thrash10       =[      $shake10, old_thrash11      ] {lightstyle(0, "e");};
void() old_thrash11       =[      $shake11, old_thrash12      ] {lightstyle(0, "g");};
void() old_thrash12       =[      $shake12, old_thrash13      ] {lightstyle(0, "i");};
void() old_thrash13       =[      $shake13, old_thrash14      ] {lightstyle(0, "k");};
void() old_thrash14       =[      $shake14, old_thrash15      ] {lightstyle(0, "m");};
void() old_thrash15       =[      $shake15, old_thrash16      ] {lightstyle(0, "m");
self.cnt = self.cnt + 1;
if (self.cnt != 3)
	self.think = old_thrash1;
};
void() old_thrash16       =[      $shake16, old_thrash17      ] {lightstyle(0, "g");};
void() old_thrash17       =[      $shake17, old_thrash18      ] {lightstyle(0, "c");};
void() old_thrash18       =[      $shake18, old_thrash19      ] {lightstyle(0, "b");};
void() old_thrash19       =[      $shake19, old_thrash20      ] {lightstyle(0, "a");};
void() old_thrash20       =[      $shake20, old_thrash20      ] {finale_4();};

//============================================================================

void() finale_1 =
{
	local entity	pos, pl;
	local entity	timer;

	intermission_exittime = time + 10000000;	// never allow exit
	intermission_running = 1;

	//nlz: add to total kills, so total kills are correct

	killed_monsters = killed_monsters + 5;
	WriteByte (MSG_ALL, SVC_KILLEDMONSTER);
	WriteByte (MSG_ALL, SVC_KILLEDMONSTER);
	WriteByte (MSG_ALL, SVC_KILLEDMONSTER);
	WriteByte (MSG_ALL, SVC_KILLEDMONSTER);
	WriteByte (MSG_ALL, SVC_KILLEDMONSTER);
	
	// find the intermission spot
	pos = find (world, classname, "info_intermission");
	
	if (!pos)
		error ("no info_intermission");
	
	//<!>Teleporttrain already removed as part of Rampage mod (shubpitbattle.SetSpawnAndWayPoints())
	//pl = find (world, classname, "misc_teleporttrain");
	//if (!pl)
	//	error ("no teleporttrain");
	//remove (pl);

	WriteByte (MSG_ALL, SVC_FINALE);
	WriteString (MSG_ALL, "");
	
	pl = find (world, classname, "player");
	while (pl != world)
	{
		pl.view_ofs = '0 0 0';
		pl.angles = pos.mangle;	//other.v_angle = pos.mangle;	(Osp: this was causing crashes)
		pl.fixangle = TRUE;		// turn this way immediately
		pl.map = self.map;
		pl.nextthink = time + 0.5;
		pl.takedamage = DAMAGE_NO;
		pl.solid = SOLID_NOT;
		pl.movetype = MOVETYPE_NONE;
		pl.modelindex = 0;
		setorigin (pl, pos.origin);
		pl = find (pl, classname, "player");
	}	
	

//nlz: note it says ALL Players!
	// make fake versions of all players as standins, and move the real
	// players to the intermission spot

	// wait for 1 second
	timer = spawn();
	timer.nextthink = time + 1;
	timer.think = finale_2;	
};

void() finale_2 =
{
	local vector	o;

	// start a teleport splash inside shub

	o = shub.origin - '0 100 0';
	WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte (MSG_BROADCAST, TE_TELEPORT);
	WriteCoord (MSG_BROADCAST, o_x);
	WriteCoord (MSG_BROADCAST, o_y);
	WriteCoord (MSG_BROADCAST, o_z);

	sound (shub, CHAN_VOICE, "misc/r_tele1.wav", 1, ATTN_NORM);
	
	self.nextthink = time + 2;
	self.think = finale_3;
};

void() finale_3 =
{

	// start shub thrashing wildly
	shub.think = old_thrash1;
	sound (shub, CHAN_VOICE, "boss2/death.wav", 1, ATTN_NORM); 
	lightstyle(0, "abcdefghijklmlkjihgfedcb");	


};

void() finale_4 =
{
	// throw tons of meat chunks	
	local	vector	oldo;
	local	float	x, y, z;
	local	float	r;
	//local entity	n;

	sound (self, CHAN_VOICE, "boss2/pop2.wav", 1, ATTN_NORM); 
	
	oldo = self.origin;

	z = 16;
	while (z <= 144)
	{
		x = -64;
		while (x <= 64)
		{
			y = -64;
			while (y <= 64)
			{
				self.origin_x = oldo_x + x;
				self.origin_y = oldo_y + y;
				self.origin_z = oldo_z + z;

				r = random();
				if (r < 0.3)				
					ThrowGib ("progs/gib1.mdl", -999);
				else if (r < 0.6)
					ThrowGib ("progs/gib2.mdl", -999);
				else
					ThrowGib ("progs/gib3.mdl", -999);
				y = y + 32;
			}
			x = x + 32;
		}
		z = z + 96;
	}
	// start the end text
	WriteByte (MSG_ALL, SVC_FINALE);
	WriteString (MSG_ALL, "RAMPAGE Mod for Quake Enhanced (Nailz 2022)\n Incorporating Cranked (Patrick Martin 1998) \n and Nightmare+ (JPiolho 2021) \n Thanks for Playing");


/*
// put a player model down

	n = spawn();
	setmodel (n, "progs/player.mdl");
	//oldo = oldo - '32 264 0';
	setorigin (n, oldo);
	n.angles = '0 290 0';
	n.frame = 1;


	n = spawn();
	setmodel (n, "progs/player.mdl");
	oldo = oldo - '32 400 0';
		//oldo = oldo - '-32 264 0';
	setorigin (n, oldo);
//--------------------------------------------------------- Code Change -----
// better winning pose
        n.angles = '0 260 0';
        n.frame = 70;
*/

//---------------------------------------------------------------------------

	remove (self);
	


// switch cd track
	WriteByte (MSG_ALL, SVC_CDTRACK);
	WriteByte (MSG_ALL, 3);
	WriteByte (MSG_ALL, 3);
	lightstyle(0, "m");	


//nlz: instead of sitting here forever, run the quake ex credits and send the user back to start
	
	local entity timer = spawn();
	timer.nextthink = time + 1;
	timer.think = finale_5;	
	
};

void() finale_5 =
{

	if (finaleFinished())
		{
		sound (self, CHAN_WEAPON, "misc/r_tele4.wav", 1, ATTN_NONE);
		SpawnMonster("knight"); //nlz: Player model center
		SpawnMonster("ogre"); // left
		SpawnMonster("demon"); // leaps from back ledge
		SpawnMonster("hellknight"); // down center swinging sword
		SpawnMonster("zombie"); // left
		//SpawnMonster("shambler"); // path opening


		self.nextthink = time + 11.5;//nlz: 5
		self.think = finale_6;
		}
	else 
		{
		self.nextthink = time + 0.1;
		}
}

void() finale_6 = 
{
	if (!coop) 
		{
		localcmd("menu_credits\n");
		localcmd("disconnect\n");
		}
 
//nlz: reset runes & return to start map

	serverflags = 0;
	changelevel ("start");
	
}



//============================================================================

void () nopain =
{
	self.health = self.health + 1; //40000;
};

//============================================================================


/*QUAKED monster_oldone (1 0 0) (-16 -16 -24) (16 16 32)
*/
void() monster_oldone =
{
	//Osp: allowing for DM while i test...
	//if (deathmatch)
	//{
	//	remove(self);
	//	return;
	//}

	precache_model2 ("progs/oldone.mdl");
//--------------------------------------------------------- New Code --------
        precache_model2 ("progs/v_spike.mdl");      // for homing missile
		precache_model2 ("progs/teleport.mdl");
//---------------------------------------------------------------------------

	precache_sound2 ("boss2/death.wav");
	precache_sound2 ("boss2/idle.wav");
	precache_sound2 ("boss2/sight.wav");
	precache_sound2 ("boss2/pop2.wav");
	precache_sound2 ("items/suit.wav"); // shub under spell
	precache_sound2 ("misc/power.wav"); // sentinal lightning
	precache_sound2 ("items/inv3.wav"); // sentinal on spawn

	precache_sound2 ("misc/menu3.wav"); // noise while missile flys around
	
	precache_sound2 ("misc/basekey.wav"); // noise while sentinel flys around from point to point

	precache_sound2("misc/null.wav"); // stop sound if sentinal is dead

	precache_sound2("enforcer/enfstop.wav"); // sound for when sentinal lighning hits suit

		precache_sound("misc/r_tele4.wav");

//--------------------------------------------------------- New Code --------
        precache_sound2 ("blob/land1.wav");   // for missile launch
//---------------------------------------------------------------------------

//--------------------------------------------------------- New Code --------
// VORE SPAWN TEST
	precache_model2 ("progs/shalrath.mdl");
	precache_model2 ("progs/h_shal.mdl");
	precache_model2 ("progs/v_spike.mdl");
	
	precache_sound2 ("shalrath/attack.wav");
	precache_sound2 ("shalrath/attack2.wav");
	precache_sound2 ("shalrath/death.wav");
	precache_sound2 ("shalrath/idle.wav");
	precache_sound2 ("shalrath/pain.wav");
	precache_sound2 ("shalrath/sight.wav");

// hellknight
	precache_model2 ("progs/hknight.mdl");
	precache_model2 ("progs/k_spike.mdl");
	precache_model2 ("progs/h_hellkn.mdl");

	
	precache_sound2 ("hknight/attack1.wav");
	precache_sound2 ("hknight/death1.wav");
	precache_sound2 ("hknight/pain1.wav");
	precache_sound2 ("hknight/sight1.wav");
	precache_sound ("hknight/hit.wav");		// used by C code, so don't sound2
	precache_sound2 ("hknight/slash1.wav");
	precache_sound2 ("hknight/idle.wav");
	precache_sound2 ("hknight/grunt.wav");

	precache_sound ("knight/sword1.wav");
	precache_sound ("knight/sword2.wav");

	// zombies
	precache_model ("progs/zombie.mdl");
	precache_model ("progs/h_zombie.mdl");
	precache_model ("progs/zom_gib.mdl");

	precache_sound ("zombie/z_idle.wav");
	precache_sound ("zombie/z_idle1.wav");
	precache_sound ("zombie/z_shot1.wav");
	precache_sound ("zombie/z_gib.wav");
	precache_sound ("zombie/z_pain.wav");
	precache_sound ("zombie/z_pain1.wav");
	precache_sound ("zombie/z_fall.wav");
	precache_sound ("zombie/z_miss.wav");
	precache_sound ("zombie/z_hit.wav");
	precache_sound ("zombie/idle_w2.wav");	


//---------------------------------------------------------------------------

	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;
	
	setmodel (self, "progs/oldone.mdl");

//nlz: reduce hitbox size

	setsize (self, '-92 -108 -92', '92 108 140');

//nlz: Set Health depending on Map tier
	
	if (cvar("saved4") == 0)
		
		self.health = 2000; // easy 2k 200 TESTING
		
	else	if (cvar("saved4") == 1)

		self.health = 4500; //normal

	
	else	if (cvar("saved4") == 2)

		self.health = 6000; //hard 6k 600 testing

	else  

		self.health = 7000; //nightmare


	self.think = StartShub;	//old_idle1;
	self.nextthink = time + 0.1;	
	self.takedamage = DAMAGE_YES;
	self.th_pain = nopain;
	self.th_die = finale_1;
	shub = self;
	
	total_monsters = total_monsters + 1;

};


//===========================================================================
//  THE START OF OSP's EXTRA FUNCTIONS.
//==========================================================================


//nlz: new Shub-Missile

/*-----------------------------------------------------------------
MISSILE IMPACT

-------------------------------------------------------------------*/
void() ShubMissile_Touch =
{
	// don't explode on owner
	if (other == self.owner)
		return;		

    T_RadiusDamage (self, self, 49, shub);

sound (self, CHAN_WEAPON, "weapons/r_exp3.wav", 1, ATTN_NORM);
    self.effects = self.effects | EF_MUZZLEFLASH;


    //PM_SpawnMindGas(self.origin, shub);	//No mindgas?

	self.velocity = '0 0 0';
	self.touch = SUB_Null;
	setmodel (self, "progs/s_explod.spr");
	self.solid = SOLID_NOT;

	//s_explode1(); //nlz: this one displays the purple particles if mindgas is active

		T_MissileTouch(); //nlz: rocket explosion

};


/*-----------------------------------------------------------------
MISSILE IN FLIGHT

Tracks like the sentinel

*Copied/similar to Sentinel
-------------------------------------------------------------------*/
void() ShubMissile_Fly =
{
	local vector dir, vtemp;
	vtemp = self.enemy.origin + '0 0 10';

    if (self.enemy.health < 1 || shub.health < 1)
    {

		ShubMissile_Touch();  // explode instead of vanish
			return;
	}
	
//nlz: noise while flying around?



sound (self, CHAN_BODY, "misc/menu3.wav", 0.35, ATTN_NORM);

	dir = normalize(vtemp - self.origin);
    self.velocity = dir * 200; //nlz: slower speed
    self.nextthink = time + 0.3;
    self.think = ShubMissile_Fly; 
};



/*-----------------------------------------------------------------
MISSILE BIRTH SEQUENCE

Missile slows down then begins normal tracking behaviour.

*Copied/similar to Sentinel
-------------------------------------------------------------------*/
void() ShubMissile_Birthing = 
{
	//if vertical velocity is < 1, stop and change to normal behaviour
	self.nextthink = time + 0.1;
	
	if (self.velocity_z < 50)	//seemed about the right speed/time
	{
		WW_SlowToStop(TRUE);

//nlz: Quadlight for ShubMissile ?

self.effects = self.effects | EF_QUADLIGHT;


		self.think = ShubMissile_Fly;
		return;
	}

	WW_SlowToStop();
};


/*-----------------------------------------------------------------
CREATE MISSILE

Spawns a missile and some gibspews.
-------------------------------------------------------------------*/
void(entity target) ShubMissile_Spawn =
{
    local entity missile;
	local vector offset = '0 0 150';

	//two gib spews, one with sound
	//GibSpew(offset, TRUE);
	GibSpew(offset, FALSE);

//nlz: put old sound back in
sound (self, CHAN_WEAPON, "blob/land1.wav", 1, ATTN_NONE);

	missile = spawn();
    missile.owner = self;

	missile.solid = SOLID_BBOX;
	missile.movetype = MOVETYPE_FLYMISSILE;
	setmodel (missile, "progs/v_spike.mdl");
    missile.classname = "placental";



	setsize (missile, '0 0 0', '0 0 0');		

    missile.origin = self.origin + offset;
    missile.velocity = '0 0 400';
	missile.avelocity = '0 300 0';	//'300 300 300';
    missile.nextthink = time + 0.1;
    missile.think = ShubMissile_Birthing;
    missile.enemy = target;
    missile.touch = ShubMissile_Touch;
};

/*-----------------------------------------------------------------
MISSILE CHECK

Any valid targets in range and line of sight? If so fire at them.
-------------------------------------------------------------------*/
void() ShubMissile_FindATarget =
{
    local entity  head;
        
	head = findradius((shub.origin + '0 0 128'), 1024);
	
	while (head)
	{
		if (head.classname == "player" && CanDamage(head, shub))
		{
			ShubMissile_Spawn(head);
		}
		
		head = head.chain;
	}
};

/*---------------------------------------------------------
GibSpew

Vomit up some gibs and perhaps make some gross noise.
Takes a vector for position offset.
---------------------------------------------------------*/
void GibSpew(vector offset, float playSound)
{
	local entity mouth;
	local float roll = random();
	local string gib;

	//choose randomly a gib model
	if (roll < 0.33)
		gib = "progs/gib1.mdl";
	else if (roll < 0.66)
		gib = "progs/gib2.mdl";
	else
		gib = "progs/gib3.mdl";

	local entity oself = self;
	
	//Mouth entity needed to spawn gibs rather than at shubs' base
	mouth = spawn();
	mouth.origin = oself.origin + offset;
	mouth.think = SUB_Remove;
	mouth.nextthink = time + 1f;
		
	//Make mouth 'self' so gib inherits from that entity
	self = mouth;

	ThrowGib(gib, -150);
	self = oself;	//change shub back to the 'self'

	//play a gibbed sound
	if (playSound == TRUE)
	{
		if (random() < 0.5)
			sound (self, CHAN_VOICE, "player/gib.wav", 0.7, ATTN_NONE); //nlz: lowered from 1
		else
			sound (self, CHAN_VOICE, "player/udeath.wav", 0.7, ATTN_NONE); //nlz: lowered from 1
	}
};


/*---------------------------------------------------------
BIRTH A WARDWEAVER

Shub twitches while vomiting up some gibs from her top, before birthing a ward weaver.
---------------------------------------------------------*/

void() old_gibspew1        =[		$shake1,  old_gibspew2       ] { GibSpew('0 0 150', TRUE); };
void() old_gibspew2        =[		$shake2,  old_gibspew3       ] {};
void() old_gibspew3        =[		$shake3,  old_gibspew4       ] {};
void() old_gibspew4        =[		$shake4,  old_gibspew5       ] { GibSpew('0 0 150', FALSE); };
void() old_gibspew5        =[		$shake5,  old_gibspew6       ] {};
void() old_gibspew6        =[		$shake6,  old_gibspew7       ] {};
void() old_gibspew7        =[		$shake7,  old_gibspew8       ] { GibSpew('0 0 150', TRUE); };
void() old_gibspew8        =[		$shake8,  old_gibspew9       ] {};
void() old_gibspew9        =[		$shake9,  old_gibspew10      ] {};
void() old_gibspew10       =[		$shake10, old_gibspew1      ] { GibSpew('0 0 150', FALSE); SpawnWardWeaver('0 0 150'); old_idle19(); };


/*---------------------------------------------------------
BIRTH A SENTINEL
Shub vomits out some gibs from her front and spawns a sentinel.
---------------------------------------------------------*/
void() old_spawnSentinel1        =[		$shake9,  old_spawnSentinel2		] {};
void() old_spawnSentinel2        =[		$shake10,  old_spawnSentinel3       ] {};
void() old_spawnSentinel3        =[		$shake11,  old_spawnSentinel4       ] {};
void() old_spawnSentinel4        =[		$shake12,  old_spawnSentinel5       ] {};
void() old_spawnSentinel5        =[		$shake13,  old_spawnSentinel6       ] {};
void() old_spawnSentinel6        =[		$shake14,  old_spawnSentinel7		] {};
void() old_spawnSentinel7        =[		$shake15,  old_spawnSentinel8       ] {};
void() old_spawnSentinel8        =[		$shake16,  old_spawnSentinel9       ] { GibSpew('0 0 150', TRUE);};
void() old_spawnSentinel9        =[		$shake17,  old_spawnSentinel10      ] {};
void() old_spawnSentinel10       =[		$shake18,  old_spawnSentinel11      ] { GibSpew('0 0 150', FALSE); };
void() old_spawnSentinel11       =[		$shake19,  old_spawnSentinel12		] { SpikedOrb('0 0 150'); };
void() old_spawnSentinel12       =[		$shake20, old_idle1					] { GibSpew('0 0 150', FALSE); };


/*--------------------------------------------------------------------------
SHUB'S INVULNRABILITY
Sets invulnerablity timer, and alpha level.
If alpha is > 0, will be considered ethereal and invulnerable.
*Using .frags to store invulnerability time
---------------------------------------------------------------------------*/
void() InvulnerabilityWard =
{
	//don't if already dead or just about
	if (self.health < 10)
		return;
	
	self.alpha = 0.70f;

//nlz: play underspell sound
sound (shub, CHAN_BODY, "items/suit.wav", 0.35, ATTN_NORM);


	self.takedamage = DAMAGE_NO;
	self.frags = time + 3.5; //nlz: try less time, was (5)
};


void() InvulnerabilityWardFade
{
	if (self.frags < time)
	{
		self.alpha = 1;
		self.frags = 0;

		self.takedamage = DAMAGE_AIM;

//nlz: play sight sound (prob, keeps restarting)
sound (shub, CHAN_VOICE, "boss2/sight.wav", 1, ATTN_NORM);

	}
};

/*---------------------------------------------------------------------------
START RAMPAGE SHUB STUFF
---------------------------------------------------------------------------*/
void() StartShub = 
{
	SetSpawnAndWayPoints();		//in shubpitbattle.qc
	self.think = old_idle1;
	self.nextthink = time + 1;
};

/*---------------------------------------------------------------------------
CHOOSE ATTACK / ACTION
Shub makes a decision on whether to give birth to:
 - birth a WardWeaver (must be < 3 ward weavers in existence)
 - <?>launch a lava storm (needs > 10 lava balls)
 - spit out a sentinel (< 4 sentinels & > 20secs from last one sent)
 - or launch a homing missile (default)

---------------------------------------------------------------------------*/
void() ChooseAttack =
{
	local float wardweaverCount = 0;
	local float rand = random();
	local float requiredRoll;

	//WardWeaver Check (requires 14 monsters killed before allowed)
	//Are there less than X ward weavers? If so, get the empty index (to store the new one)
	for (float i = 0; i < wardWeavers.length; i++)
	{
		if (wardWeavers[i].classname == "monster_wardweaver")
			wardweaverCount ++;
	}

	//Chance for a wardweaver to be birthed is based on how many exist
	requiredRoll = wardweaverCount * (1 / wardWeavers.length);

	
	if (killed_monsters > 13 && rand > requiredRoll) //nlz: Shub is now held underSpell until 14 monsters are killed then wardweavers start
	{
		//set animation for birthing a new Ward Weaver.
		self.think = old_gibspew1;
		self.nextthink = time + 0.1f;
		return;
	}
	//No wardweaver could be spawned...checking for sentinel or missile
	else
	{
		//SENTINEL (70% chance if not enough exist, BUT only if 27 (was 10) monsters killed)
		if (killed_monsters > 26) //nlz: these dont appear till later (26)
		{
			//Sentinel count
			local float sentinelCount = 0;

			for (float i = 0; i < sentinels.length; i++)
			{
				if (sentinels[i].classname == "sentinel")
					sentinelCount ++;
			}

			//Try sentinel (spiked orb)...70% chance
			if (sentinelCount < sentinels.length && random() < 0.7)
			{
				self.think = old_spawnSentinel1;
				self.nextthink = time + 0.1f;
				return;
			}
			
		}
		
		
		//MISSILE
		//Couldn't birth a sentinel or wardweaver, try looking for a target to shoot at...


if(killed_monsters < 33) //nlz: stop shub missile after 32 kills
		{
		ShubMissile_FindATarget();
		}


	}
};

//===========================================================================
//  THE END OF OSP's EXTRA FUNCTIONS.
//===========================================================================




