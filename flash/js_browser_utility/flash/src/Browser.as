/*
implement:
	- get given url source
	- instancing	
*/

package {
	import flash.external.ExternalInterface;
	
	public class Browser {
		
		public static const UTILITY_EDITION:String = 'max';
			// min , med , max
		public static const UTILITY_VERSION:String = '0.9.123';		
		
		public static const UNKNOWN:int = -1;
		public static const OTHER:int = 0;
		
		public static const OS_WIN:Number = 2;
		public static const OS_MAC:Number = 3;
		public static const OS_UNIX:Number = 4;
		public static const OS_LINUX:Number = 5;
		
		// MINIMUM -->
		public static const INTERNET_EXPLORER:int = 1001;
			public static function get isInternetExplorer():Boolean { return ( type == INTERNET_EXPLORER ) ? true : false ; }
		public static const MOZILLA_FIREFOX:int = 1002;
			public static function get isMozillaFirefox():Boolean { return ( type == MOZILLA_FIREFOX ) ? true : false ; }
		public static const CHROME:int = 1003;
			public static function get isChrome():Boolean { return ( type == CHROME ) ? true : false ; }
		public static const SAFARI:int = 1004;
			public static function get isSafari():Boolean { return ( type == SAFARI ) ? true : false ; }
		public static const OPERA:int = 1005;
			public static function get isOpera():Boolean { return ( type == OPERA ) ? true : false ; }
		// MINIMUM <--
		// MEDIUM -->
		public static const MAXTHON:int = 1006;
			public static function get isMaxthon():Boolean { return ( type == MAXTHON ) ? true : false ; }
		public static const K_MELEON:int = 1007;			
			public static function get isK_Meleon():Boolean { return ( type == K_MELEON ) ? true : false ; }
		public static const FLOCK:int = 1008;
			public static function get isFlock():Boolean { return ( type == FLOCK ) ? true : false ; }
		public static const AVANT_BROWSER:int = 1009;
		public static const SLEIPNIR:int = 1010;
		public static const SLIMBROWSER:int = 1011;
		public static const GREENBROWSER:int = 1012;
		public static const DEEPNET_EXPLORER:int = 1013;
		public static const SEAMONKEY:int = 1014;
		public static const PHASEOUT:int = 1015;
		public static const CAMINO:int = 1016;		
		// MEDIUM <--
		// MAXIMUM -->
		// MAXIMUM <--		
		
		private static var browserList:Array = [
			INTERNET_EXPLORER ,
			MOZILLA_FIREFOX ,
			CHROME ,
			SAFARI ,
			OPERA ,
			MAXTHON ,
			K_MELEON ,
			FLOCK
		]
			
		private static var ua:String = null;
		private static var vs:String = null;
		private static var bt:int = -1;
		private static var ar:Array = null;
		private static var rs:String = null;
		
		public static function get isEIA():Boolean { return ExternalInterface.available; }
			
		/*		
		public static function alert( ...arg ):void {
			if( ExternalInterface.available ) {
				var r:String = '';
				var i:int = 0;
				var L:int = arg.length;
				for( i = 0 ; i < L ; i++ ) {
					r += String( arg[i] );
					if( i+1 < L ) { r += ' , '; }
				}
				ExternalInterface.call('alert("'+r+'")');
			}
		}
		
		public static function eval( string:String ):void {
			if( ExternalInterface.available ) {
				ExternalInterface.call('eval("'+string+'")');
			}
		}
		*/
		
		// BROWSER RELATED PROPERTIES / METHODS
		public static function get type():int { 
			if( isEIA ) {
				ua = navigator.userAgent.toLowerCase();				
				if( ua.indexOf( 'maxthon' ) != -1 ) {
					return MAXTHON;
				}				
				if( ua.indexOf( 'k-meleon' ) != -1 ) {
					return K_MELEON;
				}
				//if( contains( ua , 'flock' ) ) {
				if( ua.indexOf( 'flock' ) != -1 ) {
					return FLOCK;
				}
				//if( contains( ua , 'msie' ) ) {
				if( ua.indexOf( 'msie' ) != -1 ) {
					return INTERNET_EXPLORER;
				}				
				//if( contains( ua , 'firefox' ) ) {
				if( ua.indexOf( 'firefox' ) != -1 ) {
					return MOZILLA_FIREFOX;
				}				
				//if( contains( ua , 'chrome' ) && contains( ua , 'safari' ) ) {
				if( ua.indexOf( 'chrome' ) != -1 && ua.indexOf( 'safari' ) != -1 ) {
					return CHROME;
				}
				//if( !contains( ua , 'chrome' ) && contains( ua , 'safari' ) ) {
				if( ua.indexOf( 'chrome' ) == -1 && ua.indexOf( 'safari' ) != -1 ) {
					return SAFARI;
				}
				//if( contains( ua , 'opera' ) ) {
				if( ua.indexOf( 'opera' ) != -1 ) {
					return OPERA;
				}				
			}				
			return UNKNOWN;
		}
		//public static function get typeString():String { return null; }
		//FUTURE WORK public static function get layoutEngine():Number { return 0; }
		//zoom detection
		public static function get versionString():String { 
			if( !isEIA ) { return null; }
			ua = navigator.userAgent.toLowerCase();
			if( ua == null ) { return null; }
			bt = type;
			if( bt == MAXTHON ) {
				//return ua.match( new RegExp( '(?<=maxthon[ /])([^ ;\s]+)' , 'gi' ) )[0];
				return ua.match( new RegExp( '(?<=maxthon[ /])([^ ;\s]+)' , 'i' ) )[0];
			}
			if( bt == K_MELEON ) {				
				//return ua.match( new RegExp( '(?<=k-meleon[ /])([^ ;\s]+)' , 'gi' ) )[0];
				return ua.match( new RegExp( '(?<=k-meleon[ /])([^ ;\s]+)' , 'i' ) )[0];
			}
			if( bt == FLOCK ) {
				//return ua.match( new RegExp( '(?<=flock[ /])([^ ;\s]+)' , 'gi' ) )[0];
				return ua.match( new RegExp( '(?<=flock[ /])([^ ;\s]+)' , 'i' ) )[0];
			}
			if( bt == INTERNET_EXPLORER ) {
				//return ua.match( new RegExp( '(?<=msie[ /])([^ ;\s\)\(]+)' , 'gi' ) )[0];
				return ua.match( new RegExp( '(?<=msie[ /])([^ ;\s\)\(]+)' , 'i' ) )[0];
			}				
			if( bt == MOZILLA_FIREFOX ) {
				//return ua.match( new RegExp( '(?<=firefox[ /])([^ ;\s\)\(]+)' , 'gi' ) )[0];
				return ua.match( new RegExp( '(?<=firefox[ /])([^ ;\s\)\(]+)' , 'i' ) )[0];
			}
			if( bt == CHROME ) {
				//return ua.match( new RegExp( '(?<=chrome[ /])([^ ;\s\)\(]+)' , 'gi' ) )[0];
				return ua.match( new RegExp( '(?<=chrome[ /])([^ ;\s\)\(]+)' , 'i' ) )[0];
			}
			if( bt == SAFARI ) {
				//return ua.match( new RegExp( '(?<=version[ /])([^ ;\s\)\(]+)' , 'gi' ) )[0];
				return ua.match( new RegExp( '(?<=version[ /])([^ ;\s\)\(]+)' , 'i' ) )[0];
			}
			if( bt == OPERA ) {
				//rs = ua.match( new RegExp( '(?<=version[ /])([^ ;\s\)\(]*)' , 'gi' ) )[0];
				rs = ua.match( new RegExp( '(?<=version[ /])([^ ;\s\)\(]*)' , 'i' ) )[0];
				//if( rs == null ) { rs = ua.match( new RegExp( '(?<=opera[ /])([^ ;\s\)\(]*)' , 'gi' ) )[0]; }
				if( rs == null ) { rs = ua.match( new RegExp( '(?<=opera[ /])([^ ;\s\)\(]*)' , 'i' ) )[0]; }
				return rs;
			}
			return null;			
		}
		public static function get versionMajor():String {
			vs = versionString; if( vs == null ) { return null; }
			bt = type;
			if( browserList.indexOf( bt ) != -1 ) {
				ar = vs.split('.',1);
				return ( ar[0] != undefined ) ? ar[0] : null ;
			}
			return null;				
		}
		public static function get versionMinor():String {
			vs = versionString; if( vs == null ) { return null; }
			bt = type;
			if( browserList.indexOf( bt ) != -1 ) {
				ar = vs.split('.',2);
				return ( ar[1] != undefined ) ? ar[1] : null ;
			}
			return null;						
		}
		public static function get versionBuild():String {
			vs = versionString;
			if( vs == null ) { return null; }
			bt = type;
			if( browserList.indexOf( bt ) != -1 ) {
				ar = vs.split('.',3);
				return ( ar[2] != undefined ) ? ar[2] : null ;
			}
			return null;					
		}
		public static function get versionRest():String {
			vs = versionString; if( vs == null ) { return null; }
			bt = type;
			if( browserList.indexOf( bt ) != -1 ) {
				return split( vs , 2 );
			}
			return null;			
		}
			//more to come...
	
		// COOKIE RELATED PROPERTIES / METHODS
		public static function get isCookiesEnabled():Boolean { return navigator.cookieEnabled; }
		public static function hasCookie( name:String ):Boolean { return false; }
		public static function addCookie( name:String , value:String , params:Object = null ):void { }
		public static function getCookie( name:String ):String { return null; }
		public static function removeCookie( name:String ):void { }
			public static function get numCookies():Number { return 0; }
			public static function hasCookies():Boolean { return false; }
			public static function getCookies():Array { return null; }
			public static function removeCookies():void { }
		
		private static var _os:OS = null;
		public static function get os():OS {
			if( _os != null ) { return _os; } else { _os = new OS(); return _os; }
		}
		
		private static var _window:WINDOW = null;
		public static function get window():WINDOW {
			if( _window != null ) { return _window; } else { _window = new WINDOW(); return _window; }
		}		
		
		private static var _navigator:NAVIGATOR = null;
		public static function get navigator():NAVIGATOR {
			if( _navigator != null ) { return _navigator; } else { _navigator = new NAVIGATOR(); return _navigator; }
		}

		private static var _screen:SCREEN = null;
		public static function get screen():SCREEN {
			if( _screen != null ) { return _screen; } else { _screen = new SCREEN(); return _screen; }
		}
		
		private static var _history:HISTORY = null;
		public static function get history():HISTORY {
			if( _history != null ) { return _history; } else { _history = new HISTORY(); return _history; }
		}
		
		private static var _location:LOCATION = null;
		public static function get location():LOCATION {
			if( _location != null ) { return _location; } else { _location = new LOCATION(); return _location; }
		}
		
		private static function replace( s:String , a:String , b:String ):String { return s.split(a).join(b); }
		/*private static function contains( source:String , what:String ):Boolean {
			return ( source.indexOf(what) != -1 ) ? true : false ;
		}*/	
		private static function split( src:String , offset:int = 0 ):String {
			if( src != null ) {
				if( offset == 0 ) {
					if( src.indexOf( '.' ) != -1 ) {
						return src.substr( src.indexOf( '.' )+1 );
					} 
				} else {
					var b:int = src.indexOf( '.' );
					while ( offset-- ) {
						b = src.indexOf( '.' , b+1 );
						if( b == -1 ) { break; }							
					}
					return ( b != -1 ) ? src.substr( b+1 ) : null ;
				}
			}
			return null;
		}
	}
}
	import flash.external.ExternalInterface;

	internal class JS {
		public static var B:String = '(function(){return ';
		public static var E:String = ';})';
		public static var WIN:String = B+'window.';		
		public static var NAV:String = B+'navigator.';		
		public static var SCR:String = B+'screen.';		
		public static var HIS:String = B+'history.';		
		public static var LOC:String = B+'location.';
	}

	internal class OS {
		public function get type():Number { return 0; }
		public function get typeString():String { return null; }
		public function get isWin():Boolean { return false; }
		public function get isMac():Boolean { return false; }
		public function get isUnix():Boolean { return false; }
		public function get isLinux():Boolean { return false; }
		
	}

	internal class WINDOW {
		public function get closed():Boolean {
			if( Browser.isEIA ) {
				return Boolean(ExternalInterface.call(JS.WIN+'closed'+JS.E));
			} else { return false; }
		}
	}

	internal class NAVIGATOR {
		public function get appCodeName():String {			
			if( Browser.isEIA ) {
				return String(ExternalInterface.call(JS.NAV+'appCodeName'+JS.E));
			} else { return null; }
		}
		public function get appName():String {
			if( Browser.isEIA ) {
				return String(ExternalInterface.call(JS.NAV+'appName'+JS.E));
			} else { return null; }
		}
		public function get appVersion():String {
			if( Browser.isEIA ) {
				return String(ExternalInterface.call(JS.NAV+'appVersion'+JS.E));
			} else { return null; }
		}
		public function get cookieEnabled():Boolean {
			if( Browser.isEIA ) {
				return Boolean(ExternalInterface.call(JS.NAV+'cookieEnabled'+JS.E));
			} else { return false; }
		}
		public function get platform():String {
			if( Browser.isEIA ) {
				return String(ExternalInterface.call(JS.NAV+'platform'+JS.E));
			} else { return null; }
		}
		public function get userAgent():String {
			if( Browser.isEIA ) {
				//return String(ExternalInterface.call(JS.NAV+'userAgent'+JS.E));
				//return 'Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US) AppleWebKit/533.1 (KHTML, like Gecko) Maxthon/3.0.8.2 Safari/533.1';
				//return 'Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/4.0; WOW64; Trident/5.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; Zune 4.0; InfoPath.3; MS-RTC LM 8; .NET4.0C; .NET4.0E; Maxthon 2.0)';
				//return 'Mozilla/5.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0; Maxthon; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729; .NET CLR 3.0.04320)';
				
				//return 'Mozilla/5.0 (Windows; U; Windows NT 5.1; pl-PL; rv:1.8.1.24pre) Gecko/20100228 K-Meleon/1.5.4';
				//return 'ozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.2b) Gecko/20021016 K-Meleon 0.7';
				//return 'Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.1.14) Gecko/20080406 K-Meleon/1.5.0b2 b2';
				
				//return 'Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_6; en-US) AppleWebKit/534.7 (KHTML, like Gecko) Flock/3.5.3.4628 Chrome/7.0.517.450 Safari/534.7';
				
				return 'Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8.0.4) Gecko/20060612 Firefox/1.5.0.4 Flock/0.7.0.17.1';
			} else { return null; }
		}
		public function javaEnabled():Boolean {
			if( Browser.isEIA ) {
				return Boolean(ExternalInterface.call(JS.NAV+'javaEnabled()'+JS.E));
			} else { return false; }
		}
		public function taintEnabled():Boolean {
			if( Browser.isEIA ) {
				return Boolean(ExternalInterface.call(JS.NAV+'taintEnabled()'+JS.E));
			} else { return false; }
		}
	}

	internal class SCREEN {
		public function get width():Number {
			if( Browser.isEIA ) {
				return Number(ExternalInterface.call(JS.SCR+'width'+JS.E));
			} else { return 0; }
		}
		public function get height():Number {
			if( Browser.isEIA ) {
				return Number(ExternalInterface.call(JS.SCR+'height'+JS.E));				
			} else { return 0; }
		}
		public function get availWidth():Number {
			if( Browser.isEIA ) {
				return Number(ExternalInterface.call(JS.SCR+'availWidth'+JS.E));
			} else { return 0; }
		}
		public function get availHeight():Number {
			if( Browser.isEIA ) {
				return Number(ExternalInterface.call(JS.SCR+'availHeight'+JS.E));
			} else { return 0; }
		}
		public function get pixelDepth():Number {
			if( Browser.isEIA ) {
				return Number(ExternalInterface.call(JS.SCR+'pixelDepth'+JS.E));
			} else { return 0; }
		}
		public function get colorDepth():Number {
			if( Browser.isEIA ) {
				return Number(ExternalInterface.call(JS.SCR+'colorDepth'+JS.E));
			} else { return 0; }
		}
	}

	internal class HISTORY {
		public function get length():Number {
			if( Browser.isEIA ) {
				return Number(ExternalInterface.call(JS.HIS+'length'+JS.E));
			} else { return 0; }
		}
		public function back():void {
			if( Browser.isEIA ) {
				ExternalInterface.call(JS.HIS+'back()'+JS.E);
			}
		}
		public function forward():void {
			if( Browser.isEIA ) {
				ExternalInterface.call(JS.HIS+'forward()'+JS.E);
			}
		}
		public function go( ...arg ):void {
			if( Browser.isEIA ) {
				//ExternalInterface.call('(function(){return history.forward();})');
				//FUTURE WORK
			}
		}
	}

	internal class LOCATION {
		public function get hash():String {
			if( Browser.isEIA ) {
				return String(ExternalInterface.call(JS.LOC+'hash'+JS.E));
			} else { return null; }
		}
		public function get host():String {
			if( Browser.isEIA ) {
				return String(ExternalInterface.call(JS.LOC+'host'+JS.E));
			} else { return null; }
		}
		public function get hostname():String {
			if( Browser.isEIA ) {
				return String(ExternalInterface.call(JS.LOC+'hostname'+JS.E));
			} else { return null; }
		}
		public function get href():String {
			if( Browser.isEIA ) {
				return String(ExternalInterface.call(JS.LOC+'href'+JS.E));
			} else { return null; }
		}
		public function get pathname():String {
			if( Browser.isEIA ) {
				return String(ExternalInterface.call(JS.LOC+'pathname'+JS.E));
			} else { return null; }
		}
		public function get port():String {
			if( Browser.isEIA ) {
				return String(ExternalInterface.call(JS.LOC+'port'+JS.E));
			} else { return null; }
		}
		public function get protocol():String {
			if( Browser.isEIA ) {
				return String(ExternalInterface.call(JS.LOC+'protocol'+JS.E));
			} else { return null; }
		}
		public function get search():String {
			if( Browser.isEIA ) {
				return String(ExternalInterface.call(JS.LOC+'search'+JS.E));
			} else { return null; }
		}
		public function assign( url:String ):void {
			if( Browser.isEIA ) {
				//ExternalInterface.call('(function(){return location.assign();})');
				//FUTURE WORK
			}
		}
		public function reload():void {
			if( Browser.isEIA ) {
				ExternalInterface.call(JS.LOC+'reload()'+JS.E);
			}
		}
		public function replace( url:String ):void {
			if( Browser.isEIA ) {
				//ExternalInterface.call('(function(){return location.assign();})');
				//FUTURE WORK
			}
		}
	}

	internal class ic_INTERNET_EXPLORER {
		public function is4():Boolean { return false; }
		public function is5():Boolean { return false; }
		public function is55():Boolean { return false; }
		public function is6():Boolean { return false; }
		public function is7():Boolean { return false; }
		public function is8():Boolean { return false; }
		public function is9():Boolean { return false; }
	}

	internal class ic_MOZILLA_FIREFOX {
		public function is1():Boolean { return false; }
		public function is2():Boolean { return false; }
		public function is3():Boolean { return false; }
		public function is35():Boolean { return false; }
	}

	internal class ic_GOOGLE_CHROME {		
	}
	
	internal class ic_SAFARI {		
	}
	
	internal class ic_OPERA {		
	}
