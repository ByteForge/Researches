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

function Tween() {
	var $ = this.$ = {};
	var _this = this;
	
	var obj = 0;
	var dur = 0;
	var val = 0;
	
	var fps = 25-2;
	var iID = 0;
	
	var sT = 0;
    var cT = 0;
    var eT = 0;	
    var p = 0;
    
    var sV = 0;
    var cV = 0;
    var eV = 0;
    var dV = 0;
	
    var i = -1;
    
    var onT = function(){
		cT = new Date().getTime()-sT;
    	p = cT / 1000;
    	//p = cT * 0.001;
    	
    	cV = sV + ( dV * p );
    	
    	i++;
    	
    	if( cT < eT ) {
    		
    		trace( i , 'progress' , p , cV );
    		
    	} else {
    		p = 1;
    		cV = eV;
    		
    		trace( i , 'end' , p , cV );
    		window.clearInterval( iID );
    	}
	};
    
	this.fps = function(){
		
	};	
	this.to = function( object , duration , value ){
		trace('instance to');
		obj = object;
		dur = duration;
		val = value;
		
			sV = object;
			eV = value;
			dV = eV - sV;
			
		sT = cT = new Date().getTime();
		eT = dur*1000;
		
		iID = window.setInterval( onT , 1000/fps , 'JavaScript' );
		onT();
	};
	
}
	Tween.$ = {
		fps : 25 ,
		a : [] , // PRIMARY TWEEN ARRAY
		/*
			[ intervalID , eventListeners... , ]
		*/
		b : [] , // SECONDARY TWEEN ARRAY
		onT : function(){
			
		}
	};
	Tween.fps = function() {
		
	};
	Tween.to = function( object , duration , value ){
		//trace( 'static to()' );
		//trace( 'object:' , object );
		//trace( 'duration:' , duration );
		//trace( 'value:' , value );
		//trace( '----- ----- -----' );
		
		new Tween().to( object , duration , value );
	};

function start() {
	
	Tween.to( 100 , 1 , 200 );
}

window.onload = function() {
	window.setTimeout(start,1000);
};



































































