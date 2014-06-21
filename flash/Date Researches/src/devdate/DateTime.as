package devdate {	
	
	public class DateTime {
		
		/*
		{
		// Static Constructor
		}
		*/
		
		public static const UTC:String = "UTC";
		
		private var _year:Number;
		private var _month:Number;
		private var _day:Number;
		private var _hour:Number;
		private var _minute:Number;
		private var _second:Number;
		private var _millisecond:Number;
		private var _timezone:Number; // offset in minutes
		
		/*
			instantiations:
				- empty:
					set to right now local time
				- ( UTCIndicatorObject )
					set to right now UTC time
				- ( year, month, day, hour, minute, second, millisecond, timezone )
				- ( "dateTimeString", dateTimeFormatIndicationObject, timeZoneObject )
		*/
		public function DateTime( ...parameters ) {
			
			if( parameters.length > 0 ) {
			
			} else {
			
				var d:Date = new Date();
				
				this._year = d.fullYear;
				this._month = d.month + 1;
				this._day = d.date;
				this._hour = d.hours;
				this._minute = d.minutes;
				this._second = d.seconds;
				this._millisecond = d.milliseconds;
				this._timezone = d.timezoneOffset;
			}
		}
		
		public function get year(): Number { return 0; }
		public function get month(): Number { return 0; }
		public function get day(): Number { return 0; }
		public function get hour(): Number { return 0; }
		public function get minute(): Number { return 0; }
		public function get second(): Number { return 0; }
		public function get millisecond(): Number { return 0; }
		public function get timezone(): Number { return 0; }
		
		public function adjust( ...parameters ): void {}
	}
}