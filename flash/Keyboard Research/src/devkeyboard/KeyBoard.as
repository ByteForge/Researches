package devkeyboard {	
	import flash.display.DisplayObject;
	import flash.events.KeyboardEvent;
	
	public class KeyBoard {
		
		{
			// Static Constructor
			
			keys = new Vector.<Keys>( 0, false );
			keysLength = 0;
		}
		
		internal static var keys:Vector.<Keys>;
		internal static var keysLength:uint;
		
		public static function addEventListener( displayObject:Object, listenerFunction:Function ) : void {
		
			( displayObject as DisplayObject ).addEventListener( KeyboardEvent.KEY_UP, listenerFunction );
			( displayObject as DisplayObject ).addEventListener( KeyboardEvent.KEY_DOWN, listenerFunction );
		}
		
		public static function removeEventListeners(): void {}
	}
}