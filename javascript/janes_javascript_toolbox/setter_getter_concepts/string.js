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

var Obj = new (function(){
	
	this['.'] = function( value ){
		trace( value );
	};
	
})();

/*
function A() {
	var _this = this;
	
	this['.'] = function( value ){
		trace( value );
	};	
	
	var A = function( value ){
		trace( value );
	};
		A.val = function( v ){
			trace( v );
		};
	
	trace( _this );
	//trace( A );
	
	return A;
};
*/



function A() {
	var _this = this;
	
	var _A = function( value ){
		trace( value );
		return null;
	};
		_A.getType = function() {
			return 'A';
		};
	
	//trace( A );
	
	return _A;
};

function onLOAD() {
	
	//trace('hello you');
	
	//Obj['.']('v');
	
	//trace( Obj['']('width=100px') );
	
	var obj = new A();
	
	trace( A , obj );
	//trace( obj instanceof A );
	//trace('...');
	//trace( obj() );
	//trace( A() );
	
	trace( obj.getType() );
	
	//obj('obj()');
	//A('A()');
	
	//trace( obj );
	//obj['.']('v');
	//trace( obj );
	
	//obj('val=10px');
	//obj('val','10px');
	//obj.val('10px');
	
	//obj('val');
	//obj.val();
	
	J('title=');
	
	var div = new J('div');
	var div = new jDiv();
	var div = new xDiv();
}

window.onload = function() {
	window.setTimeout(onLOAD,1000);
};




















