// Stateless stats and their retrieval methods for Weapons

CONST ATTR_BASE_NONE = -1
CONST ATTR_BASE_STRENGTH = 0

=== function getWeaponDamageStrength(damage, attrBaseIndex, charId, ref damageFromChar)
{
	-attrBaseIndex == ATTR_BASE_STRENGTH:
		~damageFromChar = getStrengthByCharId(charId)
		~return damageFromChar + damage
	-else:
		~damageFromChar = 0
		~return damage
}



=== function getAllWeaponStats(weaponId, ref name, ref isShield, ref damage, ref damage2, ref damage3, ref attrBaseIndex,  ref dtn, ref dtnT, ref atn, ref atn2, ref blunt ,  ref shieldLimit, ref twoHanded  )
{
- weaponId == "Gladius":
	~name = "Gladius"
	~isShield = 0
	~shieldLimit = 0
	~damage = 0
	~damage2 = 1
	~damage3 = 0
	~attrBaseIndex = ATTR_BASE_STRENGTH
	~dtn = 7
	~dtnT = 0
	~atn = 6
	~atn2 = 6
	~blunt =0
	~twoHanded = 0
~return
- weaponId == "Mace":
	~name = "Mace"
	~isShield = 0
	~shieldLimit = 0
	~damage = 1
	~damage2 = 0
	~damage3 = 0
	~attrBaseIndex = ATTR_BASE_STRENGTH
	~dtn = 7
	~dtnT = 0
	~atn = 6
	~atn2 = 6
	~blunt = 1
	~twoHanded = 0
~return
- weaponId == "Small Shield":
	~name = "Small Shield"
	~isShield = 1
	~shieldLimit = 0
	~damage = 0
	~damage2 = 0
	~damage3 = 0
	~attrBaseIndex = ATTR_BASE_STRENGTH
	~dtn = 6
	~dtnT = 0
	~atn = 0
	~atn2 = 0
	~blunt = 1
	~twoHanded = 0
~return
-else:
	~elseResulted = 1
}
// default empty NOTHING weapon below (remember to '~return' switch cases above to early-exit!!)
~name =""
~isShield = 0
~damage = 0
~damage2 = 0
~damage3 = 0
~attrBaseIndex = ATTR_BASE_NONE
~dtn = 0
~dtnT = 0
~atn = 0
~atn2 = 0
~blunt = 0