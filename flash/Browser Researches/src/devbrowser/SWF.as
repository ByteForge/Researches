package devbrowser {
	import flash.external.ExternalInterface;
	
	public class SWF {
		
		private static var _objectID:String;
						
		private static var get_width_function:String;
		private static var set_width_function:String;
		private static var get_height_function:String;
		private static var set_height_function:String;
		private static var get_position_function:String;
		private static var set_position_function:String;
		private static var get_top_function:String;
		private static var set_top_function:String;
		private static var get_right_function:String;
		private static var set_right_function:String;
		private static var get_bottom_function:String;
		private static var set_bottom_function:String;
		private static var get_left_function:String;
		private static var set_left_function:String;
		
		private static var EIavailable:Boolean = false;
		private static var initialized:Boolean = false;
		public static function initialize(): void {
			if( initialized ) {
				return;
			}
			
			EIavailable = ExternalInterface.available;
			
			if( EIavailable ) {
				var i:uint;
				var L:uint;
				var character:Vector.<String> = new Vector.<String>();
				var characterLength:uint = 0;
				// add numbers
				for( i = 0, L = 10; i < L; ++i ) {
					character[ characterLength++ ] = i.toString();				
				}
				// add lowercase letters
				for( i = 97, L = 123; i < L; ++i ) {
					character[ characterLength++ ] = String.fromCharCode( i );
				}
				// add uppercase letters
				for( i = 65, L = 91; i < L; ++i ) {
					character[ characterLength++ ] = String.fromCharCode( i );
				}
				
				var traceID:String = "";
				for( i = 0, L = 16; i < L; ++i ) {
					if( i > 0 ) {
						traceID += character[ int( Math.random() * characterLength ) ];
					} else {
						traceID += character[ int ( Math.random() * ( characterLength - 10 ) ) + 10 ];
					}
				}
				_objectID = "";
				for( i = 0, L = 16; i < L; ++i ) {
					if( i > 0 ) {
						_objectID += character[ int( Math.random() * characterLength ) ];
					} else {
						_objectID += character[ int ( Math.random() * ( characterLength - 10 ) ) + 10 ];
					}
				}
				
				ExternalInterface.addCallback( traceID, function(): void {} );
				
				var JavaScriptCode:String = XML(
					<![CDATA[
						var objectID = "<objectID/>";
						var traceID = "<traceID/>";
						var swf = null;
						for( var i = 0, a = document.getElementsByTagName("*"), L = a.length; i < L; ++i ) {
							if( a[ i ][ traceID ] ) {
								swf = a[ i ];
							}
						}
					
						if( swf ) {
							window[ objectID ] = swf;
							// WIDTH
							window[ objectID + "get_width" ] = function() {
								TRACE( 1 )( objectID + "get_width() called and return with:", swf.style.width );
								return swf.style.width;
							}
							window[ objectID + "set_width" ] = function( value ) {
								TRACE( 1 )( objectID + "set_width() called with value:", value );
								swf.style.width = value;
							}
							// HEIGHT
							window[ objectID + "get_height" ] = function() {
								TRACE( 1 )( objectID + "get_height() called and return with", swf.style.height );
								return swf.style.height;
							}
							window[ objectID + "set_height" ] = function( value ) {
								TRACE( 1 )( objectID + "set_height() called with value:", value );
								swf.style.height = value;
							}
							// POSITION
							window[ objectID + "get_position" ] = function() {
								TRACE( 1 )( objectID + "get_position() called and return with:", swf.style.position );
								return swf.style.position;
							}
							window[ objectID + "set_position" ] = function( value ) {
								TRACE( 1 )( objectID + "set_position() called with value:", value );
								swf.style.position = value;
							}
							// TOP
							window[ objectID + "get_top" ] = function() {
								TRACE( 1 )( objectID + "get_top() called and return with:", swf.style.top );
								return swf.style.top;
							}
							window[ objectID + "set_top" ] = function( value ) {
								TRACE( 1 )( objectID + "set_top() called with value:", value );
								swf.style.top = value;
							}
							// RIGHT
							window[ objectID + "get_right" ] = function() {
								TRACE( 1 )( objectID + "get_right() called and return with:", swf.style.right );
								return swf.style.right;
							}
							window[ objectID + "set_right" ] = function( value ) {
								TRACE( 1 )( objectID + "set_right() called with value:", value );
								swf.style.right = value;
							}
							// BOTTOM
							window[ objectID + "get_bottom" ] = function() {
								TRACE( 1 )( objectID + "get_bottom() called and return with:", swf.style.bottom );
								return swf.style.bottom;
							}
							window[ objectID + "set_bottom" ] = function( value ) {
								TRACE( 1 )( objectID + "set_bottom() called with value:", value );
								swf.style.bottom = value;
							}
							// LEFT
							window[ objectID + "get_left" ] = function() {
								TRACE( 1 )( objectID + "get_left() called and return with:", swf.style.left );
								return swf.style.left;
							}
							window[ objectID + "set_left" ] = function( value ) {
								TRACE( 1 )( objectID + "set_left() called with value:", value );
								swf.style.left = value;
							}
							
							if( swf.hasAttribute( "width" ) ) {
								if( swf.style.width === "" ) {
									var width = swf.width;
									if( width.indexOf( "px" ) === -1 && width.indexOf( "%" ) === -1 ) {
										width = width + "px";
									}
									swf.style.width = width;
								}
								swf.getAttribute( "width" );
								swf.removeAttribute( "width" );								
							}
							
							if( swf.hasAttribute( "height" ) ) {
								if( swf.style.height === "" ) {
									var height = swf.height;
									if( height.indexOf( "px" ) === -1 && height.indexOf( "%" ) === -1 ) {
										height = height + "px";
									}
									swf.style.height = height;
								}
								swf.getAttribute( "height" );
								swf.removeAttribute( "height" );													
							} 							
							
							if( swf.style.position === "" ) {
								swf.style.position = "static";
							}
							
							if( swf.style.top === "" ) {
								swf.style.top = "auto";
							}
							if( swf.style.right === "" ) {
								swf.style.right = "auto";
							}
							if( swf.style.bottom === "" ) {
								swf.style.bottom = "auto";
							}
							if( swf.style.left === "" ) {
								swf.style.left = "auto";
							}
							
							//TRACE( 0 )( swf.style.position );
							//TRACE( 0 )( swf.style.position === "" );
							
							//TRACE( 0 )( swf.style.left );
							//TRACE( 0 )( swf.style.left === "" );
						}
					]]>
				).toString()
					.replace( "<objectID/>", _objectID )
					.replace( "<traceID/>", traceID );
				
				ExternalInterface.call( '(function(){ ' + JavaScriptCode + ' })' );
				
				ExternalInterface.addCallback( traceID, null );
				
				get_width_function = 'window["' + _objectID + "get_width" + '"]';
				set_width_function = 'window["' + _objectID + "set_width" + '"]';
				get_height_function = 'window["' + _objectID + "get_height" + '"]';
				set_height_function = 'window["' + _objectID + "set_height" + '"]';
				get_position_function = 'window["' + _objectID + "get_position" + '"]';
				set_position_function = 'window["' + _objectID + "set_position" + '"]';
				get_top_function = 'window["' + _objectID + "get_top" + '"]';
				set_top_function = 'window["' + _objectID + "set_top" + '"]';
				get_right_function = 'window["' + _objectID + "get_right" + '"]';
				set_right_function = 'window["' + _objectID + "set_right" + '"]';
				get_bottom_function = 'window["' + _objectID + "get_bottom" + '"]';
				set_bottom_function = 'window["' + _objectID + "set_bottom" + '"]';
				get_left_function = 'window["' + _objectID + "get_left" + '"]';
				set_left_function = 'window["' + _objectID + "set_left" + '"]';
				
				//Main.TRACE( 1 )( get_width_function );
				//Main.TRACE( 1 )( set_width_function );
			}	
			
			initialized = true;
		}
		
		public static function get width(): Object {
			if( !initialized ) {
				initialize();
			}
			var _width:Object = null;
			
			if( EIavailable ) {
				_width = ExternalInterface.call( get_width_function );
			}
			return ( _width ) ? _width : "null" ;
		}
		public static function set width( value:Object ): void {
			if( !initialized ) {
				initialize();
			}
			if( EIavailable ) {
				if( value is Number === false ) {
					ExternalInterface.call( set_width_function, String( value ) );
				} else {
					ExternalInterface.call( set_width_function, String( value ) + "px" );
				}
			}
		}
		
		public static function get height(): Object {
			if( !initialized ) {
				initialize();
			}
			var _height:Object = null;
			
			if( EIavailable ) {
				_height = ExternalInterface.call( get_height_function );
			}			
			return ( _height ) ? _height : "null" ;
		}
		public static function set height( value:Object ): void {
			if( !initialized ) {
				initialize();
			}
			if( EIavailable ) {
				if( value is Number === false ) {
					ExternalInterface.call( set_height_function, String( value ) );
				} else {
					ExternalInterface.call( set_height_function, String( value ) + "px" );
				}
			}
		}
		
		public static function get position(): Object {
			if( !initialized ) {
				initialize();
			}
			var _position:Object = null;
			
			if( EIavailable ) {
				_position = ExternalInterface.call( get_position_function );
			}			
			return ( _position ) ? _position : "null" ;
		}
		public static function set position( value:Object ): void {
			if( !initialized ) {
				initialize();
			}
			if( EIavailable ) {
				ExternalInterface.call( set_position_function, String( value ) );				
			}
		}
		
		public static function get top(): Object {
			if( !initialized ) {
				initialize();
			}
			var _top:Object = null;
			
			if( EIavailable ) {
				_top = ExternalInterface.call( get_top_function );
			}			
			return ( _top ) ? _top : "null" ;
		}
		public static function set top( value:Object ): void {
			if( !initialized ) {
				initialize();
			}
			if( EIavailable ) {
				if( value is Number === false ) {
					ExternalInterface.call( set_top_function, String( value ) );
				} else {
					ExternalInterface.call( set_top_function, String( value ) + "px" );
				}
			}
		}		
		public static function get right(): Object {
			if( !initialized ) {
				initialize();
			}
			var _right:Object = null;
			
			if( EIavailable ) {
				_right = ExternalInterface.call( get_right_function );
			}			
			return ( _right ) ? _right : "null" ;
		}
		public static function set right( value:Object ): void {
			if( !initialized ) {
				initialize();
			}
			if( EIavailable ) {
				if( value is Number === false ) {
					ExternalInterface.call( set_right_function, String( value ) );
				} else {
					ExternalInterface.call( set_right_function, String( value ) + "px" );
				}
			}
		}		
		public static function get bottom(): Object {
			if( !initialized ) {
				initialize();
			}
			var _bottom:Object = null;
			
			if( EIavailable ) {
				_bottom = ExternalInterface.call( get_bottom_function );
			}			
			return ( _bottom ) ? _bottom : "null" ;
		}
		public static function set bottom( value:Object ): void {
			if( !initialized ) {
				initialize();
			}
			if( EIavailable ) {
				if( value is Number === false ) {
					ExternalInterface.call( set_bottom_function, String( value ) );
				} else {
					ExternalInterface.call( set_bottom_function, String( value ) + "px" );
				}
			}
		}		
		public static function get left(): Object {
			if( !initialized ) {
				initialize();
			}
			var _left:Object = null;
			
			if( EIavailable ) {
				_left = ExternalInterface.call( get_left_function );
			}			
			return ( _left ) ? _left : "null" ;
		}
		public static function set left( value:Object ): void {
			if( !initialized ) {
				initialize();
			}
			if( EIavailable ) {
				if( value is Number === false ) {
					ExternalInterface.call( set_left_function, String( value ) );
				} else {
					ExternalInterface.call( set_left_function, String( value ) + "px" );
				}
			}
		}		
	}
}