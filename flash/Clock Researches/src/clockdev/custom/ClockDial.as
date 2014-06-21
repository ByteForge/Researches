package clockdev.custom {	
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	public class ClockDial {
		
		private var _bitmapData:BitmapData;
		private var _width:Number;
		private var _heigh:Number;
		private var _centerX:Number;
		private var _centerY:Number;
				
		public function ClockDial() {
			
		}
		
		public function get bitmapData(): BitmapData {
			return this.bitmapData;
		}
		public function set bitmapData( value:BitmapData ): void {
			
		}
		
		public function get width(): Number { return 0; }
		public function set width( value:Number ): void {}
		
		public function get height(): Number { return 0; }
		public function set height( value:Number ): void {}
		
		public function get centerX(): Number { return 0; }
		public function set centerX( value:Number ): void {}
		
		public function get centerY(): Number { return 0; }
		public function set centerY( value:Number ): void {}
		
		public function get center(): Point { return null; }
		public function set center( value:Point ): void {}		
	}
}