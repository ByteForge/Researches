package devkeyboard {
	import flash.events.KeyboardEvent;
	
	public class KeyCombination extends Keys {
		
		private static var _keyMode:String = KeyMode.KEY;

		public static function get keyMode(): String {
			return _keyMode;
		}
		public static function set keyMode( value:String ): void {
			if( value === KeyMode.KEY || value === KeyMode.CHARACTER ) {
				_keyMode = value;								
			} else {
				_keyMode = KeyMode.KEY;
			}
		}
		
		private static const DEFAULT_INSTANCE_NAME:String = "KeyCombination_instance";
		private static var lastID:uint = 0;
		
		//private static var _keyCache:Vector
		public static function from( parameters:Object ): KeyCombination {
			return null;
		}
		
		public static function isDownOn( combination:String, event:KeyboardEvent ): Boolean {
			
			return false;
		}
		public static function isUpOn( combination:String, event:KeyboardEvent ): Boolean {
			
			return false;
		}
		public static function isPressedOn( combination:String, event:KeyboardEvent ): Boolean {
			
			return false;
		}
		public static function isReleasedOn( combination:String, event:KeyboardEvent ): Boolean {
			
			return false;
		}
		
		/*
		protected var _keyCode:uint;
		protected var _charCode:uint;
		protected var _ctrlKey:Boolean;
		protected var _altKey:Boolean;
		protected var _shiftKey:Boolean;
		*/
		//protected var _controlKey:Boolean;
		//protected var _commandKey:Boolean;
		
		private var _name:String;
		
		private var _ctrl:Boolean = false;
		private var _ctrlLeft:Boolean = false;
		private var _ctrlRight:Boolean = false;
		private var _alt:Boolean = false;
		private var _shift:Boolean = false;
		private var _shiftLeft:Boolean = false;
		private var _shiftRight:Boolean = false;
		
		/*
			overloads:
				empty initialization:
					new KeyCombination();
				initialization with string:
					- by default settings:
						new KeyCombination( "CTRL + A" );
						new KeyCombination( "# + A" );
						new KeyCombination( "{CTRL} + A" );
					- key position:
						new Key( "{CTRL} + [ A ]" );
					- character specific:
						new Key( "{CTRL} + ( A )" );						
						new Key( "{CTRL} + { A }" );						
						new Key( "{CTRL} + < A >" );						
						new Key( '{CTRL} + "A" ' );						
				initialization with object:
					new KeyCombination( { CTRL: true, KEY: 68 } );
					new KeyCombination( { shift: true, character: "x" } );		
		*/
		public function KeyCombination( keyCombination:Object = null ) {
			// default modifier values
			
			this._ctrl = false;
			this._ctrlLeft = false;
			this._ctrlRight = false;
			this._alt = false;
			this._shift = false;
			this._shiftLeft = false;
			this._shiftRight = false;
			
			keyCombination = "CTRL + A";
			
			if( keyCombination ) {
				if( keyCombination is String ) {
					TRACE( 1 )( "keyCombination is String" )
					
					var segment:Array = keyCombination.split( " " ).join( "" ).toLowerCase().split( "+" );
					
					TRACE( 1 )( segment );
					
				} else {
					var obj:Object;
					// CTRL
					if( ( obj = keyCombination.ctrl ) || ( obj = keyCombination.Ctrl ) || ( obj = keyCombination.CTRL ) ) {
						if( obj === true || obj === 1 ) {
							this._ctrl = true;
							this._ctrlLeft = this._ctrlRight = false;
						}						
					}
					// CTRL LEFT
					if( 	( obj = keyCombination.ctrlLeft ) || 
						( obj = keyCombination.CtrlLeft ) || 
						( obj = keyCombination.CTRLLEFT ) 
											) {
						if( obj === true || obj === 1 ) {
							this._ctrlLeft = true;
							this._ctrl = this._ctrlRight = false;
						}						
					}
					// CTRL RIGHT
					if( 	( obj = keyCombination.ctrlRight ) || 
						( obj = keyCombination.CtrlRight ) || 
						( obj = keyCombination.CTRLRight ) 
											) {
						if( obj === true || obj === 1 ) {
							this._ctrlRight = true;
							this._ctrl = this._ctrlLeft = false;
						}						
					}
					// ALT
					if( ( obj = keyCombination.alt ) || ( obj = keyCombination.Alt ) || ( obj = keyCombination.ALT ) ) {
						if( obj === true || obj === 1 ) {
							this._alt = true;
						}						
					}
					// SHIFT
					if( ( obj = keyCombination.shift ) || ( obj = keyCombination.Shift ) || ( obj = keyCombination.SHIFT ) ) {
						if( obj === true || obj === 1 ) {
							this._shift = true;
							this._shiftLeft = this._shiftRight = false;
						}
					}
					// SHIFT LEFT
					if( 	( obj = keyCombination.shiftLeft ) || 
						( obj = keyCombination.ShiftLeft ) || 
						( obj = keyCombination.SHIFTLEFT ) 
											) {
						if( obj === true || obj === 1 ) {
							this._shiftLeft = true;
							this._shift = this._shiftRight = false;
						}						
					}
					// SHIFT RIGHT
					if( 	( obj = keyCombination.shiftRight ) || 
						( obj = keyCombination.ShiftRight ) || 
						( obj = keyCombination.SHIFTRIGHT ) 
											) {
						if( obj === true || obj === 1 ) {
							this._shiftRight = true;
							this._shift = this._shiftLeft = false;
						}						
					}
					
				}
			} else {
				TRACE( 1 )( "new KeyCombination() - empty instantiation" )
			}
			
			// default name
			this._name = DEFAULT_INSTANCE_NAME + lastID.toString();
			++lastID;
		}
		
		override public function test(): Boolean {
			return false;
		}
		
		public function get name(): String {
			//return null;
			return this._name;
		}		
		public function set name( value:String ): void {
			
		}
		
		/*
		public function get combination(): String {
			return null;
		}
		public function set combination( value: Object ): void {
			return null;
		}
		*/
		
		public function get combination(): KeyCombination {
			return null;
		}
		public function set combination( keyCombination:KeyCombination ): void {
			
		}
		
	}
}