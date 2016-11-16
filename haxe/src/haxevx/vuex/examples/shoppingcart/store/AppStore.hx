package haxevx.vuex.examples.shoppingcart.store;
import haxevx.vuex.core.NoneT;
import haxevx.vuex.core.VxStore;
import haxevx.vuex.examples.shoppingcart.modules.Cart;
import haxevx.vuex.examples.shoppingcart.modules.ProductList;

/**
 * port of store/index.js
 * 
 * @author Glidias
 */
@:rtti
class AppStore extends VxStore<AppState>  
{	
	// Actions
	@action public var actions:AppActions<AppState>;
	
	// Getters
	@getter public var getters:AppGetters<AppState>;
	
	// Modules
	@module public var cart:Cart;
	@module public var products:ProductList;
	
	public function new() {
		state = new AppState();
		
		strict = true; // for demo purposes
	}

}

@:rtti
class AppState { 
	
	// CAN'T BE HELPED. Need to explicitly declare matching module states within AppState if it needs to be referenced.
	// Only runtime-init checking of matching module state types with above Appstore @module fields will be done.
	public var cart(default, null):CartState;
	public var products(default, null):ProductListModel;
	
	public function new() {
		
	}
	
}