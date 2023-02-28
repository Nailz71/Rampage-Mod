		// RAMPAGE Mod file. Last Updated 24 Sep 22
/*==========================================================================
  sigils.qc -- by Osp             Last updated:  14.07.2022
--------------------------------------------------------------------------
  Contains code that handles toggling on sigils(runes), and dynamically opening
  or closing the episode and boss gates in start map.

  [USAGE]
  Use the cvar saved2 #
  Where # is the combined sum of the desired rune values:
  1 = episode 1
  2 = episode 2
  4 = episode 3
  8 = episode 4
  So to award episode 2 and 4 runes only = (2 + 4) = 6; typed in consoles as "saved2 6"
  For all runes (1+2+4+8) = 15, typed in console as "saved2 15"
  0 will clear.

  *Picked-up runes work as normal, though they will be removed if a new value excludes them.
  *The check isn't done every frame, so there might be a slight delay.

==========================================================================*/

float sigils;		//the runes specifically set by cvar saved2

entity sigil_checker;
entity episodegates[4];
entity bossgate;

void() CreateSigilChecker;
void() episodegate_check;
void() bossgate_check;
void() set_gates;
void() sigil_check;


//CREATE SIGIL CHECKER
//Called from world.worldspawn()
//Creates an entity that will activate or deactive the episodegates and bossgate in the start level according to the runes collected.
//*Will only be created on the start map.
void() CreateSigilChecker = {

	if (world.model != "maps/start.bsp")
		return;

	//set the cvar to the serverflags. This auto updates the saved2 value to reflect what runes the player already had.
	sigils = serverflags;
	cvar_set("saved2",ftos( sigils)); 

	sigil_checker = spawn();
	sigil_checker.nextthink = time + 1;	//time required for some reason before gates exist
	sigil_checker.think = set_gates;
};

//SET EPISODE GATES
//references the episode and boss gate entities (so we only need search for them once)
//Also records their initial model as .target so when the model is nulled, it can be reloaded.
void() set_gates = {
	local float i = 0;
	local entity egate = find(world, classname, "func_episodegate");

	//find and record the four egates;
	while (egate)
	{
		episodegates[i] = egate;

		//store the episodegates' model in its .target field (bit of a hack), need it remembered.
		episodegates[i].target = episodegates[i].model;

		egate = find(egate, classname, "func_episodegate");

		i++;
	}

	//find and record the bossgate
	bossgate = find(world, classname, "func_bossgate");
	bossgate.target = bossgate.model;

	sigil_checker.nextthink = time + 1;
	sigil_checker.think = episodegate_check;
};

//
//Will check for sigils in inventory and open or close the corresponding gate.
void() episodegate_check = {

	local float i = 0;

	//cop
	sigil_check();	//check if runes have been added/subtracted

	//get each episode gate to run its use function
	while (i < 4)
	{
		if (episodegates[i].classname == "func_episodegate")
		{
			local float solidstate = serverflags & episodegates[i].spawnflags ? SOLID_BSP : SOLID_NOT;

			//if episodegate's rune is retrieved, show the gate, otherwise hide it.
			episodegates[i].angles = '0 0 0';
			episodegates[i].movetype = solidstate ? MOVETYPE_PUSH : MOVETYPE_NONE;
			episodegates[i].solid = solidstate;
			episodegates[i].model = solidstate ? episodegates[i].target : string_null;
			setmodel (episodegates[i], episodegates[i].model);
		}

		i++;
	}

	bossgate_check();
};

//Will open the bossgate if all sigils are in inventory
void() bossgate_check = {

	if (bossgate.classname == "func_bossgate")
	{
		local float closed = ((serverflags & 15) == 15) ? 0 : 1;

		bossgate.angles = '0 0 0';
		bossgate.movetype = closed ? MOVETYPE_PUSH : MOVETYPE_NONE;
		bossgate.solid = closed ?  SOLID_BSP : SOLID_NOT;
		bossgate.model = closed ? bossgate.target : string_null;
		setmodel (bossgate, bossgate.model);

		//override teamplay (friendlyfire off) if the boss gate is open
        if (!closed && teamplay == 0) //nlz: added teamplay to stop looping
           cvar_set("teamplay", "1");
		
	}

	//loop back to episodegate_check so we keep cycling
	sigil_checker.nextthink = time + 2;	//check every 2 secs
	sigil_checker.think = episodegate_check;
};


//UPDATE SIGILS 
void() sigil_check =
{
	sigils = cvar("saved2");
	serverflags = sigils;
};
