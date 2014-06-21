package {
	import admira.xDate;
	import admira.xTime;
	
	import flash.display.Sprite;
	import flash.events.Event;

	[SWF(width="600", height="600", backgroundColor="#FFFFFF", frameRate="30")]
	public class Main extends Sprite {
		public function Main() {
			this.addEventListener(Event.ADDED_TO_STAGE , onADDED_TO_STAGE);
		}		
		private function onADDED_TO_STAGE(e:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE , onADDED_TO_STAGE);
			
			//var d:xDate = new xDate();
			
			var t:xTime = new xTime();
			
			//t.$()
		}
	}
}