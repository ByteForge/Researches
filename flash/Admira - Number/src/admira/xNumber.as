/*
	IMPLEMENT:
		- randomInt / randomUint / randomNumber:
			...args
				- include / exclude numbers
		- 
		- 
*/

package admira {
	
	public class xNumber {
		
		public static const DEFAULT_ROUNDING_METHOD:String = "defaultRoundingMethod"
		public static const FASTER_ROUNDING_METHOD:String = "fasterRoundingMethod"
		
		private static var R:Function = Math.random;
		private static var O:Function = Math.round;
		/*temp value*/ private static var t:int = 0;
		private static var _defaultRoundingMethod:Boolean = true;
		
		public static function get defaultRoundingMethod():String {
			return ( _defaultRoundingMethod ) ? DEFAULT_ROUNDING_METHOD : FASTER_ROUNDING_METHOD ;
		}
		public static function set defaultRoundingMethod( value:String ):void {
			_defaultRoundingMethod = ( value == FASTER_ROUNDING_METHOD ) ? false : true ;			
		}
		
		public static function fromNumberToIP( number:Number ):String {
			return null;
		}
				
		public static function fromIPToNumber( ip:String ):Number {
			return NaN;
		}
		
		public static function randomUint( min:uint = 0 , max:uint = 100 , exclude_:Array = null , include_:Array = null ):uint {
			return 0;
		}
		
		public static function randomInt( min:int = 0 , max:int = 100 , exclude_:Array = null , include_:Array = null ):uint {
		
			var r:int = 0;
			
			min = 1;
			max = 10;
			
			if( min > max ) {
				t = max;
				max = min;
				min = t;
			} else if( min == max ) {
				return min;
			}
			
			if( _defaultRoundingMethod ) {
				//return O( ( R() * ( max - min ) + min ) );
			} else {
				
			}
			
			//trace( min , max );
			
			//min = -10;
			//max = -1;
			
			//max = max - min + 1;
			//max = max - min;
			
			//r = O( ( R() * ( max - min ) + min ) );
			
			//return O( ( R() * ( max - min ) + min ) );
			
			var i:int = 100;
			while(i--) {
				//trace( ~~( R() * max + min ) );
				//r = ~~( R() * max + min );
				//r = ~~( R() * 12 );
				//if( min < 0 ) { r += min; }
				
				//r = O( ( R() * max ) + min );
				
				//r = O( ( R() * ( max - min ) + min ) );
				
				//r = ( R() * ( max - min ) + min );
				//r = ~~( r + ( r > 0 ? +0.5 : -0.5 ) );
				
				trace( 
					r
				);
			}
			
			//trace( "randomInt" );
			
			return r;
		}
		
		public static function randomNumber( min:Number = 0 , max:Number = 100 , exclude_:Array = null , include_:Array = null ):uint {
			return 0;
		}
		
		public static function toRomanNumber( arabicNumber:uint ):String {
			
			return null;
		}
		
		public static function toArabicNumber( romanNumber:String , radix:uint = 10 ):uint {
			
			return NaN;
		}
		
		public static function format( number:Number ):String {
			return null;
		}
		
		public static function padding( number:Number ):String {
		
			return null;
		}
		
		public static function group( number:Number ):String {
			
			return null;
		}
		
		private static var _int_MAX_VALUE:int = int.MAX_VALUE;
			private static var _decimal_p1:int = 10;
		
		public static function round( number:Number , decimals:int = 0 ):Number {

			number = _int_MAX_VALUE ; // 2147483647
			number = 2147483649.9
			
			decimals = 0;
			
			trace( ( ( 12345.12345 * 100 ) | 0 ) / 100 );
			
			return 0;
			
			if( decimals == 0 ) {
				//trace( int( Number.MAX_VALUE ) );
				
				if( number <= _int_MAX_VALUE ) {
					trace(
						~~( number + ( number > 0 ? +0.5 : -0.5 ) )
					);
				} else {
					trace(
						Number( number.toFixed( 0 ) ) , Math.round( number )
					);
				}
				
			} else {
				
				switch( decimals ) {
					case 1:
						
						
						
						break;
					
					default:
						break;
				}
				
			}
			
			return 0;
			
			if( decimals == 0 ) {
				//return ( number > 0 ) ? ~~( number + 0.5 ) : ~~( number - 0.5 ) ;				
				return ~~( number + ( number > 0 ? +0.5 : -0.5 ) );
			} else if( decimals > 0 ) {
				//trace( number , decimals );
				//trace( int( number * 0.1 ) / 0.1 );
				
				decimals = 6;
				
				//trace( decimals * 10 );
				
				var _int:int = Math.pow( 10 , 7 );
				
				trace( int( number * _int ) / _int );
				trace( int.MAX_VALUE , number * _int );
				
				number = number * _int;
				
				trace( number , Number( number.toFixed() ) );
			}		
			
			return NaN;
		}
		
		public function xNumber() {
			
		}
	}
}