		// RAMPAGE Mod file. Last Updated 19 Sep 22
void() jctrig =
{
dprint ("here\n\n");
	lightstyle(0, "az");
};

/*QUAKED trigger_jctest (.5 .5 .5) ?
*/
void() trigger_jctest =
{
	setsize (self, self.mins, self.maxs);
	self.solid = SOLID_EDGE;
	self.touch = jctrig;
};
