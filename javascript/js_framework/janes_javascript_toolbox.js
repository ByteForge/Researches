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

var jt = new (function(){
    this.init = function() {
        //trace( 'hello you!' );
        
        //jDocument.title();
        
        //jBody.addChild( new jElement );
        
        trace('.....');

        var div = new jDiv();        
        jBody.addChild( div );
                
        //var t = new Date().getTime();
        /*
        div.___.div.style.left = '50%';
        div.___.div.style.top = '50%';
        div.___.div.style.width = '10px';
        div.___.div.style.height = '10px';
        */        
        
        div.x( '50%' );
        div.y( '50%' );
        div.w( '10' );
        div.h( '10' );

        //trace( div.___.div.style.display );
        
        //trace( div.x( '50%' ) );
        //trace( div.y( '50%' ) );
        //trace( div.w( '10' ) );
        //trace( div.h( '10' ) );

        //trace( new Date().getTime() - t );

        trace('.....');
        
        //div['background-color']();

        //trace( div['background-color'] );
        //div['background-color']();
        
        //trace( div['-background-color'] );
        //div['-background-color']();
        
        //trace( div.css['background-color'] );
        //div.css['background-color']();
        
        //trace( div.x(  ) );
        //trace( div.css['background-color'](  ) );        
    }
})();

/*
 * $super = this Super Class
 * $this = this Class
 * jClass.extends - extending
 * jClass.override - overriding
 */
var jClass = new (function(){
    
})();

function jEvent(){};

var jCookies = new (function(){})();
    function jCookie(){};
    function jSubCookie(){};

var jBrowser = new (function(){})();

var jDocument = new (function(){
    
    this.title = function( value ) {
        trace( document.title );
    };
        
})();

var jBody = new(function(){
    var $this = null;
        
    this.numChildren = function() {
        return 0;
    };
    
    this.addChild = function( child ) {
        if( child instanceof jElement ) {        
            trace( 'child is an instance of jElement' );
            if( child instanceof jDiv ) {
                trace( 'child is an instance of jDiv' );
                trace( child.$.div );
                //$this = window.document.body;
                //trace( $this , window.document.body );
                
                $this.appendChild( child.$.div );
            }
        } else {
            trace( child , 'is not applicable' );
        }
    };
    
    $this = window.document.body;
    //trace( $this );
})();

function jElement(){};

jDiv.prototype = new jElement(); 
jDiv.prototype.constructor = jDiv;
    jDiv.prototype.init = false
    jDiv.prototype.rawElement = null;
    //jDiv.prototype.rawElement = window.document.createElement('div');
function jDiv() {
    this.$ = {
        div : 0 ,
        sL : 0 , sLM : 1
    };
    var _ = this;    
    /*
    var ß = '';
    var π = 10;
    var Ł = 8;
    var ł = 8;
    var Đ = 8;
    var đ = 8;
    var ä = 8;
    */
    /*
    var œ = 10;
    var µ = 10; // ALT + 0181
    var Þ = 10;
    var Þ = 10;
    var æ = 10;
    */
    /*
    var Ʃ = 10;
    var ƿ = 10;
    var Ω = 10;
    var Ο = 10;
    */
    
    var Δ = 10;
    var β = 11;
    
    
    // TEMPORARY VARIABLES
    
    
    var _a = 0;
    var _b = 0;
    var _c = 0;
    
    var _e = 0;
    var _o = 0;
    var _s = 0;
    
    var _i = 0;
    var _j = 0;
    var _k = 0;
    var _l = 0;
    
    var _v = 0;
    var _n = 0;

    var o = 0; // Inner Object variable
    var s = 0; // Style variable
    
    var xU = 'px';

    this._x = function( v1 ) {
        if( v1 instanceof Number ) {
            if( v1 != v1 ) { v1 = 0; } 
            o.sL = v1;
            s.left = v1+xU; return v1;
        } else if( v1 instanceof String ) {            
            _n = parseFloat( v1 );
            if( _n != _n ) { _n = 0; };
            o.sL = _n;
            if( v1.indexOf('px') > -1 ) { xU = 'px'; s.left = _n+xU; return _n; }
            if( v1.indexOf('%') > -1 ) { xU = '%'; s.left = _n+xU; return _n; }
            if( v1 == 'px' ) { xU = 'px'; s.left = o.sL+xU; return o.sL; }            
            if( v1 == '%' ) { xU = '%'; s.left = o.sL+xU; return o.sL; }            
        } else {
            return o.sL;
        }
    }
    
    this.x = function( value ) {        
        _v = value; _s = _.$.div.style;
        switch ( ( typeof value === 'number' ) ? 1 : ( typeof value === 'string' ? 2 : 3 ) ) {
            case 1: // 'number'                
                _s.left = ( ( value == value ) ? value : 0 )+'px'; break;
            case 2: // 'string'
                _e = parseFloat( value ); _s.left = ( _e == _e ? _e : 0 )+( value.indexOf('px') !=-1 ? 'px' : ( value.indexOf('%') !=-1 ) ? '%' : 'px' ); break;
            default: break;
        }       
        _e = null;
        return _s.left;
    };
    this.y = function( value ) {
        _s = _.$.div.style;
        switch ( ( typeof value === 'number' ) ? 1 : ( typeof value === 'string' ? 2 : 3 ) ) {
            case 1: // 'number'
                _s.top = ( ( value == value ) ? value : 0 )+'px'; break;
            case 2: // 'string'
                _e = parseFloat( value ); _s.top = ( _e == _e ? _e : 0 )+( value.indexOf('px') !=-1 ? 'px' : ( value.indexOf('%') !=-1 ) ? '%' : 'px' ); break;
            default: break;
        }       
        _e = null;
        return _s.top;
    };
    this.width = this.w = function( value ) {
        _s = _.$.div.style;
        switch ( ( typeof value === 'number' ) ? 1 : ( typeof value === 'string' ? 2 : 3 ) ) {
            case 1: // 'number'
                _s.width = ( ( value == value ) ? value : 0 )+'px'; break;
            case 2: // 'string'
                _e = parseFloat( value ); _s.width = ( _e == _e ? _e : 0 )+( value.indexOf('px') !=-1 ? 'px' : ( value.indexOf('%') !=-1 ) ? '%' : 'px' ); break;
            default: break;
        }       
        _e = null;
        return _s.width;
    };
    this.height = this.h = function( value ) {
        _s = _.$.div.style;
        switch ( ( typeof value === 'number' ) ? 1 : ( typeof value === 'string' ? 2 : 3 ) ) {
            case 1: // 'number'
                _s.height = ( ( value == value ) ? value : 0 )+'px'; break;
            case 2: // 'string'
                _e = parseFloat( value ); _s.height = ( _e == _e ? _e : 0 )+( value.indexOf('px') !=-1 ? 'px' : ( value.indexOf('%') !=-1 ) ? '%' : 'px' ); break;
            default: break;
        }       
        _e = null;
        return _s.height;
    };
    this.visible = this.v = function( value ) {
        
    };
    this.alpha = this.a = function( value ) {};
    this.enabled = this.e = function( value ) {};
    this.rotation = this.r = function( value ) {};
    this.scaleX = this.sX = function( value ) {};
    this.scaleY = this.sY = function( value ) {};    
    this.skewX = this.skX = function( value ) {};
    this.skewY = this.skY = function( value ) {};
    
    this.css = {};
    
    var bgc = 'background-color';    
    
    this['-'+bgc] = this[bgc] = this.css[bgc] = function() {
        //trace( 'background-color - hello you!' );
        
        var f = function() {
            var i = arguments.length;
            if( i > 0 ) {
                var a = arguments;
                var n = 0;
                
                if( i === 1 ) {
                    var e = a[0];
                    if( typeof e === 'number' ) {
                        trace( 'number' , e );
                        n = ( e >= 0 && e <= 0xFFFFFF ) ? e : ( e < 0 ) ? 0 : ( e > 0xFFFFFF ) ? 0xFFFFFF : e;
                        trace( n , n.toString( 16 ).toUpperCase() );
                    } else if( typeof e === 'string' ) {
                        if( e.indexOf('0x') !== -1 ) {
                            trace( 'hex string' , e );
                            e = parseInt( e.split(' ').join('') , 16 );
                            n = ( e >= 0 && e <= 0xFFFFFF ) ? e : ( e < 0 ) ? 0 : ( e > 0xFFFFFF ) ? 0xFFFFFF : e;
                            trace( n , n.toString( 16 ).toUpperCase() );
                        } else if( e.indexOf('#') !== -1 ) {
                            trace( 'css hex string' , e );
                            e = parseInt( e.split(' ').join('').split('#').join('') , 16 );
                            n = ( e >= 0 && e <= 0xFFFFFF ) ? e : ( e < 0 ) ? 0 : ( e > 0xFFFFFF ) ? 0xFFFFFF : e;
                            trace( n , n.toString( 16 ).toUpperCase() );
                        } else if( e.indexOf('rgba') !== -1 ) {
                            trace( 'css rgba string' , e );                            
                        } else if( e.indexOf('rgb') !== -1 ) {
                            trace( 'css rgb string' , e );
                        } else if( e.indexOf('hsla') !== -1 ) {
                            trace( 'css hsla string' , e );
                        } else if( e.indexOf('hsl') !== -1 ) {
                            trace( 'css hsl string' , e );
                        } else {                            
                            trace( 'unknown type');
                            trace( e );
                            e = e.match( /[0-9a-f]{1,6}/ig );
                            e = ( e !== null ) ? e = parseInt( e.join('') , 16 ) : 0;
                            
                            //e = parseInt( e.match( /[0-9a-f]{1,8}/ig ).join('') , 16 );
                            //var n = parseInt( e.match( /[0-9a-f]{1,8}/ig ).join('') , 16 )
                            n = ( e >= 0 && e <= 0xFFFFFF ) ? e : ( e < 0 ) ? 0 : ( e > 0xFFFFFF ) ? 0xFFFFFF : e;
                            trace( n );
                            //trace( parseInt( e.match( /[0-9a-f]{1,8}/ig ).join('') , 16 ) );
                        }
                    } else if( typeof e === 'object' ) {
                        
                    } else {
                        n = 0;
                    }
                }
                
                return;
                
                //trace( arguments , arguments.length );
                                
                if( i === 1 ) {                    
                    if( typeof a[0] === 'number' ) {
                        trace( 0x01FFFFFF > 0xFFFFFF );
                        
                        var n = a[0];
                        if( n < 0 ) {n = 0;}
                        if( n > 0xFFFFFFFF ) {n = 0xFFFFFFFF;}
                        trace( 'number' );
                        trace( n );
                    } else if( typeof a[0] === 'string' ) {
                        trace( 'string' );
                        trace( a[0] );
                    } else if( typeof a[0] === 'object' ) {
                        trace( 'object' );
                        trace( a[0].argb );
                        trace( a[0].rgb );
                        trace( a[0].a , a[0].r , a[0].g , a[0].b );
                        trace( a[0].a , a[0].h , a[0].s , a[0].l );
                    } else if( a[0] instanceof jColor ) {
                        
                    } else {
                        
                    }
                }
                                
            } else {
                trace('no argument');
            }            
        };
        
        //f( 0xFFFFFFFF);
        //f( '0xFF0000' );
        //f( {} );
        //f( { a : 7 } );
        //f( { rgb : 12 } );
        
        var ts = function( value ) {
            trace( arguments.length > 0 );
            trace( arguments[0] != null );
            trace( typeof arguments[0] );
        };
        
        ts( NaN );
        
        return;
        
        //f( '0x 0 0 F F 0 0 FF' );
        //f( ' # 00 FF 00 ' );
        f( 'rgba(100% 12 255 0.5)' );
        /*        
        f( 'rgba 00FF00' );
        f( 'rgb 00FF00' );
        f( 'hsla 00FF00' );
        f( 'hsl 00FF00' );
        f( '0FF' );
        */
        
        return;
        
        var s = '# FCAAAA';
        //var s = '';
        //var regex = /#|\s/ig;        
        var regex = /[0-9a-f]{1,8}/ig;
            trace( s );
            //trace( s.replace( regex , '' ) );
            //trace( s.match( regex ) );
        var re = s.match( regex )
        if( re !== null ) {
            //trace( re.join('') );
            //trace( re.join('').substr(0,8) );
            var str = re.join('').substr(0,6);
            trace( str , str.length );
            var L = str.length;
            switch (L) {
                case 1:
                    trace('1 shorthand' , '#'+str+str+str+str+str+str );
                    break;
                case 2:
                    trace('2 shorthand' , '#'+str[0]+str[0]+str[0]+str[1]+str[1]+str[1] );
                    break;
                case 3:
                    trace('3 shorthand' , '#'+str[0]+str[0]+str[1]+str[1]+str[2]+str[2] );
                    break;
                case 4:
                    trace( '4' , '#00'+str );
                    break;
                case 5:
                    trace( '5' , '#0'+str );
                    break;
                case 6:
                    trace( '6' , '#'+str );                
                    break;
                default:
                    break;
            }

        } else {
            trace('re is null');
        }
        
       
        /*
        { rgb:0xFF0000 }
        { argb:0xFF0000 }
        { r:100 , '100%' }
        { r:100 , '100%' }
        
        'argb[0xFF0000]'
        
        var c = 0xFF80FF;
        
        trace( 'a' , c >> 24 & 0xff );
        trace( 'r' , c << 8 >> 24 & 0xff );
        trace( 'g' , c << 16 >> 24 & 0xff );
        trace( 'b' , c << 24 >> 24 & 0xff );
        
        trace( '.....' );
        
        trace( 'a' , c >> 24 & 0xff );
        trace( 'r' , c >> 16 & 0xff );
        trace( 'g' , c >> 8 & 0xff );
        trace( 'b' , c & 0xff );
        */
        /*
        
        add , sub , mul div colors
        
        '#FFF';
        255,255,255,255;
        rgba - '255','100%','255','100%';
        hsla - '120%';
        */
    }
        
    this.addChild = function(){};
    this.removeChild = function(){};
    this.hasChild = function(){};
    
    this.addListener = function(){};
    this.removeListener = function(){};
    this.hasListener = function(){};
    
    // Init block
    if( jDiv.prototype.init === false ) {
        jDiv.prototype.rawElement = window.document.createElement('div');
        jDiv.prototype.init = true;
    }
    _.$.div = jDiv.prototype.rawElement.cloneNode(false);
    _.$.div.style.position = 'absolute';
    _.$.div.style.left = '0px';
    _.$.div.style.top = '0px';
    _.$.div.style.width = '10px';
    _.$.div.style.height = '10px';
    _.$.div.style.backgroundColor = '#FF0000';
        o = _.$;
        s = _.$.div.style;
};

function jCSS() {};
jCSS.addStyle = function(){};
jCSS.addClass = function(){};

var jUnitMode = new (function(){
    var m = 'jUM-';
        
    this.AUTO = m+'A';    
    this.PIXEL = m+'PI';
    this.PERCENT = m+'PE';
        this.DEFAULT = this.AUTO;
})();

/*
 * Modes:
 *  - default ( mixed )
 *  - global ( all items + children )
 *  - family ( item + children )
 *  - item ( per item )
 *  - mixed ( per method )
 */
var jColorMode = new (function(){
    var m = 'jColorMode-';
    
    this.DEFAULT = m+'DEFAULT';
        this.GLOBAL = m+'GLOBAL';
        this.FAMILY = m+'FAMILY';
        this.ITEM = m+'ITEM';
        this.MIXED = m+'MIXED';
    
    var _mode = this.DEFAULT;
    
    this.mode = function( value ) {
        
        return _mode;
    }
    
        this.AUTO = m+'AUTO';
        this.HEX = m+'HEX'; //( 0x00FF00 ) ; ( '0xFF0000' )
        this.HEXA = m+'HEXA'; //( 0xFF00FF00 , false ) ; ( 0xFF00FF00 , 0-1 / '0%-100%' )
        this.CSS_HEX = m+'CSS_HEX'; // ( '#00FF00' )
        this.CSS_HEXA = m+'CSS_HEXA'; // ( '#FF00FF00' , false ) ; ( '#FF00FF00' , 0-1 / '0%-100%' )
        this.CSS_RGBA = m+'CSS_RGBA'; // ( 'rgba(0-100%,0-255,0-100%,0-1)' ; ... , 0-1 / '0%-100%' )
            // ( 'rgba' , 0-255 , '0%-100%' , 0-255 , 0-1 )
        this.CSS_RGB = m+'CSS_RGB';
        this.CSS_HSLA = m+'CSS_HSLA';
        this.CSS_HSL = m+'CSS_HSL';        
})();

function jColor(){};
jColor.blend = function(){};
    jColor.add = function(){};
        jColor['+'] = function(){};
    jColor.sub = function(){};
        jColor['-'] = function(){};
    jColor.multiple = function(){};
        jColor['*'] = jColor['x'] = function(){};
    jColor.divide = function(){};
        jColor['/'] = jColor['÷'] = function(){};

jColor.HEXtoRGB = function(){};
jColor.HEXtoRGBA = function(){};
jColor.HEXtoHSL = function(){};
jColor.HEXtoHSLA = function(){};
//jColor.HEX['->'].HSLA
//jColor['HEX->HSLA']

function jTween() {};

window.onload = jt.init();