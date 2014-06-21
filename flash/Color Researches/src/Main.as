package {
	import devcolor.RGB;
	
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
			
			//new RGB( 256, 254.5, -1 );
			
			/*
			trace( e );
			trace( new Sprite() );
			trace( new Date() );
			trace( new Number() );
			trace( new RGB( "# F" ) );
			*/
			
			trace(); trace(); trace( "<<< END <<<" );			
			System.exit( 0 );
		}
	}
}