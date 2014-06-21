package sounds {
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	public class Noise {
		
		[Embed (source="noise1.mp3")]
		private static var eNoise1:Class;
		private static var Noise1:Sound = new eNoise1() as Sound;
		[Embed (source="noise2.mp3")]
		private static var eNoise2:Class;
		private static var Noise2:Sound = new eNoise2() as Sound;
		[Embed (source="noise3.mp3")]
		private static var eNoise3:Class;
		private static var Noise3:Sound = new eNoise3() as Sound;
		[Embed (source="noise4.mp3")]
		private static var eNoise4:Class;
		private static var Noise4:Sound = new eNoise4() as Sound;
		[Embed (source="noise5.mp3")]
		private static var eNoise5:Class;
		private static var Noise5:Sound = new eNoise5() as Sound;
		[Embed (source="noise6.mp3")]
		private static var eNoise6:Class;
		private static var Noise6:Sound = new eNoise6() as Sound;
		[Embed (source="noise7.mp3")]
		private static var eNoise7:Class;
		private static var Noise7:Sound = new eNoise7() as Sound;
		[Embed (source="noise8.mp3")]
		private static var eNoise8:Class;
		private static var Noise8:Sound = new eNoise8() as Sound;
		[Embed (source="noise9.mp3")]
		private static var eNoise9:Class;
		private static var Noise9:Sound = new eNoise9() as Sound;
		[Embed (source="noise10.mp3")]
		private static var eNoise10:Class;
		private static var Noise10:Sound = new eNoise10() as Sound;
		[Embed (source="noise11.mp3")]
		private static var eNoise11:Class;
		private static var Noise11:Sound = new eNoise11() as Sound;
		[Embed (source="noise12.mp3")]
		private static var eNoise12:Class;
		private static var Noise12:Sound = new eNoise12() as Sound;
		[Embed (source="noise13.mp3")]
		private static var eNoise13:Class;
		private static var Noise13:Sound = new eNoise13() as Sound;
		[Embed (source="noise14.mp3")]
		private static var eNoise14:Class;
		private static var Noise14:Sound = new eNoise14() as Sound;
		[Embed (source="noise15.mp3")]
		private static var eNoise15:Class;
		private static var Noise15:Sound = new eNoise15() as Sound;
		[Embed (source="noise16.mp3")]
		private static var eNoise16:Class;
		private static var Noise16:Sound = new eNoise16() as Sound;
	
		public static function play( id:uint ):void {		
			var volume:SoundTransform = new SoundTransform( 1 );
			var channel:SoundChannel = Noise['Noise'+String(id)].play();
			channel.soundTransform = volume;
		}
		
	}
}