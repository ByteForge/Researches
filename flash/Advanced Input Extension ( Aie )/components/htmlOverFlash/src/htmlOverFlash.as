package {
	import flash.display.Sprite;
	import flash.events.Event;

	[SWF(width="500", height="500", backgroundColor="#00FF00", framerate="30")]
	public class htmlOverFlash extends Sprite {
		public function htmlOverFlash() {
			this.addEventListener(Event.ADDED_TO_STAGE , onADDED_TO_STAGE);
		}		
		private function onADDED_TO_STAGE(e:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE , onADDED_TO_STAGE);
			
			//trace('hello you!');
		}
	}
}