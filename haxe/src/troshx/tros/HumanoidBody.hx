package troshx.tros;
import troshx.BodyChar;
import troshx.ZoneBody;

/**
 * Humanoid Body definition for The Riddle of Steel
 * @author Glenn Ko
 */
@:expose
class HumanoidBody extends BodyChar
{
	public static inline var ZONE_I:Int = 1;
	public static inline var ZONE_II:Int = 2;
	public static inline var ZONE_III:Int = 3;
	public static inline var ZONE_IV:Int = 4;
	public static inline var ZONE_V:Int = 5;
	public static inline var ZONE_VI:Int = 6;
	public static inline var ZONE_VII:Int = 7;
	public static inline var ZONE_VIII:Int = 8;
	public static inline var ZONE_IX:Int = 9;
	public static inline var ZONE_X:Int = 10;
	public static inline var ZONE_XI:Int = 11;
	public static inline var ZONE_XII:Int = 12;
	public static inline var ZONE_XIII:Int = 13;
	public static inline var ZONE_XIV:Int = 14;

	public static var CENTER_OF_MASS:Array<Int> = [ZONE_III, ZONE_II, ZONE_V, ZONE_VI];
	public static var CENTER_OF_MASS_T:Array<Int> = [ZONE_X, ZONE_XI, ZONE_XI, ZONE_XII];
	
	private static var INSTANCE:HumanoidBody;
	public static function getInstance():HumanoidBody {
	    return INSTANCE != null ? INSTANCE : (INSTANCE = new HumanoidBody());
	}
	
	public function new() 
	{
		super();
		
		// http://knight.burrowowl.net/doku.php?id=rules:master_damage_table
		// riddle/damagetables.html
		// d is for destruction level.   1, destroy part.  2,  character dies
	///*
		partsBludgeon = {"foot":[{"BL":0,"shock":4,"shockWP":1,"pain":4,"painWP":1},{"BL":0,"shock":3,"shockWP":0,"pain":5,"painWP":1},{"KD":3,"BL":0,"shock":4,"shockWP":0,"pain":6,"painWP":1},{"KD":1,"BL":0,"shock":6,"shockWP":0,"pain":8,"painWP":1},{"KD":-1,"BL":1,"shock":9,"shockWP":0,"pain":10,"painWP":1}],"shin_and_lower_leg":[{"BL":0,"shock":4,"shockWP":0,"pain":5,"painWP":1},{"KD":2,"BL":0,"shock":5,"shockWP":0,"pain":6,"painWP":1},{"BL":0,"shock":6,"shockWP":0,"pain":7,"painWP":1},{"KD":-3,"BL":2,"shock":8,"shockWP":0,"pain":9,"painWP":1},{"KD":-1,"BL":5,"shock":10,"shockWP":0,"pain":12,"painWP":1}],"knee_and_nearby_areas":[{"BL":0,"shock":5,"shockWP":1,"pain":4,"painWP":1},{"BL":0,"shock":4,"shockWP":0,"pain":5,"painWP":1},{"KD":0,"BL":2,"shock":8,"shockWP":0,"pain":8,"painWP":1},{"KD":-5,"BL":6,"shock":10,"shockWP":0,"pain":0,"painWP":0},{"KD":-1,"BL":8,"shock":15,"shockWP":0,"pain":12,"painWP":1}],"thigh":[{"BL":0,"shock":4,"shockWP":1,"pain":4,"painWP":1},{"KD":2,"BL":0,"shock":5,"shockWP":0,"pain":4,"painWP":1},{"KD":0,"BL":0,"shock":7,"shockWP":0,"pain":7,"painWP":1},{"KD":-4,"BL":3,"shock":8,"shockWP":0,"pain":9,"painWP":1},{"KD":-1,"BL":7,"shock":10,"shockWP":0,"pain":12,"painWP":1}],"inner_thigh":[{"BL":0,"shock":4,"shockWP":1,"pain":4,"painWP":1},{"KD":2,"BL":0,"shock":5,"shockWP":0,"pain":4,"painWP":1},{"KD":0,"BL":0,"shock":7,"shockWP":0,"pain":7,"painWP":1},{"KD":-4,"BL":3,"shock":8,"shockWP":0,"pain":9,"painWP":1},{"KD":-1,"BL":7,"shock":10,"shockWP":0,"pain":12,"painWP":1}],"hip":[{"BL":0,"shock":3,"shockWP":0,"pain":4,"painWP":1},{"BL":0,"shock":5,"shockWP":0,"pain":6,"painWP":1},{"KD":-1,"BL":2,"shock":8,"shockWP":0,"pain":10,"painWP":1},{"BL":10,"shock":10,"shockWP":0,"pain":12,"painWP":1},{"BL":20,"shock":-1,"shockWP":0,"pain":13,"painWP":1,"d":1}],"groin":[{"BL":0,"shock":7,"shockWP":0,"pain":9,"painWP":1},{"ko":0,"BL":0,"shock":9,"shockWP":0,"pain":10,"painWP":1},{"ko":-2,"BL":3,"shock":11,"shockWP":0,"pain":15,"painWP":1},{"ko":-1,"BL":18,"shock":-1,"shockWP":0,"pain":-1,"painWP":0},{"BL":20,"shock":-1,"shockWP":0,"pain":-1,"painWP":0,"d":2}],"abdomen":[{"BL":0,"shock":3,"shockWP":0,"pain":5,"painWP":1},{"ko":3,"BL":0,"shock":7,"shockWP":0,"pain":6,"painWP":1},{"ko":0,"BL":3,"shock":10,"shockWP":0,"pain":8,"painWP":1},{"BL":8,"shock":10,"shockWP":0,"pain":12,"painWP":1},{"ko":-3,"BL":15,"shock":-1,"shockWP":0,"pain":15,"painWP":1}],"ribcage":[{"BL":0,"shock":5,"shockWP":1,"pain":4,"painWP":1},{"BL":0,"shock":4,"shockWP":0,"pain":5,"painWP":1},{"ko":2,"BL":1,"shock":8,"shockWP":0,"pain":6,"painWP":1},{"ko":0,"BL":3,"shock":10,"shockWP":0,"pain":9,"painWP":1},{"ko":-3,"BL":9,"shock":-1,"shockWP":0,"pain":15,"painWP":1}],"upper_abdomen":[{"BL":0,"shock":3,"shockWP":0,"pain":5,"painWP":1},{"ko":3,"BL":0,"shock":7,"shockWP":0,"pain":6,"painWP":1},{"ko":0,"BL":3,"shock":10,"shockWP":0,"pain":8,"painWP":1},{"BL":8,"shock":10,"shockWP":0,"pain":12,"painWP":1},{"ko":-3,"BL":15,"shock":-1,"shockWP":0,"pain":15,"painWP":1}],"chest":[{"BL":0,"shock":5,"shockWP":1,"pain":4,"painWP":1},{"BL":0,"shock":4,"shockWP":0,"pain":5,"painWP":1},{"ko":2,"BL":1,"shock":8,"shockWP":0,"pain":6,"painWP":1},{"ko":0,"BL":3,"shock":10,"shockWP":0,"pain":9,"painWP":1},{"ko":0,"BL":9,"shock":-1,"shockWP":0,"pain":15,"painWP":1}],"upper_body":[{"BL":0,"shock":5,"shockWP":1,"pain":4,"painWP":1},{"BL":0,"shock":4,"shockWP":0,"pain":5,"painWP":1},{"ko":2,"BL":1,"shock":8,"shockWP":0,"pain":6,"painWP":1},{"ko":0,"BL":3,"shock":10,"shockWP":0,"pain":9,"painWP":1},{"ko":-3,"BL":9,"shock":-1,"shockWP":0,"pain":15,"painWP":1}],"neck":[{"BL":0,"shock":4,"shockWP":0,"pain":5,"painWP":1},{"BL":1,"shock":7,"shockWP":0,"pain":9,"painWP":1},{"ko":0,"BL":3,"shock":10,"shockWP":0,"pain":12,"painWP":1},{"BL":3,"shock":-1,"shockWP":0,"pain":15,"painWP":1},{"shock":0,"shockWP":0,"pain":0,"painWP":0}],"face":[{"ko":3,"BL":0,"shock":5,"shockWP":1,"pain":0,"painWP":0},{"ko":1,"BL":1,"shock":8,"shockWP":0,"pain":6,"painWP":1},{"BL":4,"shock":10,"shockWP":0,"pain":0,"painWP":0},{"ko":-3,"BL":6,"shock":12,"shockWP":0,"pain":9,"painWP":1},{"d":2,"shock":0,"shockWP":0,"pain":0,"painWP":0}],"lower_head":[{"ko":3,"BL":0,"shock":5,"shockWP":1,"pain":0,"painWP":0},{"ko":1,"BL":1,"shock":8,"shockWP":0,"pain":6,"painWP":1},{"BL":4,"shock":10,"shockWP":0,"pain":0,"painWP":0},{"ko":-3,"BL":6,"shock":12,"shockWP":0,"pain":9,"painWP":1},{"d":2,"shock":0,"shockWP":0,"pain":0,"painWP":0}],"upper_head":[{"ko":2,"BL":0,"shock":8,"shockWP":1,"pain":5,"painWP":1},{"ko":0,"BL":3,"shock":8,"shockWP":0,"pain":8,"painWP":1},{"ko":-3,"BL":4,"shock":10,"shockWP":0,"pain":12,"painWP":1},{"BL":6,"shock":-1,"shockWP":0,"pain":-1,"painWP":0},{"d":2,"shock":0,"shockWP":0,"pain":0,"painWP":0}],"upper_arm_and_shoulder":[{"BL":0,"shock":5,"shockWP":1,"pain":4,"painWP":1},{"BL":0,"shock":5,"shockWP":0,"pain":5,"painWP":1},{"BL":1,"shock":7,"shockWP":0,"pain":8,"painWP":1},{"BL":5,"shock":10,"shockWP":0,"pain":9,"painWP":1},{"BL":10,"shock":13,"shockWP":0,"pain":12,"painWP":1}],"hand":[{"BL":0,"shock":4,"shockWP":1,"pain":0,"painWP":0},{"BL":0,"shock":3,"shockWP":0,"pain":4,"painWP":1},{"BL":0,"shock":7,"shockWP":1,"pain":5,"painWP":1},{"BL":1,"shock":7,"shockWP":0,"pain":8,"painWP":1},{"BL":3,"shock":9,"shockWP":0,"pain":9,"painWP":1}],"forearm":[{"BL":0,"shock":4,"shockWP":1,"pain":0,"painWP":0},{"BL":0,"shock":3,"shockWP":0,"pain":4,"painWP":1},{"BL":1,"shock":5,"shockWP":0,"pain":6,"painWP":1},{"BL":2,"shock":8,"shockWP":0,"pain":8,"painWP":1},{"BL":3,"shock":10,"shockWP":0,"pain":10,"painWP":1}],"elbow":[{"BL":0,"shock":5,"shockWP":1,"pain":4,"painWP":1},{"BL":0,"shock":5,"shockWP":0,"pain":4,"painWP":1},{"BL":0,"shock":5,"shockWP":0,"pain":6,"painWP":1},{"BL":1,"shock":8,"shockWP":0,"pain":7,"painWP":1},{"BL":3,"shock":9,"shockWP":0,"pain":10,"painWP":0}]};

		partsCut ={"foot":[{"BL":0,"shock":3,"shockWP":1,"pain":2,"painWP":1},{"BL":1,"shock":3,"shockWP":0,"pain":3,"painWP":1},{"KD":3,"BL":2,"shock":4,"shockWP":0,"pain":5,"painWP":1},{"KD":1,"BL":5,"shock":6,"shockWP":0,"pain":6,"painWP":1},{"KD":0,"BL":10,"shock":9,"shockWP":0,"pain":8,"painWP":1}],"shin_and_lower_leg":[{"BL":0,"shock":3,"shockWP":0,"pain":2,"painWP":1},{"KD":2,"BL":2,"shock":5,"shockWP":0,"pain":6,"painWP":1},{"BL":4,"shock":5,"shockWP":0,"pain":6,"painWP":1},{"KD":-2,"BL":8,"shock":7,"shockWP":0,"pain":8,"painWP":1},{"KD":0,"BL":13,"shock":9,"shockWP":0,"pain":10,"painWP":1}],"knee_and_nearby_areas":[{"BL":0,"shock":5,"shockWP":1,"pain":3,"painWP":1},{"BL":2,"shock":5,"shockWP":0,"pain":5,"painWP":1},{"KD":0,"BL":4,"shock":8,"shockWP":0,"pain":8,"painWP":1},{"KD":-5,"BL":8,"shock":10,"shockWP":0,"pain":13,"painWP":1},{"KD":0,"BL":13,"shock":12,"shockWP":0,"pain":12,"painWP":1}],"thigh":[{"BL":1,"shock":4,"shockWP":1,"pain":3,"painWP":1},{"KD":2,"BL":2,"shock":2,"shockWP":0,"pain":4,"painWP":1},{"KD":2,"BL":4,"shock":5,"shockWP":0,"pain":4,"painWP":1},{"KD":2,"BL":4,"shock":5,"shockWP":0,"pain":4,"painWP":1},{"KD":2,"BL":4,"shock":5,"shockWP":0,"pain":4,"painWP":1}],"inner_thigh":[{"BL":0,"shock":4,"shockWP":1,"pain":4,"painWP":1},{"BL":6,"shock":3,"shockWP":0,"pain":5,"painWP":1},{"KD":0,"BL":9,"shock":5,"shockWP":0,"pain":16,"painWP":1},{"BL":12,"shock":7,"shockWP":0,"pain":8,"painWP":1},{"BL":17,"shock":7,"shockWP":0,"pain":10,"painWP":1,"d":2}],"groin":[{"BL":6,"shock":9,"shockWP":0,"pain":9,"painWP":1},{"BL":9,"shock":9,"shockWP":0,"pain":10,"painWP":1},{"BL":12,"shock":10,"shockWP":0,"pain":12,"painWP":1,"d":1},{"BL":18,"shock":-1,"shockWP":0,"pain":-1,"painWP":0},{"BL":20,"shock":-1,"shockWP":0,"pain":-1,"painWP":0,"d":2}],"hip":[{"BL":0,"shock":4,"shockWP":1,"pain":3,"painWP":1},{"BL":2,"shock":3,"shockWP":0,"pain":5,"painWP":1},{"KD":0,"BL":4,"shock":5,"shockWP":0,"pain":7,"painWP":1},{"KD":-2,"BL":8,"shock":8,"shockWP":0,"pain":10,"painWP":1},{"KD":-1,"BL":12,"shock":10,"shockWP":0,"pain":12,"painWP":1}],"abdomen":[{"BL":1,"shock":2,"shockWP":0,"pain":5,"painWP":1},{"BL":3,"shock":4,"shockWP":0,"pain":6,"painWP":1},{"BL":7,"shock":8,"shockWP":0,"pain":10,"painWP":1},{"BL":10,"shock":10,"shockWP":0,"pain":12,"painWP":1},{"BL":20,"shock":-1,"shockWP":0,"pain":-1,"painWP":0}],"ribcage":[{"BL":0,"shock":2,"shockWP":0,"pain":4,"painWP":1},{"BL":2,"shock":4,"shockWP":0,"pain":5,"painWP":1},{"KD":0,"BL":3,"shock":8,"shockWP":0,"pain":7,"painWP":1},{"BL":9,"shock":10,"shockWP":0,"pain":12,"painWP":1},{"BL":20,"shock":0,"shockWP":0,"pain":0,"painWP":0,"d":2}],"chest":[{"BL":0,"shock":2,"shockWP":0,"pain":4,"painWP":1},{"BL":2,"shock":4,"shockWP":0,"pain":5,"painWP":1},{"KD":0,"BL":3,"shock":8,"shockWP":0,"pain":7,"painWP":1},{"BL":9,"shock":10,"shockWP":0,"pain":12,"painWP":1},{"BL":20,"shock":0,"shockWP":0,"pain":0,"painWP":0,"d":2}],"upper_arm_and_shoulder":[{"BL":0,"shock":4,"shockWP":1,"pain":4,"painWP":1},{"BL":2,"shock":4,"shockWP":0,"pain":5,"painWP":1},{"BL":4,"shock":5,"shockWP":0,"pain":8,"painWP":1},{"BL":8,"shock":8,"shockWP":0,"pain":10,"painWP":1},{"BL":12,"shock":13,"shockWP":0,"pain":14,"painWP":1}],"shoulder":[{"BL":1,"shock":4,"shockWP":1,"pain":4,"painWP":1},{"BL":2,"shock":4,"shockWP":0,"pain":5,"painWP":1},{"BL":5,"shock":6,"shockWP":0,"pain":7,"painWP":1},{"BL":10,"shock":8,"shockWP":0,"pain":10,"painWP":1},{"BL":25,"shock":10,"shockWP":0,"pain":11,"painWP":1}],"neck":[{"BL":1,"shock":4,"shockWP":0,"pain":5,"painWP":1},{"BL":4,"shock":7,"shockWP":0,"pain":10,"painWP":1},{"BL":9,"shock":10,"shockWP":0,"pain":11,"painWP":1},{"BL":20,"shock":13,"shockWP":0,"pain":14,"painWP":1},{"d":2,"shock":0,"shockWP":0,"pain":0,"painWP":0}],"face":[{"BL":0,"shock":5,"shockWP":1,"pain":0,"painWP":0},{"BL":2,"shock":8,"shockWP":0,"pain":5,"painWP":1},{"BL":5,"shock":1,"shockWP":1,"pain":7,"painWP":1},{"BL":7,"shock":10,"shockWP":0,"pain":10,"painWP":1},{"d":2,"shock":0,"shockWP":0,"pain":0,"painWP":0}],"lower_head":[{"BL":0,"shock":5,"shockWP":1,"pain":0,"painWP":0},{"BL":2,"shock":8,"shockWP":0,"pain":5,"painWP":1},{"BL":5,"shock":1,"shockWP":1,"pain":7,"painWP":1},{"BL":7,"shock":10,"shockWP":0,"pain":10,"painWP":1},{"d":2,"shock":0,"shockWP":0,"pain":0,"painWP":0}],"upper_head":[{"BL":3,"shock":3,"shockWP":0,"pain":4,"painWP":1},{"BL":3,"shock":7,"shockWP":0,"pain":8,"painWP":1},{"BL":4,"shock":10,"shockWP":0,"pain":12,"painWP":1},{"ko":0,"BL":10,"shock":-1,"shockWP":0,"pain":-1,"painWP":0},{"d":2,"shock":0,"shockWP":0,"pain":0,"painWP":0}],"hand":[{"BL":0,"shock":7,"shockWP":1,"pain":4,"painWP":1},{"BL":2,"shock":0,"shockWP":0,"pain":4,"painWP":1},{"BL":6,"shock":9,"shockWP":1,"pain":6,"painWP":1},{"BL":8,"shock":8,"shockWP":0,"pain":9,"painWP":1},{"BL":10,"shock":10,"shockWP":0,"pain":11,"painWP":1,"d":1}],"forearm":[{"BL":0,"shock":4,"shockWP":1,"pain":4,"painWP":1},{"BL":3,"shock":5,"shockWP":0,"pain":7,"painWP":1},{"BL":4,"shock":5,"shockWP":0,"pain":7,"painWP":1},{"BL":6,"shock":8,"shockWP":0,"pain":8,"painWP":1},{"BL":12,"shock":10,"shockWP":0,"pain":12,"painWP":1,"d":1}],"elbow":[{"BL":0,"shock":5,"shockWP":1,"pain":4,"painWP":1},{"BL":0,"shock":4,"shockWP":0,"pain":5,"painWP":1},{"BL":3,"shock":6,"shockWP":0,"pain":6,"painWP":1},{"BL":6,"shock":8,"shockWP":0,"pain":9,"painWP":1},{"BL":12,"shock":10,"shockWP":0,"pain":10,"painWP":1}]};
		
		
		partsPuncture = {"foot":[{"BL":0,"shock":4,"shockWP":1,"pain":4,"painWP":1},{"BL":0,"shock":3,"shockWP":0,"pain":5,"painWP":1},{"KD":3,"BL":2,"shock":4,"shockWP":0,"pain":6,"painWP":1},{"KD":-1,"BL":3,"shock":7,"shockWP":0,"pain":7,"painWP":1},{"KD":-1,"BL":3,"shock":7,"shockWP":0,"pain":7,"painWP":1}],"shin_and_lower_leg":[{"BL":0,"shock":4,"shockWP":0,"pain":4,"painWP":1},{"KD":2,"BL":1,"shock":5,"shockWP":0,"pain":6,"painWP":1},{"BL":2,"shock":5,"shockWP":0,"pain":6,"painWP":1},{"KD":-2,"BL":2,"shock":5,"shockWP":0,"pain":6,"painWP":1},{"KD":0,"BL":4,"shock":7,"shockWP":0,"pain":8,"painWP":1}],"knee_and_nearby_areas":[{"BL":0,"shock":5,"shockWP":1,"pain":5,"painWP":1},{"BL":0,"shock":4,"shockWP":0,"pain":5,"painWP":1},{"KD":0,"BL":3,"shock":6,"shockWP":0,"pain":6,"painWP":1},{"KD":-2,"BL":4,"shock":7,"shockWP":0,"pain":8,"painWP":1},{"KD":-5,"BL":6,"shock":9,"shockWP":0,"pain":11,"painWP":1}],"thigh":[{"BL":0,"shock":4,"shockWP":1,"pain":4,"painWP":1},{"KD":2,"BL":1,"shock":3,"shockWP":0,"pain":4,"painWP":1},{"KD":0,"BL":2,"shock":5,"shockWP":0,"pain":5,"painWP":1},{"KD":-2,"BL":4,"shock":5,"shockWP":0,"pain":6,"painWP":1},{"BL":8,"shock":5,"shockWP":0,"pain":7,"painWP":1}],"groin":[{"BL":6,"shock":7,"shockWP":0,"pain":9,"painWP":1},{"BL":8,"shock":8,"shockWP":0,"pain":10,"painWP":1},{"BL":10,"shock":10,"shockWP":0,"pain":15,"painWP":1},{"shock":-1,"shockWP":0,"pain":-1,"painWP":0},{"BL":15,"shock":-1,"shockWP":0,"pain":-1,"painWP":0}],"hip":[{"BL":0,"shock":4,"shockWP":1,"pain":4,"painWP":1},{"BL":1,"shock":3,"shockWP":0,"pain":5,"painWP":1},{"BL":3,"shock":5,"shockWP":0,"pain":9,"painWP":1},{"KD":-2,"BL":6,"shock":8,"shockWP":0,"pain":10,"painWP":1},{"KD":0,"BL":10,"shock":10,"shockWP":0,"pain":12,"painWP":1}],"flesh_to_the_side":[{"lev":1, "BL":3,"shock":5,"shockWP":0,"pain":6,"painWP":1},{"lev":1,"BL":3,"shock":5,"shockWP":0,"pain":6,"painWP":1},{"lev":1,"BL":3,"shock":5,"shockWP":0,"pain":6,"painWP":1},{"lev":1,"BL":3,"shock":5,"shockWP":0,"pain":6,"painWP":1},{"lev":1,"BL":3,"shock":5,"shockWP":0,"pain":6,"painWP":1}],"lower_abdomen":[{"BL":0,"shock":3,"shockWP":0,"pain":4,"painWP":1},{"BL":6,"shock":4,"shockWP":0,"pain":6,"painWP":1},{"BL":8,"shock":7,"shockWP":0,"pain":9,"painWP":1},{"shock":10,"shockWP":0,"pain":12,"painWP":1},{"BL":18,"shock":-1,"shockWP":0,"pain":-1,"painWP":0}],"upper_abdomen":[{"BL":0,"shock":3,"shockWP":0,"pain":4,"painWP":1},{"BL":8,"shock":5,"shockWP":0,"pain":6,"painWP":1},{"BL":10,"shock":8,"shockWP":0,"pain":10,"painWP":1},{"BL":13,"shock":13,"shockWP":0,"pain":15,"painWP":1},{"BL":19,"shock":-1,"shockWP":0,"pain":-1,"painWP":0}],"chest":[{"BL":0,"shock":9,"shockWP":1,"pain":5,"painWP":1},{"BL":4,"shock":4,"shockWP":0,"pain":6,"painWP":1},{"BL":8,"shock":7,"shockWP":0,"pain":8,"painWP":1},{"BL":19,"shock":13,"shockWP":0,"pain":13,"painWP":1,"d":2},{"d":2,"shock":0,"shockWP":0,"pain":0,"painWP":0}],"collar_and_throat":[{"BL":2,"shock":4,"shockWP":0,"pain":5,"painWP":1},{"BL":6,"shock":7,"shockWP":0,"pain":6,"painWP":1},{"shock":13,"shockWP":0,"pain":15,"painWP":1},{"BL":15,"shock":-1,"shockWP":0,"pain":20,"painWP":1},{"d":2,"shock":0,"shockWP":0,"pain":0,"painWP":0}],"face":[{"BL":1,"shock":7,"shockWP":1,"pain":4,"painWP":1},{"BL":2,"shock":6,"shockWP":0,"pain":6,"painWP":1},{"ko":-3,"BL":8,"shock":10,"shockWP":0,"pain":9,"painWP":1},{"ko":0,"BL":19,"shock":13,"shockWP":0,"pain":13,"painWP":0},{"d":2,"shock":0,"shockWP":0,"pain":0,"painWP":0}],"head":[{"BL":1,"shock":7,"shockWP":1,"pain":4,"painWP":1},{"BL":2,"shock":6,"shockWP":0,"pain":6,"painWP":1},{"ko":-3,"BL":8,"shock":10,"shockWP":0,"pain":9,"painWP":1},{"ko":0,"BL":19,"shock":13,"shockWP":0,"pain":13,"painWP":0},{"d":2,"shock":0,"shockWP":0,"pain":0,"painWP":0}],"hand":[{"BL":0,"shock":6,"shockWP":1,"pain":5,"painWP":1},{"BL":0,"shock":3,"shockWP":0,"pain":4,"painWP":1},{"BL":2,"shock":9,"shockWP":1,"pain":6,"painWP":1},{"BL":5,"shock":7,"shockWP":0,"pain":9,"painWP":1},{"BL":9,"shock":8,"shockWP":0,"pain":9,"painWP":1}],"forearm":[{"shock":5,"shockWP":1,"pain":4,"painWP":1},{"BL":1,"shock":5,"shockWP":0,"pain":6,"painWP":1},{"BL":2,"shock":5,"shockWP":0,"pain":6,"painWP":1},{"BL":6,"shock":7,"shockWP":0,"pain":8,"painWP":1},{"BL":7,"shock":8,"shockWP":0,"pain":9,"painWP":1}],"elbow":[{"BL":0,"shock":6,"shockWP":1,"pain":5,"painWP":1},{"BL":0,"shock":4,"shockWP":0,"pain":6,"painWP":1},{"BL":3,"shock":6,"shockWP":0,"pain":7,"painWP":1},{"BL":5,"shock":8,"shockWP":0,"pain":9,"painWP":1},{"BL":7,"shock":9,"shockWP":0,"pain":11,"painWP":1}],"upper_arm":[{"BL":0,"shock":4,"shockWP":1,"pain":4,"painWP":1},{"BL":1,"shock":3,"shockWP":0,"pain":5,"painWP":1},{"BL":3,"shock":5,"shockWP":0,"pain":6,"painWP":1},{"BL":5,"shock":6,"shockWP":0,"pain":7,"painWP":1},{"BL":7,"shock":7,"shockWP":0,"pain":8,"painWP":1}]};
//*/
	
		// http://knight.burrowowl.net/doku.php?id=rules:attack_locations
		thrustStartIndex = ZONE_VIII;
		
		// Bladed
		// swings
		zones[ZONE_I] = ZoneBody.create("to the Lower Legs", [1,3,2], ["foot", "shin_and_lower_leg", "knee_and_nearby_areas"] );
		zones[ZONE_II] = ZoneBody.create("to the Upper Legs",  [2, 3, 1], ["knee_and_nearby_areas", "thigh", "hip"] );
		zones[ZONE_III] = ZoneBody.create("for Horizontal Swing",  [1, 1, 1, 2, 1], ["hip", "upper_abdomen", "lower_abdomen", "ribcage", "arms"] );
		zones[ZONE_IV] = ZoneBody.create("for Overhand Swing",  [2, 1, 1, 1, 1], ["upper_arm_and_shoulder", "chest", "neck", "lower_head", "upper_head"] );
		zones[ZONE_V] = ZoneBody.create("for Downward Swing from Above",  [3, 1, 2], ["upper_head", "lower_head", "shoulder" ] );
		zones[ZONE_VI] = ZoneBody.create("for Upward Swing from Below",  [3, 1, 1, 1], ["inner_thigh", "groin", "abdomen", "chest" ] );
		zones[ZONE_VII] = ZoneBody.create("to the Arms",  [1, 2, 1, 2], ["hand", "forearm", "elbow", "upper_arm_and_shoulder" ] );
		// thrusts
		zones[ZONE_VIII] = ZoneBody.create("to the Lower Legs",  [1, 3, 1, 1], ["foot", "shin_and_lower_leg", "knee_and_nearby_areas",  "" ] );
		zones[ZONE_IX] = ZoneBody.create("to the Upper Legs",  [2, 3, 1], ["knee_and_nearby_areas", "thigh", "hip" ] );
		zones[ZONE_X] = ZoneBody.create("to the Pelvis",  [2, 2, 2], ["hip", "groin", "lower_abdomen" ] );  // NOTE: missing rules for female/male cases refer to core booklet
		zones[ZONE_XI] = ZoneBody.create("to the Belly",  [5, 1], ["lower_abdomen", "flesh_to_the_side" ] );
		zones[ZONE_XII] = ZoneBody.create("to the Chest",  [2,4], ["upper_abdomen", "chest" ] );
		zones[ZONE_XIII] = ZoneBody.create("to the Head",  [2, 4], ["collar_and_throat", ["face","face","face","head","head"] ] );
		zones[ZONE_XIV] = ZoneBody.create("to the Arm",  [1, 2, 1, 2], ["hand", "forearm", "elbow", "upper_arm" ] );
		
		// Blunt
		// swings
		zonesB[ZONE_I] = ZoneBody.create("to the Lower Legs", [1,3,2], ["foot", "shin_and_lower_leg", "knee_and_nearby_areas"] );
		zonesB[ZONE_II] = ZoneBody.create("to the Upper Legs",  [2, 3, 1], ["knee_and_nearby_areas", "thigh", "hip"] );
		zonesB[ZONE_III] = ZoneBody.create("for Horizontal Swing",  [1, 1, 1, 2, 1], ["hip", "upper_abdomen", "lower_abdomen", "ribcage", "arms"] );
		zonesB[ZONE_IV] = ZoneBody.create("for Overhand Swing",  [2, 1, 1, 1, 1], ["upper_arm_and_shoulder", "upper_body", "neck", "lower_head", "upper_head"] );
		zonesB[ZONE_V] = ZoneBody.create("for Downward Swing from Above",  [2, 1, 3], ["shoulder", "lower_head", "upper_head" ] );
		zonesB[ZONE_VI] = ZoneBody.create("for Upward Swing from Below",  [3, 1, 1, 1], ["inner_thigh", "groin", "abdomen", "lower_head" ] );
		zonesB[ZONE_VII] = ZoneBody.create("to the Arms",  [1, 2, 1, 2], ["hand", "forearm", "elbow", "upper_arm_and_shoulder" ] );
		// thrusts
		zonesB[ZONE_VIII] = ZoneBody.create("to the Lower Legs",  [1, 3, 1, 1], ["foot", "shin_and_lower_leg", "knee_and_nearby_areas", ""] );
		zonesB[ZONE_IX] = ZoneBody.create("to the Upper Legs",  [2, 3, 1], ["knee_and_nearby_areas", "thigh", "hip" ] );
		zonesB[ZONE_X] = ZoneBody.create("to the Pelvis",  [2, 2, 2], ["hip", "groin", "lower_abdomen" ] );  // NOTE: missing rules for female/male cases
		zonesB[ZONE_XI] = ZoneBody.create("to the Belly",  [6], ["lower_abdomen"] );
		zonesB[ZONE_XII] = ZoneBody.create("to the Chest",  [2,4], ["upper_abdomen", "chest" ] );
		zonesB[ZONE_XIII] = ZoneBody.create("to the Head",  [1, 3, 2], ["neck", ["face","face","face","lower_head","lower_head"], "upper_head" ] );
		zonesB[ZONE_XIV] = ZoneBody.create("to the Arm",  [1, 2, 1, 2], ["hand", "forearm", "elbow", "upper_arm_and_shoulder" ] );
		
		
		// monkey patch fixes..not sure if it's correct.. create duplicates of existing values?
		partsBludgeon.lower_abdomen = partsBludgeon.abdomen;
		partsBludgeon.arms = partsBludgeon.upper_arm_and_shoulder;
		partsBludgeon.shoulder = partsBludgeon.upper_arm_and_shoulder;
		
		// kiv : validtateZone if needed be
		//validateZoneWithDamageTable(zonesB, partsBludgeon, "blud");
		
		//validateZoneWithDamageTable(zones, partsPuncture, "punc", thrustStartIndex-1);
		
		partsCut.lower_abdomen = partsCut.abdomen;
		partsCut.upper_abdomen = partsCut.abdomen;
		partsCut.arms = partsCut.upper_arm_and_shoulder;
		//validateZoneWithDamageTable(zones, partsCut, "cut", -1, thrustStartIndex);
	
		
		centerOfMass = CENTER_OF_MASS;
		centerOfMassT = CENTER_OF_MASS_T;
	}
	
}