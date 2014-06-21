package devgauge {
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	public class GaugeStyle {
		
		static protected const BITMAP_MODE:uint = 0x01;
		static protected const COMBINED_MODE:uint = 0x02;
		static protected const VECTOR_MODE:uint = 0x04;
		
		public var sprite:Sprite;
		public var bitmapData:BitmapData;
		
		protected var _isInitialized:Boolean;
		
		protected var _mode:uint;
		
		protected var _percent:Number;
		protected var _value:Number;
		
		protected var _gaugeWidth:Number;
		protected var _gaugeHeight:Number;
		
		public function GaugeStyle() {
			
			this._isInitialized = false;
			
			this.sprite = null;
			this.bitmapData = null;
			
			this._mode = 0;
			
			this._percent = 0;
			this._value = 0;
						
			this._gaugeWidth = 100;
			this._gaugeHeight = 100;
		}
		
		public function initialize():void {};
		public function dispose():void {};
		
		public function get isInitialized():Boolean { return false; };
		
		public function get percent():Number { return NaN };
		public function set percent( value:Number ):void {};
		
		public function get value():Number { return NaN };
		public function set value( value:Number ):void {};
		
		public function get mode():String { 
			switch( this._mode ) {
				case BITMAP_MODE:
					return GaugeStyleMode.BITMAP;
				case COMBINED_MODE:
					return GaugeStyleMode.COMBINED;
				case VECTOR_MODE:
					return GaugeStyleMode.VECTOR;
			}
			return "IMPLEMENT LATER";
		};
		public function set mode( value:String ):void {
			switch( value ) {
				default:
					// FALL THROUGH
				case GaugeStyleMode.BITMAP:
					this._mode = BITMAP_MODE;
					break;
				case GaugeStyleMode.COMBINED:
					this._mode = COMBINED_MODE;
					break;
				case GaugeStyleMode.VECTOR:
					this._mode = VECTOR_MODE;
					break;
			}
		};
		
		public function get width():Number { return NaN };
		public function set width( value:Number ):void {};
		
		public function get height():Number { return NaN; };
		public function set height( value:Number ):void {};
	}
}