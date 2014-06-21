package {
	import com.greensock.TweenNano;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.ContextMenu;
	
	import sounds.Noise;

	[SWF(width="750", height="250", backgroundColor="#FFFFFF", frameRate="30")]
	public class Main extends Sprite {
		
		[Embed (source="noise-pollution.jpg")]
		private var embedImage:Class;
		private var img:Bitmap = new embedImage() as Bitmap;
		private var sprite:Sprite = null;
		
		private var tween:TweenNano = null;
		
		public function Main() {
			this.addEventListener(Event.ADDED_TO_STAGE , onADDED_TO_STAGE);
		}		
		private function onADDED_TO_STAGE(e:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE , onADDED_TO_STAGE);
			
			this.contextMenu = new ContextMenu();
			this.contextMenu.hideBuiltInItems();
			
			//trace( this.contextMenu );
			
			sprite = new Sprite();
				sprite.x = 750>>1;
				sprite.y = 250>>1;
			this.addChild( sprite );
			
			img.x = -(750>>1);
			img.y = -(250>>1);
			img.width = 750;
			img.height = 250;
			img.smoothing = true;
						
			sprite.addChild( img );
			
			this.stage.addEventListener( MouseEvent.CLICK , onCLICK );
		}
			private function rand( min:uint , max:uint ):uint {
				return (int(Math.random() * (max - min + 1)) + min);
			}
		
			private function onCLICK( e:MouseEvent ):void {
				//trace('click');
				//trace( rand( 1 , 3 ) );
				//trace( rand( 11 , 387 ) );
				//trace( rand( 11 , 387 ) );
				//trace( rand( 11 , 387 ) );
				//trace( rand( 11 , 387 ) );
				//trace( rand( 11 , 387 ) );
				Noise.play( rand( 1 , 16 ) );
				tween = TweenNano.to({},0.4,{ onUpdate:onUPDATE , onComplete:onCOMPLETE }); 
			}
			
			private function onUPDATE():void {
				//trace('.',tween.ratio);
				
				//img.x = 0; 
				//img.y = 0;
				//img.width = 750;
				//img.height = 250;
				//img.rotation = rand( 0 , 360 );
				//img.scaleX = img.scaleY = 1;
				
				//trace( rand( 0 , 360 ) - 180 );
				
				sprite.x = rand( 750>>1 , (750>>1) + 100 ) - 50;
				sprite.y = rand( 250>>1 , (250>>1) + 50 ) - 25;				
				//sprite.width = rand( 700 , 800 );
				//sprite.height = rand( 200 , 300 );				
				//sprite.rotation = rand( 0 , 30 ) - 15;
				
			}
			
			private function onCOMPLETE():void {
				//trace('complete');
				sprite.x = 750>>1;
				sprite.y = 250>>1;
				sprite.rotation = 0;
				sprite.scaleX = sprite.scaleY = 1;
			}
	}
}