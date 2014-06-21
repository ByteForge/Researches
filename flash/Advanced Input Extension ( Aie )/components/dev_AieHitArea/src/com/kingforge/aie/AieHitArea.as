/*
implement:
	Rectangle -> HitZone / HitRect
	DisplayObjectContainer -> HitElement / HitChild / HitObject / ???
	- mouseLeave
	- events:
		addEventListener / addListener

	- multiclicks up to 16 clicks
*/

package com.kingforge.aie {	
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.PixelSnapping;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.getTimer;
	
	public class AieHitArea extends Bitmap {
		
		private static var _isInitialized:Boolean = false;
		public static function get isInitialized():Boolean { return _isInitialized; }
		
		private static var stage:Stage = null;
		private static var point:Point = null;
		private static var array:Array = null;
			private static var _i:int = 0;
			private static var _L:int = 0;
			private static var overArea:Boolean = false;
			private static var cashObject:AieHitArea = null;			
				private static var hasCurrentObject:Boolean = false;
				private static var currentObject:AieHitArea = null;			
				private static var hasLastObject:Boolean = false;
				private static var lastObject:AieHitArea = null;							
				private static var hasLockObject:Boolean = false;
				private static var lockObject:AieHitArea = null;
				private static var temp_AieMouse_isPRIMARY_DOWN:Boolean = false;
				private static var _AieMouse_isPRIMARY_DOWN:Boolean = false;
				private static var _justPRIMARY_UP:Boolean = false;
				private static var _justPRIMARY_DOWN:Boolean = false;
		private static var map:BitmapData = null;
		
		public static function init( params:Object = null ):void {
			stage = params.stage;
			stage.addEventListener( Event.ENTER_FRAME , onENTER_FRAME );
			point = new Point(0,0);
			map = new BitmapData(1,1,false,0xFF00FF00);
		}		
		public static function uninit():void {}
		public static function dispose():void {}
		
			private static function onENTER_FRAME(e:Event):void {
				
				temp_AieMouse_isPRIMARY_DOWN = _AieMouse_isPRIMARY_DOWN;				
				_AieMouse_isPRIMARY_DOWN = AieMouse.isPRIMARY_DOWN;
				_justPRIMARY_UP = false;
				_justPRIMARY_DOWN = false;
				if( temp_AieMouse_isPRIMARY_DOWN && !_AieMouse_isPRIMARY_DOWN ) {
					//trace('mouse up');
					_justPRIMARY_UP = true;
				}				
				if( !temp_AieMouse_isPRIMARY_DOWN && _AieMouse_isPRIMARY_DOWN ) {
					//trace('mouse down');
					_justPRIMARY_DOWN = true;					
				}
				
				/*
				_justPRIMARY_UP = AieMouse._justPRIMARY_UP;
				_justPRIMARY_DOWN = AieMouse._justPRIMARY_DOWN;
				*/
				//trace( _AieMouse_isPRIMARY_DOWN );
				//point.x = stage.mouseX;
				//point.y = stage.mouseY;
				
				//trace( AieMouse._justPRIMARY_UP , AieMouse._justPRIMARY_DOWN );
				
				point.x = AieMouse.activeMouseX;
				point.y = AieMouse.activeMouseY;
				array = stage.getObjectsUnderPoint( point )
				_L = array.length;
				overArea = false;
				for( _i = 0 ; _i < _L ; _i++ ) {
					if( array[_i] is AieHitArea && array[_i].enabled == true ) {
						overArea = true;						
						cashObject = array[_i];						
						if( hasCurrentObject && currentObject != cashObject ) {
							lastObject = currentObject;
							hasLastObject = true;							
						}						
						currentObject = cashObject;
						hasCurrentObject = true;
						
						cashObject = null;
						array = null;
						break;
					}
				}
				/*
				trace(
					'cashObject:' , cashObject ,
					'currentObject:' , currentObject ,
					'lastObject:' , lastObject ,
					'lockObject:' , lockObject
				);
				*/				
				if( hasLockObject && currentObject != lockObject ) {
					if( lockObject != null ) { lockObject.update(); }					
				}				
				if( overArea ) {
					if( hasLastObject ) {
						if( lastObject != null ) { lastObject.update(); }
						hasLastObject = false;
						lastObject = null;
					}
					if( currentObject != null ) { currentObject.update(); }
				} else {
					if( hasCurrentObject ) {
						lastObject = currentObject;
						currentObject = null;
						if( lastObject != null ) { lastObject.update(); }
						lastObject = null;
						hasCurrentObject = false;
					}
				}
				/*
				trace(
					'cashObject:' , cashObject ,
					'currentObject:' , currentObject ,
					'lastObject:' , lastObject ,
					'lockObject:' , lockObject
				);
				*/
			}
		
//***************************************************************************************
			
		//private var _enabled:Boolean = true;
		public var enabled:Boolean = true;
		//private var _useHandCursor:Boolean = true;
			private var isOVER:Boolean = false;
			
		public function AieHitArea() {
			this.bitmapData = map; 
			this.pixelSnapping = PixelSnapping.NEVER
			this.smoothing = true;
			
			//this._enabled = true;
			this.enabled = true;
			//this._useHandCursor = true;
		}		
		
		protected function update():void {
						
			if( !this.isOVER && currentObject == this ) {
				this.isOVER = true;
				trace( this.name ,' - ', 'over' );
				return;
			}
			
			if( this.isOVER && currentObject != this ) {
				this.isOVER = false;
				trace( this.name ,' - ', 'out' );
				return;
			}						
			
			if( this.isOVER && _justPRIMARY_DOWN ) {
				lockObject = this;
				hasLockObject = true;
				trace( this.name ,' - ', 'down' );
				return;
			}
			
			if( this.isOVER && _justPRIMARY_UP ) {
				lockObject = null;
				hasLockObject = false;
				trace( this.name ,' - ', 'up' );
				return;
			}					
			
			if( !this.isOVER && _justPRIMARY_UP && lockObject == this ) {
				lockObject = null;
				hasLockObject = false;
				trace( this.name ,' - ', 'outside' );
				return;
			}			
		}		
	}
}