/*
	IMPLEMENT:
		- length frequency in PERCENTS / %
		- vice-versa serialization [ ByteArray, XML, JSON ]
		- check availability of generateRandomBytes function:
			- use when available, else use standard Math.random() or custom PRNG
*/

package devrandom {	
	//import flash.crypto.generateRandomBytes;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	public class StringGenerator {
		
		{
			// Static Constructor
			
			NUMBER = [ '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' ];
			//NUMBER = new <String>[ '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' ];
			//NUMBER.fixed = true;
			
			LETTER = [ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' ];
			//LETTER = new <String>[ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' ];
			//LETTER.fixed = true;
			
			PUNCTUATION = [ ' ', '!', '"', '$', '%', '&', '\'', '(', ')', '*', '+', ',', '-', '.', '/', ':', ';', '<', '=', '>', '?', '@', '[', '\\', ']', '^', '_', '`', '{', '|', '}', '~' ];
			//PUNCTUATION = new <String>[ ' ', '!', '"', '$', '%', '&', '\'', '(', ')', '*', '+', ',', '-', '.', '/', ':', ';', '<', '=', '>', '?', '@', '[', '\\', ']', '^', '_', '`', '{', '|', '}', '~' ];
			//PUNCTUATION.fixed = true;		
		}
		
		/*
		private static var NUMBER:Vector.<String>;
		private static var LETTER:Vector.<String>;
		private static var PUNCTUATION:Vector.<String>;
		*/
		private static var NUMBER:Array;
		private static var LETTER:Array;
		private static var PUNCTUATION:Array;
		
		private var _exactLength:Boolean;
		private var _oftenLength:Boolean;
		protected var _length:uint;
			protected var _min:uint;
			protected var _max:uint;
			protected var _often:uint;
		
		protected var _numbers:Boolean;
		protected var _letters:Boolean;
		protected var _punctuations:Boolean;
		
		protected var _upperCase:Boolean;
		protected var _lowerCase:Boolean;
		protected var _mixedCase:Boolean;
		protected var _sameCharacters:Boolean;
		
		private var vector:Array;
		//private var vector:Vector.<String>;
		private var vectorLength:uint;
		
		public static function fromSerialized( serializedStringGenerator:Object, serialization:uint = 0 ): StringGenerator {
			return null;
		}
		
		public static function generateSequence( ...parameters ): Array {
			return [];
		}
		
		/*
			initialization possibilities:
				- empty: / default:
					new StringGenerator();
				- length, sets, modifiers:
					new StringGenerator( length:Object, sets:Object, modifiers:Object );
						length:
							Number: 16, 32 ... ( exactly given length )
							Array: [ min, max, mostly ]
							Object: { min: , max: , mostly: }
						sets:
							Array: [ "numbers", "letters" ]
							Object: { numbers:, letters:, custom: }
						modifiers:
							Array:
							Object:
				- from StringGenerator instance:
					new StringGenerator( fromStringGenerator );
				- from serialized ByteArray:
					new StringGenerator( fromByteArray );
		*/	
		public function StringGenerator( ...parameters ) {
			
			_exactLength = true;
			_oftenLength = false;
			
			_length = 16;
			_min = _length;
			_max = _length;
			_often = _length;
		
			_numbers = true;
			_letters = true
			_punctuations = true;
			
			_upperCase = false;
			_lowerCase = false;
			_mixedCase = false;
			_sameCharacters = true;

			//vector = new Vector.<String>( 0, false );
			vector = [];
			if( _numbers ) {
				vector = vector.concat( NUMBER );
			}
			if( _letters ) {
				vector = vector.concat( LETTER );
			}
			if( _punctuations ) {
				vector = vector.concat( PUNCTUATION );
			}
			vectorLength = vector.length;
			vector.fixed = true;
			
			var pL:uint = parameters.length;
			//trace( "pL:", pL );
			
			if( pL > 0 ) {
				
			}
		}
		
		public function $( ...parameters ): String { return ""; }
		
		public function generate(): String { 
			//var r:Vector.<String> = new Vector.<String>( _length, true );
			var r:Array = [];
			
			for( var i:uint = 0, iL:uint = _length; i < iL; ++i ) {
				
				//var ui:uint = generateRandomBytes( 4 ).readUnsignedInt();
				//trace( ui, ui / 0xFFFFFFFF, "\t", int( vectorLength * ( ui / 0xFFFFFFFF ) ), int ( Math.random() * vectorLength ) );
				
				var n:uint = uint ( Math.random() * vectorLength );
				//var n:uint = uint ( vectorLength * ( generateRandomBytes( 4 ).readUnsignedInt() / 0xFFFFFFFF ) );
				
				var c:String = vector[ n ];
				
				if( _upperCase ) {
					c = c.toUpperCase();
				} else if( _lowerCase ) {
					c = c.toLowerCase();
				} else if( _mixedCase ) {
					//c = ( generateRandomBytes( 1 ).readUnsignedByte() > 127 ) ? c.toUpperCase() : c.toLowerCase() ;
				}
				
				if( _sameCharacters === false ) {
					
				}
				
				r[ i ] = c;
			}
		
			return r.join( '' );
		}
		public function get string(): String { return ""; }
		
		// LENGTH
			// EXACTLY
			public function get length(): uint {
				return this._length;
			}
			public function set length( value:uint ): void {
				if( value !== this._length ) {
					this._length = ( value > 0 ) ? value : 1 ;
					
					this._exactLength = true;
					this._min = this._length;
					this._max = this._length;
					this._often = this._length;
				}
			}
			// MINIMUM / AT LEAST
			public function get minimum(): uint {
				return this._min;
			}
			public function set minimum( value:uint ): void {
				if( value !== this._min ) {
					this._min = ( value > 0 ) ? value : 1 ;
					
					
				}
			}
			// MAXIMUM / BETWEEN
			public function get maximum(): uint { return 0; }
			public function set maximum( value:uint ): void {}
			// OFTEN / MOSTLY
			public function get often(): uint { return 0; }
			public function set often( value:uint ): void {}
			
			public function range( ...parameters ): void {}
			
			public function get exact(): Boolean {
				return this._exactLength;
			}
			public function get extent(): Boolean {
				return !this._exactLength;
			}
			public function get frequent(): Boolean {
				return this._oftenLength;
			}
			
		// SETS / SWITCHES
			// ADD
			public function get numbers(): Boolean {
				return this._numbers;
			}
			public function set numbers( value:Boolean ): void {
				if( value !== this._numbers ) {
					this._numbers = value;
					
					//vector = new Vector.<String>( 0, false );
					vector = [];
					if( _numbers ) { vector = vector.concat( NUMBER ); }
					if( _letters ) { vector = vector.concat( LETTER ); }
					if( _punctuations ) { vector = vector.concat( PUNCTUATION ); }
					vectorLength = vector.length;
					vector.fixed = true;
				}
			}
			public function get letters(): Boolean {
				return this._letters;
			}
			public function set letters( value:Boolean ): void {
				if( value !== this._letters ) {
					this._letters = value;
					
					//vector = new Vector.<String>( 0, false );
					vector = []
					if( _numbers ) { vector = vector.concat( NUMBER ); }
					if( _letters ) { vector = vector.concat( LETTER ); }
					if( _punctuations ) { vector = vector.concat( PUNCTUATION ); }
					vectorLength = vector.length;
					vector.fixed = true;
				}
			}
			public function get punctuations(): Boolean {
				return this._punctuations;
			}
			public function set punctuations( value:Boolean ): void {
				if( value !== this._punctuations ) {
					this._punctuations = value;
					
					//vector = new Vector.<String>( 0, false );
					vector = [];
					if( _numbers ) { vector = vector.concat( NUMBER ); }
					if( _letters ) { vector = vector.concat( LETTER ); }
					if( _punctuations ) { vector = vector.concat( PUNCTUATION ); }
					vectorLength = vector.length;
					vector.fixed = true;
				}
			}
			
			public function get hex(): Boolean { return false; }
			public function set hex( value:Boolean ): void {}
			public function get octal(): Boolean { return false; }
			public function set octal( value:Boolean ): void {}
			public function get binary(): Boolean { return false; }
			public function set binary( value:Boolean ): void {}
			// MOSTLY
			public function mostly( ...parameters ): void {}
			public function get mostlyNumbers(): Boolean { return false; }
			public function set mostlyNumbers( value:Boolean ): void {}
			public function get mostlyLetters(): Boolean { return false; }
			public function set mostlyLetters( value:Boolean ): void {}
			public function get mostlyPunctuations(): Boolean { return false; }
			public function set mostlyPunctuations( value:Boolean ): void {}
			
			public function get hexMostly(): Boolean { return false; }
			public function set hexMostly( value:Boolean ): void {}
			public function get octalMostly(): Boolean { return false; }
			public function set octalMostly( value:Boolean ): void {}
			public function get binaryMostly(): Boolean { return false; }
			public function set binaryMostly( value:Boolean ): void {}
			// ONLY
			public function only( ...parameters ): void {}
			public function get numbersOnly(): Boolean { return false; }
			public function set numbersOnly( value:Boolean ): void {}
			public function get lettersOnly(): Boolean { return false; }
			public function set lettersOnly( value:Boolean ): void {}
			public function get punctuationsOnly(): Boolean { return false; }
			public function set punctuationsOnly( value:Boolean ): void {}
			
			public function get hexOnly(): Boolean { return false; }
			public function set hexOnly( value:Boolean ): void {}
			public function get octalOnly(): Boolean { return false; }
			public function set octalOnly( value:Boolean ): void {}
			public function get binaryOnly(): Boolean { return false; }
			public function set binaryOnly( value:Boolean ): void {}
		// MODIFIERS
			// NO SAME CHARACTERS
			public function get sameCharacters(): Boolean { return false; }
			public function set sameCharacters( value:Boolean ): void {}
			// LETTER CASES
			public function get upperCase(): Boolean {
				return this._upperCase;
			}
			public function set upperCase( value:Boolean ): void {
				if( value !== this._upperCase ) {
					this._upperCase = value;
					
					if( this._upperCase ) {
						this._lowerCase = false;
						this._mixedCase = false;
					}
				}
			}
			public function get lowerCase(): Boolean {
				return this._lowerCase;
			}
			public function set lowerCase( value:Boolean ): void {
				if( value !== this._lowerCase ) {
					this._lowerCase = value;
					
					if( this._lowerCase ) {
						this._upperCase = false;
						this._mixedCase = false;
					}
				}
			}
			public function get mixedCase(): Boolean {
				return this._mixedCase;
			}
			public function set mixedCase( value:Boolean ): void {
				if( value !== this._mixedCase ) {
					this._mixedCase = value;
					
					if( this._mixedCase ) {
						this._lowerCase = false;
						this._upperCase = false;
					}
				}
			}
			
		// CUSTOM SET
			//public var custom:Vector.<String>;
			public var custom:Array;
			public function insert( ...parameters ): void {}
			public function remove( ...parameters ): Boolean { return false; }
			
		//public function clone(): StringGenerator { return new this() }
		
		/*
		public function serialize(): ByteArray { return null; }
		public function serialize( serialization:uint = 0 ): Object {}
		public function toByteArray(): ByteArray { return null; }
		*/
	}
}