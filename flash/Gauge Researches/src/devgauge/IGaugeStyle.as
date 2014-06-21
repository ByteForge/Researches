package devgauge {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	public interface IGaugeStyle {
		
		function initialize():void;
		function dispose():void;
		
		function get isInitialized():Boolean;
		
		function get percent():Number;
		function set percent( value:Number ):void;
		
		function get value():Number;
		function set value( value:Number ):void;
		
		function get type():String;
		function set type( value:String ):void;
		
		function get width():Number;
		function set width( value:Number ):void;
		
		function get height():Number;
		function set height( value:Number ):void;		
	}
}