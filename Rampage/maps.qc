		// RAMPAGE Mod file. Last Updated 11 Dec 22
string(string title) GetMapName =
{
    if(mapname == "base32b" && title == "Base 32") {
        return "Base 32 (RAMPAGE)";
    } else if(mapname == "death32c" && title == "Death 32") {
        return "Death 32 (RAMPAGE)";
    } else if(mapname == "dm1" && title == "Place of Two Deaths") {
        return "Place of Two Deaths (RAMPAGE)";
    } else if(mapname == "dm2" && title == "Claustrophobopolis") {
        return "Claustrophobopolis (RAMPAGE)";
    } else if(mapname == "dm3" && title == "The Abandoned Base") {
        return "The Abandoned Base (RAMPAGE)";

//nlz: for DM3 The Lost Rune

 } else if(mapname == "dm3" && title == "The Lost Rune") {
        return "The Lost Rune (RAMPAGE)";

    } else if(mapname == "dm4" && title == "The Bad Place") {
        return "The Bad Place (RAMPAGE)";
    } else if(mapname == "dm5" && title == "The Cistern") {
        return "The Cistern (RAMPAGE)";
    } else if(mapname == "dm6" && title == "The Dark Zone") {
        return "The Dark Zone (RAMPAGE)";
    } else if(mapname == "dm7" && title == "The Edge") {
        return "The Edge (RAMPAGE)";
    } else if(mapname == "dm8" && title == "Acrophobia") {
        return "Acrophobia (RAMPAGE)";
    } else if(mapname == "e1m1" && title == "The Slipgate Complex") {
        return "The Slipgate Complex (RAMPAGE)";
    } else if(mapname == "e1m2" && title == "Castle of the Damned") {
        return "Castle of the Damned (RAMPAGE)";
    } else if(mapname == "e1m3" && title == "The Necropolis") {
        return "The Necropolis (RAMPAGE)";
    } else if(mapname == "e1m4" && title == "The Grisly Grotto") {
        return "The Grisly Grotto (RAMPAGE)";
    } else if(mapname == "e1m5" && title == "Gloom Keep") {
        return "Gloom Keep (RAMPAGE)";
    } else if(mapname == "e1m6" && title == "The Door To Chthon") {
        return "The Door To Chthon (RAMPAGE)";
    } else if(mapname == "e1m7" && title == "The House of Chthon") {
        return "The House of Chthon (RAMPAGE)";
    } else if(mapname == "e1m8" && title == "Ziggurat Vertigo") {
        return "Ziggurat Vertigo (RAMPAGE)";
    } else if(mapname == "e2m1" && title == "The Installation") {
        return "The Installation (RAMPAGE)";
    } else if(mapname == "e2m2" && title == "The Ogre Citadel") {
        return "The Ogre Citadel (RAMPAGE)";
    } else if(mapname == "e2m3" && title == "The Crypt of Decay") {
        return "The Crypt of Decay (RAMPAGE)";
    } else if(mapname == "e2m4" && title == "The Ebon Fortress") {
        return "The Ebon Fortress (RAMPAGE)";
    } else if(mapname == "e2m5" && title == "The Wizard's Manse") {
        return "The Wizard's Manse (RAMPAGE)";
    } else if(mapname == "e2m6" && title == "The Dismal Oubliette") {
        return "The Dismal Oubliette (RAMPAGE)";
    } else if(mapname == "e2m7" && title == "The Underearth") {
        return "The Underearth (RAMPAGE)";
    } else if(mapname == "e3m1" && title == "Termination Central") {
        return "Termination Central (RAMPAGE)";
    } else if(mapname == "e3m2" && title == "The Vaults of Zin") {
        return "The Vaults of Zin (RAMPAGE)";
    } else if(mapname == "e3m3" && title == "the Tomb of Terror") {
        return "The Tomb of Terror (RAMPAGE)";
    } else if(mapname == "e3m4" && title == "Satan's Dark Delight") {
        return "Satan's Dark Delight (RAMPAGE)";
    } else if(mapname == "e3m5" && title == "the Wind Tunnels") {
        return "The Wind Tunnels (RAMPAGE)";
    } else if(mapname == "e3m6" && title == "Chambers of Torment") {
        return "Chambers of Torment (RAMPAGE)";
    } else if(mapname == "e3m7" && title == "the Haunted Halls") {
        return "The Haunted Halls (RAMPAGE)";
    } else if(mapname == "e4m1" && title == "the Sewage System") {
        return "The Sewage System (RAMPAGE)";
    } else if(mapname == "e4m2" && title == "The Tower of Despair") {
        return "The Tower of Despair (RAMPAGE)";
    } else if(mapname == "e4m3" && title == "The Elder God Shrine") {
        return "The Elder God Shrine (RAMPAGE)";
    } else if(mapname == "e4m4" && title == "The Palace of Hate") {
        return "The Palace of Hate (RAMPAGE)";
    } else if(mapname == "e4m5" && title == "Hell's Atrium") {
        return "Hell's Atrium (RAMPAGE)";
    } else if(mapname == "e4m6" && title == "The Pain Maze") {
        return "The Pain Maze (RAMPAGE)";
    } else if(mapname == "e4m7" && title == "Azure Agony") {
        return "Azure Agony (RAMPAGE)";
    } else if(mapname == "e4m8" && title == "The Nameless City") {
        return "The Nameless City (RAMPAGE)";
    } else if(mapname == "end" && title == "Shub-Niggurath's Pit") {
        return "Shub-Niggurath's Pit (RAMPAGE)";

//nlz: for shubs lair

 } else if(mapname == "end" && title == "Shub-Niggurath's Lair") {
        return "Shub-Niggurath's Lair (RAMPAGE)";

    } else if(mapname == "start" && title == "Introduction") {
        return "Introduction (RAMPAGE)";
    }
	
	// Default
	return title;
}
