package troshx.util;

/**
 * ...
 * @author Glidias
 */
class LibUtil
{


	
	public static inline function validInt(?val:Int):Bool {
		return val != null && !Math.isNaN(val);
	}
	public static inline function as<T>( obj:Dynamic, type:Class<T> ):T {
		return Std.is( obj, type ) ? cast obj : null;
	}
	public static  function asNoInline<T>( obj:Dynamic, type:Class<T> ):T {
		return Std.is( obj, type ) ? cast obj : null;
	}
	
	public static inline function tryParseFloat(val:Dynamic ):Dynamic {
		return Std.parseFloat(val);  // TOCHECK: across all platforms validity
	}
	public static inline function tryParseInt(val:Dynamic ):Dynamic {
		return Std.parseInt(val); // TOCHECK: across all platforms validity
	}
	
	public static inline function field<T>(of:Dynamic<T>, field:String):T {
		return Reflect.field(of, field);
	}
	public static inline function setField<T>(of:Dynamic<T>, field:String, value:T):Void {
		Reflect.setField(of, field, value);
	}
	public static function setFieldChain<T>(of:Dynamic<T>, field:String, value:T):T {
		Reflect.setField(of, field, value);
		return value;
	}

	
	public static function arrayToList<T>(arr:Array<T>):List<T> {
		var list:List<T> = new List<T>();
		for (val in arr) {
			list.add(val);
		}
		return list;
	}
	
	public static inline function getArrayItemAtIndex<T>(arr:Array<T>, index:Int):T {
		return arr[index];
	}
	
	public static function getListItemAtIndex<T>(list:List<T>, index:Int):T {
		if (index < 0 || index >= list.length) return null;
		var iter = list.iterator();
		for (i in 0...index) {
			iter.next();
		}
		return iter.next();
	}
	
	public static inline function clearArray<T>(arr:Array<T>):Void {
		#if (js||flash)
		untyped arr.length = 0;
		#else
		arr.splice(0,arr.length);
		#end
	}
	
	public static inline function truncateArray<T>(arr:Array<T>, fromIndex:Int):Void {
		#if (js||flash)
		untyped arr.length = fromIndex;
		#else
		arr.splice(fromIndex, arr.length);
		#end
	}
	
	public static function findForList<T>(list:List<T>, f : T -> Bool ):T {
		for ( i in list) {
			if (f(i)) {
				return i;
			}
		}
		return null;
	}
	
	static public function minI(a:Int, b:Int):Int 
	{
		return (a < b ? a : b);
	}
	static public function maxI(a:Int, b:Int):Int 
	{
		return (a >= b ? a : b);
	}
	static public inline function minI_(a:Int, b:Int):Int 
	{
		return (a < b ? a : b);
	}
	static public inline function maxI_(a:Int, b:Int):Int 
	{
		return (a >= b ? a : b);
	}
	
	static public inline function removeArrayItemAtIndex<T>(arr:Array<T>, index:Int) 
	{
		arr.splice(index,1);
	}
	
}