package devbrowser {	
	
	public class OS {
		
		/*
		{
		// Static Constructor
		}
		*/
		public static function get language(): String {
			return "";
		}
		
		public static function get isWindows(): Boolean {
			return false;
		}
			[Inline]
			public static final function get isWIN(): Boolean { return false; }
			
		public static function get isMacintosh(): Boolean {
			return false;
		}
		public static function get isLinux(): Boolean {
			return false;
		}
		public static function get isAndroid(): Boolean {
			return false;
		}
	}
}