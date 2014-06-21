package devkeyboard {	
	
	public class KeyString extends Keys {
		
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
		
		public static function from( parameters:Object ): KeyString {
			return null;
		}
		
		/*
			Overloads:
				empty initialization:
					- new KeyString();
				initialization with string:
					- new KeyString( '{CTRL}+{ALT}+STRING' );
					- new KeyString( '{CTRL}+{ALT}+ "STRING" ' );
					- new KeyString( "{CTRL}+{ALT}+ 'STRING' " );
					- new KeyString( "{CTRL}+{ALT}+[ STRING ] " );
					- new KeyString( "{CTRL}+{ALT}+( STRING ) " );
					- new KeyString( "{CTRL}+{ALT}+< STRING > " );
					- new KeyString( "{CTRL}+{ALT}+<{SPACE}{1,3}> " );
				initialization with object:
					- new KeyString( { key: A } )
		*/
		public function KeyString( parameters:Object = null ) {
			
		}
		
		override public function test(): Boolean {
			return false;
		}
		
		public function get string(): KeyString {
			return null;
		}
		public function set string( keyString:KeyString ): void {
		
		}
		
	}
}