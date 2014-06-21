package admira {

	public class xTime {
	
		public static const _12_HOUR:uint = 12;
		public static const _24_HOUR:uint = 24;
		
		private var _24hourFormat:Boolean = true;
		
		public function xTime( object:Object = null ) {
					
			var regexReplaceWhitespace:RegExp = /[\s]{2,}/g
		
			var str:String = "[ 24 , 12H 132M ] - [ 12H , 13:12 am ]";
			str = str.toLowerCase();
			
			trace( str.replace( regexReplaceWhitespace , " " ) );
			
			/*
			
				words:
					now
					yesterday / today / tomorrow
					dawn / morning / noon / night
			
					next / last
					minute / hour / day / week / month / year
			
					add plus +
					sub subtract minus -
					times multiple by *
					divide divided by per /
					convert to ->
			
				hour formats:
					24H
						12:00
						24H 12:00
					12H
						9 am / pm
			*/
			
		}
		
		public function $():void {
		
		};
		
		public function add():void {};
				
		public function sub():void {};
		public function times():void {};
		public function per():void {};
		
		public function get hourFormat():uint {
			return ( this._24hourFormat ) ? _24_HOUR : _12_HOUR ;
		}
		public function set hourFormat( value:uint ):void {
			this._24hourFormat = ( value == _12_HOUR ) ? false : true ;
		}		
		public function get is24HourFormat():Boolean { return this._24hourFormat; }
		public function set is24HourFormat( value:Boolean ):void { this._24hourFormat = value; }		
		public function get is12HourFormat():Boolean { return ( this._24hourFormat ) ? false : true ; }
		public function set is12HourFormat( value:Boolean ):void { this._24hourFormat = ( value ) ? false : true ; }
		
	}
	
}