package devstring {	
	
	public class StringManager {
		
		private var _string: String;
				
		public function StringManager( source: Object = null, immutable: Boolean = false ) {
		
			if( source ) {
				if( source is String ) {
					this._string = source as String;
					
					TRACE( 1 )( '"' + this._string + '"', "\t\t" ,this._string.length );
				}
			}
			
		}
		
		public function get length(): uint {
			return 0;
		}
		
		public function set length( value: uint ): void {
		
		}
		
		public function contains( pattern: Object ): Boolean {
			return false;
		}
		
		public function trim( mode: Object = null ): String {
			
			if( mode ) {
				if( mode is Number ) {
				
				} else if( mode is String ) {
				
				}
			}
			
			return null;
		}
		
		public function align( mode: Object ): String {
			return null;
		}
		
		/*
			lowerCase, 
			upperCase, 
			camelCase, 
			1st letter of sentence upperCase, 
			titleCase, 
			startCase / 1st of EACH word upperCase
			dasherize
		*/
		public function convert( mode: Object ): String {
			return null;
		}
		
		public function get isEmpty(): Boolean {
			return false;
		}
		public function get isBlank(): Boolean {
			return false;
		}
		public function get isAlphabetic(): Boolean {
			return false;
		}
		public function get isAlphanumeric(): Boolean {
			return false;
		}
		public function get isNumeric(): Boolean {
			return false;
		}
		public function get isInteger(): Boolean {
			return false;
		}
		public function get isUnsignedInteger(): Boolean {
			return false;
		}
		public function get isNumber(): Boolean {
			return false;
		}
		
		public function indexOf( pattern: Object, startFrom: uint = 0 ): int {
			return -1;
		}
		
		public function lasIndexOf( pattern: Object, endFrom: uint = -1 ): int {
			return 0;
		}
		
		[Inline]
		public function charAt( position: uint ): String {
			return this.getCharacterAt( position );
		}
		
		public function getCharacterAt( position: uint ): String {
			return null;
		}
		
		public function setCharacterAt( position: uint, character: String ): void {
		}
		
		public function get isLowerCase(): Boolean {
			return false;
		}
		public function get isUpperCase(): Boolean {
			return false;
		}
		public function get isMixedCase(): Boolean {
			return false;
		}
		
		public function toString(): String {
			return null;
		}
	}
}