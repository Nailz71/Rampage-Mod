//==========================================================================
//  combat2.qc -- by Patrick Martin             Last updated:  9-8-1997
//--------------------------------------------------------------------------
//  This file contains code that is used by the modified 'combat.qc'.
//==========================================================================

//-----------------//
//  NEW CONSTANTS  //
//-----------------//
// Intelligence levels used by my code.
float   IQ_LOW          = 1;    // Least intelligence, easily angered.
float   IQ_NORMAL       = 2;    // Normal Quake monster intelligence.
float   IQ_HIGH         = 3;    // Can dodge fairly well and find water.
float   IQ_GENIUS       = 4;    // Can dodge very well; hard to trick.
float   IQ_ULTIMATE     = 5;    // Genius plus can lead shots. 


//==========================================================================
//  AI.QC extras

//--------------------------------------------------------- New Code -------
//  This is similar to the function 'FoundTarget' except the monster
//  does not head straight for the opponent because it is heading for
//  a more urgent goal (i.e., water while burning).
//--------------------------------------------------------------------------
void() PM_FoundSecondary =
{
        if (self.oldenemy.classname == "player")
        {       // let other monsters see this monster for a while
                sight_entity = self;
                sight_entity_time = time;
        }
	
        self.show_hostile = time + 1;           // wake up other monsters

        SightSound ();

// watered down Hunt_Target.
        self.think = self.th_run;
        self.nextthink = time + 0.1;
        SUB_AttackFinished (1); // wait a while before first attack
};


//==========================================================================
//  COMBAT.QC extras

//-------------------------------------------------------- New Code --------
//  Returns TRUE is 'head' was not created by another entity.
//  Returns FALSE is it was created.  Created monsters should
//  *not* count as kills.
//--------------------------------------------------------------------------
float (entity head) PM_NotCreated =
{
// Zombies spawned by the nightshade should not count as kills.
        if (head.classname == "monster_zombie")
        {   if (head.owner.classname == "monster_nightshade")  return FALSE;
            if (head.owner == head)  return FALSE;
        }

// Monster was not created by another.
        return TRUE;
};

//-------------------------------------------------------- New Code --------
//  This determines whether like-kind monsters are stable.
//  FALSE is returned if:
//  1)  Monster attacked is a grunt.
//  2)  Attacker's enemy is the victim regardless of class.
//  3)  Monster is very stupid.
//--------------------------------------------------------------------------
float (entity victim, entity attacker) PM_Stable =
{
// Most monsters will attack any unlike monster who injured it.
// Only very smart monsters resist the urge to attack unlike
// monsters provided that the attack was an accident.
        if (victim.classname != attacker.classname)
                if (victim.state < IQ_GENIUS)
                        return FALSE;

// A grunt does not care who attacked it because he is insane :)
        if (victim.classname == "monster_army")  return FALSE;

// The monster will retaliate against deliberate attacks from anyone.
        if (victim == attacker.enemy)  return FALSE;

// Very stupid monsters will attack anything.
        if (victim.state == IQ_LOW)  return FALSE;

// The attack was an accident so don't turn on 'attacker'.
        return TRUE;
};

//-------------------------------------------------------- New Code --------
//  This determines whether the monster should get mad at its attacker.
//  FALSE is returned if:
//  1)  Attacker is itself.
//  2)  Attacker is already the monster's enemy.
//  3)  Attacker is already dead.
//  4)  Monster attacked is a nightshade.
//  5)  Attacker is a nightshade.
//  6)  Attacker is same class as monster and is neither insane nor stupid.
//
//  NOTE:  A monster who is looking for water because it is burning
//         will remember its attacker if none of the above checks
//         hold and attack it as soon as the fire is out.
//--------------------------------------------------------------------------
float (entity victim, entity attacker) PM_GetMad =
{
// Monster cannot attack itself.  (And why would it?)
        if (victim == attacker)  return FALSE;

// The attacker is already the monster's enemy so do nothing.
        if (victim.enemy == attacker)  return FALSE;

// The attacker is already dead so do nothing.
        if (attacker.health <= 0)  return FALSE;

// The nightshade cannot be distracted.
        if (victim.classname == "monster_nightshade")  return FALSE;

// Most monsters cannot even touch the nightshade so ignore it.
        if (attacker.classname == "monster_nightshade")  return FALSE;

// A monster may or may not ignore 'friendly-fire'.
        if (attacker.classname != "player")
                if (PM_Stable(victim, attacker))
                        return FALSE;

// A burning monster is not interested in combat for now,
// but it will remember the attacker and attack it later.
        if (victim.goalentity.classname == "watergoal")
                return (victim.oldenemy != attacker);

// Turn on attacker now.
        return TRUE;
};

//--------------------------------------------------------------------------
//  END OF FILE.
//--------------------------------------------------------------------------
