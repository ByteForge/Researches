package {
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import font.loadSimpleTTF;

	[SWF(width="600", height="600", backgroundColor="#FFFFFF", frameRate="30")]
	public class Main extends Sprite {
		public function Main() {
			this.addEventListener(Event.ADDED_TO_STAGE , onADDED_TO_STAGE);
		}		
		private function onADDED_TO_STAGE(e:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE , onADDED_TO_STAGE);
			
			//trace( "..." );
			
			//loadSimpleTextFile();
			//loadBinaryData();
			
			loadSimpleTTF.load();
		}
		
		private function loadSimpleTextFile():void {
		
			var loadCompleted:Function = function( e:Event ):void {
				trace( "loadCompleted()" );
				
				trace( URLLoader( e.target ).data );
			}
			
			var urlLoader:URLLoader = new URLLoader();
				urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
				urlLoader.addEventListener( Event.COMPLETE, loadCompleted, false, 0, true );
				
			urlLoader.load( new URLRequest( "./text.txt" ) );
		
		}
		
		private function loadBinaryData():void {
		
			var urlRequest:URLRequest = new URLRequest( "./MyFont.ttf" );
			var urlLoader:URLLoader = new URLLoader( urlRequest );
			
			var listenerCOMPLETE:Function = function( e:Event ):void {
				trace( "loadBinaryData() - listenerCOMPLETE()" );
				trace( URLLoader( e.target ).bytesTotal );
				
				trace( urlLoader.dataFormat );				
				trace( typeof e.target.data, "is ByteArray:", e.target.data is ByteArray );
				
				var byteArray:ByteArray = urlLoader.data;
					byteArray.endian = Endian.BIG_ENDIAN;
				//trace( byteArray.length );
				
				trace();
					
				var sfnt_version:int = byteArray.readInt();
				trace( sfnt_version, sfnt_version.toString( 16 ) );
				//trace( "majorVersion:", sfnt_version >> 16, "minorVersion:", ( sfnt_version << 16 ) >> 16 );
				
				//var majorVersion:uint = byteArray.readUnsignedShort();
				//trace( "majorVersion", majorVersion, majorVersion.toString( 16 ) );
				//var minorVersion:uint = byteArray.readUnsignedShort();
				//trace( "minorVersion", minorVersion, minorVersion.toString( 16 ) );
								
				var numTables:uint = byteArray.readUnsignedShort();
				trace( "numTables:", numTables, "0x" + numTables.toString( 16 ) );		
				
				var searchRange:uint = byteArray.readUnsignedShort();
				trace( "searchRange:", searchRange, "0x" + searchRange.toString( 16 ) );
				
				var entrySelector:uint = byteArray.readUnsignedShort();
				trace( "entrySelector:", entrySelector, "0x" + entrySelector.toString( 16 ) );
				
				var rangeShift:uint = byteArray.readUnsignedShort();
				trace( "rangeShift:", rangeShift, "0x" + rangeShift.toString( 16 ) );
				
				var foundName:Boolean = false;
				
				for( var i:uint = 0, L:uint = numTables; i < L; ++i ) {
					
					trace();
					
					var tag:uint = byteArray.readUnsignedInt();
					var tagName:String = String.fromCharCode( tag >> 24, ( tag << 8 ) >> 24, ( tag << 16 ) >> 24, ( tag << 24 ) >> 24 ); 
					trace( "tag:", tag, tagName );
					
					var checkSum:uint = byteArray.readUnsignedInt();
					trace( "checkSum:", checkSum, "0x" + checkSum.toString( 16 ) );
					
					var offset:uint = byteArray.readUnsignedInt();
					trace( "offset:", offset, "0x" + offset.toString( 16 ) );
					
					var length:uint = byteArray.readUnsignedInt();
					trace( "length:", length, "0x" + length.toString( 16 ) );
					
					if( tagName === "name" ) {
						foundName = true;
						break;
					}
				}
				
				if( foundName === true ) {
					trace();
					trace( "found \"name\" tag" );
					
					trace( "tag:", tag, tagName );
					trace( "checkSum:", checkSum, "0x" + checkSum.toString( 16 ) );					
					trace( "offset:", offset, "0x" + offset.toString( 16 ) );					
					trace( "length:", length, "0x" + length.toString( 16 ) );
					
					trace();
					
					byteArray.position = offset;
					
					var name_format:uint = byteArray.readUnsignedShort();
					trace( "name_format:", name_format, name_format.toString( 16 ) );
					
					var name_count:uint = byteArray.readUnsignedShort();
					trace( "name_count:", name_count, name_count.toString( 16 ) );
					
					var name_stringOffset:uint = byteArray.readUnsignedShort();
					trace( "name_stringOffset:", name_stringOffset, name_stringOffset.toString( 16 ) );
					
					trace();
					
					for( i = 0, L = name_count; i < L; ++i ) {
					
						var name_platfromID:uint = byteArray.readUnsignedShort();
						trace( "name_platfromID:", name_platfromID, name_platfromID.toString( 16 ) );
						
						var name_encodingID:uint = byteArray.readUnsignedShort();
						trace( "name_encodingID:", name_encodingID, name_encodingID.toString( 16 ) );
						
						var name_languageID:uint = byteArray.readUnsignedShort();
						trace( "name_languageID:", name_languageID, name_languageID.toString( 16 ) );
						
						var name_nameID:uint = byteArray.readUnsignedShort();
						trace( "name_nameID:", name_nameID, name_nameID.toString( 16 ) );
						
						var name_length:uint = byteArray.readUnsignedShort();
						trace( "name_length:", name_length, name_length.toString( 16 ) );
						
						var name_offset:uint = byteArray.readUnsignedShort();
						trace( "name_offset:", name_offset, name_offset.toString( 16 ) );
					}
				}
				
				//var tag:uint = byteArray.readUnsignedInt();
				//trace( "tag:", tag, "0x" + tag.toString( 16 ) );
				//trace( ( tag >> 24 ).toString( 16 ) );
				//trace( ( ( tag << 8 ) >> 24 ).toString( 16 ) );
				//trace( ( ( tag << 16 ) >> 24 ).toString( 16 ) );
				//trace( ( ( tag << 24 ) >> 24 ).toString( 16 ) );
				/*
				trace( String.fromCharCode(
					tag >> 24,
					( tag << 8 ) >> 24,
					( tag << 16 ) >> 24,
					( tag << 24 ) >> 24
				) );
				*/
				
				//var checkSum:uint = byteArray.readUnsignedInt();
				//trace( "checkSum:", checkSum, "0x" + checkSum.toString( 16 ) );
				
				//var offset:uint = byteArray.readUnsignedInt();
				//trace( "offset:", offset, "0x" + offset.toString( 16 ) );
				
				//var length:uint = byteArray.readUnsignedInt();
				//trace( "length:", length, "0x" + length.toString( 16 ) );
				
			}
				
			//var urlLoader:URLLoader = new URLLoader();
				urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
				urlLoader.addEventListener( Event.COMPLETE, listenerCOMPLETE );
			
			urlLoader.load( urlRequest );
			
			trace( "loadBinaryData() - start loading" );	
		}
	}
}