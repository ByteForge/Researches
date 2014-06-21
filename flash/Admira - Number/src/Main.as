package {
	import flash.display.Sprite;
	import flash.events.Event;
	import admira.xNumber;

	[SWF(width="600", height="600", backgroundColor="#FFFFFF", frameRate="30")]
	public class Main extends Sprite {
		public function Main() {
			this.addEventListener(Event.ADDED_TO_STAGE , onADDED_TO_STAGE);
		}		
		private function onADDED_TO_STAGE(e:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE , onADDED_TO_STAGE);
		
			xNumber.randomInt();
			
			return;
			
			xNumber.round( 12345.123456789 , 1 );
			
			return;
			
			var a:Number = 10.5;
			var b:Number = -2.25;
			var c:Number = 246.687945;
			
			trace( Math.round( a ) );
			trace( Math.round( b ) );
			trace( Math.round( c ) );
			
			trace( "" );
			
			//trace( ~~( a + 0.5 ) );
			//trace( ~~( b - 0.5 ) );
			//trace( ~~( c + 0.5 ) );
			
			trace( ( 0.5 + a ) | 0 );
			trace( ( 0.5 - b ) | 0 );
			trace( ( 0.5 + c ) | 0 );
			
			//trace( xNumber.round( a ) );
			//trace( xNumber.round( b ) );
			//trace( xNumber.round( c ) );
		}
	}
}