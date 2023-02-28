	// RAMPAGE Mod file. Last Updated 28 Jan 23

//nlz: taken form mg1/horde.qc

/*QUAKED info_monster_start START_OFF
if targeted, it will toggle between on or off, like lights 
*/
float SKIP_BLOCK_CHECK = 2;
void() monster_start_use =
{
	if (self.spawnflags & START_OFF)
		self.spawnflags = self.spawnflags - START_OFF;
	else
		self.spawnflags = self.spawnflags + START_OFF;
};

void() info_monster_start =
{
	self.wait = FALSE; // used for checking if this is a valid spawn
	self.use = monster_start_use;
	setorigin (self, self.origin);	
	setsize(self, '-80 -80 0', '80 80 128');
};

void() info_monster_start_ranged = // used for ogres and enforcers
{
	self.wait = FALSE; // used for checking if this is a valid spawn
	self.use = monster_start_use;
	setorigin (self, self.origin);	
	setsize(self, '-44 -44 0', '44 44 128');
};

void() info_monster_start_flying = // used exclusively for scrags (wizards)
{
	self.wait = FALSE; // used for checking if this is a valid spawn
	self.use = monster_start_use;
	setorigin (self, self.origin);	
	setsize(self, '-80 -80 0', '80 80 128');
};

void() info_monster_start_boss = // used for shalraths and shamblers
{
	self.wait = FALSE; // used for checking if this is a valid spawn
	self.use = monster_start_use;
	setorigin (self, self.origin);	
	setsize(self, '-44 -44 0', '44 44 128');
};


//============================================================================
void() PrecacheMonsters =
{
	//nlz: Player
	precache_model ("progs/player.mdl");
	precache_sound ("weapons/lhit.wav");
	
	// knight
	precache_model ("progs/knight.mdl");
	precache_model ("progs/h_knight.mdl");

	precache_sound ("knight/kdeath.wav");
	precache_sound ("knight/khurt.wav");
	precache_sound ("knight/ksight.wav");
	precache_sound ("knight/sword1.wav");
	precache_sound ("knight/sword2.wav");
	precache_sound ("knight/idle.wav");
	
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
	
	// dog
	precache_model ("progs/h_dog.mdl");
	precache_model ("progs/dog.mdl");

	precache_sound ("dog/dattack1.wav");
	precache_sound ("dog/ddeath.wav");
	precache_sound ("dog/dpain1.wav");
	precache_sound ("dog/dsight.wav");
	precache_sound ("dog/idle.wav");
	
	// demon
	precache_model ("progs/demon.mdl");
	precache_model ("progs/h_demon.mdl");

	precache_sound ("demon/ddeath.wav");
	precache_sound ("demon/dhit2.wav");
	precache_sound ("demon/djump.wav");
	precache_sound ("demon/dpain1.wav");
	precache_sound ("demon/idle1.wav");
	precache_sound ("demon/sight2.wav");
	
	// ogre
	precache_model ("progs/ogre.mdl");
	precache_model ("progs/h_ogre.mdl");
	precache_model ("progs/grenade.mdl");

	precache_sound ("ogre/ogdrag.wav");
	precache_sound ("ogre/ogdth.wav");
	precache_sound ("ogre/ogidle.wav");
	precache_sound ("ogre/ogidle2.wav");
	precache_sound ("ogre/ogpain1.wav");
	precache_sound ("ogre/ogsawatk.wav");
	precache_sound ("ogre/ogwake.wav");
	
	// grunt
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
	
	// enforcer
	precache_model2 ("progs/enforcer.mdl");
	precache_model2 ("progs/h_mega.mdl");
	precache_model2 ("progs/laser.mdl");

	precache_sound2 ("enforcer/death1.wav");
	precache_sound2 ("enforcer/enfire.wav");
	precache_sound2 ("enforcer/enfstop.wav");
	precache_sound2 ("enforcer/idle1.wav");
	precache_sound2 ("enforcer/pain1.wav");
	precache_sound2 ("enforcer/pain2.wav");
	precache_sound2 ("enforcer/sight1.wav");
	precache_sound2 ("enforcer/sight2.wav");
	precache_sound2 ("enforcer/sight3.wav");
	precache_sound2 ("enforcer/sight4.wav");
	
	// shambler
	precache_model ("progs/shambler.mdl");
	precache_model ("progs/s_light.mdl");
	precache_model ("progs/h_shams.mdl");
	precache_model ("progs/bolt.mdl");
	
	precache_sound ("shambler/sattck1.wav");
	precache_sound ("shambler/sboom.wav");
	precache_sound ("shambler/sdeath.wav");
	precache_sound ("shambler/shurt2.wav");
	precache_sound ("shambler/sidle.wav");
	precache_sound ("shambler/ssight.wav");
	precache_sound ("shambler/melee1.wav");
	precache_sound ("shambler/melee2.wav");
	precache_sound ("shambler/smack.wav");
	
	// shalrath
	precache_model2 ("progs/shalrath.mdl");
	precache_model2 ("progs/h_shal.mdl");
	precache_model2 ("progs/v_spike.mdl");
	
	precache_sound2 ("shalrath/attack.wav");
	precache_sound2 ("shalrath/attack2.wav");
	precache_sound2 ("shalrath/death.wav");
	precache_sound2 ("shalrath/idle.wav");
	precache_sound2 ("shalrath/pain.wav");
	precache_sound2 ("shalrath/sight.wav");
	
	// wizard
	precache_model ("progs/wizard.mdl");
	precache_model ("progs/h_wizard.mdl");
	precache_model ("progs/w_spike.mdl");

	precache_sound ("wizard/hit.wav");		// used by c code
	precache_sound ("wizard/wattack.wav");
	precache_sound ("wizard/wdeath.wav");
	precache_sound ("wizard/widle1.wav");
	precache_sound ("wizard/widle2.wav");
	precache_sound ("wizard/wpain.wav");
	precache_sound ("wizard/wsight.wav");	
	
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

	
	// ammo
	precache_model ("maps/b_shell1.bsp");
	precache_model ("maps/b_shell0.bsp");
	precache_model ("maps/b_nail1.bsp");
	precache_model ("maps/b_nail0.bsp");
	precache_model ("maps/b_rock1.bsp");
	precache_model ("maps/b_rock0.bsp");
	precache_model ("maps/b_batt1.bsp");
	precache_model ("maps/b_batt0.bsp");
	
	// items
	precache_model("maps/b_bh10.bsp"); // rotten health
	precache_sound("items/r_item1.wav");
	precache_model("maps/b_bh25.bsp"); // regular health
	precache_sound("items/health1.wav");
	precache_model ("progs/armor.mdl"); // regular armor
	
	// quad damage
	precache_model ("progs/quaddama.mdl");
	precache_sound ("items/damage.wav");
	precache_sound ("items/damage2.wav");
	precache_sound ("items/damage3.wav");
	
	// pentagram (invulnerability)
	precache_model ("progs/invulner.mdl");
	precache_sound ("items/protect.wav");
	precache_sound ("items/protect2.wav");
	precache_sound ("items/protect3.wav");

};
	
/*
================
SpawnMonster
================
*/
entity(string class) SpawnMonster =
{
	local entity monster;
	monster = spawn();
	
//nlz: Global settings:

	monster.angles = '0 0 0'; 
	monster.solid = SOLID_SLIDEBOX;
	

if !(world.model == "maps/end.bsp")
	{
	monster.movetype = MOVETYPE_STEP;
	}
	//monster.target = "horde_manager";
	monster.flags = monster.flags | FL_MONSTER;

	 
	//monster.alpha = 1; // only set monster alpha after they're a corpse //nlz: this was already commented out
	
	local entity oself; // old self


	// perform enemy-type specific loading
	if (class == "knight")
	{
		if (world.model == "maps/end.bsp")
		{	
	
	//nlz:hack using knight for endpose player model

		setmodel (monster, "progs/player.mdl");
		setsize (monster, '-16 -16 -24', '16 16 40');
		
		monster.takedamage = DAMAGE_NO;
		monster.movetype = MOVETYPE_NONE;


		//nlz: PLAYER endpose origin / angles
		setorigin(monster, '-624 1808 76');
		monster.angles = '0 200 0';
		
		//org = org + '0 0 24'; // offset based on size
		monster.classname = "monster_knight";
		monster.health = 75;
		//nlz: hack to force endpose regardless
		monster.th_stand = player_endpose1;
		monster.th_walk = player_endpose1;
		monster.th_run = player_endpose1;
		monster.th_melee = player_endpose1;
		monster.th_pain = player_endpose1;
		monster.th_die = player_endpose1;
		}

		else
		{
		setmodel (monster, "progs/knight.mdl");
		setsize (monster, '-16 -16 -24', '16 16 40');

		
		//org = org + '0 0 24'; // offset based on size
		monster.classname = "monster_knight";
		monster.health = 75;
		monster.th_stand = knight_stand1;
		monster.th_walk = knight_walk1;
		monster.th_run = knight_run1;
		monster.th_melee = knight_atk1;
		monster.th_pain = knight_pain;
		monster.th_die = knight_die;
		}


	}
	else if (class == "hellknight")
	{
		setmodel (monster, "progs/hknight.mdl");
		setsize (monster, '-16 -16 -24', '16 16 40');

		//nlz: set for diff monsters ?
	if (world.model == "maps/end.bsp")
		{
		monster.takedamage = DAMAGE_NO;
		monster.movetype = MOVETYPE_NONE;


		//nlz: HELLKNIGHT endpose origin / angles
		setorigin(monster, '-928 2176 76');
		monster.angles = '0 270 0';

		//org = org + '0 0 24';
		monster.classname = "monster_hell_knight";
		spawn_tfog(monster.origin);
		monster.health = 250;
		monster.th_stand = hknight_ep_a1;
		monster.th_walk = hknight_ep_a1;
		monster.th_run = hknight_ep_a1;
		monster.th_melee = hknight_ep_a1;
		monster.th_missile = hknight_ep_a1;
		monster.th_pain = hknight_ep_a1;
		monster.th_die = hknight_ep_a1;
		//monster.target = string_null; // don't target anything!
		}
		/*original
		//org = org + '0 0 24';
		monster.classname = "monster_hell_knight";
		monster.health = 250;
		monster.th_stand = hknight_stand1;
		monster.th_walk = hknight_walk1;
		monster.th_run = hknight_run1;
		monster.th_melee = hknight_melee;
		monster.th_missile = hknight_magicc1;
		monster.th_pain = hknight_pain;
		monster.th_die = hknight_die;
		

		*/
	}
	else if (class == "dog")
	{
		setmodel (monster, "progs/dog.mdl");
		setsize (monster, '-32 -32 -24', '32 32 40');
		//org = org + '0 0 24';
		monster.classname = "monster_dog";
		monster.health = 25;
		monster.th_stand = dog_stand1;
		monster.th_walk = dog_walk1;
		monster.th_run = dog_run1;
		monster.th_pain = dog_pain;
		monster.th_die = dog_die;
		monster.th_melee = dog_atta1;
		monster.th_missile = dog_leap1;
	}
	else if (class == "demon")
	{
		setmodel (monster, "progs/demon.mdl");
		setsize (monster, VEC_HULL2_MIN, VEC_HULL2_MAX);
		monster.classname = "monster_demon1";
		
	//nlz: set for diff monsters ?
	if (world.model == "maps/end.bsp")
		{
		monster.takedamage = DAMAGE_NO;
		monster.movetype = MOVETYPE_NONE;
		
	//nlz: FIEND endpose origin / angles
		
		setorigin(monster, '-1024 2672 232'); //back ledge
		
		monster.angles = '0 180 0'; //250
		spawn_tfog(monster.origin);
		monster.health = 300;
		//org = org + '0 0 48';

	//nlz: hack to force endpose regardless
		monster.th_stand = demon1_endpose1;
		monster.th_walk = demon1_endpose1;
		monster.th_run = demon1_endpose1;
		monster.th_die = demon1_endpose1;
		monster.th_melee = demon1_endpose1;
		monster.th_missile = demon1_endpose1;
		monster.th_pain = demon1_endpose1;
		}
	else
		{
		monster.health = 300;
		//org = org + '0 0 48';
		
		monster.th_stand = demon1_stand1;
		monster.th_walk = demon1_walk1;
		monster.th_run = demon1_run1;
		monster.th_die = demon_die;
		monster.th_melee = Demon_MeleeAttack;
		monster.th_missile = demon1_jump1;
		monster.th_pain = demon1_pain;
		}
	}
	else if (class == "ogre")
	{
		setmodel (monster, "progs/ogre.mdl");
		setsize (monster, VEC_HULL2_MIN, VEC_HULL2_MAX);
		monster.classname = "monster_ogre";

	//nlz: set for diff monsters ?

	if (world.model == "maps/end.bsp")
		{	
		monster.takedamage = DAMAGE_NO;
		monster.movetype = MOVETYPE_NONE;


//nlz: OGRE endpose origin / angles
		setorigin(monster, '-880 1824 76');
		monster.angles = '0 135 0';

		monster.health = 200;
		//org = org + '0 0 24';
		
	//nlz: hack to force endpose regardless
		monster.th_stand = ogre_endpose1;
		monster.th_walk = ogre_endpose1;
		monster.th_run = ogre_endpose1;
		monster.th_die = ogre_endpose1;
		monster.th_melee = ogre_endpose1;
		monster.th_missile = ogre_endpose1;
		monster.th_pain = ogre_endpose1;
		monster.target = string_null; // don't target anything!

		}
	else
		{
		monster.health = 200;
		//org = org + '0 0 24';

		monster.th_stand = ogre_stand1;
		monster.th_walk = ogre_walk1;
		monster.th_run = ogre_run1;
		monster.th_die = ogre_die;
		monster.th_melee = ogre_melee;
		monster.th_missile = ogre_nail1;
		monster.th_pain = ogre_pain;
		}
	}
	else if (class == "grunt")
	{
		setmodel (monster, "progs/soldier.mdl");
		setsize (monster, '-16 -16 -24', '16 16 40');
		monster.classname = "monster_army";
		monster.health = 30;
		//org = org + '0 0 24';
		monster.th_stand = army_stand1;
		monster.th_walk = army_walk1;
		monster.th_run = army_run1;
		monster.th_missile = army_atk1;
		monster.th_pain = army_pain;
		monster.th_die = army_die;
	}
	else if (class == "enforcer")
	{
		setmodel (monster, "progs/enforcer.mdl");
		setsize (monster, '-16 -16 -24', '16 16 40');
		monster.classname = "monster_enforcer";
		monster.health = 80;
		//org = org + '0 0 24';
		monster.th_stand = enf_stand1;
		monster.th_walk = enf_walk1;
		monster.th_run = enf_run1;
		monster.th_pain = enf_pain;
		monster.th_die = enf_die;
		monster.th_missile = enf_atk1;
	}
	else if (class == "shambler")
	{
		setmodel (monster, "progs/shambler.mdl");
		setsize (monster, VEC_HULL2_MIN, VEC_HULL2_MAX);
		monster.classname = "monster_shambler";

	if (world.model == "maps/end.bsp")
		{	
		monster.takedamage = DAMAGE_NO;
		monster.movetype = MOVETYPE_NONE;

	//nlz:(NOT USED) SHAMBLER endpose origin / angles
		setorigin(monster, '-1358 2050 168');
		monster.angles = '0 325 0';

	
		monster.health = 600;
		//org = org + '0 0 32';
		monster.th_stand = ep_sham_magica1;
		monster.th_walk = ep_sham_magica1;
		monster.th_run = ep_sham_magica1;
		monster.th_die = ep_sham_magica1;
		monster.th_melee = ep_sham_magica1;
		monster.th_missile = ep_sham_magica1;
		monster.th_pain = ep_sham_magica1;
		}
		
		/*original
		monster.health = 600;
		//org = org + '0 0 32';
		monster.th_stand = sham_stand1;
		monster.th_walk = sham_walk1;
		monster.th_run = sham_run1;
		monster.th_die = sham_die;
		monster.th_melee = sham_melee;
		monster.th_missile = sham_magic1;
		monster.th_pain = sham_pain;
		*/
		
	}
	else if (class == "shalrath")
	{
		setmodel (monster, "progs/shalrath.mdl");
		setsize (monster, VEC_HULL2_MIN, VEC_HULL2_MAX);
		monster.classname = "monster_shalrath";
		//org = org + '0 0 32';
		monster.health = 400;
		monster.th_stand = shal_stand;
		monster.th_walk = shal_walk1;
		monster.th_run = shal_run1;
		monster.th_die = shalrath_die;
		monster.th_pain = shalrath_pain;
		monster.th_missile = shal_attack1;
	}
	else if (class == "wizard")
	{
		setmodel (monster, "progs/wizard.mdl");
		monster.flags = monster.flags | FL_FLY; // special behavior
		monster.classname = "monster_wizard";
		setsize (monster, VEC_HULL_MIN, VEC_HULL_MAX);
		//org = org + '0 0 32';
		monster.health = 80;
		monster.th_stand = wiz_stand1;
		monster.th_walk = wiz_walk1;
		monster.th_run = wiz_run1;
		monster.th_missile = Wiz_Missile;
		monster.th_pain = Wiz_Pain;
		monster.th_die = wiz_die;
	}
	else if (class == "zombie")
	
	{
		setmodel (monster, "progs/zombie.mdl");
		setsize (monster, '-16 -16 -24', '16 16 40');
	
	if (world.model == "maps/end.bsp")
		{
		monster.takedamage = DAMAGE_NO;
		monster.movetype = MOVETYPE_NONE;

	//nlz: endpose origin / angles
		
		setorigin(monster, '-664 1808 76');
		monster.angles = '0 270 0';

		monster.classname = "monster_zombie";
		//org = org + '0 0 32';
		spawn_tfog(monster.origin);
		monster.health = 60;
		monster.th_stand = zombie_epb10;
		monster.th_walk = zombie_epb10;
		monster.th_run = zombie_epb10;
		monster.th_pain = zombie_epb10;
		monster.th_die = zombie_epb10;
		monster.th_missile = zombie_epb10;
		monster.target = string_null; // don't target anything!
		}
	}

		/*original
	{
		setmodel (monster, "progs/zombie.mdl");
		setsize (monster, '-16 -16 -24', '16 16 40');
		monster.classname = "monster_zombie";
		//org = org + '0 0 32';
		monster.health = 60;
		monster.th_stand = zombie_stand1;
		monster.th_walk = zombie_walk1;
		monster.th_run = zombie_run1;
		monster.th_pain = zombie_pain;
		monster.th_die = zombie_die;
		monster.th_missile = zombie_missile;
		monster.target = string_null; // don't target anything!
	}
*/
	else
	{
		dprint("ERROR: No monster provided");
	}
	// finish the shared settings
	//setorigin (monster);
	//monster.origin_z = monster.origin_z + 1;	// raise off floor a bit
	
	// temporarily swap self for next funcs
	oself = self;
	self = monster;
	
	if (class != "wizard")
		droptofloor();
	
	if (!walkmove(0,0))
	{
		dprint ("walkmonster in wall at: ");
		dprint (vtos(self.origin));
		dprint ("\n");
	}
	
	// resume normal self behavior
	self = oself;
	
	monster.category = CATEGORY_MONSTER;
	
if !(world.model == "maps/end.bsp")
	{
	monster.takedamage = DAMAGE_AIM;
	}
	monster.ideal_yaw = monster.angles * '0 1 0';
	if (!monster.yaw_speed)
		monster.yaw_speed = 20;
	monster.view_ofs = '0 0 25';
	monster.use = monster_use;
	
	monster.flags = monster.flags | FL_MONSTER;
	
	//monster.enemy = HordeFindTarget(); // find a random living player
	//monster.enemy = find (world, classname, "player");
	monster.think = FoundTarget;
		
	//monster.nextthink = monster.nextthink + 0.1;
	monster.nextthink = time + 0.1;
	
	//spawn_tdeath_fast (monster.origin, monster);
	//spawn_tfog(monster.origin);
	
	monster.owner = self;

/* horde stuff
	if (monster.classname != "monster_zombie") // don't count zombies toward total goal
		total_monsters = total_monsters + 1;
*/
	
	
	return monster;
};

//SpawnMonster("ogre", org + '0 0 0', org_angles);