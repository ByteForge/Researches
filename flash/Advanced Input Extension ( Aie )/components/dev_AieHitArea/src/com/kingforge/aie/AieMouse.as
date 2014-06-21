/*
implement:

	- mouse leave / enter

	- cursor related:
		- setActive( pointer:int )
		- activateNative/False()

	- modes:
		NATIVE:int = 1;
		AIE:int = 2;
		AIE_JS_EXT
		AIR:int = 3;
		SWFSTUDIO:int = 4; ???
		ZINC:int = 5; ???

		- get/set mode():int
		- getAvailableModes():Array
		- isModeAvailable( givenMode:int ):Boolean
		- isNATIVE/AIE/AIR_MODE_SUPPORTED():Boolean
		- isNATIVE/AIE/AIR():Boolean

	- public static read-only properties:
		- isPRIMARY/MIDDLE/SECONDARY_UP/DOWN/OUTSIDE
		- isMOUSE_UP/DOWN/OUTSIDE
		- button():int
		- state():int
		- clickCount():int

		- isMODIFIER_DOWN
			...

		- isMOUSE_WHEEL():Boolean
		- wheel():int

		- buttonModes:
			- NATIVE
			- AIE
			- AIR

		- wheelModes:
			- NATIVE
			- AIE
*/

package com.kingforge.aie {	
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.ContextMenu;
	import flash.ui.Mouse;
	
	public class AieMouse {
		
		private static var _isInitialized:Boolean = false;
		public static function get isInitialized():Boolean { return _isInitialized; }
		
		private static var stage:Stage = null;
		private static var parent:DisplayObjectContainer = null;
			private static var _buttonMode:int = 0;
				private static var _frameEntered:int = 0;
				public static var _justPRIMARY_UP:Boolean = false;
				public static var _justPRIMARY_DOWN:Boolean = false;
				private static var _isPRIMARY_DOWN:Boolean = false;
			private static var _wheelMode:int = 0;
				private static var _justWHEEL_ROTATED:Boolean = false;
				private static var _isWHEEL_ROTATED:Boolean = false;
				private static var _wheelDelta:int = 0;
		
		public static function init( params:Object = null ):void {
			//_nativeVisible = true;
			
			stage = params.stage;				
			parent = params.parent;
				stage.addEventListener( Event.ENTER_FRAME , onENTER_FRAME );
				//stage.addEventListener( Event.FRAME_CONSTRUCTED , onFRAME_CONSTRUCTED );				
			
			//setButtonMode( AieMouseButtonMode.NATIVE );
			buttonMode = AieMouseButtonMode.NATIVE;
			wheelMode = AieMouseWheelMode.NATIVE;
							
				//parent.contextMenu = new ContextMenu();
				//parent.contextMenu.addEventListener( ContextMenuEvent.MENU_SELECT , onNATIVE_CONTEXT_MENU );
							
			//trace( parent );
			//stage.addEventListener(Event.MOUSE_LEAVE,onMOUSE_LEAVE);
			//stage.addEventListener(MouseEvent.MOUSE_OUT,onMOUSE_OUT);
			//trace('...');
		}		
		public static function uninit():void {}
		public static function dispose():void {}
		
		public static function get buttonMode():int { return _buttonMode; }
		public static function set buttonMode( value:int ):void {
			switch( value ) {
				case AieMouseButtonMode.NATIVE: {
					stage.addEventListener( MouseEvent.MOUSE_UP , onMOUSE_UP );				
					stage.addEventListener( MouseEvent.MOUSE_DOWN , onMOUSE_DOWN );
				break; }
				
				default: { break; }
			}
			
		}
		
		public static function get wheelMode():int { return _wheelMode; }
		public static function set wheelMode( value:int ):void {
			switch( value ) {
				case AieMouseWheelMode.NATIVE: {
					stage.addEventListener( MouseEvent.MOUSE_WHEEL , onMOUSE_WHEEL );
				break; }
				
				default: { break; }
			}
		}
		
			/*
			private static function onNATIVE_CONTEXT_MENU( e:ContextMenuEvent ):void {
				trace('context menu');
				//_nativeVisible = true;
			}*/
			
			private static function onENTER_FRAME( e:Event ):void {
				
				//trace('enter frame');
				
				//_justPRIMARY_UP = false;
				//_justPRIMARY_DOWN = false;
				
				/*
				trace( _frameEntered );
				_frameEntered = 2;
				*/
				
				if( _frameEntered >= 1 && _justPRIMARY_UP ) {
					_justPRIMARY_UP = false;
				}
				if( _frameEntered >= 1 && _justPRIMARY_DOWN ) {
					_justPRIMARY_DOWN = false;
				}
				if( _frameEntered >= 1 && _justWHEEL_ROTATED ) {
					_justWHEEL_ROTATED = false;
					//trace( _wheelDelta );
					_wheelDelta = 0;					
				}
				_frameEntered = 1;
				
				if( _nativeVisible ) {
					Mouse.show();
				} else {
					Mouse.hide();
				}
				
				//trace( _frameEntered );
			}
			
			private static function onMOUSE_UP( e:MouseEvent ):void {
				//trace('up');
				_justPRIMARY_UP = true;
				_justPRIMARY_DOWN = false;				
				_isPRIMARY_DOWN = false;
				_frameEntered = 0;
			}			
			private static function onMOUSE_DOWN( e:MouseEvent ):void {
				//trace('down');
				_justPRIMARY_UP = false;
				_justPRIMARY_DOWN = true;
				_isPRIMARY_DOWN = true;
				_frameEntered = 0;
			}
			
			private static function onMOUSE_WHEEL( e:MouseEvent ):void {
				_wheelDelta = e.delta;
				_justWHEEL_ROTATED = true;
				_isWHEEL_ROTATED = true;
				_frameEntered = 0;
				trace(_wheelDelta);
			}
		
		public static function get isPRIMARY_DOWN():Boolean { return _isPRIMARY_DOWN; }
			
		private static var _nativeVisible:Boolean = true;
		private static var _nativeActive:Boolean = true;
		
		public static function get nativeMouseX():int {
			//return 0;
			return stage.mouseX;
		}		
		public static function get nativeMouseY():int {
			//return 0;
			return stage.mouseY;
		}
		
		public static function get nativeVisible():Boolean {
			return _nativeVisible;
		}
		public static function set nativeVisible( value:Boolean ):void {
			_nativeVisible = value;
		}
		public static function get nativeActive():Boolean {
			return _nativeActive;
		}
		public static function set nativeActive( value:Boolean ):void {
			_nativeActive = value;
		}
		public static function nativeShow():void {
			Mouse.show();
			_nativeVisible = true;
		}
		public static function nativeHide():void {
			Mouse.hide();
			_nativeVisible = false;
		}
		
		public static function get activeMouseX():int {
			return stage.mouseX;
		}
		public static function get activeMouseY():int {
			return stage.mouseY;
		}
	}
}	
	