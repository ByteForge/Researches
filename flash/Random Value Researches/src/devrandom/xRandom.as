package devrandom {	
	import flash.crypto.generateRandomBytes;
	import flash.utils.ByteArray;
	
	public class xRandom {
		
		{
			// Static Constructor
			
			private static var i:uint;
			private static var L:uint;
			
			for( i = 0, L = 10; i < L; ++i ) {
				//trace( byte, unsignedByte );
				//trace( "short:", short, " unsignedShort:", unsignedShort, " integer:", integer, " unsignedInteger:", unsignedInteger );
				//trace( "float:", float, " double:", double );
			}
		}
		
		private static var byteArray:ByteArray;
				
		public static function get boolean(): Boolean {
			return generateRandomBytes( 1 ).readUnsignedByte() > 127;
		}
		public static function get byte(): int {
			return generateRandomBytes( 1 ).readByte();
		}
		public static function get unsignedByte(): uint {
			return generateRandomBytes( 1 ).readUnsignedByte();
		}
		public static function get short(): int {
			return generateRandomBytes( 2 ).readShort();
		}
		public static function get unsignedShort(): uint {
			return generateRandomBytes( 2 ).readUnsignedShort();
		}
		public static function get integer(): int {
			return generateRandomBytes( 4 ).readInt();
		}
		public static function get unsignedInteger(): uint {
			return generateRandomBytes( 4 ).readUnsignedInt();
		}
		public static function get float(): Number {
			return generateRandomBytes( 4 ).readFloat();
		}
		public static function get double(): Number {
			return generateRandomBytes( 8 ).readDouble();
		}
		
		public static function uintRange( minimum:uint, maximum:uint ): uint {
			return 0;
		}
		public static function intRange( minimum:int, maximum:int ): int {
			return 0;
		}
		public static function numberRange( minimum:Number, maximum:Number ): Number {
			return 0;
		}
		
		public static function get ASCII(): String {
			return "";
		}
		public static function get extendedASCII(): String {
			return "";
		}
		public static function get UTF(): String {
			return "";
		}
		
		public static function characterRange(): String {
			return "";
		}
		
		public static function stringGenerator( ...parameters ): String {
			return "";
		}
	}
}