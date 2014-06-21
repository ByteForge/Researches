package admira {
	
	public class xDate {
				
		public function xDate( date:Object = null , ...arg ) {
			
			date = "Tue Feb 1 02:03:04 GMT-0800 2005";
			
			//var regexGMT:RegExp = /(mon|tue|wed|thu|fri|sat|sun).*?(jan|feb|mar|apr|may|jun|jul|aug|sep|oct|nov|dec).*?(\d{1,2}).*?(\d{2}):(\d{2}):(\d{2}).*GMT-(\d{2})(\d{2}).*?(\d{4})/i
			var regexGMT:RegExp = /(mo|tu|we|th|fr|sa|su).*?(ja|fe|ma|ap|ma|jun|jul|au|se|oc|no|de).*?(\d{1,2}).*?(\d{1,2}).*?[:]{0,}(\d{1,2}).*?[:]{0,}(\d{1,2}).*?GMT.*?(\d{2})(\d{2}).*?(\d{2,4})/i
			
			//trace( date );
				
			//trace( regexGMT );
				
			//trace( String( date ).match( regexGMT ) );
				
			trace( regexGMT.test( String( date ) ) );
			trace("");
			trace( String( date ).match( regexGMT ) );
			
		}
	}
}