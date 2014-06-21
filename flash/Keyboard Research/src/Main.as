package {
	//import devkeyboard.Key;
	//import devkeyboard.KeyCombination;
	//import devkeyboard.KeyGroup;
	import devkeyboard.Key;
	import devkeyboard.KeyBoard;
	import devkeyboard.KeyCombination;
	import devkeyboard.KeyMode;
	import devkeyboard.KeyString;
	import devkeyboard.Keys;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.system.Capabilities;
	import flash.system.System;
	import flash.ui.KeyLocation;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	[SWF(width="200", height="600", backgroundColor="#FFFFFF", frameRate="30")]
	public class Main extends Sprite {
		public function Main() {
			this.addEventListener( Event.ADDED_TO_STAGE, listenerADDED_TO_STAGE );
		}	
		
		//private var forward:Key = new Key( "{UP}" );
		
		private function listenerADDED_TO_STAGE( evt:Event ):void {
			this.removeEventListener( Event.ADDED_TO_STAGE, listenerADDED_TO_STAGE );
			/*
			this.stage.addEventListener( KeyboardEvent.KEY_UP, listenerKEY );
			this.stage.addEventListener( KeyboardEvent.KEY_DOWN, listenerKEY );
			*/
			trace( ">>> START >>>" ); trace(); trace();
		
			/*
				key 0x01  ||  character 0x00
			*/
		
			var signs: uint = 0;
			
			TRACE( 1 )( signs.toString( 2 ) );
			
			signs |= 0x0001;
			TRACE( 1 )( signs.toString( 2 ) );
			
			signs |= 0x0004;
			TRACE( 1 )( signs.toString( 2 ) );
					
			//new Key();
			//new Key( "up" );
			//new Key( "{ENTER}" );
			//new Key( "SPACE" );
			//new Key( "{E}" );
						
			//var a:Key = new Key();
			//var b:Key = new Key( "CTRL" );
			//var c:Key = new Key( "{ctrl}" );
			//var d:Key = new Key( "{e}" );
			//var e:Key = new Key( "{spc}" );
			
			//new Key( "ctrll" );
			//new Key( "ctrl_l" );
			//new Key( "ctrlleft" );
			//new Key( "ctrl_left" );
			//new Key( "{ctrll}" );
			//new Key( "{ctrl_l}" );
			//new Key( "{ctrlleft}" );
			//new Key( "{ctrl_left}" );
			
			//Keys.initialize();
			
			//new Key();
			
			//new KeyCombination( { CTRL: true, alt: false, Shift: true, Key: "{SPACE}" } );
			
			//KeyBoard.addEventListener( this.stage, listenerKEY );
			
			//new Key( "CTRL" );
						
			/*			
			new Key( "" );
			new Key( "x" );
			new Key( "{CTRL}" );
			new Key( "X", KeyMode.KEY );
			new Key( "X", KeyMode.CHARACTER );
			new Key( Key.NUMBER_2 );
			
			new Key( { ch: "Q" } );
			new Key( { k: "U" }, KeyMode.CHARACTER );
			*/
			
			trace(); trace(); trace( "<<< END <<<" );			
			System.exit( 0 );
		}
		private function listenerKEY( e:KeyboardEvent ): void {
			//trace( e.type );
			/*
			trace( ( ( e.type === KeyboardEvent.KEY_UP ) ? "up" : "down" ),
				"charCode:", e.charCode, " keyCode:", e.keyCode, " keyLocation:", e.keyLocation, " ctrl:", e.ctrlKey, " shift:", e.shiftKey );
			*/
			//trace( Capabilities.language );
			
			//TRACE()( "charCode:", e.charCode, " keyCode:", e.keyCode, " keyLocation:", e.keyLocation, " ctrl:", e.ctrlKey, " shift:", e.shiftKey, ( ( e.type === KeyboardEvent.KEY_UP ) ? "up" : "down" ) );
			
			var charCode:uint = e.charCode;
			var character:String = String.fromCharCode( charCode );
			var keyCode:uint = e.keyCode;
			
			var keyLocation:uint = e.keyLocation;
			var keyPlace:String;
			switch( keyLocation ) {
				case KeyLocation.STANDARD:
					keyPlace = "STANDARD";
					break;
				case KeyLocation.LEFT:
					keyPlace = "LEFT";
					break;
				case KeyLocation.RIGHT:
					keyPlace = "RIGHT";
					break;
				case KeyLocation.NUM_PAD:
					keyPlace = "NUM PAD";
					break;
				default:
					keyPlace = "STANDARD";
					break;
			}
			
			var type:String = ( e.type === KeyboardEvent.KEY_UP ) ? "UP" : "DOWN";
			var shift:Boolean = e.shiftKey;
			var ctrl:Boolean = e.ctrlKey;
			
			TRACE( 0 )( "charCode: [" + charCode + "]", "character: [" + character + "]" );
			TRACE( 1 )( "keyCode: [" +keyCode+ "]", "keyPlace: [" +keyPlace+ "]" );
			TRACE( 2 )( "type: [" +type+ "]", "shift: [" +shift+ "]", "ctrl: [" +ctrl+ "]" );
			
			/*
			keys.listen( e );
			if( forward.isDown ) {
			
			} else if( jump.isPressed ) {
			
			} else if( Key.isDownOn( "ENTER", keys / event ) ) {
			
			}
			keys.ignore();
			*/
		}
	}
}