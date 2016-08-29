package ;

import haxe.rtti.Meta;
import haxe.rtti.Rtti;
import troshx.BodyChar;
import troshx.ZoneBody;

import troshx.util.TROSAI;
import troshx.util.ReflectUtil;
import troshx.util.PropertyChainHolder;

import troshx.tros.HumanoidBody;
import troshx.tros.ai.TROSAiBot;
import dat.gui.DatUtil;

import troshx.tros.ai.TROSAiBotInkle;


/**
 * Generic Haxe Codebase for all TROS-like RPGs (for targeting any platform, Javascript/C#/AS3/etc.)
 * @author 
 */

class Main 
{
	
	static function main() 
	{
		var data = ReflectUtil.getMetaDataOfField("bind", TROSAiBot, "initiative", false);
		var b = data[0];
	}
	
}