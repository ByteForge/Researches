package devkeyboard {
	import flash.events.KeyboardEvent;
	
	public class Key extends Keys {
		
		private static const DEFAULT_INSTANCE_NAME:String = "Key_instance";
		private static var _lastID:uint = 0;
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
		
		//private static var _keyCache:Vector
		
		public static function from( parameters:Object ): Key {
			return null;
		}
		
		public static function isDownOn( key:String, event:KeyboardEvent ): Boolean {
		
			return false;
		}
		public static function isUpOn( key:String, event:KeyboardEvent ): Boolean {
			
			return false;
		}
		public static function isPressedOn( key:String, event:KeyboardEvent ): Boolean {
		
			return false;
		}
		public static function isReleasedOn( key:String, event:KeyboardEvent ): Boolean {
		
			return false;
		}
		
		/*		
		protected var _event_keyCode:uint;
		protected var _event_charCode:uint;
		protected var _event_ctrlKey:Boolean;
		protected var _event_altKey:Boolean;
		protected var _event_shiftKey:Boolean;
		*/
		//protected var _controlKey:Boolean;
		//protected var _commandKey:Boolean;
		
		private static var _string:Vector.< Vector.<String> >;
		private static var _command:Vector.< Vector.<uint> >;
		private static var _length:uint;
		private static var _offset:uint;
		
		// Keycodes
		public static const _0:uint = 48;	public static const ZERO:uint = 	48;	public static const NUMBER_0:uint = 	48;
		public static const _1:uint = 49;	public static const ONE:uint = 		49;	public static const NUMBER_1:uint = 	49;
		public static const _2:uint = 50;	public static const TWO:uint = 		50;	public static const NUMBER_2:uint = 	50;
		public static const _3:uint = 51;	public static const THREE:uint =	51;	public static const NUMBER_3:uint = 	51;		
		public static const _4:uint = 52;	public static const FOUR:uint = 	52;	public static const NUMBER_4:uint = 	52;
		public static const _5:uint = 53;	public static const FIVE:uint = 	53;	public static const NUMBER_5:uint = 	53;
		public static const _6:uint = 54;	public static const SIX:uint = 		54;	public static const NUMBER_6:uint = 	54;
		public static const _7:uint = 55;	public static const SEVEN:uint =	55;	public static const NUMBER_7:uint = 	55;
		public static const _8:uint = 56;	public static const EIGHT:uint =	56;	public static const NUMBER_8:uint = 	56;
		public static const _9:uint = 57;	public static const NINE:uint = 	57;	public static const NUMBER_9:uint = 	57;
		
		public static const NUMPAD_0:uint = 96;
		public static const NUMPAD_1:uint = 97;
		public static const NUMPAD_2:uint = 98;
		public static const NUMPAD_3:uint = 99;
		public static const NUMPAD_4:uint = 100;
		public static const NUMPAD_5:uint = 101;
		public static const NUMPAD_6:uint = 102;
		public static const NUMPAD_7:uint = 103;
		public static const NUMPAD_8:uint = 104;
		public static const NUMPAD_9:uint = 105;
		
		public static const A:uint = 65;
		public static const B:uint = 66;
		public static const C:uint = 67;
		public static const D:uint = 68;
		public static const E:uint = 69;
		public static const F:uint = 70;
		public static const G:uint = 71;
		public static const H:uint = 72;
		public static const I:uint = 73;
		public static const J:uint = 74;
		public static const K:uint = 75;
		public static const L:uint = 76;
		public static const M:uint = 77;
		public static const N:uint = 78;
		public static const O:uint = 79;
		public static const P:uint = 80;
		public static const Q:uint = 81;
		public static const R:uint = 82;
		public static const S:uint = 83;
		public static const T:uint = 84;
		public static const U:uint = 85;
		public static const V:uint = 86;
		public static const W:uint = 87;
		public static const X:uint = 88;
		public static const Y:uint = 89;
		public static const Z:uint = 90;
		
		// +
		public static const NUMPAD_ADD:uint = 107;
		// -
		public static const NUMPAD_SUBTRACT:uint = 109;
		// /
		public static const NUMPAD_DIVIDE:uint = 111;
		// *
		public static const NUMPAD_MULTIPLY:uint = 106;		
		// .
		public static const NUMPAD_DECIMAL:uint = 110;		
		public static const NUMPAD_ENTER:uint = 108;	
		
		// '
		public static const QUOTE:uint = 222;		public static const SINGLEQUOTE:uint = 222;
		// `
		public static const BACKQUOTE:uint = 192;
		
		// -
		public static const DASH:uint = 189;		public static const MINUS:uint = 189;
		// =
		public static const EQUAL:uint = 187;		public static const EQUAL_SIGN:uint = 187;
		
		// /
		public static const SLASH:uint = 191;		
		// \
		public static const BACKSLASH:uint = 220;
		
		// [
		public static const LEFTBRACKET:uint = 219;	public static const OPENBRACKET:uint = 219;
		// ]
		public static const RIGHTBRACKET:uint = 221;	public static const CLOSEBRACKET:uint = 221;
		
		// ;
		public static const SEMICOLON:uint = 186;		
		// ,
		public static const COMMA:uint = 188;		
		// .
		public static const PERIOD:uint = 190;		public static const DOT:uint = 190;
		
		public static const ESC:uint = 		27;
		public static const ENTER:uint = 	13;
		public static const SPACE:uint = 	32;
		public static const BACKSPACE:uint = 	8;
		public static const TAB:uint = 		9;
		public static const PAUSE:uint = 	19; 	public static const BREAK:uint = 19;
						
		public static const UP:uint = 		38;	public static const UP_ARROW:uint = 	38;	
		public static const RIGHT:uint =	39;	public static const RIGHT_ARROW:uint =	39;
		public static const DOWN:uint = 	40;	public static const DOWN_ARROW:uint = 	40;
		public static const LEFT:uint = 	37;	public static const LEFT_ARROW:uint = 	37;
		
		public static const INSERT:uint = 	45;
		public static const DELETE:uint = 	46;
		public static const HOME:uint = 	36;
		public static const END:uint = 		35;
		public static const PAGE_UP:uint = 	33;
		public static const PAGE_DOWN:uint = 	34;
		
		public static const CAPS_LOCK:uint = 	20;
		public static const NUM_LOCK:uint = 	144;
				
		public static const F1:uint = 		112;
		public static const F2:uint = 		113;
		public static const F3:uint = 		114;
		public static const F4:uint = 		115;
		public static const F5:uint = 		116;
		public static const F6:uint = 		117;
		public static const F7:uint = 		118;
		public static const F8:uint = 		119;
		public static const F9:uint = 		120;
		public static const F10:uint = 		121;
		public static const F11:uint = 		122;
		public static const F12:uint = 		123;
		
		// Modifiers
		
		public static const CTRL:uint = 		17;
			public static const CTRL_LEFT:uint = 	17 + 1000000;
			public static const CTRL_RIGHT:uint = 	17 + 2000000;
		public static const ALT:uint = 			18;			
		//public static const ALTGR:uint = 		???
		public static const SHIFT:uint = 		16;
			public static const SHIFT_LEFT:uint = 	16 + 1000000;
			public static const SHIFT_RIGHT:uint = 	16 + 2000000;
		
		/*
			overloads:
				empty initialization:
					- new Key();
				initialization with string:
					- by default settings:
						new Key( "{CTRL}", optional KeyMode );
						new Key( "X", optional KeyMode );
					- key position:
						new Key( "[ A ]", optional KeyMode );
					- character specific:
						new Key( "( A )", optional KeyMode );						
						new Key( "{ A }", optional KeyMode );						
						new Key( "< A >", optional KeyMode );						
						new Key( ' "A" ', optional KeyMode );						
				initialization with object:
					- new Key( { key: A } )
					- new Key( { character: A } )
		*/
		
		private var _name:String;
		
		public function Key( key:Object = null, keyMode:String = null ) {
			
			// default initialization
			this._initialized = false;
			
			this._keyCode = 0;
			this._charCode = 0;
			this._ctrlKey = false;
			this._altKey = false;
			this._shiftKey = false;
			
			this._event_keyCode = 0;
			this._event_charCode = 0;
			this._event_ctrlKey = false;
			this._event_altKey = false;
			this._event_shiftKey = false;
			
			this._name = DEFAULT_INSTANCE_NAME + _lastID.toString();
			++_lastID;
			
			var instance_keyMode:String = _keyMode;
						
			if( key ) {
				if( keyMode && ( keyMode === KeyMode.KEY || keyMode === KeyMode.CHARACTER ) ) {
					instance_keyMode = keyMode;
					TRACE(1 )( "keyMode specified: [" + instance_keyMode + "]" );
				}
			
				if( key is String && key.length ) {
					TRACE( 1 )( "initialization with string" );
					TRACE( 2 )( "length:", key.length );
					
					var keyString:String = ( key as String ).split( " " ).join( "" ).toLocaleLowerCase();
					var keyLength:uint = keyString.length;
					TRACE( 2 )( "keyString: [" +keyString+ "]", "keyLength: <" +keyLength+ ">" );
					
					if( keyLength ) {
						if( instance_keyMode === KeyMode.KEY ) {
							TRACE( 3 )( "KeyMode.KEY" );
							
							for( var i:uint = 0, str:Array = Keys.strings[ key.length ], num:Array = Keys.numbers[ key.length ], L:uint = str.length; i < L; ++i ) {
								if( str[ i ] === keyString ) {
									TRACE( 4 )( "found:", keyString, " keyCode: [" +( num[ i ] )+ "]" );
									
									this._keyCode = num[ i ];
									this._initialized = true;
									
									break;
								}
							}
							
						} else {
							TRACE( 3 )( "KeyMode.CHARACTER" );
						}
					}					
					
				} else if( key is Number ) {
					TRACE( 1 )( "initialization with int / uint / Number" );
					TRACE( 2 )( key is int, key is uint, key is Number );
					
				} else {
					TRACE( 1 )( "initialization with object / {}" );
					
					var obj:Object = null;
					
					if( ( obj = key.key ) || ( obj = key.Key ) || ( obj = key.KEY ) || ( obj = key.k ) || ( obj = key.K ) ) {
						TRACE( 2 )( "key:", obj );						
					} else if( ( obj = key.character ) || ( obj = key.Character ) || ( obj = key.CHARACTER ) || ( obj = key.char ) || ( obj = key.Char ) || ( obj = key.CHAR ) || ( obj = key.ch ) || ( obj = key.CH ) || ( obj = key.c ) || ( obj = key.C ) ) {
						TRACE( 2 )( "character:", obj );
					}
										
					if( obj ) {
						if( obj.length ) {
							TRACE( 3 )( "String with length:", obj.length );
						} else if( obj is int, obj is uint, obj is Number ) {
							TRACE( 3 )( "Number:", obj );
						}
					}
					
				}
			} else {
				TRACE( 1 )( "empty initialization" );
			}			
		}
		
		override public function test(): Boolean {
			return false;
		}
				
		public function get key(): Key {
			return null;
		}
		public function set key( key:Key ): void {
		
		}		
		
		public function get name(): String {
			return this._name;
		}		
		public function set name( value:String ): void {
			if( value.length ) {
				this._name = value;
			}
		}
		
		public function get charCode(): uint {
			return this._charCode;
		}
		public function set charCode( value:uint ): void {
			this._charCode = value;
		}
		public function get keyCode(): uint {
			return this._keyCode;
		}
		public function set keyCode( value:uint ): void {
			this._keyCode = value;
		}
		public function get ctrlKey(): Boolean {
			return this._ctrlKey;
		}
		public function set ctrlKey( value:Boolean ): void {
			this._ctrlKey = value;
		}
		public function get shiftKey(): Boolean {
			return this._shiftKey;
		}
		public function set shiftKey( value:Boolean ): void {
			this._shiftKey = value;
		}
		public function get altKey(): Boolean {
			return this._altKey;
		}
		public function set altKey( value:Boolean ): void {
			this._altKey = value;
		}
		public function get keyLocation(): uint {
			return this._keyLocation;
		}
		public function set keyLocation( value:uint ): void {
			this._keyLocation = value;
		}
		
		public function isUp():Boolean {
			return false;
		}
		public function isDown():Boolean {
			return false;
		}
		public function isPressed():Boolean {
			return false;
		}
		public function isReleased():Boolean {
			return false;
		}
		
		
	}
}





