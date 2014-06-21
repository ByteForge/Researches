package devgauge {
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.utils.getDefinitionByName;
	
	public class Gauge extends Sprite {
		
		private var _style:IGaugeStyle;		
		private var _type:String;
		
		private var _percent:Number;
		private var _value:Number;
		
		private var _bitmapData:BitmapData;
		private var _sprite:Sprite;
		
		private var _gaugeWidth:Number;
		private var _gaugeHeight:Number;
		
		public function Gauge( parameters:Object = null ) {
						
			this._percent = 0;
			this._value = 0;
			this._gaugeWidth = 100;
			this._gaugeHeight = 100;
			
			if( parameters ) {
				var p:Object;
				var q:Object;
				
				if( ( p = parameters.type ) || ( p = parameters.TYPE ) || ( p = parameters.Type ) ) {
					trace( "parameters.type:", p );
					
					this.type = p.toString();
				}
				
				if( ( p = parameters.style ) || ( p = parameters.STYLE ) || ( p = parameters.Style ) ) {
					trace( "parameters.style:", p, p is IGaugeStyle );
					
					//trace( getDefinitionByName( "devgauge.SimpleGauge" ) );
					
					if( p is IGaugeStyle ) {
						this._style = p as IGaugeStyle;
					}
				}
				
				if( ( p = parameters.percent ) || ( p = parameters.PERCENT ) || ( p = parameters.Percent ) ) {
					trace( "parameters.percent:", p );
				}
				
				if( ( p = parameters.value ) || ( p = parameters.VALUE ) || ( p = parameters.Value ) ) {
					trace( "parameters.value:", p );
				}
				
				if( ( p = parameters.gauge ) || ( p = parameters.GAUGE ) || ( p = parameters.Gauge ) ) {
					trace( "parameters.gauge:", p );
					if( ( q = p.width ) || ( q = p.WIDTH ) || ( q = p.Width ) ) {
						trace( "parameters.gauge.width:", q );
					}
					if( ( q = p.height ) || ( q = p.HEIGHT ) || ( q = p.Height ) ) {
						trace( "parameters.gauge.height:", q );
					}
				}
				
				if( ( p = parameters.gaugeWidth ) ) {
					trace( "parameters.gaugeWidth:", p );
				}
				if( ( p = parameters.gaugeHeight ) ) {
					trace( "parameters.gaugeHeight:", p );
				}
			}
		}
		
		public function get style():GaugeStyle {
			return null;
		}
		
		public function set style( value:GaugeStyle ):void {
			//trace( value );
			
			//value.initialize();
			
			//value.
			
			
			//this.addChild( value["bitmap"] );
		}
		
		public function get type():String {
			return this._type;
		}
		
		public function set type( value:String ):void {
			switch( value ) {
				default:
				// FALL THROUGH
				case GaugeType.BITMAP:
					/*
					this._bitmapGauge = new Bitmap( null );
					this._vectorGaugeDial = null;
					this._vectorGaugeNeedle = null;
					*/
					this._type = GaugeType.BITMAP;
					trace( "GaugeType.BITMAP - bitmap" );
					break;
				case GaugeType.VECTOR:
					/*
					this._bitmapGauge = null;
					this._vectorGaugeDial = new Shape();
					this._vectorGaugeNeedle = new Shape();
					*/
					this._type = value;
					trace( "GaugeType.VECTOR - vector" );					
			}
		}
		
		public function get percent():Number {
			return 0;
		};
		
		public function set percent( value:Number ):void {
		
		}
		
		public function get value():Number {
			return 0;
		};
		
		public function set value( value:Number ):void {
			
		}
		
		public function get gaugeWidth():Number {
			return 0;
		}
		
		public function set gaugeWidth( value:Number ):void {
			
		}
		
		public function get gaugeHeight():Number {
			return 0;
		}
		
		public function set gaugeHeight( value:Number ):void {
			
		}
	}
}