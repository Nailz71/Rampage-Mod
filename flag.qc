		// RAMPAGE Mod file. Last Updated 19 Sep 22

/*QUAKED item_deathball (.3 .3 1) (0 0 0) (32 32 32)
*/
void() deathball_touch;

void() item_deathball =
{	
	self.touch = deathball_touch;
};