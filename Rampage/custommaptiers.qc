		// RAMPAGE Mod file. Last Updated 24 Nov 22
// ==========================================================================
//  custommaptiers.qc -- by Osp
//--------------------------------------------------------------------------
//	Fields set when Set_Map_Tier called in world.worldspawn().
//	Sets the spawn counts, health multiplier and other level based variables for RAMPAGE Mod
//	'tier_skill' value stands in for skill option - allowing more specific customisation.
//==========================================================================


float	cmt_spawn_amount;			//number of times to spawn each monster
float	cmt_bonus_spawn;			//this chance to add +1 spawn (0.2 = 20% chance)
float	cmt_health_multiplier;		//monster max_health is mutliplied by this
float	cmt_bonus_health;			//adds a random amount of health up to this % of max health (0.15 would be a random bonus of 0%-15% extra health).

void() Set_Map_Tier;
void(entity monster) CMT_SetHealth;

//SET MAP TIER INFO
//When run will set the values used in the nightmare+ spawn logic.
void() Set_Map_Tier = 
{
	//Default values:
	cmt_spawn_amount = 2.0;
	cmt_bonus_spawn = 0.0;		//nlz: Not used
	cmt_health_multiplier = 1.5;
	cmt_bonus_health = 0.0;		//nlz: 

//nlz: bonus not yet used. bonus spawn would throw out balance. bonus health will prob be used for shub map at least Note. would need to be added to monster files see soldier.qc. or scragg.qc


	//Set the tier according to the saved4 value, unless the nightmare+ gm_nightmare_only is set, in which case set to tier 3 (Osp: 4 SEP 2022).
	local float tier = (gamemode & GM_NIGHTMARE_ONLY) ? 3 : cvar ("saved4"); //nlz: this stopped working & is now done in triggers.qc

	//Custom settings for certain maps:
	switch (world.model)
	{

		// Introduction *start*

		case "maps/start.bsp":
			cmt_spawn_amount = 1.0;
			break;

//nlz: Start of Map Balancing, this is where difficulties can be edited to suit but beware of ammo shortage problems with high multipliers and or HP

			// *Episode 1*

		
			// The Slipgate Complex *e1m1*
	
		//***
		case "maps/e1m1.bsp":
			if (tier == 0)	//easy
			{
				cmt_spawn_amount = 1.0;
			}

			else if (tier == 2)	//hard
			{
				// Default
			}

			else if (tier == 3)	//nightmare
			{
				
				cmt_health_multiplier = 2.0;
			}

			else	//normal
			{
				cmt_spawn_amount = 1;
			}
			break;
		
		
		// Castle of the Damned *e1m2*
			
			case "maps/e1m2.bsp":
			if (tier == 0)	//easy
			{
				cmt_spawn_amount = 1.0;	
			}

			else if (tier == 2)	//hard
			{
				// Default
			}

			else if (tier == 3)	//nightmare
			{
				
				cmt_health_multiplier = 2.0;
			}

			else	//normal
			{
				cmt_spawn_amount = 1.0;
				cmt_health_multiplier = 2.0;
			}
			break;


		// The Necropolis *e1m3*

		case "maps/e1m3.bsp":
			if (tier == 0)	//easy
			{
				cmt_spawn_amount = 1.0;
				cmt_health_multiplier = 1.3;
			}

			else if (tier == 2)	//hard
			{
				// default

			}

			else if (tier == 3)	//nightmare
			{
				
				cmt_health_multiplier = 2.0;
			}

			else	//normal
			{
				cmt_spawn_amount = 1;
			}
			break;

		// The Grisly Grotto *e1m4*

			case "maps/e1m4.bsp":
			if (tier == 0)	//easy
			{
				cmt_spawn_amount = 1.0;
			}

			else if (tier == 2)	//hard
			{
				// Default
			}

			else if (tier == 3)	//nightmare
			{
				
				cmt_health_multiplier = 2.0;
			}
			else	//normal
			{
				cmt_spawn_amount = 1;
			}
			break;



		// Gloom Keep *e1m5*

			

			case "maps/e1m5.bsp":
			if (tier == 0)	//easy
			{
				cmt_spawn_amount = 1.0;
			}

			else if (tier == 2)	//hard
			{
				
				cmt_health_multiplier = 2.0;
			}

			else if (tier == 3)	//nightmare
			{
				cmt_spawn_amount = 3;

			}
			else	//normal
			{
				// Default
			}
			break;




		// The Door to Chthon *e1m6*

		case "maps/e1m6.bsp":
			if (tier == 0)	//easy
			{
				cmt_spawn_amount = 1.0;
				cmt_health_multiplier = 2.0;
			}

			else if (tier == 2)	//hard
			{
				cmt_spawn_amount = 3.0;
			}

			else if (tier == 3)	//nightmare
			{
				cmt_spawn_amount = 3;
				cmt_health_multiplier = 2.0;
			}

			else	//normal
			{
				cmt_spawn_amount = 2.0;
				cmt_health_multiplier = 2.0;
			}
			break;

			
		// The House of Chthon *e1m7*

		case "maps/e1m7.bsp":
			if (tier == 0)	//easy
			{
				cmt_health_multiplier = 2; // x 1000
			}

			else if (tier == 2)	//hard
			{
				cmt_health_multiplier = 7; // x 1000
			}

			else if (tier == 3)	//nightmare
			{
				cmt_health_multiplier = 9; // x 1000
			}

			else	//normal
			{
				cmt_health_multiplier = 4; // x 1000
			}
			break;

	
		// Ziggurat Vertigo *e1m8* (Secret Level ep1)

			case "maps/e1m8.bsp":
			if (tier == 0)	//easy
			{
				cmt_spawn_amount = 1.0;
			}

			else if (tier == 2)	//hard
			{
				// Default
			}

			else if (tier == 3)	//nightmare
			{
				
				cmt_health_multiplier = 2.0;
			}

			else	//normal
			{
				cmt_spawn_amount = 1;
			}
			break;


//-----------------------------------------------------------

			// *Episode 2*

		// The Installation *e2m1*

			case "maps/e2m1.bsp":
			if (tier == 0)	//easy
			{
				cmt_spawn_amount = 1.0;

			}

			else if (tier == 2)	//hard
			{
				
			cmt_health_multiplier = 2.0;

			}

			else if (tier == 3)	//nightmare
			{
				
				cmt_spawn_amount = 3;
			}

			else	//normal
			{
				// Default
			}
			break;


		
		// The Ogre Citadel *e2m2*
		
			case "maps/e2m2.bsp":
			if (tier == 0)	//easy
			{
				cmt_spawn_amount = 1.0;
			}

			else if (tier == 2)	//hard
			{
				cmt_health_multiplier = 2.0;
			}

			else if (tier == 3)	//nightmare
			{
				
				cmt_spawn_amount = 3;
			}

			else	//normal
			{
				// Default
			}
			break;



		// The Crypt of Decay *e2m3*

			case "maps/e2m3.bsp":
			if (tier == 0)	//easy
			{
				cmt_spawn_amount = 1.0;
			}

			else if (tier == 2)	//hard
			{
				// default
			}

			else if (tier == 3)	//nightmare
			{
				
				cmt_health_multiplier = 2.0;
			}

			else	//normal
			{
				cmt_spawn_amount = 1;
			}
			break;




		// The Ebon Fortress *e2m4*

			case "maps/e2m4.bsp":
			if (tier == 0)	//easy
			{
				cmt_spawn_amount = 1.0;
			}
			
			else if (tier == 2)	//hard
			{
				// default
			}

			else if (tier == 3)	//nightmare
			{
				
				cmt_health_multiplier = 2.0;
			}

			else	//normal
			{
				cmt_spawn_amount = 1;
			}
			break;



		// The Wizards Manse *e2m5*

			case "maps/e2m5.bsp":
			if (tier == 0)	//easy
			{
				cmt_spawn_amount = 1.0;
			}

			else if (tier == 2)	//hard
			{
				cmt_spawn_amount = 3.0;
			}

			else if (tier == 3)	//nightmare
			{
				cmt_spawn_amount = 3;
				cmt_health_multiplier = 2.0;
			}

			else	//normal
			{
				// Default
			}
			break;




		// The Dismal Oubliette *e2m6

			case "maps/e2m6.bsp":
			if (tier == 0)	//easy
			{
				cmt_spawn_amount = 1.0;
			}

			else if (tier == 2)	//hard
			{
				cmt_health_multiplier = 2.0;
			}
			
			else if (tier == 3)	//nightmare
			{
				
				cmt_spawn_amount = 3;
			}

			else	//normal
			{
				// Default
			}
			break;

		

		// The Underearth  *e1m7* (Secret Level ep2)

			case "maps/e2m7.bsp":
			if (tier == 0)	//easy
			{
				cmt_spawn_amount = 1.0;
			}

			else if (tier == 2)	//hard
			{
				// Default
			}

			else if (tier == 3)	//nightmare
			{
				
				cmt_health_multiplier = 2.0;
			}

			else	//normal
			{
				cmt_spawn_amount = 1;
				cmt_health_multiplier = 2.0;
			}
			break;


//-----------------------------------------------------------

			// *Episode 3*


		// Temination Central *e3m1*

			case "maps/e3m1.bsp":
			if (tier == 0)	//easy
			{
				cmt_spawn_amount = 1.0;
				
			}

			else if (tier == 2)	//hard
			{
				// Default
			}

			else if (tier == 3)	//nightmare
			{
				
				cmt_health_multiplier = 2.0;
			}

			else	//normal
			{
				cmt_spawn_amount = 1;
				cmt_health_multiplier = 2.0;
			}
			break;




		// The Vaults of Zin *e3m2*

			case "maps/e3m2.bsp":
			if (tier == 0)	//easy
			{
				cmt_spawn_amount = 1.0;
			}

			else if (tier == 2)	//hard
			{
				
				cmt_health_multiplier = 2.0;
			}

			else if (tier == 3)	//nightmare
			{
				
				cmt_spawn_amount = 3;
			}

			else	//normal
			{
				// Default
			}
			break;


		
		// The Tomb of Terror *e3m3*

			case "maps/e3m3.bsp":
			if (tier == 0)	//easy
			{
				cmt_spawn_amount = 1.0;
			}

			else if (tier == 2)	//hard
			{
				cmt_spawn_amount = 3.0;
			}

			else if (tier == 3)	//nightmare
			{
				cmt_spawn_amount = 3.0;
				cmt_health_multiplier = 2.0;
			}
			else	//normal
			{
				// Default
			}
			break;

		

		// Satans Dark Delight *e3m4*

			case "maps/e3m4.bsp":
			if (tier == 0)	//easy
			{
				cmt_spawn_amount = 1.0;
			}

			else if (tier == 2)	//hard
			{
				cmt_spawn_amount = 3.0;
			}

			else if (tier == 3)	//nightmare
			{
				cmt_spawn_amount = 3.0;
				cmt_health_multiplier = 2.0;
			}

			else	//normal
			{
				// Default
			}
			break;




		// The Wind Tunnels *e3m5*

		case "maps/e3m5.bsp":
			if (tier == 0)	//easy
			{
				cmt_spawn_amount = 1.0;
			}

			else if (tier == 2)	//hard
			{
				cmt_health_multiplier = 2.0;
			}

			else if (tier == 3)	//nightmare
			{
				cmt_spawn_amount = 3.0;
			}

			else	//normal
			{
				// Default
			}
			break;


		// The Chambers of tourment *e3m6*

		case "maps/e3m6.bsp":
			if (tier == 0)	//easy
			{
				cmt_spawn_amount = 1.0;
			}

			else if (tier == 2)	//hard
			{
				cmt_spawn_amount = 3.0;
			}

			else if (tier == 3)	//nightmare
			{
				cmt_spawn_amount = 3.0;
				cmt_health_multiplier = 2.0;
			}

			else	//normal
			{
				
				cmt_health_multiplier = 2.0;

			}
			break;



		// The Haunted Halls *e3m7* (Secret Level ep3)

			case "maps/e3m7.bsp":
			if (tier == 0)	//easy
			{
				cmt_spawn_amount = 1.0;
			}

			else if (tier == 2)	//hard
			{
				cmt_health_multiplier = 2.0;
			}

			else if (tier == 3)	//nightmare
			{
				
				cmt_spawn_amount = 3.0;
			}

			else	//normal
			{
				// Default
			}
			break;


//-----------------------------------------------------------

			// *Episode 4*


		// The Sewage System *e4m1*

			case "maps/e4m1.bsp":
			if (tier == 0)	//easy
			{
				cmt_spawn_amount = 1.0;
			}

			else if (tier == 2)	//hard
			{
				// Default
			}

			else if (tier == 3)	//nightmare
			{
				
				cmt_health_multiplier = 2.0;
			}

			else	//normal
			{
				cmt_spawn_amount = 1;
				cmt_health_multiplier = 2.0;
			}
			break;




		// The Tower of Despair *e4m2*		

			case "maps/e4m1.bsp":
			if (tier == 0)	//easy
			{
				cmt_spawn_amount = 1.0;
			}

			else if (tier == 2)	//hard
			{
				// Default
			}

			else if (tier == 3)	//nightmare
			{
				
				cmt_health_multiplier = 2.0;
			}

			else	//normal
			{
				cmt_spawn_amount = 1;
				cmt_health_multiplier = 2.0;
			}
			break;




		// The Elder God Shrine *e4m3*

		case "maps/e4m3.bsp":
			if (tier == 0)	//easy
			{
				cmt_spawn_amount = 1.0;
			}

			else if (tier == 2)	//hard
			{
				cmt_spawn_amount = 3.0;
			}

			else if (tier == 3)	//nightmare
			{
				cmt_spawn_amount = 3.0;
				cmt_health_multiplier = 2.0;
			}

			else	//normal
			{
				// Default
			}
			break;




		// The Palace of Hate *e4m4*

		case "maps/e4m4.bsp":
			if (tier == 0)	//easy
			{
				cmt_spawn_amount = 1.0;
			}

			else if (tier == 2)	//hard
			{
				cmt_spawn_amount = 3.0;
			}

			else if (tier == 3)	//nightmare
			{
				cmt_spawn_amount = 3.0;
				cmt_health_multiplier = 2.0;
			}

			else	//normal
			{
				// Default
			}
			break;



		// Hells Atrium *e4m5*

			case "maps/e4m5.bsp":
			if (tier == 0)	//easy
			{
				cmt_spawn_amount = 1.0;
			}

			else if (tier == 2)	//hard
			{
				cmt_spawn_amount = 3.0;
			}

			else if (tier == 3)	//nightmare
			{
				cmt_spawn_amount = 3.0;
				cmt_health_multiplier = 2.0;
			}
			else	//normal
			{
				// Default
			}
			break;


		// The Pain Maze *e4m6*

		case "maps/e4m6.bsp":
			if (tier == 0)	//easy
			{
				cmt_spawn_amount = 1.0;
			}

			else if (tier == 2)	//hard
			{
				cmt_spawn_amount = 3.0;
			}

			else if (tier == 3)	//nightmare
			{
				cmt_spawn_amount = 3.0;
				cmt_health_multiplier = 2.0;
			}

			else	//normal
			{
				// Default
			}
			break;



		// Azure Agony *e4m7*

		case "maps/e4m7.bsp":
			if (tier == 0)	//easy
			{
				cmt_spawn_amount = 1.0;
			}
			else if (tier == 2)	//hard
			{
				cmt_spawn_amount = 3.0;
				cmt_health_multiplier = 2.0;

			}

			else if (tier == 3)	//nightmare
			{
				
				cmt_spawn_amount = 4.0;
			}

			else	//normal
			{
				cmt_spawn_amount = 3;
			}
			break;


		// The Nameless City *e4m8* (Secret Level ep4)

			case "maps/e4m7.bsp":
			if (tier == 0)	//easy
			{
				cmt_spawn_amount = 1.0;
			}

			else if (tier == 2)	//hard
			{
				// Default
			}

			else if (tier == 3)	//nightmare
			{
				
				cmt_health_multiplier = 2.0;
			}

			else	//normal
			{
				cmt_spawn_amount = 1;
				cmt_health_multiplier = 2.0;
				
			}
			break;


		// Shubs Pit *end*

//nlz: are any extra's spawned? maybe just use HP increases

		case "maps/end.bsp":
			if (tier == 0)	//easy
			{
				cmt_spawn_amount = 1;
				cmt_health_multiplier = 1.2;
			}
			else if (tier == 2)	//hard
			{
				cmt_spawn_amount = 1;
				cmt_health_multiplier = 1.8;
			}

			else if (tier == 3)	//nightmare
			{
				cmt_spawn_amount = 1;
				cmt_health_multiplier = 2.2;
			}

			else	//normal
			{
				cmt_spawn_amount = 1;
				
			}
			break;

	// DM3 - *The Lost Rune*

case "maps/dm3.bsp":
			if (tier == 0)	//easy
			{
				cmt_spawn_amount = 1;
				cmt_health_multiplier = 1.3;
				
			}
			else if (tier == 2)	//hard
			{
				cmt_spawn_amount = 1;
				cmt_health_multiplier = 1.8;
			}

			else if (tier == 3)	//nightmare
			{
				cmt_spawn_amount = 1;
				cmt_health_multiplier = 2.25;
			}

			else	//normal
			{
				cmt_spawn_amount = 1;
				
			}
			break;

	}
};

//nlz: end of map blancing



//SET MODIFIED HEALTH
//Updates the monster health to include the bonus value.
//Bonus will be between 0 and % indicated. Example: 0.15 will add an extra random amount between 0 and 15% monster health.
//<!> I think this is only implemented for the soldier currently...
void(entity monster) CMT_SetHealth = 
{
	if (cmt_bonus_health > 0)
	{
		monster.health = monster.health + ((random() * cmt_bonus_health) * monster.health);
	}
};

