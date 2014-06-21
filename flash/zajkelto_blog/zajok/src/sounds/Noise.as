package sounds {
	
	import flash.media.Sound;
	
	public class Noise {
		public var id:String = null;
		public var sound:Sound = null;
		
		public function Noise( id:String , sound:Sound ) {
			this.id = id;
			this.sound = sound;
		}
		
	}
}