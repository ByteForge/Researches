/*
implement:
	- tester GUI
*/

package com.kingforge.browser {
	
	import flash.external.ExternalInterface;
	
	public class Cookies {
	
		public static function isEIA():Boolean { return ExternalInterface.available; }
		public static function get enabled():Boolean {
			if( ExternalInterface.available ) {
				return Boolean(ExternalInterface.call('(function(){return navigator.cookieEnabled;})'));
			}			
			return false;
		}
		
		public static function hasCookie( name:String ):Boolean {
			if( enabled ) {
				var a:Array = getCookies();
				if( a != null ) {
					var i:int = a.length
					while(i--) {
						if( a[i][0] == name ) { return true; }
					}
				}
			}
			return false;
		}
		
		public static function addCookie( name:String , value:Object = null , expiration:Object = null , path:Object = null , domain:String = null , secure:Boolean = false ):void {
			if( enabled ) {
				
				/*
					value: String , int , uint , Number , Array , null , undefined , NaN
					expiration:
						- String ( '1' / '+1' , '-1' , '1h/1m/1s' , 'regular string' )
						- int / uint / Number ( 1,-1 )
						- Date
						- Array [ year , month , day , hours , minutes , seconds , milliseconds ]
						- Object ( { y , mo , d , h , m , s , ms } )
						- null , undefined , NaN
				*/
				
				/*
				var _name:String = name;
				var _value:String = value;
				
				ExternalInterface.call('(function(){ n = "'+
					name + 
					'"; v = "'+
					value +
					'"; d = 0.1; if (d) { var date = new Date(); date.setTime(date.getTime()+(d*60*1000)); var expires = "; expires="+date.toGMTString();} else { var expires = ""; } document.cookie = n+"="+v+expires+"; path=/"; })');
				
				*/
				
				//var GMTString:String = ExternalInterface.call('(function(){ return new Date().toGMTString();})');
				
				//trace( GMTString );
				//trace( new Date().toUTCString() );
				
				//ExternalInterface.call('(function(){ n = "'+name+'"; v = "'+value+'"; d = 1; if (d) { var date = new Date(); date.setTime(date.getTime()+(d*60*1000)); var expires = "; expires="+date.toGMTString();} else { var expires = ""; } document.cookie = n+"="+v+expires+"; path=/"; })');
				//ExternalInterface.call('(function(){ n = "name"; v = ""; d = 0.1; if (d) { var date = new Date(); date.setTime(date.getTime()+(d*60*1000)); var expires = "; expires="+date.toGMTString();} else { var expires = ""; } document.cookie = n+"="+v+expires+"; path=/"; })');
				
				/*
				ExternalInterface.call('(function(){ n = "name1"; v = "value1"; d = 0.05; if (d) { var date = new Date(); date.setTime(date.getTime()+(d*60*1000)); var expires = "; expires="+date.toGMTString();} else { var expires = ""; } document.cookie = n+"="+v+expires+"; path=/"; })');
				ExternalInterface.call('(function(){ n = "name2"; v = "value2"; d = 0.05; if (d) { var date = new Date(); date.setTime(date.getTime()+(d*60*1000)); var expires = "; expires="+date.toGMTString();} else { var expires = ""; } document.cookie = n+"="+v+expires+"; path=/"; })');
				ExternalInterface.call('(function(){ n = "name3"; v = "value3"; d = 0.05; if (d) { var date = new Date(); date.setTime(date.getTime()+(d*60*1000)); var expires = "; expires="+date.toGMTString();} else { var expires = ""; } document.cookie = n+"="+v+expires+"; path=/"; })');
				*/
				
				//ExternalInterface.call('(function(){ n = ""; v = "value1"; d = 0.1; if (d) { var date = new Date(); date.setTime(date.getTime()+(d*60*1000)); var expires = "; expires="+date.toGMTString();} else { var expires = ""; } document.cookie = n+"="+v+expires+"; path=/"; })');
				//ExternalInterface.call('(function(){ n = "value1"; v = ""; d = 0.1; if (d) { var date = new Date(); date.setTime(date.getTime()+(d*60*1000)); var expires = "; expires="+date.toGMTString();} else { var expires = ""; } document.cookie = n+"="+v+expires+"; path=/"; })');
				
				//ExternalInterface.call('(function(){ n = "name1"; v = "= value1="; d = 0.1; if (d) { var date = new Date(); date.setTime(date.getTime()+(d*60*1000)); var expires = "; expires="+date.toGMTString();} else { var expires = ""; } document.cookie = n+"="+v+expires+"; path=/"; })');
				//ExternalInterface.call('(function(){ n = "name2"; v = "= value2="; d = 0.1; if (d) { var date = new Date(); date.setTime(date.getTime()+(d*60*1000)); var expires = "; expires="+date.toGMTString();} else { var expires = ""; } document.cookie = n+"="+v+expires+"; path=/"; })');
			
			}
		}
		public static function getCookie( name:String ):String { 
			var r:String = null
			if( enabled ) {
				var a:Array = getCookies();
				if( a != null ) {
					var i:int = a.length
					while(i--) {
						if( a[i][0] == name ) { return String(a[i][1]); }
					}
				}
			}
			return r;
		}
		
		public static function removeCookie( name:String ):void {
			addCookie( name , '' , -1 );
		}
		
		public static function get numCookies():Number { 
			var r:int = 0;
			if( enabled ) {
				var a:Array = getCookies();
				if( a != null ) { r = a.length; }
			}
			return r;
		}
		
		public static function get hasCookies():Boolean {
			if( enabled ) {
				//return ( int(ExternalInterface.call('(function(){return (String(document.cookie).length>0)?1:0;})')) == 1 ) ? true : false ;
				var r:Array = getCookies();
				return ( r != null ) ? true : false ;
			}
			return false;
		}
		
		public static function getCookies():Array { 
			var r:Array = null;
			if( enabled ) {
				//trace( String(ExternalInterface.call('(function(){return String( document.cookie );})') ) );
				var s:String = String(ExternalInterface.call('(function(){return String( document.cookie );})') );
				//trace( 'string returned from JavaScript:' , s , '...length:' , s.length , 'split:' , s.split('; ').length );
				if( s.length > 0 ) {
					//r = [];
					var a:Array = s.split('; ');
					var e:Array = null;
					var o:Object = null;
					var i:int = 0;
					var L:int = a.length;
					
					for( i = 0 ; i < L ; i+=1 ) {						
						if( String(a[i]).indexOf('=') != -1 ) {
							e = [];
							o = String(String(a[i]).match( new RegExp( '^(?<!(\=))([^\=]+)' , 'i' ) )[0]);							
								e[0] = ( o ) ? String(o) : '' ;							
							o = String(String(a[i]).match( new RegExp( '(?<=\=).*' , 'i' ) )[0]);							
								e[1] = ( o ) ? String(o) : '' ;
							if( r == null ) { r = []; }
							r.push( [ e[0] , e[1] ] );
						} else {
							if( r == null ) { r = []; }
							r.push( [ String(a[i]) , '' ] );
						}
					}					
				}								
			}			
			return r;
		}
		public static function removeCookies():void {
			if( enabled ) {
				var a:Array = getCookies();
				if( a != null ) {
					var i:int = a.length;
					//trace( a );
					while(i--) {
						//trace( a[i] );
						addCookie( a[i][0] , '' , -1 );
					}
				}
			}			
		}		
	}
}