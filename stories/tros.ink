﻿//https://github.com/inkle/ink/blob/master/Documentation/WritingWithInk.md

INCLUDE functions.ink
INCLUDE manuevers.ink

// Unit tests goes here  (comment away to avoid it)
INCLUDE unittests.ink
//->testing_fight_resolve_initiative
//-> ChooseManueverListAtk("massweapons", 5, 14, ORIENTATION_AGGRESSIVE,   6,7,4,5, 1, 0,    0,0, ->GameStart)
//=== ChooseManueverListDef(profeciencyType, profeciencyLevel, diceAvailable, orientation, lastAttacked, hasShield, enemyDiceRolled, enemyTargetZone, enemyManueverType, DTN, DTNt, DTN_off, DTNt_off ) 
//-> ChooseManueverListDef("massweapons", 5, 14, ORIENTATION_CAUTIOUS,  0,1   ,5,5, 0,    7,7,6,7 ,    0  )

-> GameStart

=== GameStart
// ACTUAL game flow starts here
// Combat!
Welcome to Riddle of Steel/Song of Swords RPG Combat simulator. Combat takes place across an indefinite series of Rounds, a short period of time represented roughly around 2 seconds per round. For each round, there are 2 Exchanges, representing the 1st and 2nd half of a given combat round! 
Let's fight!
-> Exchange

=== Exchange
	Start of {boutExchange!=2:new|2nd} exchange. {boutExchange!=2:You are up against  (TODO: party/enemy roster)}
	-> Combat_Step0 ->Combat_Step1 ->Combat_Step2 ->Combat_Step3 -> Combat_ResolveExchange -> Exchange


=== Combat_Step0
	~boutStep = 0
	~temp gotReveal = 0
	///* player
	{	charPersonName_FIGHT && charPersonName_fight_stance==STANCE_RESET && charPersonName_fight_paused:
		~gotReveal = 1
	}
	//*/
	///* utest
	{ charPersonName2_FIGHT && charPersonName2_fight_stance==STANCE_RESET && charPersonName2_fight_paused: 
		~gotReveal = 1
	}
	//*/
	{ gotReveal==0: 
		->->
	}

	//*/
	{
		- boutExchange == 1:
			{showCombatStatus()}
			-> Combat_Step0.DeclareStancesForAll(0)
	}
	->->
	= DeclareStancesForAll(repeated)
	//If it's the 1st exchange at the start of a round,  for all combatants that require, declare stance, in order from lowest to highest adriotness stat.

	// TODO: figure out a way to roll off ties (tiebreaking)
	///* utest perceptionCheck<playerPerceptionCheck
	{  -charPersonName2_FIGHT && charPersonName2_fight_stance==STANCE_RESET && charPersonName2_fight_paused: 
		~charPersonName2_fight_stance = getAIStance(charPersonName2_id)
		You noticed {charPersonName2_label} adopting a {getStanceLabel(charPersonName2_fight_stance)} martial stance.
	}
	//*/
	///* pc
	{  -charPersonName_FIGHT && charPersonName_fight_stance==STANCE_RESET && charPersonName_fight_paused: 
		-> DeclareStance(charPersonName_label, charPersonName_isYOU) 
	}
	//*/
	///* utest perceptionCheck>=playerPerceptionCheck
	{  -charPersonName2_FIGHT && charPersonName2_fight_stance==STANCE_RESET && charPersonName2_fight_paused: 
		~charPersonName2_fight_stance = getAIStance(charPersonName2_id)
		{charPersonName2_label} adopted {getStanceLabel(charPersonName2_fight_stance)} a martial stance.
	}
	->->
	//*/
	= DeclareStance(charLabel, isYou)
	What is the martial stance you wish to adopt and reveal to your enemies?
	+[Neutral ...(Balanced.)]
	~charPersonName_fight_stance = STANCE_NEUTRAL
	{isYou: You|{charLabel}} adopted a neutral stance.
	->DeclareStancesForAll(1)
	//->->
	+[Offensive ...(+2 roll for attack manuevers. -2 roll for defensive manuevers)]
	~charPersonName_fight_stance = STANCE_OFFENSIVE 
	{isYou: You|{charLabel}} adopted an offensive stance. 
	->DeclareStancesForAll(1)
	//->->
	+[Defensive ...(-2 roll for attack manuevers. +2 roll for defensive manuevers)] 
	~charPersonName_fight_stance = STANCE_DEFENSIVE
	{isYou: You|{charLabel}} adopted a defensive stance.
	->DeclareStancesForAll(1)
	//->->

	

=== Combat_Step1
	~boutStep = 1
	~temp gotReveal = 0
	///* player
	{	charPersonName_FIGHT && charPersonName_fight_orientation==ORIENTATION_NONE && charPersonName_fight_paused:
		~gotReveal = 1
	}
	//*/
	///* utest
	{ charPersonName2_FIGHT && charPersonName2_fight_orientation==ORIENTATION_NONE && charPersonName2_fight_paused: 
		~gotReveal = 1
	}
	//*/
	{ gotReveal==0: 
		->->
	}

	{
		- boutExchange == 1:
		-> Combat_Step1.ChooseOrientationForAll
	}
	->->
	= ChooseOrientationForAll
	{showCombatStatus()}
	//STEP 1:
	//If it's the 1st exchange at the start of a round, for all combatants that need to, secretly choose orientation before the next step.
	///* utest ai
	{ charPersonName2_FIGHT && charPersonName2_fight_paused && charPersonName2_fight_orientation == ORIENTATION_NONE: 
		~charPersonName2_fight_orientation = getAIOrientation(charPersonName_id, charPersonName_fight_stance) 
	}
	//*/
	// KIV: multi-player character support
	{ -charPersonName_FIGHT && charPersonName_fight_paused && charPersonName_fight_orientation == ORIENTATION_NONE: 
	What is your orientation intent you wish to secretly adopt?
	+[Cautious ...(Not sure if you wish to attack or defend until later on..)]
	~charPersonName_fight_orientation = ORIENTATION_CAUTIOUS
	You intend to be Cautious.
	->->
	+[Aggressive ...(Commit initiative to attack. Cannot defend at all for this exchange.)]
	~charPersonName_fight_orientation = ORIENTATION_AGGRESSIVE
	You intend to be Aggressive.
	->->
	+[Defensive ...(Cannot attack for this exchange, and can only defend. If you intend to flee, you must use this.)]
	~charPersonName_fight_orientation = ORIENTATION_DEFENSIVE
	You intend to be Defensive.
	->->
	}
	

=== Combat_Step2
	~boutStep = 2
	~temp gotReveal = 0

	// Preinspect
	//STEP 2:
	///* player
	{	charPersonName_FIGHT && charPersonName_fight_orientation!=ORIENTATION_NONE:
		~gotReveal = 1
	}
	{	charPersonName_FIGHT && charPersonName_fight_target == TARGET_NONE:
		~gotReveal = 1
	}
	//*/
	///* utest
	{ charPersonName2_FIGHT && charPersonName2_fight_orientation!=ORIENTATION_NONE: 
		~gotReveal = 1
	}
	{ charPersonName2_FIGHT && charPersonName2_fight_target==TARGET_NONE: 
		~gotReveal = 1
	}
	//*/


	{ gotReveal==0: 
		->->
	}

	{showCombatStatus()}
	//If it's the 1st exchange,  For all combatants that secretly chose orientation, reveal their orientations at the same time.
	{	charPersonName_FIGHT && charPersonName_fight_orientation!=ORIENTATION_NONE:
			You revealed your {getOrientationLabel( charPersonName_fight_orientation )} orientation.
	}
	///* utest
	{ charPersonName2_FIGHT && charPersonName2_fight_orientation!=ORIENTATION_NONE: 
		{charPersonName2_label} revealed an orientation intent of: {getOrientationLabel( charPersonName2_fight_orientation )}.
	}
	//*/

	->Combat_Step2.ChooseTargetForAll

	// kiv: If it's the 1st exchange, for all combatants that are able to (prompt them about it in order of highest mobility character to lowest), and wish to, secretly establish a specific L-mobility manuever. (and by house rules, have them secretly commit costs. Other house rule variations might simply involve having them to openly declare their specific L-mobility manuever immediately)

	= ChooseTargetForAll
	//For all combatants that need to, establish their primary target, in order of those that can  (and wish to) freely gain initiative over specific targets from their previous exchange of combat, and if it's the first exchange, also those from aggressive, cautious, and defensive orientations respectively. Initiatives fighting states are determined from here
	// GainedInitiative
	/* TODO: kiv when up against multiple opponents. Figure out a way to determine this
	{ charPersonName2_FIGHT && charPersonName2_fight_target == -1 && charPersonName2_fight_orientation==ORIENTATION_NONE: 
		{charPersonName2_label} chose a target.
	}
	*/
	// Aggressive
	///* utest reflex all
	{ charPersonName_FIGHT && charPersonName_fight_target == TARGET_NONE && charPersonName_fight_orientation==ORIENTATION_AGGRESSIVE: 
		->ChooseTargetForPlayer(charPersonName_id, charPersonName_fight_orientation, charPersonName_label, charPersonName_fight_side, charPersonName_isYOU)
	}
	{ charPersonName2_FIGHT && charPersonName2_fight_target == -1 && charPersonName2_fight_orientation==ORIENTATION_AGGRESSIVE: 
		->ChooseTargetForAI(charPersonName2_id, charPersonName2_fight_orientation, charPersonName2_label, charPersonName2_fight_side)
	}
	//*/
	// Cautious
	///* utest reflex all
	{ charPersonName_FIGHT && charPersonName_fight_target == TARGET_NONE && charPersonName_fight_orientation==ORIENTATION_CAUTIOUS: 
		->ChooseTargetForPlayer(charPersonName_id, charPersonName_fight_orientation, charPersonName_label, charPersonName_fight_side, charPersonName_isYOU)
	}
	{ charPersonName2_FIGHT && charPersonName2_fight_target == -1 && charPersonName2_fight_orientation==ORIENTATION_CAUTIOUS: 
		->ChooseTargetForAI(charPersonName2_id, charPersonName2_fight_orientation, charPersonName2_label, charPersonName2_fight_side)
	}
	//*/
	// Defensive
	///* utest reflex all
	{ charPersonName_FIGHT && charPersonName_fight_target == TARGET_NONE && charPersonName_fight_orientation==ORIENTATION_DEFENSIVE: 
		->ChooseTargetForPlayer(charPersonName_id, charPersonName_fight_orientation, charPersonName_label, charPersonName_fight_side, charPersonName_isYOU)
	}
	{ charPersonName2_FIGHT && charPersonName2_fight_target == -1 && charPersonName2_fight_orientation==ORIENTATION_DEFENSIVE: 
		->ChooseTargetForAI(charPersonName2_id, charPersonName2_fight_orientation, charPersonName2_label, charPersonName2_fight_side)
	}
	//*/
	->->

	= ChooseTargetForPlayer(charId, charOrientation, charLabel, charSide, isYou)
	~ temp lockingEngagement=0
	Choosing target for player character: {isYou: You|{charLabel}}
	///* player
	{ charPersonName_FIGHT && charPersonName_fight_side != charSide && charPersonName_isYOU!=1 : 
		+ [{charPersonName_label}]
		 ~lockingEngagement= pickTarget(charId, charOrientation, charPersonName_id, charPersonName_fight_target, charPersonName_fight_orientation)
			You {lockingEngagement:engaged|targetted} {charPersonName_label}{charOrientation==ORIENTATION_DEFENSIVE:{" defensively."}|.}
			->Combat_Step2.ChooseTargetForAll
	}
	//*/
	///* utest
	{ charPersonName2_FIGHT && charPersonName2_fight_side != charSide && charPersonName2_isYOU!=1 : 
		+ [{charPersonName2_label}] 
			 ~lockingEngagement= pickTarget(charId, charOrientation, charPersonName2_id, charPersonName2_fight_target, charPersonName2_fight_orientation)
			You {lockingEngagement:engaged|targetted} {charPersonName2_label}{charOrientation==ORIENTATION_DEFENSIVE:{" defensively."}|.}
			->Combat_Step2.ChooseTargetForAll
	}
	//*/

	= ChooseTargetForAI(charId, charOrientation, charLabel, charSide)
	~ temp lockingEngagement=0
	///* player
	{ charPersonName_FIGHT && charPersonName_fight_side != charSide: 
		 ~lockingEngagement= pickTarget(charId, charOrientation, charPersonName_id, charPersonName_fight_target, charPersonName_fight_orientation)
			{charLabel} {lockingEngagement:engaged|targetted} {getDescribeLabelOfChar(charPersonName_id)}{charOrientation==ORIENTATION_DEFENSIVE:{" defensively."}|.}
			->Combat_Step2.ChooseTargetForAll
	}
	//*/
	///* utest
	{ charPersonName2_FIGHT && charPersonName2_fight_side != charSide: 
			 ~lockingEngagement= pickTarget(charId, charOrientation, charPersonName2_id, charPersonName2_fight_target, charPersonName2_fight_orientation)
			{charLabel} {lockingEngagement:engaged|targetted} {getDescribeLabelOfChar(charPersonName_id)}{charOrientation==ORIENTATION_DEFENSIVE:{" defensively."}|.}
			->Combat_Step2.ChooseTargetForAll
	}
	//*/
	//->Combat_Step2.ChooseTargetForAll


=== Combat_Step3
	~boutStep = 3
	{showCombatStatus()}
	//STEP 3:
	//kiv: If it's the 1st exchange, reveal any hidden L-mobility manuevers and resolve all L-mobility manuevers in order from highest to lowest mobility stat, using commit costs. If a mobility manuever fails to execute due to circumstance during the resolution, may consider some form of refund scheme, or no refunding.
	
	{	// limit resolving of new initiatives to only 1st exchange
	-boutExchange == 1:
		-> Combat_Step3.ResolveInitiatives
	- else:
		{showPlayerInitiativeState()}
		-> DeclareCombatManuevers
	}
	= DeclareCombatManuevers
	// Declare/reveal combat manuevers (their costs and details) in order of combatants that have initiative, then those without initiative, in order of lowest to highest adriotness stat.
	//TODO: Declare moves...get lists of available moves, AI choose suitable move and CP, 
	Declaring moves...

	+ [Continue]
	->->

	= ResolveInitiatives
	~temp whoWins =0
	~temp roll
	~temp roll2
	///* player
	{  
	   -charPersonName_FIGHT && charPersonName_fight_target!=TARGET_NONE && charPersonName_fight_cautiousLock !=  RESOLVED_LOCKED:
	   {
		- charPersonName_fight_orientation == ORIENTATION_CAUTIOUS && getOrientationByCharId(charPersonName_fight_target) == ORIENTATION_CAUTIOUS:
			~roll = rollNumSuccesses(charPersonName_reflex,5,0)
			~roll2 = rollNumSuccesses(getReflexByCharId(charPersonName_fight_target),5,0)
			~whoWins = roll > roll2
			{ 
				-roll != roll2: 
					{ fight_resolve_initiative(charPersonName_id, charPersonName_fight_target, whoWins) }
					{ 
						- whoWins:
						You took the initaitive over your cautious opponent. 
						- else:
						The enemy took the initiative over your cautious presence.
					}
				-else:
					Both parties remain cautiously uncertain.
					{fight_cancelBothInitiatives(charPersonName_id, charPersonName_fight_target)}
			}
		- else:
			{ 
				-  charPersonName_fight_cautiousLock !=  RESOLVED_LOCKED: 
					{setOrientationInitiative(charPersonName_fight_initiative, charPersonName_fight_orientation, getOrientationByCharId(charPersonName_fight_target)) }
			}
		}
		//- else:
			//~charPersonName_fight_initiative = 0
		//	~charPersonName_fight_cautiousLock = 0
			//{charPersonName_FIGHT: You lost track of your moving target: {getNameOfChar(charPersonName_fight_target)}. }
	}	
	//*/
	///* utest
	{  
		-charPersonName2_FIGHT && charPersonName2_fight_target!=TARGET_NONE && charPersonName2_fight_cautiousLock !=  RESOLVED_LOCKED: 
		{
		- charPersonName2_fight_orientation == ORIENTATION_CAUTIOUS && getOrientationByCharId(charPersonName2_fight_target) == ORIENTATION_CAUTIOUS:
			~roll = rollNumSuccesses(charPersonName2_reflex,5,0)
			~roll2 = rollNumSuccesses(getReflexByCharId(charPersonName2_fight_target),5,0)
			~whoWins = roll > roll2
			{ -roll != roll2: 
				{fight_resolve_initiative(charPersonName2_id, charPersonName2_fight_target, whoWins)}
				-else:
					{fight_cancelBothInitiatives(charPersonName2_id, charPersonName2_fight_target)}
			 }
		- else:
			{ 
				-  charPersonName2_fight_cautiousLock !=  RESOLVED_LOCKED: 
					{setOrientationInitiative(charPersonName2_fight_initiative, charPersonName2_fight_orientation, getOrientationByCharId(charPersonName2_fight_target)) }
			}
		} 
		//- else:
		//	~charPersonName2_fight_initiative = 0
		//	~charPersonName2_fight_cautiousLock = 0
			//{charPersonName2_FIGHT: You lost track of your moving target: {getNameOfChar(charPersonName2_fight_target)}. }
	}
	//*/
	{showPlayerInitiativeState()}
	->Combat_Step3.DeclareCombatManuevers

=== Combat_ResolveExchange
	{showCombatStatus()}
	Resolution:
	Now, resolve all offensive combat maneuvers in order of those with initiative, then those without initiative, in order of highest to lowest adriotness stat.
	Establish new initiatives as a result of each exchange of combat manuevers
	Establish any new possible targets that a person can choose (later in the next exchange) to freely gain initiative over
	+ [{boutExchange==1: Proceed to 2nd Exchange|Proceed to Next Round}]
	// reset combat flags
	///* player
	~charPersonName_fight_stance = STANCE_NEUTRAL
	~charPersonName_fight_orientation = ORIENTATION_NONE
	~charPersonName_fight_cautiousLock = 0
	//*/
	///* utest
	~charPersonName2_fight_stance = STANCE_RESET
	~charPersonName2_fight_orientation = ORIENTATION_NONE
	~charPersonName2_fight_cautiousLock = 0
	//*/

	// proceed to next exchange
	~boutExchange++
	{ boutExchange >= 3:
		// proceed to next round
		~boutExchange=1
		~boutRounds++
	}
	->->


=== GameOver
-> END
