//==========================================================================
//  cranked.qc -- by Patrick Martin             Last updated:  9-12-1997
//--------------------------------------------------------------------------
//  This file contains code that is used by other code I added to
//  other QuakeC monsters files.
//==========================================================================

//-------------------------------------------------------- New Code --------
//  A monster angry at a nearby zombie can destroy it outright.  This
//  is used by monsters who are normally incapable of destroying zombies
//  (such as knights, ogres, and fiends).  'chance' represents chance of
//  success and is expressed as a decimal.
//--------------------------------------------------------------------------
void(float chance) PM_GibZombie =
{
        local   vector  delta;

        if (self.enemy.classname != "monster_zombie")  return;

        chance = chance * 0.01;
        delta = self.enemy.origin - self.origin;
        if (vlen(delta) <= 60)
            if (random() < chance)
                T_Damage (self.enemy, self, self, self.enemy.health);
};

//-------------------------------------------------------- New Code --------
//  This returns the z-velocity added to a monster's grenade based on
//  the distance between attacker and target and on gravity.
//--------------------------------------------------------------------------
float(float dist) PM_GrenadeFly =
{
        local   float   g;      // Gravity -- g = 1 is Earth gravity.
        local   float   base;   // This dictates how fast the projectile
                                //   will fly up when it is launched.

//------------------------------------------------------//
//  800 is normal (Earth) gravity.  800 * 0.00125 = 1.  //
//------------------------------------------------------//
        g = (cvar("sv_gravity")) * 0.00125;   // Find gravity in terms of g.

        if (dist > 900)       base = 200+((dist - (200 - (dist * 0.2)))*0.5);
        else if (dist > 700)  base = 200+((dist - (200 - (dist * 0.15)))*0.5);
        else if (dist > 500)  base = 200+((dist - (200 - (dist * 0.1)))*0.5);
        else if (dist > 300)  base = 200+((dist - 200)*0.5);
        else if (dist > 200)  base = 200;
        else if (dist > 100)  base = dist;
        else                  base = 100;

        return (base * g);
};

//-------------------------------------------------------- New Code --------
//  This gives the monster a chance to come back to life.
//--------------------------------------------------------------------------
float() PM_SelfRevive =
{
        local   float   chance;

        if (skill < 1)  return FALSE;
        else if (skill < 2)  chance = 0.15;
        else if (skill < 3)  chance = 0.20; // 1 in 5 _sz
        else  chance = 0.5;

        return (random() < chance);
};

//--------------------------------------------------------------------------
//  END OF FILE.
//--------------------------------------------------------------------------
