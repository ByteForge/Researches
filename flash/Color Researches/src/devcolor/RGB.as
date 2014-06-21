package devcolor {
	
	public class RGB {
		public static function from( ...parameters ): void {
		
		}
		
		private static function TRACE( tabs:uint = 0 ): Function {
			var t:String = "";
			while( tabs-- ) {
				t += "\t";
			}
			return function( ...arg ): void {
				if( arg.length === 0 ) {
					trace( "" );
				} else {
					if( t !== "" ) {
						arg.unshift( t );
					}					
					trace.apply( null, arg ); 
				}
			};
		}
		
		private var _r:uint = 0;
		private var _g:uint = 0;
		private var _b:uint = 0;
		
		/*
			instantiations:
				- empty:
					- new RGB();
				- string:
					- new RGB( "...color..." );
				- hex number:
					- new RGB( 0x000000 );
				- number triplet:
					- new RGB( 0, 0, 0 );
		*/
		public function RGB( ...parameters ) {
			var length:uint = parameters.length;
			
			var element:Object;
			var color:uint = 0;
			var CSSColor:Boolean = false;
			
			var hexPatter:RegExp = /^\s*(0x|#|)\s*([0-9a-f\s]*)\s*$/ig;
			
			this._r = 0;
			this._g = 0;
			this._b = 0;
			
			switch( length ) {				
				case 0:
					TRACE( 1 )( "zero arguments" );
					
					break;
				case 1:
					element = parameters[ 0 ];
					//element = 0xFFCCFF;
					//element = "# FAC C ";
					TRACE( 1 )( "1 argument:", element, " typeof:", typeof element );				
					
					if( element is Number && element >= 0 && element !== Number.POSITIVE_INFINITY ) {
						TRACE( 2 )( "is Number:", element );
						color = uint( element );
												
					} else if( element is String && element.length ) {
						TRACE( 2 )( "is String:", element );
						
						var match:Object = hexPatter.exec( element as String );
						TRACE( 3 )( match );
						trace();
						
						if( match ) {
							if( match[ 1 ] !== "#" ) {
								TRACE( 3 )( "0x hex string" );
								CSSColor = false;
							} else {
								TRACE( 3 )( "# CSS string" );
								CSSColor = true;
							}
							
							if( !CSSColor ) {
								TRACE( 4 )( "color:", match[ 2 ] );								
								color = parseInt( String( match[ 2 ] ).split( " " ).join( "" ), 16 );
								TRACE( 4 )( "parsed color:", color );
							} else {
								element = String( match[ 2 ] ).split( " " ).join( "" );
								TRACE( 4 )( "CSS color:", element, " length:", element.length );
								switch( element.length ) {
									case 1:
										TRACE( 5 )( "#X -> XXXXXX, length: ", element.length );
										var cssColorValue:uint = parseInt( String( element ), 16 );
										cssColorValue = cssColorValue + ( cssColorValue << 4 ) + ( cssColorValue << 8 ) + ( cssColorValue << 12 ) + ( cssColorValue << 16 ) + ( cssColorValue << 20 );
										TRACE( 6 )( "cssColorValue: ", cssColorValue.toString( 16 ), cssColorValue );
										color = cssColorValue;
										break;
									case 2:
										TRACE( 5 )( "#XY -> XXXYYY, length: ", element.length );
										var cssColorValue:uint = parseInt( String( element ), 16 );
										var cssCV1:uint = cssColorValue >> 4;
										var cssCV2:uint = cssColorValue & 0xF;
										//TRACE( 6 )( ( cssColorValue >> 4 ).toString( 16 ) );
										//TRACE( 6 )( ( cssColorValue & 0xF ).toString( 16 ) );
										cssColorValue = ( cssCV1 << 20 ) + ( cssCV1 << 16 ) + ( cssCV1 << 12 ) + ( cssCV2 << 8 ) + ( cssCV2 << 4 ) + cssCV2;
										TRACE( 6 )( "cssColorValue: ", cssColorValue.toString( 16 ), cssColorValue );
										color = cssColorValue;
										break;
									case 3:
										TRACE( 5 )( "#XYZ -> XXYYZZ, length: ", element.length );
										var cssColorValue:uint = parseInt( String( element ), 16 );
										var cssCV1:uint = cssColorValue >> 8;
										var cssCV2:uint = ( cssColorValue >> 4 ) & 0xF;
										var cssCV3:uint = cssColorValue & 0xF;
										//TRACE( 6 )( cssCV1.toString( 16 ) );
										//TRACE( 6 )( cssCV2.toString( 16 ) );
										//TRACE( 6 )( cssCV3.toString( 16 ) );
										cssColorValue = ( cssCV1 << 20 ) + ( cssCV1 << 16 ) + ( cssCV2 << 12 ) + ( cssCV2 << 8 ) + ( cssCV3 << 4 ) + cssCV3;
										TRACE( 6 )( "cssColorValue: ", cssColorValue.toString( 16 ), cssColorValue );
										color = cssColorValue;
										break;
									default:
										TRACE( 5 )( "#... , length: ", element.length );
										var cssColorValue:uint = parseInt( String( element ), 16 );
										TRACE( 6 )( "cssColorValue: ", cssColorValue.toString( 16 ), cssColorValue );
										color = cssColorValue;
										break;
								}
							}							
							
						}												
					} else {
						TRACE( 2 )( "useless:", element );						
					}
					
					this._r = ( color >> 16 ) & 0xFF;
					this._g = ( color >> 8 ) & 0xFF;
					this._b = color & 0xFF;						
					
					TRACE( 3 )( "color:", color.toString( 16 ), color );
					TRACE( 4 )( "R: ", this._r.toString( 16 ), this._r );
					TRACE( 4 )( "G: ", this._g.toString( 16 ), this._g );
					TRACE( 4 )( "B: ", this._b.toString( 16 ), this._b );
					
					break;
				case 3:
					TRACE( 1 )( "3 arguments" );
					
					var pR:int = int( parameters[ 0 ] );
					var pG:int = int( parameters[ 1 ] );
					var pB:int = int( parameters[ 2 ] );
					
					if( pR > 255 ) {
						pR = 255;
					} else if( pR < 0 ) {
						pR = 0;
					}
					if( pG > 255 ) {
						pG = 255;
					} else if( pG < 0 ) {
						pG = 0;
					}
					if( pB > 255 ) {
						pB = 255;
					} else if( pB < 0 ) {
						pB = 0;
					}
					
					this._r = pR;
					this._g = pG;
					this._b = pB;
					
					TRACE( 3 )( "R: ", this._r.toString( 16 ), this._r );
					TRACE( 3 )( "G: ", this._g.toString( 16 ), this._g );
					TRACE( 3 )( "B: ", this._b.toString( 16 ), this._b );
					
					break;
				default:
					TRACE( 1 )( "unsopported argument length:", length );
					break;
			}
		}
		
		public function get webSafe(): Boolean {
			return false;
		}
		public function set webSafe( value:Boolean ): void {
			
		}
		
		public function getColor(): Object {
			return {};
		}
		public function setColor( ...parameters ): void {
		
		}
		public function get color(): uint {
			return ( this._r << 16 ) + ( this._g << 8 ) + this._b;
		}
		public function set color( value:uint ): void {
			if( value > 0xFFFFFF ) {
				value = 0xFFFFFF;
			}
			this._r = ( value >> 16 ) & 0xFF;
			this._g = ( value >> 8 ) & 0xFF;
			this._b = value & 0xFF;
		}
		
		public function setRed( value:Object = null ): void {
			
		}
		public function getRed(  ): Object {
			return {};
		}
		public function get red(): uint {
			return this._r;
		}
		public function set red( value:uint ): void {
			this._r = value <= 255 ? value : 255;
		}
		public function get green(): uint {
			return this._g;
		}
		public function set green( value:uint ): void {
			this._g = value <= 255 ? value : 255;
		}
		public function get blue(): uint {
			return this._b;
		}
		public function set blue( value:uint ): void {
			this._b = value <= 255 ? value : 255;
		}
		
		public function lighter( value:Object = null ): void {
		
		}
		
		public function darker( value:Object = null ): void {
		
		}
		
		public function tint( ...parameters ): void {
		
		}
		
		public function toString():String {
			return "[ " +
				"RGB: " + ( ( this._r << 16 ) + ( this._g << 8 ) + this._b ).toString( 16 ).toUpperCase() +
				" , red: " + ( this._r ).toString( 16 ).toUpperCase() + " / " + this._r.toString() +
				" , green: " + ( this._g ).toString( 16 ).toUpperCase() + " / " + this._g.toString() +
				" , blue: " + ( this._b ).toString( 16 ).toUpperCase() + " / " + this._b.toString() +
			" ]";
		}
	}
}