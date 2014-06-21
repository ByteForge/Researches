package devkeyboard {
	
	public class Keys {
		
		private static var _keyMode:String = KeyMode.KEY;

		public static function get keyMode(): String {
			return _keyMode;
		}
		public static function set keyMode( value:String ): void {
			if( value === KeyMode.KEY ) {
				_keyMode = value;
			} else {
				_keyMode = KeyMode.CHARACTER;
			}
			
			Key.keyMode = value;
			KeyCombination.keyMode = value;
			KeyString.keyMode = value;
		}

		internal static var length:uint;
		internal static var strings:Array;
		internal static var numbers:Array;
		
		private static var initialized:Boolean = false;
		
		protected var _initialized: Boolean = false;
		
		protected var _keyCode: uint;
		protected var _charCode: uint;
		protected var _ctrlKey: Boolean;
		protected var _altKey: Boolean;
		protected var _shiftKey: Boolean;
		
		protected var _event_keyCode: uint;
		protected var _event_charCode: uint;
		protected var _event_ctrlKey: Boolean;
		protected var _event_altKey: Boolean;
		protected var _event_shiftKey: Boolean;
		
		public function Keys() {
			
			if( initialized ) {
				return;
			}
			
			var keys:Array = [
				[ Key._0,	"0" ],
				[ Key._1,	"1" ],
				[ Key._2,	"2" ],
				[ Key._3,	"3" ],
				[ Key._4,	"4" ],
				[ Key._5,	"5" ],
				[ Key._6,	"6" ],
				[ Key._7,	"7" ],
				[ Key._8,	"8" ],
				[ Key._9,	"9" ],
			
				[ Key.A,	"a" ],
				[ Key.B,	"b" ],
				[ Key.C,	"c" ],
				[ Key.D,	"d" ],
				[ Key.E,	"e" ],
				[ Key.F,	"f" ],
				[ Key.G,	"g" ],
				[ Key.H,	"h" ],
				[ Key.I,	"i" ],
				[ Key.J,	"j" ],
				[ Key.K,	"k" ],
				[ Key.L,	"l" ],
				[ Key.M,	"m" ],
				[ Key.N,	"n" ],
				[ Key.O,	"o" ],
				[ Key.P,	"p" ],
				[ Key.Q,	"q" ],
				[ Key.R,	"r" ],
				[ Key.S,	"s" ],
				[ Key.T,	"t" ],
				[ Key.U,	"u" ],
				[ Key.V,	"v" ],
				[ Key.W,	"w" ],
				[ Key.X,	"x" ],
				[ Key.Y,	"y" ],
				[ Key.Z,	"z" ],
				
				[ Key.PERIOD,		"." ],
				[ Key.COMMA,		"," ],
				[ Key.SEMICOLON,	";" ],				
				[ Key.SINGLEQUOTE,	"'" ],
				[ Key.BACKQUOTE,	"`" ],
				[ Key.OPENBRACKET,	"[" ],
				[ Key.CLOSEBRACKET,	"]" ],
				[ Key.SLASH,		"/" ],
				[ Key.BACKSLASH,	"\\" ],
				[ Key.DASH,		"-" ],
				[ Key.EQUAL,		"=" ],
				
				[ Key.UP, 		"up", "{up}", "{u}"		],
				[ Key.LEFT, 		"left", "{left}", "{l}"		],
				[ Key.DOWN, 		"down", "{down}", "{d}"		],
				[ Key.RIGHT, 		"right", "{right}", "{r}"	],
				[ Key.ENTER, 		"enter", "{enter}", "{e}"	],
				[ Key.SPACE, 		"space", "{space}", "spc", "{spc}"	],
				
				[ Key.CTRL,		"ctrl", "{ctrl}", "{c}"		],
				[ Key.CTRL_LEFT,	"ctrll", "ctrl_l", "lctrl", "l_ctrl", "ctrlleft", "ctrl_left", "leftctrl", "left_ctrl", "{ctrll}", "{ctrl_l}", "{lctrl}", "{l_ctrl}", "{ctrlleft}", "{ctrl_left}", "{leftctrl}", "{left_ctrl}" ],
				[ Key.CTRL_RIGHT,	"ctrlr", "ctrl_r", "rctrl", "r_ctrl", "ctrlright", "ctrl_right", "rightctrl", "right_ctrl", "{ctrlr}", "{ctrl_r}", "{rctrl}", "{r_ctrl}", "{ctrlright}", "{ctrl_right}", "{rightctrl}", "{right_ctrl}" ],
				
				[ Key.ALT,		"alt", "{alt}", "{a}"		],
				
				[ Key.SHIFT,		"shift", "{shift}", "{s}"	],
				[ Key.SHIFT_LEFT,	"shiftl", "shift_l", "lshift", "l_shift", "shiftleft", "shift_left", "leftshift", "left_shift", "{shiftl}", "{shift_l}", "{lshift}", "{l_shift}", "{shiftleft}", "{shift_left}", "{leftshift}", "{left_shift}" ],
				[ Key.SHIFT_RIGHT,	"shiftr", "shift_r", "rshift", "r_shift", "shiftright", "shift_right", "rightshift", "right_shift", "{shiftr}", "{shift_r}", "{rshift}", "{r_shift}", "{shiftright}", "{shift_right}", "{rightshift}", "{right_shift}" ],
				
				[ Key.HOME, 		"home", "{home}" ],
				[ Key.END, 		"end", "{end}" ],
				[ Key.DELETE, 		"delete", "{delete}" ],
				[ Key.INSERT, 		"insert", "{insert}" ],
				[ Key.PAGE_UP, 		"page_up", "{page_up}" ],
				[ Key.PAGE_DOWN, 	"page_down", "{page_down}" ],
				[ Key.TAB, 		"tab", "{tab}" ],
				[ Key.CAPS_LOCK, 	"caps", "{caps}" ],
				[ Key.BACKSPACE, 	"backspace", "{backspace}" ],
				[ Key.PAUSE, 		"pause", "{pause}" ],
				[ Key.BREAK, 		"break", "{break}" ],
				
				[ Key.F1,		"f1", "{f1}" ],
				[ Key.F2,		"f2", "{f2}" ],
				[ Key.F3,		"f3", "{f3}" ],
				[ Key.F4,		"f4", "{f4}" ],
				[ Key.F5,		"f5", "{f5}" ],
				[ Key.F6,		"f6", "{f6}" ],
				[ Key.F7,		"f7", "{f7}" ],
				[ Key.F8,		"f8", "{f8}" ],
				[ Key.F9,		"f9", "{f9}" ],
				[ Key.F10,		"f10", "{f10}" ],
				[ Key.F11,		"f11", "{f11}" ],
				[ Key.F12,		"f12", "{f12}" ]				
			];
			
			//TRACE( 1 )( "start initializing" );
			
			// determine length
			var maxLength:uint = 0;
			
			var STR:Array = [];
			var NUM:Array = [];
			
			for( var i:uint = 0, iL:uint = keys.length; i < iL; ++i ) {
				//TRACE( 2 )( i );
				
				for( var j:uint = 1, jL:uint = keys[ i ].length; j < jL; ++j ) {
					//TRACE( 3 )( keys[ i ][ j ] );
					
					var str:String = keys[ i ][ j ];
					
					if( maxLength < str.length ) {
						maxLength = str.length;
					}
				}
			}
			
			//TRACE( 1 )( "maxLength:", maxLength );
			
			// fill in temporary arrays
			for( i = 1; i <= maxLength; ++i ) {
				//TRACE( 2 )( i );
				STR[ i ] = [];
				NUM[ i ] = [];
			}
			
			for( i = 0, iL = keys.length; i < iL; ++i ) {
				for( j = 1, jL = keys[ i ].length; j < jL; ++j ) {
				
					var str:String = keys[ i ][ j ];
					var strLength:uint = str.length;
				
					STR[ strLength ].push( str );
					NUM[ strLength ].push( keys[ i ][ 0 ] );
				}
			}
			
			for( i = 0; i <= maxLength; ++i ) {
				//TRACE( 2 )( STR[ i ] );
				//TRACE( 2 )( NUM[ i ] );
			}
			
			// copy to permanent arrays
			Keys.strings = STR;
			Keys.numbers = NUM;
		
			Keys.length = maxLength;
		
			initialized = true;
			
			//TRACE()();
		}
		
		public function test(): Boolean {
			throw new Error("test() must be override");
			return false;
		}
	}
}