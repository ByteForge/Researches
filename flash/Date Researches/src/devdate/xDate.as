package devdate {
	import flash.crypto.generateRandomBytes;
	import flash.utils.ByteArray;
	
	public class xDate {
		
		{
			//trace( "Static Constructor / Static Initializer" );
			
			private static var byteArray:ByteArray = generateRandomBytes( 4 + 8 );
			trace( byteArray );
			trace( byteArray.length );
			//trace( byteArray.readUnsignedInt() );
			trace( byteArray.readFloat() );			
		}
		
		public static const NOT_EQUAL:uint = 0;
		public static const EQUAL:uint = 1;
		public static const FIRST_GREATER:uint = 2;
		public static const FIRST_SMALLER:uint = 3;
		public static const SECOND_GREATER:uint = 3;
		public static const SECOND_SMALLER:uint = 2;
		
		public static function equal( ...parameters ): Boolean {
			return false;
		}
		
		public static function compare( a:Object, b:Object ): uint {
			return 0;
		}
		
		public static function randomRange( min:Object = null, max:Object = null ): void {
		}
		
		public static function fromRoman( romanDate:String ): void {
			
			romanDate = "MCMXCIX";
			
			var s:String = romanDate;
			
			var i:uint = 0;
			var L:uint = 0;
			var _result:uint = 0;
			var _this:uint = 0;
			var _last:uint = 0;
			
			for( i = 0, L = s.length; i < L; ++i ) {
				var c:String = s.charAt( i );
				
				switch( c ) {
					case 'M': _this = 1000; break;
					case 'D': _this = 500; break;
					case 'C': _this = 100; break;
					case 'L': _this = 50; break; 
					case 'X': _this = 10; break;
					case 'V': _this = 5; break;
					case 'I': _this = 1; break;
					default:
						trace( "unknown roman letter:", c );
						break;
				}
				
				_result += _this;
				if( _this > _last ) {
					_result -= 2 * _last;
				}
				_last = _this;
			}
			
			trace( "fromRoman( " + romanDate + " ) result:", _result );
		}
		
		private var _date:Date;
		
		private var _year:int;
		private var _month:uint;
		private var _day:uint;
		private var _hours:uint;
		private var _minutes:uint;
		private var _seconds:uint;
		private var _milliseconds:uint;
		private var _timezone:int; // in minutes
		
		/*
			possible initializations:
				- empty: / default, local time /
					- new xDate( timezone );
				- 1 -> 7 Numbers, Timezone:
					- new xDate( year, month, day, hours, minutes, seconds, milliseconds, timezone );
				- 1 or 2 parameters:
					- new xDate( dateInString, formatOptions, timezone );
				- Date object:
					- new xDate( Date object, timezone );
				- Unix Timestamp:
					- new xDate( unixTimestamp, timezone );
		*/
		public function xDate( ...parameters ) {
		
			return;
		
			var y_ms:Number = 365 * 24 * 60 * 60 * 1000;
			var ly_ms:Number = 366 * 24 * 60 * 60 * 1000;
		
			// unix epoch: 1970.01.01 00:00:00
			var date:Date = new Date( 2012, 0, 2, 1, 0, 0, 0 );
			trace( date.toUTCString() , date.time );
			trace();
			
			//trace( 365 * 24 * 60 * 60 * 1000 );
			
			//var y:int = u / ( 365 * 24 * 60 * 60 * 1000 );
			//trace( y );
			
			var y:int = 2012;
			var m:uint = 1;
			var d:uint = 2;
			var leap:Boolean = ( ( i % 400 === 0 || ( i % 100 !== 0 && i % 4 === 0 ) ) === false ) ? false : true ;
			
			var time:Number = 0;
			
			var i:uint;
			var L:uint;
			
			// add years
			for( i = 1970, L = y; i < L; ++i ) {
				//trace( i );
				if( ( i % 400 === 0 || ( i % 100 !== 0 && i % 4 === 0 ) ) === false ) {
					time += y_ms;					
				} else {
					time += ly_ms;					
				}				
			}
			// add months
			switch( m ) {
				case 12: // NOVEMBER passed, we're in DECEMBER
					time += 334 * 24 * 60 * 60 * 1000; break;
				case 11: // OCTOBER passed, we're in NOVEMBER
					time += 304 * 24 * 60 * 60 * 1000; break;
				case 10: // SEPTEMBER passed, we're in OCTOBER
					time += 273 * 24 * 60 * 60 * 1000; break;
				case 9: // august passed
					time += 243 * 24 * 60 * 60 * 1000; break;
				case 8: // july passed
					time += 212 * 24 * 60 * 60 * 1000; break;
				case 7: // june passed
					time += 181 * 24 * 60 * 60 * 1000; break;
				case 5: // may passed
					time += 151 * 24 * 60 * 60 * 1000; break;
				case 5: // april passed
					time += 120 * 24 * 60 * 60 * 1000; break;
				case 4: // march passed
					time += 90 * 24 * 60 * 60 * 1000; break;
				case 3: // february passed
					time += ( ( !leap ) ? 59 : 60 )
						* 24 * 60 * 60 * 1000; break;
				case 2: // january passed
					time += 31 * 24 * 60 * 60 * 1000; break;
				default:
					break;
			}
			// add days
			time += ( d - 1 ) * 24 * 60 * 60 * 1000;
			
			trace();
			trace( date.time );
			trace( time );
		}
		
		public function adjust( ...parameters ): void {}
		
		public function get year(): uint { 
			return this._date.fullYear;
		}
		public function get month(): uint {
			return this._date.month;
		}
		public function get day(): uint {
			return this._date.date;
		}
		public function get hour(): uint {
			return this._date.hours;
		}
		public function get minutes(): uint {
			return this._date.minutes;
		}
		public function get seconds(): uint {
			return this._date.seconds;
		}
		public function get milliseconds(): uint {
			return this._date.milliseconds;
		}
		public function get timezone(): uint {
			return 0;
		}
		public function set timezone( value:uint ): void {			
		}
		
		public function get dayOfYear(): uint {
			
			var y:Number = this._date.fullYear;
			var m:Number = this._date.month + 1;
			var doty:uint = 0;
			
			switch( m ) {
				case 12: // november passed
					doty = 334; break;
				case 11: // october passed
					doty = 304; break;
				case 10: // september passed
					doty = 273; break;
				case 9: // august passed
					doty = 243; break;
				case 8: // july passed
					doty = 212; break;
				case 7: // june passed
					doty = 181; break;
				case 5: // may passed
					doty = 151; break;
				case 5: // april passed
					doty = 120; break;
				case 4: // march passed
					doty = 90; break;
				case 3: // february passed
					doty = 59; break;
				case 2: // january passed
					doty = 31; break;
				default:
					break;
			}
			
			if( m > 2 && ( y % 400 === 0 || ( y % 100 !== 0 && y % 4 === 0 ) ) ) {
				//trace( "leap year and month > 2" );
				++doty;
			}
			
			doty += this._date.date;
			
			//trace( doty );
			
			return doty;
		}
		public function get weekOfYear(): uint {
			
			var y:Number = this._date.fullYear;
			var m:Number = this._date.month + 1;
			var doty:uint = 0;
			var woty:uint = 0;
			
			switch( m ) {
				case 12: // november passed
					doty = 334; break;
				case 11: // october passed
					doty = 304; break;
				case 10: // september passed
					doty = 273; break;
				case 9: // august passed
					doty = 243; break;
				case 8: // july passed
					doty = 212; break;
				case 7: // june passed
					doty = 181; break;
				case 5: // may passed
					doty = 151; break;
				case 5: // april passed
					doty = 120; break;
				case 4: // march passed
					doty = 90; break;
				case 3: // february passed
					doty = 59; break;
				case 2: // january passed
					doty = 31; break;
				default:
					break;
			}
			
			if( m > 2 && ( y % 400 === 0 || ( y % 100 !== 0 && y % 4 === 0 ) ) ) {
				//trace( "leap year and month > 2" );
				++doty;
			}
			
			doty += this._date.date;
			woty = Math.ceil( doty / 7 );
			
			//trace( woty );
			
			return woty;
		}
		
		public function get leapDay(): Boolean {
			var y:Number = this._date.fullYear;
			if( y % 400 === 0 || ( y % 100 !== 0 && y % 4 === 0 ) ) {
				// year is leap year
				return ( this._date.month === 1 && this._date.date === 29 ) ? true : false ;
			}
			return false;
		}
		
		public function get leapYear(): Boolean {
			var y:Number = this._date.fullYear;
			return ( y % 400 === 0 || ( y % 100 !== 0 && y % 4 === 0 ) ) ? true : false ;
		}
		// FURTHER TESTS NEEDED
		public function set leapYear( value:Boolean ): void {
			//var y:Number = this._date.fullYear;
			var y:Number = 1799;
			if( y % 400 === 0 || ( y % 100 !== 0 && y % 4 === 0 ) ) {
				trace( y + " is already a leap year" );
			} else {
				trace( y + " is not a leap year" );
				trace( "y % 400", y % 400 );
				trace( "y % 100", y % 100 );
				trace( "y % 4", y % 4 );
				trace( "next POSSIBLE leap year is:", y + ( 4 - ( y % 4 ) ) );
				for(;;) {
					y = y + ( 4 - ( y % 4 ) );
					if( y % 400 === 0 || ( y % 100 !== 0 && y % 4 === 0 ) ) {
						break;
					} else {
						++y;
					}
				}
				trace( "next TRUE leap year is:", y );
			}
		}
		
		public function get lastLeapYear(): uint {
			return 0;
		}
		public function get nextLeapYear(): uint {
			return 0;
		}
		
		public function get daysInMonth(): uint {
			var y:Number = this._date.fullYear;
			var m:Number = this._date.month + 1;
			var dim:uint = 0;
			switch( m ) {
				case 12: // december
					dim = 31; break;
				case 11: // november
					dim = 30; break;
				case 10: // october
					dim = 31; break;
				case 9: // september
					dim = 30; break;
				case 8: // august
					dim = 31; break;
				case 7: // july
					dim = 31; break;
				case 6: // june
					dim = 30; break;
				case 5: // may
					dim = 31; break;
				case 4: // april
					dim = 30; break;
				case 3: // march
					dim = 31; break;
				case 2: // february
					dim = ( y % 400 === 0 || ( y % 100 !== 0 && y % 4 === 0 ) ) ? 29 : 28 ;
					break;
				case 1: // january
					dim = 31; break;
				default:
					break;
			}
			return dim;
		}
		
		public function get daysInYear(): uint {
			var y:Number = this._date.fullYear;
			return ( y % 400 === 0 || ( y % 100 !== 0 && y % 4 === 0 ) ) ? 366 : 365 ;
		}
		
		public function get century(): uint {
			var y:Number = this._date.fullYear;
			return uint( ( y - 1 ) * 0.01 ) + 1;
		}
		
		public function get decade(): uint {
			var y:Number = this._date.fullYear;
			return uint( y * 0.1 ) * 10;
		}
		
		public function $( ...parameters ): void {}
		
		public function plus( parameter:Object ): void {}
		public function add( parameter:Object ): void {}
		
		public function minus( parameter:Object ): void {}
		public function subtract( parameter:Object ): void {}
		
		public function adjust( ...parameters ): void {}
				
		public function toRoman(): void {
		
			var date:uint = 1999;
			var originalDate:uint = date;
		
			var roman:String = "";
			
			if( date >= 3000 ) {
				roman += "MMM";
				date -= 3000;
			} else if( date >= 2000 ) {
				roman += "MM";
				date -= 2000;
			} else if( date >= 1000 ) {
				roman += "M";
				date -= 1000;
			}
			
			if( date >= 900 ) {
				roman += "CM";
				date -= 900;
			} else if( date >= 800 ) {
				roman += "DCCC";
				date -= 800;
			} else if( date >= 700 ) {
				roman += "DCC";
				date -= 700;
			} else if( date >= 600 ) {
				roman += "DC";
				date -= 600;
			} else if( date >= 500 ) {
				roman += "D";
				date -= 500;
			} else if( date >= 400 ) {
				roman += "CD";
				date -= 400;
			} else if( date >= 300 ) {
				roman += "CCC";
				date -= 300;
			} else if( date >= 200 ) {
				roman += "CC";
				date -= 200;
			} else if( date >= 100 ) {
				roman += "C";
				date -= 100;
			}
			
			if( date >= 90 ) {
				roman += "XC";
				date -= 90;
			} else if( date >= 80 ) {
				roman += "LXXX";
				date -= 80;
			} else if( date >= 70 ) {
				roman += "LXX";
				date -= 70;
			} else if( date >= 60 ) {
				roman += "LX";
				date -= 60;
			} else if( date >= 50 ) {
				roman += "L";
				date -= 50;
			} else if( date >= 40 ) {
				roman += "XL";
				date -= 40;
			} else if( date >= 30 ) {
				roman += "XXX";
				date -= 30;
			} else if( date >= 20 ) {
				roman += "XX";
				date -= 20;
			} else if( date >= 10 ) {
				roman += "X";
				date -= 10;
			}
		
			if( date >= 9 ) {
				roman += "IX";
				date -= 9;
			} else if( date >= 8 ) {
				roman += "VIII";
				date -= 8;
			} else if( date >= 7 ) {
				roman += "VII";
				date -= 7;
			} else if( date >= 6 ) {
				roman += "VI";
				date -= 6;
			} else if( date >= 5 ) {
				roman += "V";
				date -= 5;
			} else if( date >= 4 ) {
				roman += "IV";
				date -= 4;
			} else if( date >= 3 ) {
				roman += "III";
				date -= 3;
			} else if( date >= 2 ) {
				roman += "II";
				date -= 2;
			} else if( date >= 1 ) {
				roman += "I";
				date -= 1;
			}
		
			trace( "toRoman( " + originalDate + " ) result:", roman );
		}
	}
}