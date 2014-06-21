/*
implement:
	units:
		- AieMouse unit
		- AieMouseSimulation unit
		
	1 Bitmap/Sprite for the FalseCursor
	DOC options:
		-attach DOC to the AieMouse
		-AieMouse internal DOC
	managing options:
		- lock properties
		- alwaysOnTop
		- getDisplayObjectContainer
		.bitmap / .sprite
*/

package com.kingforge.aie {
	import flash.display.DisplayObjectContainer;
	
	public class AieMouse {
		
			private static var _isInitialized:Boolean = false;
			public static function get isInitialized():Boolean { return _isInitialized; }
		public static function init( params:Object = null ):void {
			_isInitialized = true;
		}
		public static function uninit():void {
			if( _isInitialized ) {  }
			_isInitialized = false;
		}
			private static var _enabled:Boolean = false;
		public static function get enabled():Boolean { return _enabled; }
		public static function set enabled( value:Boolean ):void { _enabled = value; }
		
			private static var _eventMode:int = AieMouseEventMode.NATIVE;
		public static function get eventMode():Number { return _eventMode; }
		public static function set eventMode( value:Number ):void { _eventMode = value; }
		
			private static var _cycleMode:int = AieMouseCycleMode.TIME;
		public static function get cycleMode():Number { return _cycleMode; }
		public static function set cycleMode( value:Number ):void { _cycleMode = value; }
		
			private static var _aieContainer:DisplayObjectContainer = null;
		public static function get container():DisplayObjectContainer { return _aieContainer; }
		public static function set container( value:DisplayObjectContainer ):void {}	
		
//***************************************************************************************
		
		private static var _nativeMouseIsNull:Boolean = true;
		private static var _nativeMouse:NativeMouse = null;
		public static function get nativeMouse():NativeMouse {
			if( _nativeMouseIsNull ) {
				_nativeMouse = new NativeMouse();
				_nativeMouseIsNull = false;
			}
			return _nativeMouse;
			//NativeMouse._cursors;
		}
		
		private static var _falseMouseIsNull:Boolean = true;
		private static var _falseMouse:FalseMouse = null;
		public static function get falseMouse():FalseMouse {
			if( _falseMouseIsNull ) {
				_falseMouse = new FalseMouse();
				_falseMouseIsNull = false;
			}
			return _falseMouse;			
		}
	}
}
	import com.kingforge.aie.AieMouse;
	import com.kingforge.aie.AieMouseCursor;
	
	import flash.geom.Point;
	import flash.sampler.NewObjectSample;

	internal class NativeMouse {
		//public var x:Number = 10;
		//public static var y:Number = 10;
		
		public function get x():Number { return 0; }
		public function get y():Number { return 0; }
		
		public function show():void {}
		public function hide():void {}
		
		public function get cursor():Object { return null; }
		public function set cursor( value:Object ):void {}		
		public function get supportsCursor():Boolean { return true; }
		public function get supportsNativeCursor():Boolean { return true; }
				
		public static var _cursors:Vector.<AieMouseCursor> = null;
		
		public function removeCursors():void {
			if( _cursors != null && _cursors.length > 0 ) {
				var i:int = _cursors.length;
				while(i--) {
					_cursors[i].dispose();
					_cursors[i] = null;
				}
				_cursors = null;
			}
			_cursors = null;
			
			// check current cursor / delete current cursorm
		}
		public function getCursors():Vector.<AieMouseCursor> { 
			return _cursors;
		}
		public function getCursorsAsArray():Array {
			if( _cursors != null && _cursors.length > 0 ) {
				var i:int = 0;
				var L:int = _cursors.length;
				var r:Array = new Array(L);
				for( i = 0 ; i < L ; i++ ) {
					r[i] = _cursors[i];
				}
				return r;
			} else {
				return null;
			}
		}
		public function get numCursors():int { 
			if( _cursors != null && _cursors.length > 0 ) {
				return _cursors.length;
			} else {
				return 0;
			}
		}
		
		public function hasCursor( name:String ):Boolean { 
			if( _cursors != null && _cursors.length > 0 ) {
				var i:int = _cursors.length
				while(i--) {
					if( _cursors[i].name == name ) {
						return true;
					}				
				}
				return false;
			} else {
				return false;
			}
		}
		public function addCursor( name:String , object:Object , frameRate:Number = 1 , hotSpot:Point = null ):void {
			if( _cursors != null && _cursors.length > 0 ) {
				var cur:AieMouseCursor = new AieMouseCursor( name , object , frameRate , hotSpot );
				var i:int = _cursors.length;
				while(i--) {
					if( _cursors[i].name == name ) {
						_cursors[i].dispose();
						_cursors[i] = null;
						_cursors.splice(i,1);
						break;
					}
				}
				_cursors.push( cur );
			}
		}
		public function removeCursor( name:String ):void { }
		public function getCursor( name:String ):AieMouseCursor { 
			if( _cursors != null && _cursors.length > 0 ) {
				var i:int = _cursors.length
				while(i--) {
					if( _cursors[i].name == name ) {
						return _cursors[i];
					}				
				}
				return null;
			} else {
				return null;
			}
		}
		
		//public function registerCursor( name:String , object:Object , frameRate:Number = 1 , hotSpot:Point = null ):void {}
		//public function unregisterCursor( name:String ):void {}
	}

	internal class FalseMouse { 
	
		public function get x():Number { return 0; }
		public function set x( value:Number ):void { }
		public function get y():Number { return 0; }
		public function set y( value:Number ):void { }
		
		public function show():void {}
		public function hide():void {}		
		public function get lockProperties():Boolean { return false; }
		public function set lockProperties( value:Boolean ):void {}
		public function get alwaysOnTop():Boolean { return false; }
		public function set alwaysOnTop( value:Boolean ):void {}
		
		public function get cursor():Number { return 0; }
		public function set cursor( value:Number ):void {}		
		
	}
		internal class UTIL {
			public static var cursorInstance:int = 0;			
			public static function rand( minValue:int = 0 , maxValue:int = 1 ):Number {
				return Math.floor(Math.random()*(1+maxValue-minValue))+minValue;
			}
		}
