package ;

import haxe.rtti.Meta;
import haxe.rtti.Rtti;

import haxevx.vuex.examples.shoppingcart.store.AppStore;

import haxevx.vuex.examples.shoppingcart.components.App;
import haxevx.vuex.util.ActionFactory;
import haxevx.vuex.util.MutatorFactory;
import troshx.core.BodyChar;
import troshx.core.Weapon;
import troshx.core.ZoneBody;
import troshx.util.ReflectVueJSUtil;

import troshx.components.FightState;
import troshx.sos.BoutController;

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
			trace(Meta.getFields( FightState));
			MutatorFactory;
			ActionFactory;

			
			App;
			

		AppStore;
	}
	
}