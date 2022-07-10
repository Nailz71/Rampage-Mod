//==========================================================================
//  mindgas.qc -- by Patrick Martin             Last updated:  9-14-1997
//--------------------------------------------------------------------------
//  This file contains code that creates clouds of mind-altering gas.
//  Mind-altering gas may cause monsters to fight each other, and it
//  also causes players' vision to yaw and flip.
//==========================================================================

//-------------------------------------------------------- New Code --------
//  Returns FALSE if the entity is invulnerable to gas.  TRUE if not.
//--------------------------------------------------------------------------
float(entity head) PM_CanGas =
{
// An entity that is immune to damage is immune to gas as well.
        if (!head.takedamage)  return FALSE;

// The undead cannot be asphyxiated.
        if (head.classname == "monster_zombie")      return FALSE;
        if (head.classname == "monster_nightshade")  return FALSE;

// Support for cyberdemon patch -- this bad@$$ monster ignores gas.
        if (head.classname == "monster_cyberdemon")  return FALSE;

// Gas cannot penetrate the power of the pentagram.
        if (head.items & IT_INVULNERABILITY)  return FALSE;

// An entity that is wearing a bio-suit is fully protected against
// gas.  Otherwise, it is vulnerable to its effects.
        return !(head.items & IT_SUIT);
};

//-------------------------------------------------------- New Code --------
//  This disorients a player.  It also causes anyone with pain frames
//  to go in pain.
//--------------------------------------------------------------------------
void(entity victim) PM_AlterView =
{
	local	entity	oldself;

        if (!victim.takedamage)  return;

// Force a monster to turn up to 90 degrees to either side.
        if (victim.flags & FL_MONSTER)
        {       victim.angles_y = victim.angles_y + (random()*180 - 90);
                victim.fixangle = TRUE;
        }
// Warp the player's vision.
        victim.punchangle_y = random()*180 - 90;        // yaw
        victim.punchangle_z = random()*60 - 30;         // flip

// Feel the buzz!
	oldself = self;
        self = victim;
        if (self.th_pain)  self.th_pain (self, 5000);   // Feel it!
	self = oldself;
};

//-------------------------------------------------------- New Code --------
//  An affected monster changes targets.
//--------------------------------------------------------------------------
void(entity victim, entity attacker, entity newtarg) PM_ChangeTarget =
{
        local   entity  oldself;

// FIXME:  Don't change .enemy while looking for water.
        if (victim.enemy.classname == "watergoal")
        {       victim.oldenemy = newtarg;
                oldself = self;
                self = victim;
                PM_FoundSecondary ();   // victim found a new target
        }
        else
        {       victim.oldenemy = victim.enemy;
                victim.enemy = newtarg;
                oldself = self;
                self = victim;
                FoundTarget ();   // victim found a new target
        }

        self = attacker;
        //----------------------------------------------------//
        // If attacker is a monster, go idle or find player.  //
        //----------------------------------------------------//
        if (self.flags & FL_MONSTER)
            if (self.enemy.classname != "watergoal")
                if (self.enemy.classname != "player")
                {   self.enemy = world;
                    if (self.oldenemy.classname == "player")
                    {   if (self.oldenemy.health > 0)
                        {   self.enemy = self.oldenemy;
                            self.oldenemy = world;
                            HuntTarget ();
                        }
                        else
                        {   if (self.movetarget)
                                self.th_walk ();
                            else
                                self.th_stand ();
                        }
                    }
                }
        self = oldself;
};

//-------------------------------------------------------- New Code --------
//  This checks whether the monster is allowed to attack to target.
//--------------------------------------------------------------------------
float(entity head, entity victim, entity attacker) PM_CheckTarget =
{
// Victim will not attack targets that cannot be damaged.
        if (!head.takedamage)  return FALSE;

// Target must be a monster or player.
        if (!(head.flags & FL_MONSTER))
                if (head.classname != "player")
                        return FALSE;

// Victim cannot target itself.
        if (head == victim)  return FALSE;

// Most entities cannot touch (i.e., damage) the nightshade.
        if (head.classname == "monster_nightshade")  return FALSE;

// Do not target an ally of the attacker.
        

// If target is not blocked, it is valid.
        return (CanDamage (head, victim));
};

//-------------------------------------------------------- New Code --------
//  A monster (and only a monster) will select and attack any other
//  nearby monster (or player if the attacker is not a player) that
//  it can see.  Chthon and Shub-Niggurath do NOT count as monsters.
//--------------------------------------------------------------------------
void(entity victim, entity attacker) PM_FindNewTarget =
{
        local   entity  newtarg;
        local   entity  currtarg;

        if (victim.flags & FL_MONSTER)
        {
            newtarg = findradius(victim.origin, 1024);
            currtarg = world;

            while (newtarg)
            {
                if (PM_CheckTarget(newtarg, victim, attacker))
                {   if (newtarg != victim.enemy)
                    {   PM_ChangeTarget(victim, attacker, newtarg);
                            return;
                    }
                    currtarg = newtarg;
                }
                newtarg = newtarg.chain;
            }
            if (currtarg != world)
                PM_ChangeTarget(victim, attacker, currtarg);
        }
};

//-------------------------------------------------------- New Code --------
//  Everyone within the 'radius' that is vulnerable to gas is affected.
//--------------------------------------------------------------------------
void(entity inflictor, entity attacker, float radius)
PM_AlterMind =
{
     // Compile errors _sz   local   float   points, chance;
	local	entity	head;
        local   vector  org;

        org = inflictor.origin;
        head = findradius(org, radius);
	
	while (head)
        {       if (PM_CanGas(head))
        //---------------------------------------------------------------//
        // The following if-statement is an ugly hack, but it stops      //
        // a bug in which, for some strange reason, the radius in        //
        // PM_ChangeTarget() is used instead once a monster is affected. //
        //---------------------------------------------------------------//
                        if (vlen(head.origin - org) <= radius)
                        {       PM_AlterView(head);
                                if (head != attacker)
                                    if (head.state < IQ_GENIUS)
                                        PM_FindNewTarget (head, attacker);
                        }
                head = head.chain;
	}
};

//-------------------------------------------------------- New Code --------
//  The cloud has a constant radius, and the radius is the same as
//  that of a typical rocket explosion.  For every one-half of a
//  second, the mind gas takes effect.
//--------------------------------------------------------------------------
void() PM_MindGasThink =
{
        PM_AlterMind (self, self.owner, 160);
        self.cnt = self.cnt - 1;
        if (self.cnt <= 0)
                remove(self);
        else
        {       self.nextthink = time + 0.5;
                self.think = PM_MindGasThink;
        }
};

//-------------------------------------------------------- New Code --------
//  This creates a tarexplosion that represents the mind-gas cloud.
//  The cloud lasts about 1.5 seconds.
//--------------------------------------------------------------------------
void(vector spot, entity from) PM_SpawnMindGas =
{
        local entity cloud;

        WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
        WriteByte (MSG_BROADCAST, TE_TAREXPLOSION);
        WriteCoord (MSG_BROADCAST, spot_x);
        WriteCoord (MSG_BROADCAST, spot_y);
        WriteCoord (MSG_BROADCAST, spot_z);

        cloud = spawn();
        setmodel (cloud, "");   // invisible
        setsize (cloud, '0 0 0', '0 0 0');
        setorigin (cloud, spot);
        cloud.movetype  = MOVETYPE_NONE;
        cloud.solid     = SOLID_NOT;
        cloud.velocity  = '0 0 0';
        cloud.touch     = SUB_Null;
        cloud.owner     = from;
        cloud.cnt       = 3;    // loop counter
        cloud.nextthink = time + 0.1;
        cloud.think     = PM_MindGasThink;
};

//--------------------------------------------------------------------------
//  END OF FILE.
//--------------------------------------------------------------------------
