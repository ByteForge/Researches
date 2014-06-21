package {
	import com.kingforge.browser.Cookies;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.system.System;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	[SWF(width="500", height="500", backgroundColor="#FFFFFF", framerate="30")]
	public class Main extends Sprite {
		public function Main() {
			this.addEventListener(Event.ADDED_TO_STAGE , onADDED_TO_STAGE);
		}		
		private function onADDED_TO_STAGE(e:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE , onADDED_TO_STAGE);
		
			_getUserStrings_000();
			//_dev_arrayContains();
			//_dev_versionSplit();
			//_dev_RegEx();			
			//_dev_Browser();
			//_dev_Cookies();
			//_dev_DateForger();
		}
		
		private function _getUserStrings_000():void {
			
			//var urlRequest:URLRequest = new URLRequest();
			var urlStream:URLStream = new URLStream();
				urlStream.addEventListener( ProgressEvent.PROGRESS , _onUSER_STRING_URLSTREAM_PROGRESS );
				urlStream.addEventListener( Event.COMPLETE , _onUSER_STRING_URLSTREAM_COMPLETED );
				
			urlStream.load( new URLRequest( 'http://www.useragentstring.com/pages/All/' ) );
			
		}		
			public function _onUSER_STRING_URLSTREAM_PROGRESS( e:ProgressEvent ):void {
				//trace('URL Stream on progress...' , URLStream(e.currentTarget).bytesAvailable );
			}
			public function _onUSER_STRING_URLSTREAM_COMPLETED( e:Event ):void {
				trace('URL Stream completed' , URLStream(e.currentTarget).bytesAvailable );
				trace();
				
				var raw:String = URLStream(e.currentTarget).readUTFBytes( URLStream(e.currentTarget).bytesAvailable );
					//trace( raw.length );
				
				var regex1:RegExp = new RegExp( '(<div)[\\s]*(id=\'liste\').*?(</div>)' , 'ims' );				
				//trace( regex );
				
				//trace( String( raw.match( regex ) ).length );
				
				var str:String = String( raw.match( regex1 ) );				
				//var str:String = String( raw.match( regex1 ) ).substr( 0 , 10000 );				
				//trace( str );
				
				//var regex2:RegExp = new RegExp( '(<h4>).*?(<br /></ul>)' , 'ims' );
				//var regex2:RegExp = new RegExp( '(<br />).*?(<h4>)' , 'ims' );
				//var regex2:RegExp = new RegExp( '(<h3>).*?(</h3>)' , 'ims' );
				var regex2:RegExp = new RegExp( '<h3>' , 'ims' );
				//trace( regex2 )
				
				var ar:Array = str.split( regex2 );
				var L:int = ar.length;
				var i:int = 0;
				for( i = 0 ; i < L ; i++ ) {
					//trace( 'ar[',i,'] -' , ar[i] );
				}
				
				System.setClipboard( ar.join('\n\n') );
			}
		
		private function _dev_arrayContains():void {
		
			var a:Array = [ 1 , 10 , 1001 ];
			
			trace( a.indexOf( 1 ) );
			trace( a.indexOf( 10 ) );
			trace( a.indexOf( 1001 ) );
			trace( a.indexOf( 1002 ) );
		}
		
		private function _dev_versionSplit():void {
			
			var s:String = '1.2.3.4.5';
			//var s:String = null;
			
			trace( split( s , 2 ) );
			
			//trace( split( s , 0 ) );
			//trace( split( s , 1 ) );
			//trace( split( s , 2 ) );
			//trace( split( s , 3 ) );
			//trace( split( s , 4 ) );
		}
			private function split( src:String , offset:int = 0 ):String {
				if( src != null ) {
					if( offset == 0 ) {
						if( src.indexOf( '.' ) != -1 ) {
							return src.substr( src.indexOf( '.' )+1 );
						} 
					} else {
						var b:int = src.indexOf( '.' );
						while ( offset-- ) {
							b = src.indexOf( '.' , b+1 );
							if( b == -1 ) { break; }							
						}
						return ( b != -1 ) ? src.substr( b+1 ) : null ;
					}
				}
				return null;
			}
		
		private function _dev_RegEx():void {			
			//var ua:String = 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031016 K-Meleon/0.8.2';
			var ua:String = 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031016 K-Meleon 0.8.2';
			ua = ua.toLowerCase();
			//var p:RegExp = /k-meleon.*/i;
			
			var p:RegExp = /k-meleon.*/ig;
			//var r:String = p.exec(ua); 
			//trace( r );
			
			var pattern:RegExp = /k-meleon( |\/)/ig;			
			//trace( r.replace( pattern , '' ) );
			
			//var sg:RegExp = new RegExp( '.*?k-meleon' , 'ig' );
			//var sg:RegExp = new RegExp( 'k-meleon.' , 'i' );
			//trace( ua.split( sg )[1] );
			
			ua = 'asd';
			
			trace( String(ua.split( new RegExp( 'k-meleon.' , 'i' ) )[1]) );
		}
		
		private function _dev_Browser():void {
						
			var tfm:TextFormat = new TextFormat();
				tfm.size = 12;
						
			var tf:TextField = new TextField();
				tf.x = 5;				
				tf.y = 5;				
				tf.width = this.stage.stageWidth - ( tf.x * 2 );				
				tf.height = this.stage.stageHeight - ( tf.y * 2 );				
				tf.wordWrap = true;
				tf.border = true;
				tf.backgroundColor = 0x000000;
				tf.defaultTextFormat = tfm;
				tf.text = '';
			this.addChild( tf );
			
			//trace('hello youo!');
			
			//var browser:Browser = new Browser();
			
			//trace( int('3.6.12') );
			//trace( Browser.type );
			
			tf.appendText('Browser \n');
				tf.appendText('\t.type:[ '+String(Browser.type)+' ] \n');
				//tf.appendText('\t.versionNumber:[ '+String(Browser.versionNumber)+' ] \n');
				tf.appendText('\t.versionString:[ '+String(Browser.versionString)+' ] \n');
				tf.appendText('\t.versionMajor:[ '+String(Browser.versionMajor)+' ] \n');
				tf.appendText('\t.versionMinor:[ '+String(Browser.versionMinor)+' ] \n');
				tf.appendText('\t.versionBuild:[ '+String(Browser.versionBuild)+' ] \n');
				tf.appendText('\t.versionRest:[ '+String(Browser.versionRest)+' ] \n');
			tf.appendText('\n');
				tf.appendText('\t.navigator \n');
				tf.appendText('\t\t.appCodeName:[ '+String(Browser.navigator.appCodeName)+' ] \n');
				tf.appendText('\t\t.appName:[ '+String(Browser.navigator.appName)+' ] \n');
				tf.appendText('\t\t.appVersion:[ '+String(Browser.navigator.appVersion)+' ] \n');
				tf.appendText('\t\t.cookiesEnabled:[ '+String(Browser.navigator.cookieEnabled)+' ] \n');
				tf.appendText('\t\t.platform:[ '+String(Browser.navigator.platform)+' ] \n');
				tf.appendText('\t\t.userAgent:[ '+String(Browser.navigator.userAgent)+' ] \n');
				tf.appendText('\t\t.javaEnabled():[ '+String(Browser.navigator.javaEnabled())+' ] \n');
				tf.appendText('\t\t.taintEnabled():[ '+String(Browser.navigator.taintEnabled())+' ] \n');
			tf.appendText('\n');			
				tf.appendText('\t.screen \n');
					tf.appendText('\t\t.width:[ '+String(Browser.screen.width)+' ] \n');
					tf.appendText('\t\t.height:[ '+String(Browser.screen.height)+' ] \n');
					tf.appendText('\t\t.availWidth:[ '+String(Browser.screen.availWidth)+' ] \n');			
					tf.appendText('\t\t.availHeight:[ '+String(Browser.screen.availHeight)+' ] \n');
					tf.appendText('\t\t.pixelDepth:[ '+String(Browser.screen.pixelDepth)+' ] \n');
					tf.appendText('\t\t.colorDepth:[ '+String(Browser.screen.colorDepth)+' ] \n');
			tf.appendText('\n');			
				tf.appendText('\t.history \n');
					tf.appendText('\t\t.length:[ '+String(Browser.history.length)+' ] \n');
			tf.appendText('\n');			
				tf.appendText('\t.location \n');
					tf.appendText('\t\t.hash:[ '+String(Browser.location.hash)+' ] \n');
					tf.appendText('\t\t.host:[ '+String(Browser.location.host)+' ] \n');
					tf.appendText('\t\t.hostname:[ '+String(Browser.location.hostname)+' ] \n');
					tf.appendText('\t\t.href:[ '+String(Browser.location.href)+' ] \n');
					tf.appendText('\t\t.pathname:[ '+String(Browser.location.pathname)+' ] \n');
					tf.appendText('\t\t.port:[ '+String(Browser.location.port)+' ] \n');
					tf.appendText('\t\t.protocol:[ '+String(Browser.location.protocol)+' ] \n');
					tf.appendText('\t\t.search:[ '+String(Browser.location.search)+' ] \n');
		}
		
		private function _dev_Cookies():void {
			//trace( 'com.kingforge.browser.enabled:' , Cookies.enabled );
			//trace( 'hasCookies: ' , Cookies.hasCookies() );
			Cookies.addCookie( 'name1' , '' );
			//Cookies.addCookie( 'name2' , '' );
			//Cookies.addCookie( 'name2' , 'value2' );
			//trace( Cookies.hasCookie( 'name1' ) );
			//trace( Cookies.hasCookie( 'name2' ) );
			
			//trace( Cookies.hasCookies );
			//trace( Cookies.numCookies );
			//trace( Cookies.getCookies() );
			
			//Cookies.addCookie( 'name' , 'value' , {} );
			//Cookies.addCookie( 'name' , 'value' , new Date() );
		}
		
		private function _dev_DateForger():void {
			
			//var regex1:RegExp = /(\d{4}[ \.\:\-/]{0,32}([0-9a-zA-Z]{1,32})[ \.\:\-/]{0,32}\d{1,2})/gi;
			//var regex1:RegExp = new RegExp( '(\\d{4}[ \\.\\:\\-/]{0,32}([0-9a-zA-Z]{1,32})[ \\.\\:\\-/]{0,32}\\d{1,2})' , 'gi' );
			//var regex1:RegExp = new RegExp( '\\d{4}[ \\.\\:\\-/]{0,32}[0-9a-zA-Z]{1,32}[ \\.\\:\\-/]{0,32}\\d{1,2}' , 'gi' );
			var regex1:RegExp = new RegExp( '(\\d{4})[ \\.\\:\\-/]{0,32}([0-9a-zA-Z]{1,32})[ \\.\\:\\-/]{0,32}(\\d{1,2})' , 'gi' );
						
			var str1:String = ' ... 2000.01.02 ... ';
			//var str1:String = ' 01-2000-02 ';
			//var str1:String = ' 01-02-2000 ';
			
			//var o:Object = str1.match( regex1 );
			var o:Object = regex1.exec( str1 );
			
			//trace( regex1 );
			//trace( o[1] );
			//trace( regex1.exec( str1 ) );
						
			trace( o );
			
			var date1:Date = new Date();
			date1.setTime( Date.UTC( int(o[1]) , int(o[2])-1 , int(o[3]) , 0 , 0 , 0 , 0 ) );
			
			//var date1:Date = new Date( int(o[1]) , int(o[2]) , int(o[3]) , 0 , 0 , 0 , 0 );
			//var date1:Date = new Date();
			//trace( date1.timezoneOffset * 60 * 1000 )
			//date1.setTime( Date.UTC( o[1] , o[2] , o[3] , 0 , 0 , 0 , 0 ) );
			
			trace( date1 );			
			trace( date1.toUTCString() );			
			
			var year:Number = 0;
			var month:Number = 0;
			var day:Number = 0;
			var hour:Number = 0;
			var minute:Number = 0;
			var second:Number = 0;
			var millisecond:Number = 0;
						
		}
	}
}