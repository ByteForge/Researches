package devstring {	
	import flash.utils.ByteArray;
	
	public class xString {
		
		/*
		{
		// Static Constructor
		}
		*/
		
		public static const WHITESPACE:uint = 1;
			public static const BACKSPACE:uint = 8;
			public static const TAB:uint = 9;
			public static const LINE_FEED:uint = 10;
			public static const NEW_FEED:uint = 10;
			public static const CARRIAGE_RETURN:uint = 13;
			public static const RETURN:uint = 13;
			public static const SPACE:uint = 32;
		
		/*
			remove:
				- accents / diacritics
				- trim / trimLeft / trimRight
		*/
		public static function remove( string:String, what:Object ): String {
			return null;
		}
		
		public static function contains( string:String, what:String, caseSensitive:Boolean = true ): Boolean {
			if( caseSensitive ) {
				return string.indexOf( what ) > -1;
			} else {
				return string.toLowerCase().indexOf( what.toLowerCase() ) > -1;
			}
		}
		public static function presenceOf( string:String, what:Object ): uint {
			
			return 0;
		}
		
		public static function reverse( string:String ): String {
			return string.split( "" ).reverse().join( "" );
		}
		
		// public static function cut
		public static function length( string:String, newLength:Number ): String {
			
			return string.split( "", newLength ).join( "" );
		}
		
		public static function select(): void {}
		
		/*
			move( begin, end, whereToMove )
			move( StringSelection, whereToMove )
		*/
		public static function move(): void {}
		
		/*
			insert( what, where )
		*/
		public static function insert(): void {}
		
		public static function align(): void {}
		
		// CONTAINING FUNCTIONS
			public static function hasUNICODE(): Boolean { return false; }
		
		// DETERMINE FUNCTIONS
			public static function isEmpty( string:String ): Boolean {
				return string.length === 0;
			}
			public static function isBlank( string:String ): Boolean {
				
				var pattern:RegExp = /^\s*$/ig;
				
				return pattern.test( string );
			}
			
			public static function isA( string:String, ...rest ): Boolean {
				return false;
			}
			
			public static function isBoolean(): Boolean { 
				
				//var string:String = " t ";
				var string:String = " 0x0 ";
				
				var pattern:RegExp = /^\s*((true|t)|(false|f))\s*$/i;
				
				var match:Object = pattern.exec( string );
				
				TRACE( 1 )( match );
				trace();
				
				if( match ) {
					/*
					if( match[ 2 ] ) {
						TRACE( 2 )( "true" );
					} else if( match[ 3 ] ) {
						TRACE( 2 )( "false" );
					}
					*/
					return ( match[ 2 ] ) ? true : false ;
				} else {
					/*
					var n:Number = parseInt( string );
					TRACE( 2 )(
						( n !== 0 ) ? true : false
					);
					*/
					return ( parseInt( string ) !== 0 ) ? true : false ;
				}				
				//return false; 
			}
			
			public static function isASCII( string:String ): Boolean {
			
				var pattern:RegExp = /^[\x00-\xFF]*$/;
				
				return pattern.test( string );
			}
			public static function isASCII7( string:String ): Boolean {
				
				var pattern:RegExp = /^[\x00-\x80]*$/;
				
				return pattern.test( string );
			}
			public static function isASCII8( string:String ): Boolean {
				return isASCII( string );
			}
			public static function isUNICODE( string:String ):Boolean {
				return !isASCII( string );
			}
			
			public static function isInteger( string:String ): Boolean {				
				if( parseFloat( string.split( " " ).join( "" ).split( "," ).join( "." ) ) % 1 === 0 ) {
					return true;
				}
				return false;	
			}
			
			public static function isNumber( string:String ): Boolean {
			
				string = " 1.1e30 ";
			
				//string = string.split( " " ).join( "" );
				
				//var number:Number = parseFloat( string );
				var number:Number = parseFloat( string.split( " " ).join( "" ).split( "," ).join( "." ) );
				
				//TRACE( 1 )( number );
			
				if( number === number && number !== Number.POSITIVE_INFINITY && number !== Number.NEGATIVE_INFINITY ) {
					//TRACE( 2 )( "valid number:", number );
					
					return true;
				}
				return false;
			}
			
			public static function isHex( string:String ): Boolean {
				
				var pattern:RegExp = /^\s*(|0x|#|h)[0-9a-f\s]*h?\s*$/i;
				
				return pattern.test( string );
			}
			public static function isBinary( string:String ): Boolean {
			
				var pattern:RegExp = /^\s*b?[01\s]*b?\s*$/i;
				
				return pattern.test( string );
			}
			
			// IMPROVE LOCALIZATION
			public static function isUpperCase( string:String ): Boolean { 
				return string.toUpperCase() === string;
			}
			// IMPROVE LOCALIZATION
			public static function isLowerCase( string:String ): Boolean {
				return string.toLowerCase() === string;
			}
			// IMPROVE LOCALIZATION
			public static function isMixedCase( string:String ): Boolean {
				return string.toLowerCase() !== string && string.toUpperCase() !== string;
			}
			
		// PARSE FUNCTIONS
			public static function asBoolean(): Boolean { return false; }
			
			public static function asUnsignedInt(): uint { return 0; }
			public static function asInt(): int { return 0; }
			public static function asNumber(): Number { return 0; }
			
			public static function asHex( string:String, exceptionCases:uint = 0 ): Number {
				
				var pattern:RegExp = /0x|h|#|\s/ig;
				
				return parseInt( string.replace( pattern, "" ), 16 );
			}
			public static function asOctal( string:String ): Number {
				
				var pattern:RegExp = /\s/ig;
				
				return parseInt( string.replace( pattern, "" ), 8 );
			}
			public static function asBinary( string:String ): Number {
				
				var pattern:RegExp = /0b|b|\s/ig;
				
				return parseInt( string.replace( pattern, "" ), 2 );
			}
			public static function asRadix( string:String ): Number {
			
				//string = " 12345_10 ";
			
				var pattern:RegExp = /0b|b|0x|h|#|\s/ig;
				var n:Number = 0;
				
				string = string.replace( pattern, "" );
				var p:int = string.indexOf( "_" );
				
				if( p > -1 ) {
					/*
					var numberString:String = string.substring( 0, p );
					var radixString:String = string.substr( p + 1 );
					TRACE( 1 )( numberString );
					TRACE( 1 )( radixString );
					*/
					
					var radix:uint = parseInt( string.substr( p + 1 ), 10 );
					if( radix > 1 && radix <= 36 ) {
						return parseInt( string.substring( 0, p ), radix );
					}
				}
				// ExceptionCase
				return 0;
			}
	}
}