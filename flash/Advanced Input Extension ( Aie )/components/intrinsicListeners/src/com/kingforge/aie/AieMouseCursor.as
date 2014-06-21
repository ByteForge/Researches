package com.kingforge.aie {
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	public class AieMouseCursor {
		
		public static const ARROW:int = 1;
		public static const AUTO:int = 2;
		public static const BUTTON:int = 3;
		public static const HAND:int = 4;
		public static const IBEAM:int = 5;
		
		private var _isDisposed:Boolean = false;
		private var _name:String = null;
		private var _data:Vector.<BitmapData> = null;
		private var _frameRate:Number = 1;
		private var _hotSpot:Point = null;
		
		public function AieMouseCursor( name:String = null , data:Object = null , frameRate:Number = 1 , hotSpot:Point = null ) {
			this._name = 'randomGeneratedName' ;
			this._data = null // MouseCursorData , MovieClip , Sprite , Bitmap , BitmapData , Shape
			this._frameRate = 1;
			this._hotSpot = ( hotSpot != null ) ? hotSpot : new Point(0,0) ;
		}
		
		public function get name():String { return this._name; }
		public function set name( value:String ):void { this._name = value; }
		
		public function get data():Vector.<BitmapData> { return this._data; }
		public function set data( value:Vector.<BitmapData> ):void { this._data = value; }
		
		public function get frameRate():Number { return this._frameRate; }
		public function set frameRate( value:Number ):void { this._frameRate = value; }
		
		public function get hotSpot():Point { return this._hotSpot; }
		public function set hotSpot( value:Point ):void { this._hotSpot = value; }
		
		public function get isDisposed():Boolean { return this._isDisposed; }
		
		public function dispose():void {}
		
		public function toString():String { return '[object AieMouseCursor]'; }
	}
}