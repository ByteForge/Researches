package {
	import devbrowser.Browser;
	import devbrowser.Language;
	import devbrowser.SWF;
	import devbrowser.Version;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.UncaughtErrorEvent;
	import flash.external.ExternalInterface;
	import flash.system.Capabilities;
	import flash.system.System;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import org.osmf.utils.Version;

	[SWF(width="600", height="600", backgroundColor="#FFFFFF", frameRate="30")]
	public class Main extends Sprite {
		private static var debugTextField:TextField;
		
		public static const FLASH_PLAYER:uint = 1;
		public static const FLASH_BUILDER:uint = 2;
		public static const BROWSER:uint = 3;
		
		private static var _traceLocation:uint = 0;
		private static function getTraceLocation(): uint {
			return _traceLocation;
		}
		private static function setTraceLocation( value:uint ): void {
			switch( value ) {
				case FLASH_PLAYER: {
					_traceLocation = FLASH_PLAYER;
					break;
				}
				case FLASH_BUILDER: {
					_traceLocation = FLASH_BUILDER;
					break;
				}
				case BROWSER: {
					_traceLocation = BROWSER;
					break;
				}
				default: {
					_traceLocation = 1;
					break;
				}
			}
		}
		public static function TRACE( tabs:uint = 0, traceLocation:uint = 0 ): Function {
			if( traceLocation !== 0 ) {
				setTraceLocation( traceLocation );
			}
						
			var t:String = "";
			while( tabs-- ) {
				t += "\t"; // 4 spaces
				//t += "\t\t"; // 8 spaces
			}
			return function( ...parameters ): void {
				var a:Array = [];
				if( parameters.length ) {
					parameters[ 0 ] = t + String( parameters[ 0 ] );
					//trace.apply( this, parameters );
					t = "";					
					for( var i:uint = 0, L:uint = parameters.length; i < L; ++i ) {
						t += String( parameters[ i ] );
						if( i <= L-1 ) {
							t += " ";
						}
					}
					t += "\n";
					//debugTextField.appendText( t );
				} else {
					t = "\n";
					
					//trace();
					//debugTextField.appendText( "\n" );					
				}
				
				switch( _traceLocation ) {
					case FLASH_PLAYER: {
						debugTextField.appendText( t );
						break;
					}
					case FLASH_BUILDER: {
						if( parameters.length ) {
							trace.apply( this, parameters );
						} else {
							trace();
						}						
						break;
					}
					case BROWSER: {
						
						break;
					}
					default: {
						
						break;
					}
				}
			}
		}
		
		public function Main() {
			this.addEventListener( Event.ADDED_TO_STAGE, listenerADDED_TO_STAGE );
		}		
		private function listenerADDED_TO_STAGE( e:Event ):void {
			this.removeEventListener( Event.ADDED_TO_STAGE, listenerADDED_TO_STAGE );
			this.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, listenerUNCAUGHT_ERROR );
			
			debugTextField = new TextField();
			debugTextField.x = 1;
			debugTextField.y = 1;
			debugTextField.width = this.stage.stageWidth - 2;
			debugTextField.height = this.stage.stageHeight - 2;
			debugTextField.borderColor = 0x000000;
			debugTextField.border = true;
			debugTextField.selectable = true;
			debugTextField.defaultTextFormat = new TextFormat(
				"Consolas", 16, 0x000000
			);
			debugTextField.text = "";
			this.addChild( debugTextField );
			
			setTraceLocation( FLASH_PLAYER );
			
			TRACE()( ">>> START >>>" ); TRACE()(); TRACE()();
			
			/*
			SWF.initialize();
			
			TRACE( 1 )( "SWF:" );
			TRACE( 2 )( "width: ", SWF.width, " height:", SWF.height );
			TRACE( 3 )( "position: ", SWF.position );
			TRACE( 4 )( "top: ", SWF.top );
			TRACE( 4 )( "right: ", SWF.right );
			TRACE( 4 )( "bottom: ", SWF.bottom );
			TRACE( 4 )( "left: ", SWF.left );
			
			SWF.width = "600px";
			SWF.height = "600px";
			SWF.position = "absolute";
			SWF.left = "25px";
			SWF.top = "28px";
			
			TRACE( 1 )( "after modifications:" );
			TRACE( 2 )( "width: ", SWF.width, " height:", SWF.height );
			TRACE( 3 )( "position: ", SWF.position );
			TRACE( 4 )( "top: ", SWF.top );
			TRACE( 4 )( "right: ", SWF.right );
			TRACE( 4 )( "bottom: ", SWF.bottom );
			TRACE( 4 )( "left: ", SWF.left );
			*/
			
			//SWF.width = "102%";
			//SWF.height = 502;
			//TRACE( 1 )( "after modified:" );
			//TRACE( 2 )( "width: ", SWF.width, " height:", SWF.height );
			
			//SWF_initialize();			
			
			//new Browser().version == Version( "" ).toString();
			
			//VERSION( new Browser().version ) >= VERSION( "10.11.12" );
			
			//var Version:Function = VERSION;
			
			//Version( "" ) >= Version( "" );
			
			//TRACE( 1 )( Capabilities.screenDPI );
			
			//VersionParity( Browser.version ) > VersionParity( "11.11.5" );
			
			//devbrowser.Version.
			
			var Version:Function = devbrowser.Version.from;
			
			Version( "12" );
			//TRACE( 1 )( Version( "12" ) );
						
			TRACE()(); TRACE()(); TRACE()( "<<< END <<<" );
			//System.exit( 0 );
		}
		
		private static var initialized:Boolean = false;
		private static function SWF_initialize(): void {
			if( initialized ) {
				return;
			}
			
			TRACE( 1 )( "ExternalInterface.available: ", 
				ExternalInterface.available.toString().toUpperCase() );
			
			if( ExternalInterface.available ) {
				ExternalInterface.addCallback( "abcd1234", function(): void {
					TRACE( 2 )( "callback CALLED" );
				} );
				
				TRACE( 2 )( "ExternalInterface.objectID:", ExternalInterface.objectID );
				
				var JavaScriptCode:XML = XML( <![CDATA[
					
					function trace() {
						var r = '';
						var a = arguments;
						var L = a.length;
						var i = 0;
						if( L > 0 ) {
						for( i = 0 ; i < L ; i++ ) {
						r += a[i];
						if( i+1 < L ) {r += ' , ';}
						}
						} else {
						r = " ";
						}
						//alert( r );
						
						if( console.debug ) { // FF
						console.debug(r);
						} else if( console.log ) { // IE9
						console.log(r);
						}
						//document.body.innerHTML += r + '<br>';
					};
					
					function TRACE( value ) {
						
						var t = "";
						
						if( typeof value === "number" ) {
						if( value === value && value !== Number.POSITIVE_INFINITY && value !== Number.NEGATIVE_INFINITY ) {
						value = Math.round( value );
						} else {
						value = 0;
						}
						} else {
						value = 0;
						}
						
						while( value-- ) {
						t += "\t";
						}
						
						var f = function() {
						var r = t;
						var a = arguments;
						var L = a.length;
						var i = 0;
						if( L > 0 ) {
						for( i = 0 ; i < L ; i++ ) {
						r += a[i];
						if( i+1 < L ) {r += ' , ';}
						}
						} else {
						r = " ";
						}
						//alert( r );
						
						if( console.debug ) { // FF
						console.debug(r);
						} else if( console.log ) { // IE9
						console.log(r);
						}
						//document.body.innerHTML += r + '<br>';
						}
						
						return f;
					}
					
					//TRACE()( "hey there!" );
					
					var swf = null;
					
					for( var i = 0, a = document.getElementsByTagName("*"), L = a.length; i < L; ++i ) {
						//TRACE()( a[ i ], a[ i ][ "abcd1234" ] );
						if( a[ i ][ "abcd1234" ] ) {
							swf = a[ i ];
						}
					}
					
					if( swf ) {
						TRACE()( "SWF object found" );
					
						//swf.style.width = "200px";
						//swf.style.height = "200px";
					
						//swf.width = null;
						//swf.width = undefined;
						//swf.height = null;
						//swf.height = undefined;
					
						//delete swf.width;
						//delete swf.height;
					
						//swf.setAttribute( "width", null );
					
						swf.getAttribute( "width" );
						swf.removeAttribute( "width" );
						swf.getAttribute( "height" );
						swf.removeAttribute( "height" );
					
						swf.style.width = "100%";
						swf.style.height = "100%";
					
						TRACE( 1 )( swf.width, swf.style.width );
						TRACE( 1 )( swf.height, swf.style.height );
						TRACE( 1 )( "swf.id:", swf.id );
					} else {
						TRACE()( "SWF object NOT FOUND" );
					}
				]]> );
				
				//ExternalInterface.call("(function(){alert('hi');})");
				ExternalInterface.call("(function(){" + JavaScriptCode.toString() + "})");
			}
			
			/*
			var xml:XML = XML( <![CDATA[
			
			var 5 = 10;
			function a() {};
			]]> );
			*/
			
			//trace( "\"", xml.toString(), XML, "\"" );
			//TRACE( 1 )( "\"", xml.toString(), XML, "\"" );
			
			initialized = true;
		}
		
		private function listenerUNCAUGHT_ERROR( e:UncaughtErrorEvent ): void {
			TRACE()( "Uncaught Error:", e.toString() );
		}
	}
}