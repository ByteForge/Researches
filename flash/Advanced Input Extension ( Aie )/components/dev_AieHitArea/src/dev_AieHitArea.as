package {
	import com.kingforge.aie.AieHitArea;
	import com.kingforge.aie.AieMouse;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.flash_proxy;

	[SWF(width="600", height="600", backgroundColor="#FFFFFF", framerate="30")]
	public class dev_AieHitArea extends Sprite {
		public function dev_AieHitArea() {
			this.addEventListener(Event.ADDED_TO_STAGE , onADDED_TO_STAGE);
		}		
		private function onADDED_TO_STAGE(e:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE , onADDED_TO_STAGE);
			
			//trace('hi');
			this.stage.frameRate = 1;
			
			_dev_AieMouse();
			_dev_AieHitArea();
		}
		
		private function _dev_AieMouse():void {
			
			AieMouse.init({ stage:this.stage , parent:this });
				//AieMouse.nativeVisible = true;
			
		}
		
		private function _dev_AieHitArea():void {
			
			AieHitArea.init({ stage:this.stage });
			
			var hitArea1:AieHitArea = new AieHitArea();
				hitArea1.name = 'hitArea1';			
				hitArea1.x = 25;
				hitArea1.y = 25;
				hitArea1.width = 100;
				hitArea1.height = 100;			
			this.addChild( hitArea1 );
			
			var hitArea2:AieHitArea = new AieHitArea();
				hitArea2.name = 'hitArea2';			
				hitArea2.x = 125;
				hitArea2.y = 25;
				hitArea2.width = 100;
				hitArea2.height = 100;			
			this.addChild( hitArea2 );
			
			var shape1:Shape = new Shape();
				shape1.graphics.beginFill(0xFF0000,0.5);
				shape1.graphics.drawRect(0,0,100,100);
				shape1.graphics.endFill();
				shape1.x = 25;
				shape1.y = 250;
			this.addChild(shape1);
		}
	}
}