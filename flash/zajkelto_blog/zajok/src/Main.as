package {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	import flash.utils.setTimeout;
	
	import sounds.Noise;

	[SWF(width="600", height="600", backgroundColor="#FFFFFF", frameRate="30")]
	public class Main extends Sprite {
		
		private var _URL:String = 'http://m.blog.hu/pe/peets/';
		private var _XML:String = 'noises.xml';
		private var _hasSounds:Boolean = false;
		private var _Sounds:Vector.<Noise> = null;
		
		private var timer:Timer = null;
		
		private var XML_urlLoader:URLLoader = null;
		
		public function Main() {
			this.addEventListener(Event.ADDED_TO_STAGE , onADDED_TO_STAGE);
		}		
		private function onADDED_TO_STAGE(e:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE , onADDED_TO_STAGE);
			
			XML_urlLoader = new URLLoader();
				XML_urlLoader.addEventListener( Event.COMPLETE , XML_onCOMPLETE );
			XML_urlLoader.load( new URLRequest( _URL + _XML ) );
			
			if( ExternalInterface.available ) {
				ExternalInterface.addCallback( 'makeNoise' , callBack );
			}
		}
			private function XML_onCOMPLETE( e:Event ):void {				
				_Sounds = new Vector.<Noise>();
				
				var xml:XML = new XML( XML_urlLoader.data );
				//trace( xml.children() );
				
				var a:XMLList = xml.children();
				var i:uint = a.length();
				while(i--){
					//trace( XML( a[i] ).attribute('file') );
					//trace( XML( a[i] ).attribute('id') );
					
					//trace( _URL , XML( a[i] ).attribute('file') );
					//_Sounds.push( new Sound( new URLRequest( _URL + String(XML( a[i] ).attribute('file') ) ) ) );
					
					_Sounds.push(
						new Noise( 
							XML( a[i] ).attribute('id') ,
							new Sound( new URLRequest( _URL + String(XML( a[i] ).attribute('file') ) ) )
						)
					);
				}
				
				
				setTimeout( function():void{
					//trace('call');
					//trace( _Sounds.length );
					//_Sounds[2].sound.play();
					
					callBack( 'noise_02' , 10 );
					
				} , 1500 );
				
				
			}
		
			private function callBack( id:String , vol:Number = 100 ):void {
				//Noises.play( id );
				
				var volume:SoundTransform = new SoundTransform( vol );				
				var channel:SoundChannel = null;
				
				var i:uint = _Sounds.length;
				while(i--) {
					if( _Sounds[i].id == id ){
						//_Sounds[i].sound.play();
						channel = _Sounds[i].sound.play();
						channel.soundTransform = volume;
						break;
					}
				}
			} 
	}
}