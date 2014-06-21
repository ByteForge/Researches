/*

0. [\d-].*(?= [a] )
1. ((\-[0-9])|[0-9]).*
2. ((\-[0-9])|[0-9])([^ ])*
3. ((\-[0-9])|[0-9]).*

relative time tags (hours):
find:
1st.: ((\-[0-9])|[0-9]).*?(h)
2nd.: ^([\-]\d{1,16})|(\d{1,16})

1 y/year(s) | 2 mo/month(s) | 3 w/week(s) | 4 d/day(s) | 5 h/hour(s) | 6 m/min/minute(s) | 7 s/sec/second(s) | 8 ms/millisec(s)/millisecond(s)

time separators ( 2011.01.02 )
big endian:
2000-(0)1-(0)2
2000.(0)1.(0)2
2000/(0)1/(0)2
2000 jan (0)2

1st.: (\d{4}\-\d{1,2}\-\d{1,2}) | (\d{4}\.\d{1,2}\.\d{1,2}) | (\d{4}\s\d{1,2}\s\d{1,2}) | (\d{4}/\d{1,2}/\d{1,2})
2nd.: (\d{4}(\-|\.|\s|/)\d{1,2}(\-|\.|\s|/)\d{1,2})
3rd.: (\d{4}(\-|\.|\s|/)(\d{1,2} |(jan(uary){0,1})|(feb(ruary){0,1})|(mar(ch){0,1})|(apr(il){0,1})|(may)|(jun(e){0,1})|(jul(y){0,1})|(aug(ust){0,1})|(sep(tember){0,1})|(oct(ober){0,1})|(nov(ember){0,1})|(dec(ember){0,1})   )(\-|\.|\s|/)\d{1,2})

year.month.day find:
1st.: \d{4}\.\d{2}\.\d{2}

h:m:s:ms find:
1st.: \d{2}\:\d{2}(\:\d{2}|)


*/
/*
implement:
	- addition / substraction 2 or more dates
	- until
	- toGMTString ( JavaScript equivalent )
	- time synchronization from sites
	- formatting: unix / php
	- multiple languages for dates/weekdays ( eng , fra , ger , esp ... )
	- current datetime in country / timezone ( current date/time in HUN )		
	- 12-24 / 24-12 time conversion ( 18:11:12 to/-/->/> 12h ; am/a.m. 3:11:12 am/a.m. -> 24h )
	- datetime conversion DateFormats / timezones / TimeFormats
	- months 1-12 not 0-11
	- value to a given format ( 120m/min -> h/hours ; 168h/hours -> week , 1 year -> days )
	- to / from roman number
	- Language Packs
	- Timezone Packs
	- Country Packs
*/

package com.kingforge.datetime {
	
	public class DateForger {
		
		public static function add( subject:String , what:String , ...arg ):void {}
		public static function substract( subject:String , what:String , ...arg ):void {}
		public static function until( subject:String , what:String , ...arg ):void {}
		public static function eval( ...arg ):void {}
		
		public static function get defaultTimezoneSet():int { return 0; }
		public static function set defaultTimezoneSet( value:int ):void { }
		
		public var UTC:int = 0;
		
		public function DateForger( ...arg ) {
			
		}
		
			public function toDate():void {}
			//public function synchronize/Now
			// public function synchronizationInterval/Period/Cycle
	}
}