package devdate {
	
	public class xTime {
		
		{
			// Static Constructor
			//_staticDate = new Date();
			_staticStarted = false;
			_staticPaused = false;
		}
		
		//private static var _staticDate:Date;
		private static var _staticStartTime:Number;
		private static var _staticEndTime:Number;
		private static var _staticStarted:Boolean;
		private static var _staticPaused:Boolean;
		
		public static function start(): void {
			_staticStarted = true;
			_staticPaused = false;
			
			_staticStartTime = new Date().time;
		}
		public static function pause(): void {
			_staticStarted = false;
			_staticPaused = true;
			
			_staticEndTime = new Date().time;
		}
		public static function reset(): void {
			_staticPaused = false;
			
			_staticStartTime = new Date().time;
		}
		public static function get elapsed(): Number {
			
			if( _staticStarted ) {
				return new Date().time - _staticStartTime;
			} else if( _staticPaused ) {
				return _staticEndTime - _staticStartTime;
			}
						
			return 0;
		}
		
		private static const HOUR: uint = 1;
		private static const MINUTE: uint = 2;
		private static const SECOND: uint = 3;
		
		private var _hour:uint;
		private var _minute:uint;
		private var _second:uint;
		private var _millisecond:uint;
		private var _milliseconds:Number;
		//private var _date:Date;
		private var _startTime:Number;
		private var _endTime:Number;
		private var _started:Boolean;
		private var _paused:Boolean;
				
		/*
			possible initialization:
				- empty: // 0 seconds / 0 milliseconds
					new xTime();
				- custom time string with optional formatting indication:
					new xTime( customTimeString, [ formattingIndication ] );
				- hours, minutes, seconds, milliseconds
					new xTime( hours, minutes, seconds, milliseconds );
		*/
		public function xTime( ...parameters ) {
			
			this._hour = 0;
			this._minute = 0;
			this._second = 0;
			this._millisecond = 0;
			
			this._milliseconds = 0;
			
			//this._date = new Date();
			this._started = false;
			this._paused = false;
			
			var ms:Number;
			var timeUnit:Number;			
			var timeString:String;
			var formatIndicator:String;
			
			if( parameters.length ) {
				if( parameters[ 0 ] is Number ) {
					timeUnit = parameters[ 0 ];
					if( timeUnit !== timeUnit || timeUnit < 0 ) { timeUnit = 0; } else if( timeUnit === Number.POSITIVE_INFINITY ) { timeUnit = Number.MAX_VALUE; }
					_milliseconds = timeUnit * 3600000;
					trace( "hours: ", timeUnit );
										
					if( parameters[ 1 ] is Number ) {
						timeUnit = parameters[ 1 ];
						if( timeUnit !== timeUnit || timeUnit < 0 ) { timeUnit = 0; } else if( timeUnit === Number.POSITIVE_INFINITY ) { timeUnit = Number.MAX_VALUE; }
						_milliseconds += timeUnit * 60000;
						trace( "minutes: ", timeUnit );						
					}
					if( parameters[ 2 ] is Number ) {
						timeUnit = parameters[ 2 ];
						if( timeUnit !== timeUnit || timeUnit < 0 ) { timeUnit = 0; } else if( timeUnit === Number.POSITIVE_INFINITY ) { timeUnit = Number.MAX_VALUE; }
						_milliseconds += timeUnit * 1000;
						trace( "seconds: ", timeUnit );						
					}
					if( parameters[ 3 ] is Number ) {
						timeUnit = parameters[ 3 ];
						if( timeUnit !== timeUnit || timeUnit < 0 ) { timeUnit = 0; } else if( timeUnit === Number.POSITIVE_INFINITY ) { timeUnit = Number.MAX_VALUE; }
						_milliseconds += timeUnit;
						trace( "milliseconds: ", timeUnit );						
					}
					
				} else if( parameters[ 0 ] is String ) {
					timeString = parameters[ 0 ];
					if( timeString ) {
						trace( "timeString: ", timeString );
						
						if( parameters[ 1 ] is String ) {
							formatIndicator = parameters[ 1 ];
							if( formatIndicator ) {
								trace( "formatIndicator:", formatIndicator );
							}
						}
					}			
				}
				
				trace();
				
				if( _milliseconds % 1 > 0 ) { _milliseconds = Math.round( _milliseconds ); }
				if( _milliseconds > 0 ) {
					ms = this._milliseconds;
					
					this._hour = Math.floor( ms / 3600000 );					
					ms -= this._hour * 3600000;
					this._minute = Math.floor( ms / 60000 );
					ms -= this._minute * 60000;
					this._second = Math.floor( ms / 1000 );
					this._millisecond = ms % 1000;
					
					/*
					TRACE( 5 )( this._hour );
					TRACE( 5 )( this._minute );
					TRACE( 5 )( this._second );
					TRACE( 5 )( this._millisecond );
					*/					
				} else {
					_milliseconds = 0;
				}				
			}			
		}
				
		public function get hour(): Number {
			return this._hour;
		}
		public function set hour( value:Number ): void {
			if( value === value && value !== Number.POSITIVE_INFINITY && value !== Number.NEGATIVE_INFINITY ) {
				
				_milliseconds = ( value * 3600000 ) + ( this._minute * 60000 ) + ( this._second * 1000 ) + this._millisecond;
				
				if( _milliseconds % 1 > 0 ) { _milliseconds = Math.round( _milliseconds ); }
				if( _milliseconds > 0 ) {					
					var ms:Number = this._milliseconds;
					
					this._hour = Math.floor( ms / 3600000 );					
					ms -= this._hour * 3600000;
					this._minute = Math.floor( ms / 60000 );
					ms -= this._minute * 60000;
					this._second = Math.floor( ms / 1000 );
					this._millisecond = ms % 1000;					
				} else {
					this._hour = 0;
					this._minute = 0;
					this._second = 0;
					this._millisecond = 0;
				
					this._milliseconds = 0; 
				}
			}			
		}
		public function get minute(): Number {
			return this._minute;
		}
		public function set minute( value:Number ): void {
			if( value === value && value !== Number.POSITIVE_INFINITY && value !== Number.NEGATIVE_INFINITY ) {
				
				_milliseconds = ( this._hour * 3600000 ) + ( value * 60000 ) + ( this._second * 1000 ) + this._millisecond;
				
				if( _milliseconds % 1 > 0 ) { _milliseconds = Math.round( _milliseconds ); }
				if( _milliseconds > 0 ) {					
					var ms:Number = this._milliseconds;
					
					this._hour = Math.floor( ms / 3600000 );					
					ms -= this._hour * 3600000;
					this._minute = Math.floor( ms / 60000 );
					ms -= this._minute * 60000;
					this._second = Math.floor( ms / 1000 );
					this._millisecond = ms % 1000;					
				} else {
					this._hour = 0;
					this._minute = 0;
					this._second = 0;
					this._millisecond = 0;
				
					this._milliseconds = 0; 
				}
			}			
		}
		public function get second(): Number {
			return this._second;
		}
		public function set second( value:Number ): void {
			if( value === value && value !== Number.POSITIVE_INFINITY && value !== Number.NEGATIVE_INFINITY ) {
				
				_milliseconds = ( this._hour * 3600000 ) + ( this._minute * 60000 ) + ( value * 1000 ) + this._millisecond;
				
				if( _milliseconds % 1 > 0 ) { _milliseconds = Math.round( _milliseconds ); }
				if( _milliseconds > 0 ) {					
					var ms:Number = this._milliseconds;
					
					this._hour = Math.floor( ms / 3600000 );					
					ms -= this._hour * 3600000;
					this._minute = Math.floor( ms / 60000 );
					ms -= this._minute * 60000;
					this._second = Math.floor( ms / 1000 );
					this._millisecond = ms % 1000;					
				} else {
					this._hour = 0;
					this._minute = 0;
					this._second = 0;
					this._millisecond = 0;
				
					this._milliseconds = 0; 
				}
			}			
		}
		public function get millisecond(): Number {
			return this._millisecond;
		}
		public function set millisecond( value:Number ): void {
			if( value === value && value !== Number.POSITIVE_INFINITY && value !== Number.NEGATIVE_INFINITY ) {
				
				_milliseconds = ( this._hour * 3600000 ) + ( this._minute * 60000 ) + ( this._second * 1000 ) + value;
				
				if( _milliseconds % 1 > 0 ) { _milliseconds = Math.round( _milliseconds ); }
				if( _milliseconds > 0 ) {					
					var ms:Number = this._milliseconds;
					
					this._hour = Math.floor( ms / 3600000 );					
					ms -= this._hour * 3600000;
					this._minute = Math.floor( ms / 60000 );
					ms -= this._minute * 60000;
					this._second = Math.floor( ms / 1000 );
					this._millisecond = ms % 1000;					
				} else {
					this._hour = 0;
					this._minute = 0;
					this._second = 0;
					this._millisecond = 0;
				
					this._milliseconds = 0; 
				}
			}			
		}
		
		public function get inHours(): Number {
			return this._milliseconds / 3600000;
		}
		public function set inHours( value:Number ): void {
			if( value === value && value !== Number.POSITIVE_INFINITY && value !== Number.NEGATIVE_INFINITY ) {
				
				_milliseconds = value * 3600000;
				
				if( _milliseconds % 1 > 0 ) { _milliseconds = Math.round( _milliseconds ); }
				if( _milliseconds > 0 ) {					
					var ms:Number = this._milliseconds;
					
					this._hour = Math.floor( ms / 3600000 );					
					ms -= this._hour * 3600000;
					this._minute = Math.floor( ms / 60000 );
					ms -= this._minute * 60000;
					this._second = Math.floor( ms / 1000 );
					this._millisecond = ms % 1000;					
				} else {
					this._hour = 0;
					this._minute = 0;
					this._second = 0;
					this._millisecond = 0;
				
					this._milliseconds = 0; 
				}
			}
		}
		
		public function get inMinutes(): Number {
			return this._milliseconds / 60000;
		}
		public function set inMinutes( value:Number ): void {
			if( value === value && value !== Number.POSITIVE_INFINITY && value !== Number.NEGATIVE_INFINITY ) {
				
				_milliseconds = this._hour * 60000 ;
				
				if( _milliseconds % 1 > 0 ) { _milliseconds = Math.round( _milliseconds ); }
				if( _milliseconds > 0 ) {					
					var ms:Number = this._milliseconds;
					
					this._hour = Math.floor( ms / 3600000 );					
					ms -= this._hour * 3600000;
					this._minute = Math.floor( ms / 60000 );
					ms -= this._minute * 60000;
					this._second = Math.floor( ms / 1000 );
					this._millisecond = ms % 1000;					
				} else {
					this._hour = 0;
					this._minute = 0;
					this._second = 0;
					this._millisecond = 0;
				
					this._milliseconds = 0; 
				}
			}
		}
		
		public function get inSeconds(): Number {
			return this._milliseconds / 1000;
		}
		public function set inSeconds( value:Number ): void {
			if( value === value && value !== Number.POSITIVE_INFINITY && value !== Number.NEGATIVE_INFINITY ) {
				
				_milliseconds = value * 1000;
				
				if( _milliseconds % 1 > 0 ) { _milliseconds = Math.round( _milliseconds ); }
				if( _milliseconds > 0 ) {					
					var ms:Number = this._milliseconds;
					
					this._hour = Math.floor( ms / 3600000 );					
					ms -= this._hour * 3600000;
					this._minute = Math.floor( ms / 60000 );
					ms -= this._minute * 60000;
					this._second = Math.floor( ms / 1000 );
					this._millisecond = ms % 1000;					
				} else {
					this._hour = 0;
					this._minute = 0;
					this._second = 0;
					this._millisecond = 0;
				
					this._milliseconds = 0; 
				}
			}
		}
		
		public function get inMilliseconds(): Number {
			return this._milliseconds;
		}
		public function set inMilliseconds( value:Number ): void {
			if( value === value && value !== Number.POSITIVE_INFINITY && value !== Number.NEGATIVE_INFINITY ) {
				
				_milliseconds = value;
				
				if( _milliseconds % 1 > 0 ) { _milliseconds = Math.round( _milliseconds ); }
				if( _milliseconds > 0 ) {					
					var ms:Number = this._milliseconds;
					
					this._hour = Math.floor( ms / 3600000 );					
					ms -= this._hour * 3600000;
					this._minute = Math.floor( ms / 60000 );
					ms -= this._minute * 60000;
					this._second = Math.floor( ms / 1000 );
					this._millisecond = ms % 1000;					
				} else {
					this._hour = 0;
					this._minute = 0;
					this._second = 0;
					this._millisecond = 0;
				
					this._milliseconds = 0; 
				}
			}
		}
		
		public function adjust( ...parameters ): void {}
		
		// TimeFormat
		public function get format(): Object { return null; }
		public function set format( value:Object ): void {
		
			if( value ) {
				if( value is String && value.length > 0 ) {
				
					var string:String = value as String;
				
					string = "h:m:s";
					//string = "d.h:m:s-h";
				
					TRACE( 1 )( string );
					
					var forList:Array = [];
					var forListLength:uint = 0;
					
					var i:uint = 0;
					var L:uint = 0;
					var a:Vector.<int> = null; // vector of elements
					var e:int = 0; // current element
				
					a = new Vector.<int>( string.length );
				
					for( i = 0, L = string.length; i < L; ++i ) {
						a[ i ]	= string.charCodeAt( i );
					}
					
					TRACE( 1 )( a );
				}
			}
		}
		
		public function get formatted(): String {
			return "";
		}
		
		public function start(): void {
			this._started = true;
			this._paused = false;
			
			this._startTime = new Date().time;
		}
		public function pause(): void {
			this._started = false;
			this._paused = true;
			
			this._endTime = new Date().time;
		}
		public function reset(): void {
			this._paused = false;
			
			this._startTime = new Date().time;
		}
		public function get elapsed(): Number {
			
			if( this._started ) {
				return new Date().time - this._startTime;
			} else if( this._paused ) {
				return this._endTime - this._startTime;
			}
						
			return 0;
		}
		
		public function toString( format:Object = null ): String {
			/*
			return "H: " + ( _milliseconds / 60 / 60 * 0.001 ) + 
				" M: " + ( _milliseconds / 60 * 0.001 ) + 
				" S: " + ( _milliseconds * 0.001 ) + 
				" MS: " + ( _milliseconds ) +
				" total MS: " + _milliseconds;
			*/
			return "xTime Object";
		}
	}
}