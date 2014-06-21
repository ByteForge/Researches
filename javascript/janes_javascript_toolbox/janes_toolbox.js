function trace() {
    var r = '';
    var a = arguments;
    var L = a.length;
    var i = 0;
    for( i = 0 ; i < L ; i++ ) {
        r += a[i];
        if( i+1 < L ) {r += ' , ';}
    }    
    //alert( r );
    console.debug(r);
    //document.body.innerHTML += r + '<br>';
}

/*
 *	IMPLEMENT:
 *		- Debugger Tools
 *		- J('...') - SQL-like query syntax
 *		- Redistribute names ( J -> $ ... )
 *		- Add / Remove extensions to native objects ( xArray -> Array )
 *		- Plugins
 *		- String generator
*/

var DEV = new (function(){
	this.run = function() {
		//xDoc.add( new xEvent( xWindowEvent.ONLOAD , function(){} ) );
		
		//window.win = window;
		//window.doc = window.document;		
		//trace( win , doc );
		
		//var div = new xDiv();
		//div.id('10');	
		
		//trace( Body );
		//Body.addChild( document.createElement('div') );
		//Body.addChild( new xDiv() );
		//Body.addChild( NaN );
		//Body.addChild( Number.POSITIVE_INFINITY );
		//Body.addChild( Number.NEGATIVE_INFINITY );
		
		//Body.addChild( new xDiv() );
		//Body.addChild( new xDiv() );
		
		//var div = new xDiv();		
		//Body.addChild( div );		
		//Body.addChild( div );
				
	};
})();

var Jane = new (function(){
	
})();

//var J = function(){
window.J = function(){
	trace( 'hello you!' , arguments[0] );
};
	var Body = new (function(){
		var _this = this;
		var _body = window.document.body;
		this.$ = {};
		var _$ = this.$;		
			_$.children = null;
			
		this.$.children = [];
		
		this.addChild = function( child ){
			/*
			trace( 'child:' , child );
			trace( 'typeof:' , typeof child );
			trace( 'is undefined:' , typeof child === 'undefined' );
			trace( 'is null:' , typeof child === 'null' );
			trace( 'is NaN:' , typeof child === 'number' && child != child );
			trace( 'is +Infinity:' , typeof child === 'number' && child === Infinity , 'is -Infinity:' , typeof child === 'number' && child === -Infinity );
				trace( '\tis number:' , typeof child === 'number' );
				trace( '\tis string:' , typeof child === 'string' );
				trace( '\tis object:' , typeof child === 'object' );
				trace( '\tinstance of HTMLElement:' , child instanceof HTMLElement );
				trace( '\tinstance of xElement:' , child instanceof xElement );
				
			trace( '.....' );
			*/
			var a = this.$.children;
			var i = a.length;
			while(i--){
				if( a[i] == child ) {
					a.splice(i,1);
					break;
				}
			};
			a[a.length] = child;
			//trace( a.length );			
		};
	})();

	function xElement(){};
	
	xDiv.prototype = new xElement(); 
	xDiv.prototype.constructor = xDiv;	
	function xDiv() {
		this.$ = {				
    		div : null ,
    			id : null ,    			
    				z : null
    	};
    	var _this = this;
    	var _$ = this.$;
    	var _doc = window.document;
    	
		var _pt = xDiv.prototype;    	
    	if( !_pt.isInit ) {
    		_pt.isInit = true;  
    		_pt.div = _doc.createElement("div");
    			_pt.div.style.position = "absolute";
    			_pt.div.style.left = "10px";
    			_pt.div.style.top = "10px";
    			_pt.div.style.width = "10px";
    			_pt.div.style.height = "10px";
    			_pt.div.style.backgroundColor = "#FF0000";
    	}
    	_$.div = _pt.div.cloneNode(false);
    	
    	this.id = function( value ) {
    		if( typeof value === 'string' ) {
    			trace( 'it is a String' );
    		}
    		//trace( typeof value );
    		return _this.$.id;
    	};
    	
    	this.name = function( value ) {};
    	
    	this.width = this.w = function( value ) {};
    	this.height = this.h = function( value ) {};
  
    	this.left = this.x = function( value ) {};
    	this.top = this.y = function( value ) {};
    	this.right = function( value ) {};
    	this.bottom = function( value ) {};
    	
    	this.alpha = this.a = function( value ) {};
    	this.visible = this.v = function( value ) {};
    	this.rotation = this.r = function( value ) {};
    	
    	this.scaleX = this.sX = function( value ) {};
    	this.scaleY = this.sY = function( value ) {};
    	
    	this.skewX = this.skX = function( value ) {};
    	this.skewY = this.skY = function( value ) {};
    	
    	this.css = function() {};
    	
    	this.numChildren = this.num = function() {};
		this.hasChild = function() {};
		this.hasChildren = this.has = function() {};
		
		this.addChild = function( child ) {};
		this.addChildAt = function( child , index ) {};
		
		this.getChildAt = function( index ) {};
		this.getChildByName = function( name ) {};
		this.getChildIndex = function( child ) {};
		
		this.removeChild = function( child ) {};
		this.removeChildAt = function( index ) {};
		this.removeChildByName = function( index ) {};
		
		this.setChildIndex = function( child , index ) {};
		
		this.swapChildren = function( child1 , child2 ) {};
		this.swapChildrenAt = function( index1 , index2 ) {};
		
		this.addChildren = this.add = function() {};
		this.getChildren = this.get = function() {};
		this.removeChildren = this.remove = function() {};
    	
    	return this;
	};
		xDiv.prototype.isInit = false;		
		xDiv.prototype.lastID = 0;		
		xDiv.prototype.nextID = function(){ return "xdiv_instance"+xDiv.prototype.lastID++; };		
				
	var xWindowEvent = {
		ONLOAD : 'onload',
		ONUNLOAD : 'onunload'
	};
	
	function xInvisibleButton() {};
	
	function xButton(){
		this.label = function( value ) {
			
		};
		
		this.icon = function( value ) {
			
		};
	};
	function xCheckbox(){};
	function xRadiobutton(){};
	function xScrollbar(){};
	function xGroup(){};
	
// CSS related
	function xCSS() {};

// COLOR related
	function xColor() {};
	
// BROWSER related
	function xBrowser() {};
	
// MOUSE and KEYBOARD related
	var xMouse = new (function(){
		this.cursor = function( value ) {
			window.document.body.style.cursor = value;
		};
	})();
	var xKeyboard = new (function(){   })();

// COOKIE related
	var xCookies = new (function(){   
		this.num = this.numCookies = function() {};
		this.hasCookie = function() {};
		this.has = this.hasCookies = function() {};
		
		this.addCookie = function() {};
		this.getCookie = function() {};
		this.removeCookie = function() {};
		
		this.add = this.addCookies = function() {};
		this.get = this.getCookies = function() {};
		this.remove = this.removeCookies = function() {};
	})();
		function xCookie() {
    		this.num = this.numSubCookies = function() {};
    		this.hasSubCookie = function() {};
    		this.has = this.hasSubCookies = function() {};
    		
    		this.addSubCookie = function() {};
    		this.getSubCookie = function() {};
    		this.removeSubCookie = function() {};
    		
    		this.add = this.addSubCookies = function() {};
    		this.get = this.getSubCookies = function() {};
    		this.remove = this.removeSubCookies = function() {};
		};
		function xSubCookie() {};
		
// TWEEN related
	function xTween() {};
		function xTimeLine() {};
// TIMER/INTERVAL related
	function xTimer() {
		this.delay = function() {};
		this.currentCount = function() {};
		this.repeatCount = function() {};
		this.running = false;
		
		this.reset = function() {};
		this.start = function() {};
		this.stop = function() {};
	};
// DATE and TIME related
	function xDate() {};
	function xTime() {
		
		this.to12 = function(){};
		this.to24 = function(){};		
	};
// ARRAY related
	function xArray( array ) {
		var R = Math.random;
		
		this.run = function() {
			
			array = [ '1' , '2' , '3' , '4' , '5' , '6' , '7' , '8' , '9' , '10' ];
			
			//random();
			
			randomize();
		};
		
		// randomize elements
		// remove, single and multiple elements
		// merge
		// sum numbers
		
		/**
		 * depth , filter:Function
		 */		
		this.randomize = function() {
			var r = null;
			var a = 0;
			var b = array.length;
			
			var nums = [];			
			var i = b;
			var j = 0;
			var n = 0;
				b--;
			while(i--) {
				n = ~~( R() * ( b - a + 1 ) + a );
				j = nums.length;
				while(j--) {
					if( nums[j] == n ) {
						n = ~~( R() * ( b - a + 1 ) + a );
						j = nums.length;
					}
				}
				nums.push( n );
			}
			//trace( nums );
			//trace( nums.length );
			
			var r = new Array(nums.length);
			for( var i = 0 , L = r.length ; i < L ; i++ ) {
				r[i] = array[nums[i]];
			}
			
			trace( r );
			trace( '.....' );
			trace( r.length );
		};
		
		/*
		 * get a random element
		 * optional:
		 * 		- range -> ( min , max , index ) -> ( 0 , 11 , 2 )
		 * 		- range -> ( min , max )
		 * 		- index -> ( index of a multidimensional element )
		*/
		this.random = function() {
			//var R = Math.random;
			/*
			var min = 1;
			var max = 3;
			trace( ~~( MR() * ( max - min + 1 ) + min ) );
			*/
			
			var a = 0;
			var b = array.length-1;
			
			trace( array[ ~~( R() * ( b - a + 1 ) + a ) ] );
		};
		
		this.runRemove = function() {
			//remove( null , undefined , Number , String , Array , Object , document , Element , '*' );
			remove( [ Array , Object , 'steve' ] , 0 );
		};		
		/**
		 * arg:
		 * 		- '*' -> clear array
		 * 		- Object, Array, Number, String, null , undefined ... -> clear specified
		 */		
		/*
		 * Usage 1: ( args... -> Array , Object ... )
		 * Usage 2: ( [ args... ] )
		 * Usage 3: ( [ args... ] , depth:Number/String('*') )
		 * Usage 4: ( [ args... ] , depth , filter:Function )
		 * Usage 5: ( range -> '0-10' / 0 , 10 )
		 * Usage 6: remove given
		 * Usage 7: remove except
		*/		
		this.remove = function() {
			trace( arguments.length );
			trace( '.....' );
			for( var i = 0 , a = arguments , L = a.length ; i < L ; i++ ) {
				trace( a[i] );
			}
		};

		/*
		 * 		same as remove but doesn't delete, just clear
		 * Usage 1: ( arg pairs... -> Array , '' ... )
		 * Usage 2: ( arg arrays... -> [ Array , '' ] ... )
		 * Usage 3: ( arg arrays , depth )
		 * Usage 4: ( arg arrays , depth , filter )
		 * Usage 5: ( filter )
		*/
		this.clear = function() {};
		
		/*
		 * 		same as clear, but gives options to replace given
		*/
		this.replace = function() {};
		
		this.merge = function() {};
		this.sum = function() {};
		this.clone = function() {};
		
		this.indexOf = function() {};
		this.lastIndexOf = function() {};
		
		/*
		 * check whether a given arg/args has an array
		 * 		( values , Native objects ... )
		*/
		this.contains = function() {};

		/*
		 * returns an array what types of an array has in it
		*/
		this.types = function() {};
		
		return this;
	};
	
	function xNumber() {
		
		// what:String - 'hex' / 'roman' / 'ipv4' / 'ipv6'
		this.to = function() {};

		// what:String - 'hex' / 'roman' / 'ipv4' / 'ipv6'
		this.from = function() {};
		
		// String/Regex
		this.group = function() {};
		
		/*
		 * returns a random number by given parameters
		 * 	- min , max
		*/
		this.random = function() {};
		
		// from/to roman numbers
		// from/to HEX
		// könyvelői kerekítés
		// padding
		// from/to IPv4 / IPv6
		// summarize values
		// min / max values
		// isInt, isFloat, isHEX, isRoman
		// group numbers
		// toFloat decimal
		
		return this;
	};
	
	function from( value ) {
		
		this.to = function() {};
		
		return this;
	}
	
// STRING related
	function xString( value ){		
		var PI = parseInt;
		var MR = Math.random;
		var NU = 'number';
		var _ = xString;
				
		this.reverse = function() {
			return value.split('').reverse().join('');
		};
		
		/*
		 * returns random characters based on params
		*/
		this.random = function() {};
		
		this.generate = function( length , params ) {
			length = ( typeof length == 'number' && length == length ) ? PI(length) : 16 ;
			params = ( params == undefined ) ? {} : params ;
			
			var hexOnly = ( !params.hexOnly ) ? false : params.hexOnly ;
				var numbers = ( !params.numbers ) ? true : params.numbers ;
				var letters = ( !params.letters ) ? true : params.letters ;
				var punctiations = ( !params.punctiations ) ? false : params.punctiations ;
			var similarity = ( params.similarity ) ? params.similarity : true ;
			var mixedCase = ( !params.mixedCase ) ? false : params.mixedCase ;
			var upperCase = ( !params.upperCase ) ? false : params.upperCase ;
			
			length = 128;
			//similarity = false;
			
			//var MR = Math.random;
			
			var a = '';			
			if( !hexOnly ) {
				if( numbers ) { a += _.N; }
				if( letters ) { a += _.L; }
				if( punctiations ) { a += _.P; }
			} else {
				a = _.H;
			}
			a = a.split('');
			var L = a.length;
			var r = '';
			if( !similarity && length > L ) { length = L; }
			var c = '';
			for( var i = 0 ; i < length ; i++ ) {
				c = a[ PI( MR() * L ) ];
				if( !similarity ) {
					do {
						if( r.indexOf(c) > -1 ) {
							c = a[ PI( MR() * L ) ];							
						} else {
							break;							
						}
					} while (true);
				}
				if( mixedCase ) { 
					if( PI( MR() * ( 2 ) ) == 1 ) { c.toUpperCase(); }
				}				
				r += c;
			}
			if( !upperCase ) { return r; } else { return r.toUpperCase(); }
		};
		
		this.align = function( direction ) {}; // left , right
		this.trim = function( direction ) {}; // left , right , both/center
		this['*'] = this.times = function( number ) { 
			var r = ''; while(number--) { r += value; } return r; 
		};
		this.remove = function( mode ) {
			
			// script
			// extra whitespaces
			// trim , left-right-both
			// accents/diacritics
			
			//mode = 'extra-whitespaces';
			//value = '   s a sentence 1. sentence 2!   sentence 3? sen     tence 4 continue... break! ';
			
			//mode = 'accents';
			//value = 'öüóőúéáűí - ÖÜÓŐÚŰÁÉÍ - äÄ';
			
			//mode = 'trim';
			//value = '     ...     ';			
			//mode = 'trim-left';
			//value = '     ...     ';			
			//mode = 'trim-right';
			//value = '     ...     ';
			
			if( mode == 'extra-whitespaces' ) {
				var regex = /(^[ ]{1,}|[ ]{1,}$)|((?=[ ]{2}).)/g;				
				var r = value.replace( regex , '' );				
				//trace( r );				
				return r;
			} else if( mode == 'accents' ) {
				var i = 0, a = remove.A, L = remove.L;
				for( i = 0 ; i < L ; i+=2 ) {
					value = value.replace(a[i+1],a[i]);
				}
				trace( value );
				return value;
			} else if( mode == 'trim' ) {
				var regex = /^[ ]{1,}|[ ]{1,}$/g;
				var r = value.replace( regex , '' );
				trace( r );				
				return r;
			} else if( mode == 'trim-left' ) {
				var regex = /^[ ]{1,}/;
				var r = value.replace( regex , '' );
				trace( r );				
				return r;
			} else if( mode == 'trim-right' ) {
				var regex = /[ ]{1,}$/;
				var r = value.replace( regex , '' );
				trace( r );				
				return r;
			} else {
				return value;
			}			
		};
			this.remove.A = [
           		'A',/[\u0041\u24B6\uFF21\u00C0\u00C1\u00C2\u1EA6\u1EA4\u1EAA\u1EA8\u00C3\u0100\u0102\u1EB0\u1EAE\u1EB4\u1EB2\u0226\u01E0\u00C4\u01DE\u1EA2\u00C5\u01FA\u01CD\u0200\u0202\u1EA0\u1EAC\u1EB6\u1E00\u0104\u023A\u2C6F]/g,
                'AA',/[\uA732]/g,
                'AE',/[\u00C6\u01FC\u01E2]/g,
                'AO',/[\uA734]/g,
                'AU',/[\uA736]/g,
                'AV',/[\uA738\uA73A]/g,
                'AY',/[\uA73C]/g,
                'B',/[\u0042\u24B7\uFF22\u1E02\u1E04\u1E06\u0243\u0182\u0181]/g,
                'C',/[\u0043\u24B8\uFF23\u0106\u0108\u010A\u010C\u00C7\u1E08\u0187\u023B\uA73E]/g,
                'D',/[\u0044\u24B9\uFF24\u1E0A\u010E\u1E0C\u1E10\u1E12\u1E0E\u0110\u018B\u018A\u0189\uA779]/g,
                'DZ',/[\u01F1\u01C4]/g,
                'Dz',/[\u01F2\u01C5]/g,
                'E',/[\u0045\u24BA\uFF25\u00C8\u00C9\u00CA\u1EC0\u1EBE\u1EC4\u1EC2\u1EBC\u0112\u1E14\u1E16\u0114\u0116\u00CB\u1EBA\u011A\u0204\u0206\u1EB8\u1EC6\u0228\u1E1C\u0118\u1E18\u1E1A\u0190\u018E]/g,
                'F',/[\u0046\u24BB\uFF26\u1E1E\u0191\uA77B]/g,
                'G',/[\u0047\u24BC\uFF27\u01F4\u011C\u1E20\u011E\u0120\u01E6\u0122\u01E4\u0193\uA7A0\uA77D\uA77E]/g,
                'H',/[\u0048\u24BD\uFF28\u0124\u1E22\u1E26\u021E\u1E24\u1E28\u1E2A\u0126\u2C67\u2C75\uA78D]/g,
                'I',/[\u0049\u24BE\uFF29\u00CC\u00CD\u00CE\u0128\u012A\u012C\u0130\u00CF\u1E2E\u1EC8\u01CF\u0208\u020A\u1ECA\u012E\u1E2C\u0197]/g,
                'J',/[\u004A\u24BF\uFF2A\u0134\u0248]/g,
                'K',/[\u004B\u24C0\uFF2B\u1E30\u01E8\u1E32\u0136\u1E34\u0198\u2C69\uA740\uA742\uA744\uA7A2]/g,
                'L',/[\u004C\u24C1\uFF2C\u013F\u0139\u013D\u1E36\u1E38\u013B\u1E3C\u1E3A\u0141\u023D\u2C62\u2C60\uA748\uA746\uA780]/g,
                'LJ',/[\u01C7]/g,
                'Lj',/[\u01C8]/g,
                'M',/[\u004D\u24C2\uFF2D\u1E3E\u1E40\u1E42\u2C6E\u019C]/g,
                'N',/[\u004E\u24C3\uFF2E\u01F8\u0143\u00D1\u1E44\u0147\u1E46\u0145\u1E4A\u1E48\u0220\u019D\uA790\uA7A4]/g,
                'NJ',/[\u01CA]/g,
                'Nj',/[\u01CB]/g,
                'O',/[\u004F\u24C4\uFF2F\u00D2\u00D3\u00D4\u1ED2\u1ED0\u1ED6\u1ED4\u00D5\u1E4C\u022C\u1E4E\u014C\u1E50\u1E52\u014E\u022E\u0230\u00D6\u022A\u1ECE\u0150\u01D1\u020C\u020E\u01A0\u1EDC\u1EDA\u1EE0\u1EDE\u1EE2\u1ECC\u1ED8\u01EA\u01EC\u00D8\u01FE\u0186\u019F\uA74A\uA74C]/g,
                'OI',/[\u01A2]/g,
                'OO',/[\uA74E]/g,
                'OU',/[\u0222]/g,
                'P',/[\u0050\u24C5\uFF30\u1E54\u1E56\u01A4\u2C63\uA750\uA752\uA754]/g,
                'Q',/[\u0051\u24C6\uFF31\uA756\uA758\u024A]/g,
                'R',/[\u0052\u24C7\uFF32\u0154\u1E58\u0158\u0210\u0212\u1E5A\u1E5C\u0156\u1E5E\u024C\u2C64\uA75A\uA7A6\uA782]/g,
                'S',/[\u0053\u24C8\uFF33\u1E9E\u015A\u1E64\u015C\u1E60\u0160\u1E66\u1E62\u1E68\u0218\u015E\u2C7E\uA7A8\uA784]/g,
                'T',/[\u0054\u24C9\uFF34\u1E6A\u0164\u1E6C\u021A\u0162\u1E70\u1E6E\u0166\u01AC\u01AE\u023E\uA786]/g,
                'TZ',/[\uA728]/g,
                'U',/[\u0055\u24CA\uFF35\u00D9\u00DA\u00DB\u0168\u1E78\u016A\u1E7A\u016C\u00DC\u01DB\u01D7\u01D5\u01D9\u1EE6\u016E\u0170\u01D3\u0214\u0216\u01AF\u1EEA\u1EE8\u1EEE\u1EEC\u1EF0\u1EE4\u1E72\u0172\u1E76\u1E74\u0244]/g,
                'V',/[\u0056\u24CB\uFF36\u1E7C\u1E7E\u01B2\uA75E\u0245]/g,
                'VY',/[\uA760]/g,
                'W',/[\u0057\u24CC\uFF37\u1E80\u1E82\u0174\u1E86\u1E84\u1E88\u2C72]/g,
                'X',/[\u0058\u24CD\uFF38\u1E8A\u1E8C]/g,
                'Y',/[\u0059\u24CE\uFF39\u1EF2\u00DD\u0176\u1EF8\u0232\u1E8E\u0178\u1EF6\u1EF4\u01B3\u024E\u1EFE]/g,
                'Z',/[\u005A\u24CF\uFF3A\u0179\u1E90\u017B\u017D\u1E92\u1E94\u01B5\u0224\u2C7F\u2C6B\uA762]/g,
                'a',/[\u0061\u24D0\uFF41\u1E9A\u00E0\u00E1\u00E2\u1EA7\u1EA5\u1EAB\u1EA9\u00E3\u0101\u0103\u1EB1\u1EAF\u1EB5\u1EB3\u0227\u01E1\u00E4\u01DF\u1EA3\u00E5\u01FB\u01CE\u0201\u0203\u1EA1\u1EAD\u1EB7\u1E01\u0105\u2C65\u0250]/g,
                'aa',/[\uA733]/g,
                'ae',/[\u00E6\u01FD\u01E3]/g,
                'ao',/[\uA735]/g,
                'au',/[\uA737]/g,
                'av',/[\uA739\uA73B]/g,
                'ay',/[\uA73D]/g,
                'b',/[\u0062\u24D1\uFF42\u1E03\u1E05\u1E07\u0180\u0183\u0253]/g,
                'c',/[\u0063\u24D2\uFF43\u0107\u0109\u010B\u010D\u00E7\u1E09\u0188\u023C\uA73F\u2184]/g,
                'd',/[\u0064\u24D3\uFF44\u1E0B\u010F\u1E0D\u1E11\u1E13\u1E0F\u0111\u018C\u0256\u0257\uA77A]/g,
                'dz',/[\u01F3\u01C6]/g,
                'e',/[\u0065\u24D4\uFF45\u00E8\u00E9\u00EA\u1EC1\u1EBF\u1EC5\u1EC3\u1EBD\u0113\u1E15\u1E17\u0115\u0117\u00EB\u1EBB\u011B\u0205\u0207\u1EB9\u1EC7\u0229\u1E1D\u0119\u1E19\u1E1B\u0247\u025B\u01DD]/g,
                'f',/[\u0066\u24D5\uFF46\u1E1F\u0192\uA77C]/g,
                'g',/[\u0067\u24D6\uFF47\u01F5\u011D\u1E21\u011F\u0121\u01E7\u0123\u01E5\u0260\uA7A1\u1D79\uA77F]/g,
                'h',/[\u0068\u24D7\uFF48\u0125\u1E23\u1E27\u021F\u1E25\u1E29\u1E2B\u1E96\u0127\u2C68\u2C76\u0265]/g,
                'hv',/[\u0195]/g,
                'i',/[\u0069\u24D8\uFF49\u00EC\u00ED\u00EE\u0129\u012B\u012D\u00EF\u1E2F\u1EC9\u01D0\u0209\u020B\u1ECB\u012F\u1E2D\u0268\u0131]/g,
                'j',/[\u006A\u24D9\uFF4A\u0135\u01F0\u0249]/g,
                'k',/[\u006B\u24DA\uFF4B\u1E31\u01E9\u1E33\u0137\u1E35\u0199\u2C6A\uA741\uA743\uA745\uA7A3]/g,
                'l',/[\u006C\u24DB\uFF4C\u0140\u013A\u013E\u1E37\u1E39\u013C\u1E3D\u1E3B\u017F\u0142\u019A\u026B\u2C61\uA749\uA781\uA747]/g,
                'lj',/[\u01C9]/g,
                'm',/[\u006D\u24DC\uFF4D\u1E3F\u1E41\u1E43\u0271\u026F]/g,
                'n',/[\u006E\u24DD\uFF4E\u01F9\u0144\u00F1\u1E45\u0148\u1E47\u0146\u1E4B\u1E49\u019E\u0272\u0149\uA791\uA7A5]/g,
                'nj',/[\u01CC]/g,
                'o',/[\u006F\u24DE\uFF4F\u00F2\u00F3\u00F4\u1ED3\u1ED1\u1ED7\u1ED5\u00F5\u1E4D\u022D\u1E4F\u014D\u1E51\u1E53\u014F\u022F\u0231\u00F6\u022B\u1ECF\u0151\u01D2\u020D\u020F\u01A1\u1EDD\u1EDB\u1EE1\u1EDF\u1EE3\u1ECD\u1ED9\u01EB\u01ED\u00F8\u01FF\u0254\uA74B\uA74D\u0275]/g,
                'oi',/[\u01A3]/g,
                'ou',/[\u0223]/g,
                'oo',/[\uA74F]/g,
                'p',/[\u0070\u24DF\uFF50\u1E55\u1E57\u01A5\u1D7D\uA751\uA753\uA755]/g,
                'q',/[\u0071\u24E0\uFF51\u024B\uA757\uA759]/g,
                'r',/[\u0072\u24E1\uFF52\u0155\u1E59\u0159\u0211\u0213\u1E5B\u1E5D\u0157\u1E5F\u024D\u027D\uA75B\uA7A7\uA783]/g,
                's',/[\u0073\u24E2\uFF53\u00DF\u015B\u1E65\u015D\u1E61\u0161\u1E67\u1E63\u1E69\u0219\u015F\u023F\uA7A9\uA785\u1E9B]/g,
                't',/[\u0074\u24E3\uFF54\u1E6B\u1E97\u0165\u1E6D\u021B\u0163\u1E71\u1E6F\u0167\u01AD\u0288\u2C66\uA787]/g,
                'tz',/[\uA729]/g,
                'u',/[\u0075\u24E4\uFF55\u00F9\u00FA\u00FB\u0169\u1E79\u016B\u1E7B\u016D\u00FC\u01DC\u01D8\u01D6\u01DA\u1EE7\u016F\u0171\u01D4\u0215\u0217\u01B0\u1EEB\u1EE9\u1EEF\u1EED\u1EF1\u1EE5\u1E73\u0173\u1E77\u1E75\u0289]/g,
                'v',/[\u0076\u24E5\uFF56\u1E7D\u1E7F\u028B\uA75F\u028C]/g,
                'vy',/[\uA761]/g,
                'w',/[\u0077\u24E6\uFF57\u1E81\u1E83\u0175\u1E87\u1E85\u1E98\u1E89\u2C73]/g,
                'x',/[\u0078\u24E7\uFF58\u1E8B\u1E8D]/g,
                'y',/[\u0079\u24E8\uFF59\u1EF3\u00FD\u0177\u1EF9\u0233\u1E8F\u00FF\u1EF7\u1E99\u1EF5\u01B4\u024F\u1EFF]/g,
                'z',/[\u007A\u24E9\uFF5A\u017A\u1E91\u017C\u017E\u1E93\u1E95\u01B6\u0225\u0240\u2C6C\uA763]/g
           	];
    		this.remove.L = this.remove.A.length;
		
		this.convert = function( mode ) {
			// camelize
			// dasherize
			// capitalize
				// - first letter of a sentence
				// - first letter of a word				
			//
			
			//value = 'this  is an example-of.something';
			//value = 'background-color';
			//mode = 'camelCase';
			
			//value = 'backgroundColor';
			//mode = 'hyphenate';
			
			//value = 'sentence 1. sentence 2! sentence 3? sentence 4 continue... break! ';
			//mode = 'capitalize-sentence';
			
			value = ' s a sentence 1. sentence 2! sentence 3? sentence 4 continue... break! ';
			mode = 'capitalize-word';
						
			if( mode == 'camelCase' ) {
				var regex = /[\s\-\.\,]{1,}/g;
				var r = value.replace(regex, ' ');
				//trace( '1:' , value );
				//trace( '2:' , r );
				var a = r.split(' ');
				r = '';
				for( var i = 0 , L = a.length ; i < L ; i++ ) {
					if( i > 0 ) {
						r += a[i][0].toUpperCase() + a[i].substr(1);
					} else {						
						r += a[i];
					}					
				}
				//trace( r );				
				return r;
			} else if( mode == 'hyphenate' ) {
				var regex = /[A-Z]/;
				var a = value.split('');
				var r = '';
				for( var i = 0 , L = a.length ; i < L ; i++ ) {
					if( regex.test( a[i] ) == false ) {
						r += a[i];
					} else {
						r += '-'+a[i];
					}
				}
				r = r.toLowerCase();
				//trace( r );
				return r;
			} else if( mode == 'capitalize-sentence' ) {
				var regex1 = /([\.\!\?].*?)([a-z])/g;
				var regex2 = /([\s]{0,})([a-z])/;
				var f = function(A,B,C){return B+C.toUpperCase();};
				var r = value;				
				r = r.replace( regex2 , f ).replace( regex1 , f );
				//trace( r );
				return r;
			} else if( mode == 'capitalize-word' ) {
				var regex = /([a-z]{1})(.*?[\s\.\?\!])/g;				
				var f = function(A,B,C){return B.toUpperCase()+C;};
				var r = value;
				r = r.replace( regex , f );
				//trace( r );
				return r;
			} else {
				return value;
			}
		};
		
		this.is = function( type ) {
			if( type == 'empty' || type == 'blank' ) {
				
			} else if( type == 'int' ) {
				
			} else if( type == 'float' ) {
				
			} else {
				return false;
			}
		};
		this.empty = function() {};
		/*
		var _r = '';
		var _i = 0;
		var _a = 0;
		var _L = 0;				
		this.deaccent = function() {						
			_r = value;
			_a = deaccent.a;
			_L = deaccent.L;
		
			for( _i = 0 ; _i < _L ; _i+=2 ) {
				//_r = _r.replace(_a[_i+1],_a[_i]);
				if( _a[_i+1].test( _r ) ) {
					//trace( 'found:' , ' to:' , _a[_i] );
					_r = _r.replace(_a[_i+1],_a[_i]);
				}
			}
			return _r;
		};
		*/		
		
		// Number , Number , Number -> 10 , 11 , 6	
		// String , Number -> '0-10' , 6
		// Regex , Number -> regex , 6
		// Regex , function -> regex , function
		this.move = function( ) {};

		// String , Number , Boolean -> 'what' , 10 , overwrite:false
		this.insert = function() {};
		
		// what:String , from:Number , to:Number
		// what:Regex , from:Number , to:Number
    	this.contains = function( what , where ) {
    		
    		return false;
    	};
		
    	// what:String , where:Number
    	this.set = function() {};
    	
    	this.get = function() {};    	
			
		return this;		
	};
	xString.H = '0123456789abcdef';
	xString.N = '0123456789';
	xString.L = 'abcdefghijklmnopqrstuvwxyz';
	xString.P = ' _.,:;=*+-!?()[]{}<>/|\\\'"%$#&@';

window.onload = function() {
	
	DEV.run();
};




























