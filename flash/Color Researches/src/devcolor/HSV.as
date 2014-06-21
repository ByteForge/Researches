package devcolor {
	
	public class HSV {
		
		/*
			possible arguments:
				- Number:
					0xRRGGBB
				- String:
					"#RRGGBB"
					"rgb( 100%, 255, 100 )"
					"1.0f, 0.5f, 0.1f"
					"black"
				- Array:
					[ 100, 100, 100 ]
				- Number Triplet:
					255, 100, 50
		*/
		public static function fromRGB( ...parameters ): HSV {
			
			var hsl:HSL = new HSL();
			var parametersLength:uint = parameters.length;
			
			switch( parametersLength ) {
				case 1:
					var element:Object = parameters[ 0 ];
					if( element is Number ) {
						trace( "is Number" );
					} else if( element is String && element.length ) {
						trace( "is String" );
					} else if( element is Object && element !== null ) {
						if( !element is Array ) {
							trace( "is Object" );
						} else {
							trace( "is Array" );
						}
					}
					break;
				case 3:
					break;
				default:
					break;
			}
			
			return null;
		}
		public static function fromHSL( ...parameters ): HSV {
			
			return null;
		}
		
		private var _hue:Number;
		private var _saturation:Number;
		private var _value:Number;
		
		/*
			possible declarations:
				- empty
				- Number Triplet
		*/
		public function HSV( ...parameters ) {
			
		}
		
		public function get hue(): Number {
			return this._hue;
		}
		public function set hue( value:Number ): void {
		
		}
		public function get saturation(): Number {
			return this._saturation;
		}
		public function set saturation( value:Number ): void {
		
		}
		public function get value(): Number {
			return this._value;
		}
		public function set value( value:Number ): void {
			
		}
		
		public function toRGB(): void {}
		public function toHSL(): void {}
	}
}