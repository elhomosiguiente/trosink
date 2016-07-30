package troshx.util;
import haxe.rtti.Rtti;
import haxe.rtti.CType;
import haxe.rtti.Meta;

/**
 * Useful utility to reflect properties/methods, etc. of Haxe classes/instances to VueJS and other ViewModel implementations
 * @author Glenn Ko
 */
@:expose
class ReflectUtil
{

	public static function setItemStaticMethodsTo<T>(c:Class<T>, to:Dynamic):Dynamic {
		return setItemMethodsTo(c, to, true);
	}
	public static function setItemInstanceMethodsTo<T>(c:Class<T>, to:Dynamic):Dynamic {
		return setItemMethodsTo(c, to, false);
	}
	public static function setItemMethodsTo<T>(c:Class<T>, to:Dynamic, isStatic:Bool=false, requireMeta:String=null):Dynamic {
		var rtti = Rtti.getRtti(c);
		var reference:Dynamic = isStatic ? c : Type.createEmptyInstance(c);
		var meta = isStatic ? Meta.getStatics(c) : Meta.getFields(c);
		for (f in (isStatic ? rtti.statics : rtti.fields ).iterator() ) {
			var fieldMeta = Reflect.field(meta, f.name);
			if (requireMeta == null || (fieldMeta != null && Reflect.hasField(fieldMeta, requireMeta)) ) {
				switch( f.type ) {
					case CType.CFunction(args, ret):
						Reflect.setField(to, f.name, Reflect.field(reference, f.name) );
					default:
						
				}
			}
		}
		return to;
	}
	
}