package font {
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.system.System;
	import flash.utils.ByteArray;
	
	public class loadSimpleTTF {
		
		private static var urlLoader:URLLoader;
		private static var file:ByteArray = new ByteArray();
		private static var url:String = "./MyFont.ttf";
		
		public static function load():void {

			urlLoader = new URLLoader();
				urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
				urlLoader.addEventListener( Event.COMPLETE, listenerCOMPLETE );
			
			urlLoader.load( new URLRequest( url ) );
		}
		
		private static function F( name:String, data:Object ):String {
			var r:String = "";
			
			var t:String = "";
			
			if( data is uint ) {
				t = "uint";
			} else if( data is int ) {
				t = "int";
			} else if( data is Number ) {
				t = "Number"
			}
			
			r += name + ": " + String( data ) + ", " + t + ": 0x" + ( Number( data ).toString( 16 ) ).toUpperCase() ;
			
			return r;
		}
		
		private static function T( value:int ):String {
			var r:String = "";
			while( value-- ) { r += "\t"; }
			return r;
		}
		
		private static function listenerCOMPLETE( e:Event ):void {
		
			trace( "\" " + url + " \"" + " font loading process COMPLETED" );
			
			file = urlLoader.data;
			
			trace( "file size:", file.length );
			trace();
			
			var i:uint = 0;
			
			var sfnt_version:uint = file.readInt();
			trace( F( "sfnt_version", sfnt_version ) );
			
			var numTables:uint = file.readUnsignedShort();
			trace( F( "numTables", numTables ) );		
			
			var searchRange:uint = file.readUnsignedShort();
			trace( F( "searchRange", searchRange ) );
			
			var entrySelector:uint = file.readUnsignedShort();
			trace( F( "entrySelector", entrySelector ) );
			
			var rangeShift:uint = file.readUnsignedShort();
			trace( F( "rangeShift", rangeShift ) );
			
			trace( "parse for Tables:" )
			
			var name_offset:uint;
			var name_format:uint;
			var name_count:uint;
			var name_stringOffset:uint;
			
			for( i = 0; i < numTables; ++i ) {
				
				trace();
				
				var tag:uint = file.readUnsignedInt();
				var tagString:String = String.fromCharCode( tag >> 24, ( tag << 8 ) >> 24, ( tag << 16 ) >> 24, ( tag << 24 ) >> 24 ); 
				trace( T( 1 ), tagString, F( "tag", tag ) );
				
				var checkSum:uint = file.readUnsignedInt();
				trace( T( 2 ), F( "checkSum", checkSum ) );
				
				var offset:uint = file.readUnsignedInt();
				trace( T( 2 ), F( "offset", offset ) );
				
				var length:uint = file.readUnsignedInt();
				trace( T( 2 ), F( "length", length ) );
				
				if( tagString === "name" ) {
					name_offset = offset; 
				}
			}
			
			trace( "Tables are parsed succesfully, numTables: ", numTables );
			
			trace();
			trace( T( 1 ), "parse for \"name\" table" );
			
			file.position = name_offset;
			
			name_format = file.readUnsignedShort();
			trace( T( 2 ), F( "name_format", name_format ) );
			
			name_count = file.readUnsignedShort();
			trace( T( 2 ), F( "name_count", name_count ) );
			
			name_stringOffset = file.readUnsignedShort();
			trace( T( 2 ), F( "name_stringOffset", name_stringOffset ) );
						
			for( i = 0; i < name_count; ++i ) {
				trace();
				
				var nameRecord_platformID:uint = file.readUnsignedShort();
				trace( T( 3 ), F( "nameRecord_platformID", nameRecord_platformID ) );
				
				var nameRecord_encodingID:uint = file.readUnsignedShort();
				trace( T( 3 ), F( "nameRecord_encodingID", nameRecord_encodingID ) );
				
				var nameRecord_languageID:uint = file.readUnsignedShort();
				trace( T( 3 ), F( "nameRecord_languageID", nameRecord_languageID ) );
				
				var nameRecord_nameID:uint = file.readUnsignedShort();
				trace( T( 3 ), F( "nameRecord_nameID", nameRecord_nameID ) );
				
				var nameRecord_length:uint = file.readUnsignedShort();
				trace( T( 3 ), F( "nameRecord_length", nameRecord_length ) );
				
				var nameRecord_offset:uint = file.readUnsignedShort();
				trace( T( 3 ), F( "nameRecord_offset", nameRecord_offset ) );
			}
			
			trace( file.position, file.position.toString( 16 ).toUpperCase() );
			
			trace();
			trace( "....." );
			System.exit( 0 );
		}
	}
}