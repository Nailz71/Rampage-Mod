RAMPAGE coop Mod for 1-8 Players (Public Release V1.0)

Install Instructions:
Install the Mod in the usual way ie. type game mpmod (more detail at end of file). 

Play Instructions:
Start a Quake campaign coop game from the Start Map! (e1m1 is not the start map).

Recommended Difficulties:
Choose the EASY passage for 1-2 Players.

Choose the NORMAL passage for 2-4 Players.

Choose the HARD passage for 3-6 Players.

Choose the NIGHTMARE passage for 4-8 Players.

Alternatively Nightmare only can be activated (saved1 4) where all passages set Nightmare.

Play the game :)

You may want to check the cvars saved1 & saved2  are set to default '0'
see below how these can be used to activate various game options.

---------------------------------------------------------------------

Some of the Mods game play features:

AXE - If you have 5 cells or more the axe will do more damage (enough to gib a  zombie) and take 5 cells.

Armor - Each Armor will respawn for every player, a player may only collect each  
Armor once, Armor sets are limited to 8 players.

Friendly Fire - If on, any player that kills another player will Gib instantly.  

Quad Drop - If a player dies with an active Quad Powerup it will be dropped & can  
be used by ANOTHER player, the last player that dropped the quad cannot pick it up. 

Shotguns have a slight kick that can be used to jump a little higher, SSG jump can 
easily get you on top of crate for example.

Short Game option. see How to set Short Game options: saved2

Revised Shub Fight! Shub is kept under an energy shield by Wizard Scraggs
that shoot spells at her, killing the wizards on screen will release shub from
the spell & is then vulnerable to damage from weapons, be quick & shoot
before she rebirths more wizards.

Note: Some options such as more than 4 players in a coop game require quakepatches by Jpiolho
current version can be found here:

https://github.com/jpiolho/QuakePatches/releases/tag/version-1.12.0

----------------------------------------------------------

Technical explanation:

When any passage is chosen, the game skill is set to 2 (HARD) 

Note: In RAMPAGE Mod, SKILL is not the same as difficulty. SKILL should always be  set to 2 (HARD).

The Mod uses the spawn multiplied monsters used in Nightmare+ mod by JPiolho.

Depending on the Passage chosen a balanced & progressive (hopefully) set of  
difficulties is activated other than EASY which is 1x Monsters with 1.5x hp

For example, HARD Passage will have 2x Monsters for the first 2 maps of an episode,  then 3x Monsters for the rest of the episode, some maps will also have Monsters  with even higher HP.
The above varies depending on the particular map & episode.

----------------------------------------------------------

## How to set gamemodes: saved1

1. Open console and set the variable 'saved1' to the value you want.

2. The change will take effect on the next Map or on map restart.

## Optional Game modes:
You can activate multiple gamemodes by adding the values together. (eg: 1+2 = 3).

### 1: Extra Ammo:

   Players start ammo will be increased by 20%

### 2: Double Jump:

   Tap the jump button twice to Double Jump, reach new areas, avoid getting hit or  
jump over monsters / players.

### 4: Nightmare Only:

   Activates Nightmare Difficulty regardless of which passage is chosen.


### 8: No Early Exit: 

Players will not be able to leave map with an undisclosed number of enemies still alive! They will Gib on exit & be given a msg  about there being too many monsters alive to exit yet.


Before using Plague Mode below, NOTE: this changes the speed, BE SURE to change it back before playing a different game or hosting DM etc.
Type 'sv_maxspeed 320' into console or ideally put that line in your AUTOEXEC.cfg

### 16: Plague Mode: NOTE: this also changes the server setting:
sv_maxspeed to 250 (default 320).

   The Plague has gone through Ranger Town - Players start with reduced HP 75 &  
also reduced top speed 250 (320 is default) Jumps have been adjusted & are only
slightly more difficult, shotgun jumps can assist with any tricky jumps.

### 32: Disable Nametags:

Player Names will NOT be displayed while in sight of the crosshair.

### 1024: Respawn items - Only applies to single player:

   Items can respawn, even in singleplayer. This applies to health and ammo Note  
armor will not respawn.

-------------------------------------------------------------------------------

Options below are not recommended see comment for each (left in just in case)

### 64: Disperse Monsters:

   In RAMPAGE Mod Monsters are dispersed by default (512), this will disperse them  
a little less (384) for slight variation ..not fully tested. Probably doesn't make  
much diff from testing I have done

### 128: Don't respawn items: - Maybe an option for EASY, won't be enough ammo / health for harder difficulties:

   Items will not respawn, even in coop. This applies to health and ammo. Note  
armor will still be available for all players.

### 256: Don't carry items over - Joining players will need weapons:

   Cooperative: When players spawn, they will not be given weapons or items that  
have been found or carried over by other players.

### 512: Don't start with extra ammo - Likely to have major ammo shortages:

   The player will not be given extra ammo for nails, rockets and cells when  
spawning or starting a map.

-----------------------------------------------------------------------------

## How to set Short Game options: saved2

## Short Game options
You can activate multiple options by adding the values together. (eg: 1+2 = 3).

While on the START MAP open console and set the variable 'saved2' to the value you  
want.
Note. Only works on the START MAP

### 1: will give you the Rune for the first episode & close off that episode.

### 2: second episode

### 4: third episode

### 8: fourth episode

These can be combined ie 'saved2 15' will give you runes 1,2, 3 & 4, close those  
episodes & open the floor to Shub!

This can also be useful if you do experience game crashes :( 
at least you could restart with the Runes already collected.


**********************************************************
## Manual Episode Difficulties: saved4

saved4 0 = EASY

saved4 1 = NORMAL

saved4 2 = HARD

Saved4 3 = NIGHTMARE

These can be used to set the difficulty rather than go through the start passage  
portal.

Note: In RAMPAGE Mod, SKILL is not the same as difficulty. SKILL should always be set at 2 (HARD).

At times in coop a player may activate EASY even though the host wanted to play on  
HARD, the above can be used to manually override the chosen setting, will require a  
changelevel map restart unless changed on start map or change will kick in for  
following maps of that episode. A top left msg is displayed to show the selected  
difficulty at the start of each episode & shub

Have Fun :)

#Credits - Some coding is also from various Authors of  other Mods.

Nailz - RAMPAGE Mod Author

OSP - Code Specifically Written for RAMPAGE Mod, Thanks.

JPiolho - QENightmarePlus (2021)

Patrick Martin - Cranked Mod (1998)

Teamred - Double Jump


**********************************************************
Detailed Installation:

## How to install for singleplayer
1. Go to your 'Saved games' quake folder, or your steam quake/rerelease folder. You  
can get to your saved games folder by pressing Windows+R and typing: %userprofile% 
\Saved Games\Nightdive Studios\Quake
2. Create a folder called "rampage"
3. Extract zip into this folder

## How to install for multiplayer
1. Go to your 'Saved games' quake folder, NOT THE STEAM FOLDER. You can go to it by  
pressing Windows+R and typing: %userprofile%\Saved Games\Nightdive Studios\Quake
2. Create a folder called 'id1'
3. Create another folder and call it 'mpmod'. If you already have this folder, skip  
this step.
4. Extract zip into the 'id1' folder you created on step 2. If you already have an  
'id1' folder, it's likely from another mod. Unfortunately, you'll have to replace  
it.

## How to run the mod

### For multiplayer
1. Open console and type: `game mpmod`
2. Start a multiplayer game from the START map

### Technical explanation of how multiplayer works.
When you change to mpmod, it sets the root folder to be Saved Games, so next time  
the game goes into id1 it will use the files from Saved Games and override.


### For singleplayer
1. Open console and type: `game rampage`
2. Start a Quake campaign from the START map

NOTE: Single Player is not fully tested / balanced, taking the EASY passage is recommended as each map must be done with only 1 life.


END OF FILE.....

