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
 * implement:
 *      - 
 *      - 
 *      - 
 */
var JaneInitArguments = {
    
}

var Jane = new (function( arg ){
    var _this = null;
    this._ = {
        
    };
    
    this.onLOAD = function() {
        trace( 'Jane initialized' );
        
        Stage._.init();        
    }
    
    // Init Block
    _this = this;
    
})();
    var Stage = new (function(){
        var _this = null;
        this._ = {
            fps : 0 , // Stage FPS
            
            // RENDER Related
            div : null , // fundamental DIV container            
                        
            updates : null ,
            numUpdates : 0 ,
            needUpdate : false ,
            update : function() {
                
            } ,
            
            // CHILD Related
            children : null , // Children list
            numChildren : 0 ,
            queue : null , // Children related updates , add/remove queue
            numQueue : 0 ,
            
            lastObjID : 0 , // Individual Object ID
            genObjID : function() {
                _this._.lastObjID++;return _this._.lastObjID;
            } ,
            lastNameNum : 0 ,
            genName : function() {                
                //return 'instance' + String( Math.floor(Math.random()*10000) ); // 0 - 9999 , original formula: [ Math.floor(Math.random() * (1+max-min)) + min; ]
                _this._.lastNameNum++; return 'instance' + String( _this._.lastNameNum );
            } ,
            
            //TWEEN Related
            tweens : null , // Tween list
            currentTime : 0 , 
            intervalID : 0 , // interval ID for setInterval() timer function
                        
            renderLoop : function() {
                Stage._.currentTime = new Date().getTime();
                //trace( Stage._.intervalID );
                if( Stage._.needUpdate == true ) {
                    
                    
                    
                    Stage._.needUpdate = false;
                }
            } ,
            
            initialized : false ,
            init : function(){
                if( _this._.initialized == false ){
                    
                    _this._.initialized = true;
                }
                
                

                // RENDER Related
                Stage._.changeArray = [];

                // CHILD Related
                Stage._.childArray = [];
                Stage._.lastObjID = 0;
                
                // TWEEN Related                
                Stage._.tweenArray = [];
                
                // TIMER Related
                Stage._.fps = 25
                Stage._.intervalID = window.setInterval( Stage._.timer , Number( 1000 / Stage._.fps ).toFixed( 0 ) );
            }            
        }
                
        this.frameRate = function( value ){
            if( value != undefined || value != null ) {
                var q = Number( value ).toFixed( 1 );
                if( Stage._.fps != q ) {
                    Stage._.fps == q;
                    window.clearInterval( Stage._.Stage._.intervalID );
                    Stage._.intervalID = window.setInterval( Stage._.timer , Number( 1000 / Stage._.fps ).toFixed( 0 ) );
                }
            }
            return Stage._.fps;
        }
        this.mouseX = function(){}
        this.mouseY = function(){}
        
        this.width = function(){}
        this.height = function(){}
        
        this.numChildren = function(){
            return Stage._.childArray.length;
        };
        this.addChild = function( child ){
            if( child != undefined ) {
                var a = _this._.childArray;
                var i = a.length;
                while(i--) {
                    if( a[i]._.objID == child._.objID ) {
                        a.splice( i , 1 );
                    }
                }
                a.push( child );
                Stage._.needUpdate = true;
                return child;
            }
            return null;
        };
        this.hasChild = function(){};
        this.getChild = function(){};
        this.removeChild = function(){
            if( child != undefined || child != null || child._ != null || child._.objID != null ) {
                var a = Stage._.childArray;
                var i = a.length;
                while(i--) {
                    if( a[i]._.objID == child._.objID ) {
                        a.splice( i , 1 );
                        Stage._.needUpdate = true;
                        return child;
                    }
                }                
            }
            return null;
        };
        
        // Init block
        _this = this;
    });
    
    function Group( x , y , width , height ){
        var _this = null;
        
        this._ = {
            objID : 0 , // Individual Object ID            
            div : null , // Div                        
            
            // CHILD Related
            children : null , // Children list
            queue : null , // Children related updates , add/remove queue
            
            // Public Properties                        
            n : null , // 0x0001
            x : 0 , // 0x0001
            y : 0 , // 0x0002
            w : 0 ,
            h : 0 ,
            
            updates : null ,
            numUpdates : 0 ,
            needUpdate : false ,
            update : function() {
                //_this._.D;
                updates[i] = 0x0001;i++;
                updates[i] = 12;i++;
            }
        }
        
        this.x = function( value ) {
            if( value != undefined ) {
                var tX = _this._.x;
                var tU = _this._.updates;
                var tNU = _this._.numUpdates;                
                tX = value;tU[tNU] = 0x0001;tNU++;tU[tNU] = tX;tNU++;                
            }
            return _this._.x;
        }
        
        // Init block
        _this = this;
            _this._.objID = Stage._.genObjID();
            _this._.div = Group.div.cloneNode();
            
                _this._.n = Stage._.genName();
        
    };
        Group.div = window.document.createElement('div');
            
    function Sprite( x , y , width , height ){
        this._ = {
            
        }
        this.x = function(){};
        
        // Init block
        trace( x , y , width , height );
    };
    
    function Tween(){};
    Tween.to = function( object , duration , props , ease ){
        
    };
    
    function TimeLine(){};
    
    function CSS() {
        
    };
    //CSS.addClass = function(){};