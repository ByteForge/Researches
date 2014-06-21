package {
	import devstring.StringManager;
	import devstring.xString;
	
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
			
			//trace( xString( "a" ) ):
			
			//trace( Boolean( -1 ) );
			
			//xString.isBoolean();
			
			//TRACE( 1 )( xString.asHex( "" ) );
			//TRACE( 1 )( xString.asBinary( "0b 1001" ) );
			
			//TRACE( 1 )( xString.asRadix( " 07 _ 8 " ) );
			
			//xString.isBinary();
			
			//xString.isASCII();
			
			//xString.isNumber( "" );
			//TRACE( 1 )( xString.isInteger( " 10 " ) );
			
			var str:StringManager = new StringManager( "test string" );
			
			trace(); trace(); trace( "<<< END <<<" );			
			System.exit( 0 );
		}
	}
}