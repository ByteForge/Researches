package {
	import clockdev.Clock;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.system.System;
	import flash.utils.Timer;

	[SWF(width="600", height="600", backgroundColor="#FFFFFF", frameRate="30")]
	public class Main extends Sprite {
		public function Main() {
			this.addEventListener( Event.ADDED_TO_STAGE, listenerADDED_TO_STAGE );
		}		
		private function listenerADDED_TO_STAGE( e:Event ):void {
			this.removeEventListener( Event.ADDED_TO_STAGE, listenerADDED_TO_STAGE );
			
			trace( ">>> START >>>" ); trace(); trace();
			
			var clock:Clock = new Clock();
			clock._stage = this.stage;
			
			clock.second = 50;
			clock.minute = 59;
			clock.hour = 23;
			
			clock.traceTime();			
			clock.drawClock();
			
			/*
			clock.second = 59;			
			clock.traceTime();			
			clock.drawClock();
			*/
			
			//clock.minute = 60;
			//clock.traceTime();
			
			var timer:Timer = new Timer( 1000 );
			timer.addEventListener( TimerEvent.TIMER, function():void {
				clock.second++;
				clock.tickMechanism();
							
				clock.traceTime();			
				clock.drawClock();		
			} )
			timer.start();
			
			trace(); trace(); trace( "<<< END <<<" );			
			//System.exit( 0 );
		}
	}
}