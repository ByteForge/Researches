package {
	import devdate.xDate;
	import devdate.xTime;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.System;

	[SWF(width="600", height="600", backgroundColor="#FFFFFF", frameRate="30")]
	public class Main extends Sprite {
		public function Main() {
			this.addEventListener( Event.ADDED_TO_STAGE, listenerADDED_TO_STAGE );
		}		
		private function listenerADDED_TO_STAGE( e:Event ):void {
			this.removeEventListener( Event.ADDED_TO_STAGE, listenerADDED_TO_STAGE );
			
			trace( ">>> START >>>" ); trace(); trace();
			
			//var d:xDate = new xDate();
			
			//trace( d.year );
			//d.dayOfYear;
			//d.weekOfYear;
			
			//trace( d.daysInMonth );
			//trace( d.century );
			//trace( "decade:", d.decade );
			
			//d.leapYear = true;
			
			/*
			var d:Date = new Date( 0 );
						
			trace( "Local:", d, d.timezoneOffset, " time:", ( d.time + ( -1 * d.timezoneOffset * 60 * 1000 ) ) );
			trace( "......" );
			trace( "UTC:", d.toUTCString(), " time:", d.time );
			*/
			
			//var t:xTime = new xTime();
			
			//++t.time;
			//t.time = "++";
			
			//var t:xTime = new xTime( 1, 2, 3, 4 );
			//trace( t );
			
			//var t:xTime = new xTime( 1, 59, 59, 1000 );
			/*
			var t:xTime = new xTime( 1.5, 30, 3, 4 );
			trace( t.inHours );
			trace( t.inMinutes );
			trace( t.inSeconds );
			trace( t.inMilliseconds );
			
			//t.hour = 10;
			//t.minute = 20;
			//t.second = 30.1;
			
			trace( "\t\t hour: ", t.hour );
			trace( "\t\t min:  ", t.minute );
			trace( "\t\t sec:  ", t.second );
			trace( "\t\t ms:   ", t.millisecond );
			trace();
			
			TRACE( 5 )( ( 168 * 54 ) * 3600000 );
			*/
			
			var t:xTime = new xTime();
			
			t.hour = 1;
			t.minute = 2;
			t.second = 3;
			
			t.format = "h:m:s";
			
			/*
			t.hour = 1;
			t.hour++;
			t.hour++;
			*/
			
			/*
			t.minute = 59;			
			t.minute++;
			t.minute++;
			t.minute++;
					
			TRACE( 1 )( "inHours:", t.inHours );
			TRACE( 1 )( "inMinutes:", t.inMinutes );
			trace();
						
			TRACE( 2 )( "h:", t.hour );
			TRACE( 2 )( "m:", t.minute );
			TRACE( 2 )( "s:", t.second );
			TRACE( 2 )( "ms:", t.millisecond );
			*/
			
			/*
			var h:Number = 2.00000019999999;
			
			var n:Number = h;
			var r:Number;
			
			r = n % 1;
			n = int( n );
						
			trace( "hours:" );
			trace( "\twhole part: " + n + ", fractional part: " + r );
			
			if( r > 0.000001 ) {
				trace( "\t\t\t" + r + " next level" );
			}
			
			n = r * 60;
			r = n % 1;
			n = int( n );
			
			trace( "minutes:" );
			trace( "\twhole part: " + n + ", fractional part: " + r );
			
			if( r > 0.000001 ) {
				trace( "\t\t\t" + r + " next level" );
			}
			
			n = r * 60;
			r = n % 1;
			n = int( n );
			
			trace( "seconds:" );
			trace( "\twhole part: " + n + ", fractional part: " + r );
			
			if( r > 0.001 ) {
				trace( "\t\t\t" + r + " next level" );
			}
			
			n = r * 1000;
			r = n % 1;
			n = int( n );
			
			trace( "milliseconds:" );
			trace( "\twhole part: " + n + ", fractional part: " + r );
			trace( "\twhole part: " + n + ", fractional part: " + Math.round( r ) );
			
			*/
								
			trace(); trace(); trace( "<<< END <<<" );			
			System.exit( 0 );
		}
	}
}