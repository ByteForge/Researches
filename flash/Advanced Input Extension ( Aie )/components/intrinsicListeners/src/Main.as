package {
	import com.kingforge.aie.AieMouse;
	import com.kingforge.aie.AieMouseCursor;
	import com.kingforge.aie.AieMouseEventMode;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	[SWF(width="600", height="600", backgroundColor="#FFFFFF", framerate="30")]
	public class Main extends Sprite {
		public function Main() {
			this.addEventListener(Event.ADDED_TO_STAGE , onADDED_TO_STAGE);
		}		
		private function onADDED_TO_STAGE(e:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE , onADDED_TO_STAGE);
			
			//AieMouse.mode = AieMouseMode.TIME
			//trace(AieMouse.eventMode);
			
			//trace( root );
			
			//AieMouse.nativeMouse
			
			//_dev_000();
			_dev_randomNameGenerator();
		}
		
		private function _dev_000():void {
			
			this.stage.frameRate = 0.125;
			trace( this.stage.frameRate );
			
			var bitmap:Bitmap = new Bitmap( new BitmapData(1,1,false,0xFF00FF00) , PixelSnapping.NEVER , true );
				bitmap.x = 0;
				bitmap.y = 0;
				bitmap.width = 100;
				bitmap.height = 100;
			//this.addChild( bitmap );
			
			var sprite:Sprite = new Sprite();
				sprite.x = 50;
				sprite.y = 50;			
				sprite.addChild( bitmap );				
			this.addChild( sprite );
			
			sprite.addEventListener( MouseEvent.MOUSE_OVER , onMOUSE_OVER );
			sprite.addEventListener( MouseEvent.MOUSE_OUT , onMOUSE_OUT );
		}
		
			private function onMOUSE_OVER( e:MouseEvent ):void {
				trace('over');
			}
			private function onMOUSE_OUT( e:MouseEvent ):void {
				trace('out');
			}
			
		private function _dev_randomNameGenerator():void {
			var list:Vector.<String> = new Vector.<String>();
			
			list.push( 'name0123' );
			list.push( 'name4567' );
			
			//trace( list );
			
			var n:String = 'name4567';
			
			var i:int = list.length;
			
			//var o:Object = {};			
			//trace( o , o.toString() );
			
			//var sprite:Sprite = new Sprite();
			//trace( sprite , sprite.toString() , sprite.name );
			
			//var cursor:AieMouseCursor = new AieMouseCursor();
			//trace( cursor , cursor.toString() );
			
			//var num:Number;
			//trace( num , num.toString() );
			
			/*
			while(i--) {
				//trace( list[i] );
				if( list[i] == n ) {
					
				}
			}
			*/
			//trace( rand(0,8192) );
		}
		
			private function rand( minValue:int = 0 , maxValue:int = 1 ):Number {
				return Math.floor(Math.random()*(1+maxValue-minValue))+minValue;
			}
	}
}










