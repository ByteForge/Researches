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
	
	this.to = function( object , duration , value ){		
		Tween.$.add( object , duration , value );
	};
	
}
	Tween.$ = new ( function() {		
		var _this = this;
		
		_this.fps = 25;	
		_this.a = [];
		_this.iID = 0;
		_this.running = false;
		this.update = function() {
			var a = _this.a;
			var L = _this.a.length;
			var i = L;
			if( L > 0 ) {
				if ( _this.running ) {
					
					while(i--) {						
						var o = _this.a[i];
						
						//trace( o.startTime , o.endTime );
						
						var cT = new Date().getTime();
						var p = ( cT - o.startTime ) / 1000;
						
						if( cT < o.endTime ) {
							trace( i , 'progress' , p );
						} else {
							p = 1;							
							trace( i , 'end' , p );
							_this.a.splice( i , 1 );
							//trace( _this.a.length );
						}
					}
					
				} else {
					window.setInterval( _this.update , 1000 / this.fps , 'JavaScript' );
					_this.running = true;
					_this.update();
				}
			} else {				
				window.clearInterval( _this.iID );
				_this.running = false;
			}
		};
		
		this.add = function( object , duration , value ){
			/* startTime , endTime , object , duration , value , function */
			this.a.push({
				startTime : new Date().getTime() ,
				endTime : new Date().getTime() + ( duration * 1000 ) ,
				startValue : object ,
				endValue : value ,
				diffValue : value - object
			});
			
			//trace( this.a.length );
			
			this.update();
		};
		
	} )();
	
	Tween.fps = function() {
		
	};
	Tween.to = function( object , duration , value ){
		//trace( 'static to()' );
		//trace( 'object:' , object );
		//trace( 'duration:' , duration );
		//trace( 'value:' , value );
		//trace( '----- ----- -----' );
		
		trace( this.$.add );
		
		//new Tween().to( object , duration , value );
	};

function start() {
	
	//Tween.to( 100 , 1 , 200 );
	//Tween.to( 100 , 1 , 200 );
	//Tween.to( 100 , 1 , 200 );
	//Tween.to( 100 , 1 , 200 );
	//Tween.to( 100 , 1 , 200 );
	
	trace('hello you');
}

window.onload = function() {
	window.setTimeout(start,1000);
};



































































