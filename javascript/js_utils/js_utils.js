"use strict";

var initialize = function() {
    //alert("initialized");
    
    var f = function() {
        log( "called f()" );
        
        var m = Math.pow( 2, 53 );
                
        log( m );
        log( (m+100) );
        
        return;
        //var o = asObject( arguments );
        //var o = asObject( ["a", null, undefined, Infinity, 2, 4] );
        //var o = asObject( document.getElementsByTagName("div") );
        var o = asObject( '{ "a": 1, "b": true, "c": "string" }' );
        //log( o );
        for( var obj in o ) {
            log( typeof o, obj, o[obj], typeof o[obj] );
        }
        
        return;
        log( arguments, typeof arguments, Object.prototype.toString.call(arguments), arguments.length );
        
        var list = document.getElementsByTagName("div");        
        log( list, typeof list, Object.prototype.toString.call(list), list.length );
        
        //var array = asArray('{ "a": 1, "b": true, "c": "string" }');
        var array = asArray({ 1: 1, "b": true, "c": "text" });
        log( array, typeof array, Object.prototype.toString.call(array), array.length );
        
        var NAN = function fNAN(){};
        var o = NAN;
        
        log( undefined == undefined, undefined === undefined );
    };  
    
    //f( 1, 2, 3 );
    //stringTests();
    //ArraysTests();
    
    var object = {};
    //var object = document.getElementsByTagName("div");
    //log( object, object.toString(),  Object.prototype.toString.call( object ) );
};
function ArraysTests() {
    log("ArraysTests");
    
    var emptyArray = [];
    var smallArray = [ 1, 2, 3, 4, 5, 6, 7, 8, 9 ];
    
    //Arrays.getRandom();
    //log( Arrays.getRandom( smallArray ) );
    
    for( var i = 0; i < 10; ++i ) {
        ilog( i, Arrays.getRandom( smallArray ) );
    }
};

function stringTests() {
    log("String Tests");
    
    var s = "abc";
    
    log( String.prototype.setChar );
    String.prototype.setChar = function( index, value ) {
        var r = this.substring(0, 1) + value + this.substring(2, 1);
        return r;
    };    
    log( String.prototype.setChar );
    
    log( s );
    s = s.setChar( 1, "-" );
    log( s );
}

// Log
var Log = function() {};

    // Type Representations
        // NULL
        Log.____defaultNull = function( nullValue ) {
            return "null";
        }; 
        Log.setNull = Log.____defaultNull;
        Log.nullRepresentation = function( value ) {
            return Log.setNull( value );
        };
        // UNDEFINED
        Log.____defaultUndefined = function( undefinedValue ) {
            return "undefined";
        }; 
        Log.setUndefined = Log.____defaultUndefined;
        Log.undefinedRepresentation = function( value ) {
            return Log.setUndefined( value );
        };
        // NAN
        Log.____defaultNAN = function( nanValue ) {
            return "NaN";
        }; 
        Log.setNAN = Log.____defaultNAN;
        Log.nanRepresentation = function( value ) {
            return Log.setNAN( value );
        };
        // BOOLEAN
        Log.____defaultBoolean = function( booleanValue ) {
            return ( booleanValue === true ? "true" : "false" );
        }; 
        Log.setBoolean = Log.____defaultBoolean;
        Log.booleanRepresentation = function( value ) {
            return Log.setBoolean( value );
        };
        // STRING
        Log.____defaultString = function( stringValue ) {
            return  '"' + stringValue + '"';
        };        
        Log.setString = Log.____defaultString;
        Log.stringRepresentation = function( value ) {
            return Log.setString( value );
        };
        // NUMBERS
        Log.____defaultNumber = function( numberValue ) {
            return numberValue;
        };
        Log.setNumber = Log.____defaultNumber;
        Log.numberRepresentation = function( value ) {
            return Log.setNumber( value );
        };
        // ARRAY
        Log.____defaultArray = function( arrayValue ) {
            if( arrayValue.length > 0 ) {
                return "[ " + arrayValue.join(", ") + " ]";
            }
            return "[]";
        }; 
        Log.setArray = Log.____defaultArray;
        Log.arrayRepresentation = function( value ) {
            return Log.setArray( value );
        };
        // OBJECT
        Log.____defaultObject = function( objectValue ) {
            if( Object.prototype.toString.call( objectValue ) === "[object Object]" ) {
                var r = "{ ";
                for( var obj in objectValue ) {
                    r += obj.toString() +": "+ objectValue[obj];
                };
                r += "} ";
                return r;
            }
            return objectValue.toString();
        }; 
        Log.setObject = Log.____defaultObject;
        Log.objectRepresentation = function( value ) {
            return Log.setObject( value );
        };
    
    
    Log.setSeparator; // , , ,
    Log.setClosure; // [...]
    Log.setLogFunction = function() {};
    
        

function ___logFunction( args, indentation, separator, closure ) {
    var r = "";
    var i = indentation;
    i = ( i > 0 ? ( i < 64 ? i : 64 ) : 0 );    
    while( i-- ) {
        r += "\t";
    }
            
    for( var i=0, L=args.length, B=L-1; i<L; ++i ) {
        var o = args[i];
        
        if( o !== null ) {
            if( typeof o === "undefined" ) {
                r += "undefined";
            } else if( typeof o === "object" ) {
                if( Object.prototype.toString.call( value ) === '[object Array]' ) {
                    //r += Log.
                }
            } else {
                r += o.toString();
            }    
        } else {
            r += "null";
        }
        
        if( i<B ) {
            r += ", ";
        }
    }
    return r;
};
function log() {
    var args = Array.prototype.slice.call( arguments, 0 );
    console.log( ___logFunction( args )  );
};
function ilog( indentation ) {
    if( arguments.length > 1 ) {
        var args = Array.prototype.slice.call( arguments, 0 );
        args.splice( 0, 1 );
        console.log( ___logFunction( args, indentation )  );        
    } else {
        console.log( "" );
    }
};
function tlog() {};
function itlog() {};
function logr() {};
function type() {};

// ARRAY
function Arrays() {
    
    Arrays.prepend = function() {}; // pop
    Arrays.append = function() {}; // push
    Arrays.sort = function() {};
    Arrays.add = function() {}; //
    Arrays.insert = function( index, value ) {}; //
    Arrays.remove = function( index ) {}; //        
};
    Arrays.clear = function( array ) {        
    };
    Arrays.getRandom = function( array, defaultValue ) {
        if( array !== null && array.length > 0 ) {
            var length = array.length;
            
            if( length > 1 ) {
                return array[ Math.round((Math.random() * (length-1))) ];
            } else {
                return array[0];
            }
        }                
        return ( arguments.length > 1 ? arguments[1] : undefined );
    };

// STRING
function Strings() {};
    Strings.getChar = function() {};
    Strings.setChar = function() {};
    Strings.insert = function() {};
    Strings.remove = function() {};
    Strings.toArray = function() {};
    Strings.getRandom = function() {};

// SEARCH PATTERN - replace RegExp
function isNull( value ) {
    return ( value === null ? true : false );
}
function isUndefined( value ) {
    return (typeof value === "undefined" ? true : false);
};
function isNumber( value ) {
    if( typeof value === "number" && value === value && value !== Infinity && value !== -Infinity ) {
        return true;
    }
    return false;
};
function isNAN( value ) {
    //return ( value !== value ? true : false );
    if( value !== value || value === Infinity || value === -Infinity ) {
        return true;
    }
    return false;
};
function isInfinity( value ) {
    return ( value === Infinity && value === -Infinity ? true : false );
};
function isObject( value ) {
    return ( value !== null && typeof value === "object" ? true : false );
};
function isArray( value ) {
    return ( value !== null && Object.prototype.toString.call( value ) === '[object Array]' ? true : false );    
};

function asArray( value ) {
    var t = typeof value;
    var r = [];
    
    if( value !== null ) {
        if( t === "string" && value.length > 0 ) {
            try {
                value = JSON.parse( value );
                t = typeof value;
            } catch( e ) {
                // Split string to an array
                
                // handle JSON parse exception
                //console.error(e);
                
                r = value.split("");
            }
        }
        
        if( Object.prototype.toString.call( value ) === '[object Array]' ) {
            return value;
        } else if( t === "object" ) {
            if( value.length && value.length > 0 ) {
                r = Array.prototype.slice.call( value, 0 );
            } else {
                var l = 0;
                for( var o in value ) {
                    r[l] = value[o];
                    ++l;
                }
            }
        }        
    }
    return r;
};
function asObject( value ) {
    var r = {};
    var t = typeof value;
    
    if( value !== null ) {
        if( t === "string" ) {
            try {
                value = JSON.parse( value );
                t = typeof value;
            } catch( e ) {
                // handle JSON parse exception
                console.error(e);
            }
        }
        
        if( t === "object" ) {
            if( value.length && value.length > 0 ) {
                value = Array.prototype.slice.call( value, 0 );
            }
            
            for( var o in value ) {
                r[o] = value[o];
            }
        }
    }
    
    return r;
};

function asBoolean( value ) {};
function asString( value ) {
    return value.toString();
};

function asInt( value ) {};
function asUInt( value ) {};
function asFloat( value ) {};
function asNumber( value ) {};

function typeOf( value ) {
    if( value === null ) {
        return "null";
    }        
    var t = typeof value;
    
    if( t === "object" ) {
        if( Object.prototype.toString.call( value ) === '[object Array]' ) {
            return "array";
        }
    }
    
    if( value !== value ) {
        return "nan";
    }
    if( value === Infinity ) {
        return "nan";
    }
    if( value === -Infinity ) {
        return "nan";
    }
    
    return t;   
};

// MATH
function minimum() {};
function maximum() {};
function average() {};
function absolute() {};

function round( value, decimalPlaces, roundingMode ) {    
};
function random() { // between 0-1, 1 inclusive
    var n = Math.random() * 1.001;
    return (n<1 ? n : 1);    
};

function randomInt( minimum, maximum, options ) {
    return 0;
};
function randomUInt( minimum, maximum, options ) {
    return 0;
};
function randomFloat( minimum, maximum, options ) {
    return 0;
};

// INPUT VALIDATION
function inputIsNumber() {};
function validateNumber() {};
























