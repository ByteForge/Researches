package devkeyboard {
	import flash.events.KeyboardEvent;
	
	public class KeyGroup implements IKeys {
		
		private static const DEFAULT_INSTANCE_NAME:String = "KeyGroup_instance";
		private static var lastID:uint = 0;
		
		protected var parent:KeyGroup;
				
		protected var _keyCode:uint;
		protected var _charCode:uint;
		protected var _ctrlKey:Boolean;
		protected var _altKey:Boolean;
		protected var _shiftKey:Boolean;
		//protected var _controlKey:Boolean;
		//protected var _commandKey:Boolean;
		
		private var _event:KeyboardEvent;
		private var _vector:Vector.<IKeys>;
		private var _length:uint;
				
		public function KeyGroup() {
			this._vector = new Vector.<IKeys>( 0, false );
			this._length = 0;
		}
		
		public function listen( e:KeyboardEvent ): void {
		
			this._keyCode = e.keyCode;
			this._charCode = e.charCode;
			
			this._ctrlKey = e.ctrlKey;
			this._altKey = e.altKey;
			this._shiftKey = e.shiftKey;
			
			//this._controlKey = e.c
			//this._commandKey = e.
		}
		
		public function get name(): String {
			return null;
		}		
		public function set name( value:String ): void {
			
		}
		
		public function ignore(): void {
		
			
		}
		
		public function get occur(): Boolean {
			return false;
		}
		
		public function get engage(): Boolean {
			return false;
		}
		
		public function add( key:IKeys ): void {
			for( var i:uint = 0, iL:uint = this._vector.length; i < iL; ++i ) {
				if( key === this._vector[ i ] ) {
					TRACE( 1 )( "public function add( key:IKeys ) -> found matching -> remove matching" );
					this._vector.splice( i, 1 );
					this._length--;
				}
			}
			this._vector[ this._length ] = key;
			this._length++;
		}
		
		public function remove( key:IKeys ): void {
			for( var i:uint = 0, iL:uint = this._vector.length; i < iL; ++i ) {
				if( key === this._vector[ i ] ) {
					TRACE( 1 )( "public function remove( key:IKeys ) -> found matching -> remove matching" );
					this._vector.splice( i, 1 );
					this._length--;
				}
			}
		}
		
		public function get numKeys(): uint {
			
			//return this._vector.length;
			return this._length;
			
			//return 0;
		}
		
		private static function TRACE( tabs:uint = 0 ): Function {
			var t:String = "";
			while( tabs-- ) {
				t += "\t";
			}
			return function( ...arg ): void {
				if( arg.length === 0 ) {
					trace( "" );
				} else {
					if( t !== "" ) {
						arg.unshift( t );
					}					
					trace.apply( null, arg ); 
				}
			};
		}
	}
}