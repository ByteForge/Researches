package devbrowser {
	
	public class Browser {
		
		/*
		{
			// Static Constructor
		}
		*/
		/*
		public static function get isUnknown(): Boolean {
			return false;
		}
		public static function get isIdentified(): Boolean {
			return false;
		}
		public static function get isInternetExplorer(): Boolean {
			return false;
		}
		public static function get isMozillaFirefox(): Boolean {
			return false;
		}
		public static function get isAppleSafari(): Boolean {
			return false;
		}
		public static function get isGoogleChrome(): Boolean {
			return false;
		}
		public static function get isOpera(): Boolean {
			return false;
		}
		*/
		public static function addCookie( cookie:Object ): void {}
		public static function removeCookie( cookie:Object ): void {}
		public static function hasCookie( cookie:Object ): void {}
		
		public static function numCookies(): uint {
			return 0;
		}
		public static function addCookies( ...parameters ): void {}
		public static function removeCookies( ...parameters ): void {}
		public static function hasCookies( ...parameters ): void {}
		
		public function Browser( userAgentString:String = null ) {
		
		}
		
		// AVAILABLE DIMENSIONS
			public function get width(): uint {
				return 0;
			}
			public function get height(): uint {
				return 0;
			}
		
		// LANGUAGE RELATED
			public function get language(): String { return null; }
		
		// BRAND RELATED		
			public function get isIdentified(): Boolean {
				return false;
			}
			public function get isUnknown(): Boolean {
				return false;
			}
			public function get isOther(): Boolean {
				return false;
			}
			
			public function name(): String {
				return null;
			}
			
			public function get isInternetExplorer(): Boolean {
				return false;
			}
			public function get isMozillaFirefox(): Boolean {
				return false;
			}
			public function get isAppleSafari(): Boolean {
				return false;
			}
			public function get isGoogleChrome(): Boolean {
				return false;
			}
			public function get isOpera(): Boolean {
				return false;
			}
		
		// VERSION RELATED
			public function get version(): String {
				return null;
			}
			public function get majorVersion(): String {
				return "";
			}
			public function get minorVersion(): String {
				return "";
			}
			public function get buildVersion(): String {
				return "";
			}
			public function get revisionVersion(): String {
				return "";
			}
			
			public function get versionSequences(): uint {
				return 0;
			}
			public function get versionType(): Object {
				return 0;
			}
		// ENGINE RELATED
			public function get isGecko(): Boolean {
				return false;
			}
			public function get isWebkit(): Boolean {
				return false;
			}
			public function get isPresto(): Boolean {
				return false;
			}
			public function get isTrident(): Boolean {
				return false;
			}
			public function get isKHTML(): Boolean {
				return false;
			}
	}
}