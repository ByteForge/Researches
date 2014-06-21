package clockdev {	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	public class ClockStyle {
		
		protected var mode: uint;
		protected var bitmap: BitmapData;
		protected var vector: Sprite;
		
		protected var _name: String = null;
		
		public function ClockStyle() {
			
		}
		
		public function get name(): String {
			return null;
		}
		
		protected function initialize(): void {}
		protected function dispose(): void {}
		protected function update() : void {}
	}
}