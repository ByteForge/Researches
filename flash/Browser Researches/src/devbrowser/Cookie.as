package devbrowser {
	
	public class Cookie {
		
		public function Cookie( name:String = null, value:Object = null, expiration:Object = null ) {
			
		}
		
		public function get name(): String {
			return null;
		}
		public function set name( value:String ): void {
			
		}
		public function get value(): Object {
			return null;
		}
		public function set value( value:Object ): void {
			
		}
		
		public function get expiration(): Object {
			return null;
		}
		public function set expiration( value:Object ): void {
			
		}
		
		public function addSubCookie( subCookie:Object ): void {}
		public function removeSubCookie( subCookie:Object ): void {}
		public function hasSubCookie( subCookie:Object ): void {}
		
		public function numSubCookies(): uint {
			return 0;
		}
		public function addSubCookies( ...parameters ): void {}
		public function removeSubCookies( ...parameters ): void {}
		public function hasSubCookies( ...parameters ): void {}
	}
}