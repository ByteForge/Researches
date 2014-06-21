package clockdev {	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.PixelSnapping;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
		
	public class Clock extends Sprite {
		
		public var _stage:Stage;
		
		private var _hour:uint;
		private var _minute:uint;
		private var _second:uint;
				
		/*
			constructor(s):
				empty:
					new Clock();
				
		*/		
		public function Clock( ...parameters ) {
			
			this._hour = 0;
			this._minute = 0;
			this._second = 0;
			
		}
		
		public function tickMechanism(): void {
			
			if( this._second === 60 ) {
				this._second = 0;
				this._minute++;
			}
			
			if( this._minute === 60 ) {
				this._minute = 0;
				this._hour++;
			}
			
			if( this._hour === 24 ) {
				this._hour = 0;
			}
		}
		
		/*
			public properties:
				for each one:
					milliseconds
					seconds
					minutes
					hours
					-----
					days
					weeks
					months
					years
					-----
					decades
					centuries
					millenas / milleniums
					eras
				combined:
					adjust( ...parameters )
		*/
		public function get hour(): int {
			return this._hour;
		}
		public function set hour( value: int ): void {
			/*
			if( value > -1 && value < 13 ) {
				if( value !== 0 ) {
					this._hour = value;
				} else {
					this._hour = 12;
				}
			}
			*/
			this._hour = value;
		}
		public function get minute(): int {
			return this._minute;
		}
		public function set minute( value: int ): void {
			if( value > -1 && value < 60 ) {
				this._minute = value;
			}
			
			if( value === 60 ) {
				this._minute = 0;
				this._hour++;
			}
		}
		public function get second(): int {
			return this._second;
		}
		public function set second( value: int ): void {
			if( value > -1 && value < 60 ) {
				this._second = value;
			}
			
			if( value === 60 ) {
				this._second = 0;
				this._minute++;
			}
		}
		
		public function get inHours(): uint { return 0; }
		public function set inHours( value: uint ): void {}
		public function get inMinutes(): uint { return 0; }
		public function set inMinutes( value: uint ): void {}
		public function get inSeconds(): uint { return 0; }
		public function set inSeconds( value: uint ): void {}
		
		public function adjustHours(): uint { return 0; }
		public function adjustMinutes(): uint { return 0; }
		public function adjustSeconds(): uint { return 0; }
		
		public function traceTime(): void {
		
			TRACE( 1 )( "time: [ ",
				this._hour, ":", this._minute, ":", this._second
			," ]" );
		
		}
		
		public function drawClock(): void {
						
			if( this._stage.numChildren > 0 ) {
				this._stage.removeChildAt( 0 );
			}
							
			var sprite:Sprite = new Sprite();
				sprite.x = 10;
				sprite.y = 10;
				
			var g:Graphics = sprite.graphics;
				// DRAW PLATE
				g.beginFill( 0x000000 );
				g.drawCircle( 200, 200, 200 );
				g.endFill();
				// DRAW CENTRAL DOT
				g.beginFill( 0xFFFFFF, 0.50 );
				g.drawCircle( 200, 200, 25 );
				g.endFill();
				// DRAW MARKERS
				for( var i:uint = 0; i < 12; ++i ) {
					
					var centerX:Number = 200;
					var centerY:Number = 200;
					
					var lineDistance:Number = 175;
					var lineLength:Number = 20;
					
					var rad:Number = ( 1.5 + ( i / 6 ) ) * 3.1415;
					var x:Number = 0;
					var y:Number = 0;
					
					x = centerX + ( lineDistance * Math.cos( rad ) );
					y = centerY + ( lineDistance * Math.sin( rad ) );
					
					//TRACE( 1 )( i+".: ", "rad: "+rad, " x:["+x+"]", " y:["+y+"]" );
					
					g.lineStyle( 2, 0xFFFFFF );
					g.moveTo( x, y );
					g.lineTo(
						centerX + ( ( lineDistance + lineLength ) * Math.cos( rad ) ),
						centerY + ( ( lineDistance + lineLength ) * Math.sin( rad ) )
					);
				}
				// DRAW NUMBERS
				for( var i:uint = 0; i < 12; ++i ) {
					var textField:TextField = new TextField();
						textField.background = false;
						textField.border = true;
						textField.borderColor = 0x999999;
						textField.autoSize = TextFieldAutoSize.LEFT;
						if( i !== 0 ) {
							textField.text = i.toString();;
						} else {
							textField.text = "12";
						}						
						textField.setTextFormat(
							new TextFormat( null, 20, 0xFFFFFF )
						);
						
						//TRACE( 1 )( textField.text, "bounds: ", textField.getBounds( sprite ) );					
					
					var w:Number = textField.getBounds( sprite ).width + 1;
					var h:Number = textField.getBounds( sprite ).height + 1;
					
					var bitmapData:BitmapData = new BitmapData( w, h, true, 0x00000000 );
						bitmapData.draw( textField );
						
					var bitmap:Bitmap = new Bitmap( bitmapData, PixelSnapping.NEVER, true );
					
					var centerX:Number = 200;
					var centerY:Number = 200;
					
					var numDist:Number = 150;
					
					var rad:Number = ( 1.5 + ( i / 6 ) ) * 3.1415;
					var x:Number = 0;
					var y:Number = 0;
					
					x = centerX - ( bitmap.width / 2 ) + ( numDist * Math.cos( rad ) );
					y = centerY - ( bitmap.height / 2 ) + ( numDist * Math.sin( rad ) );
					
					bitmap.x = x;
					bitmap.y = y;
					
					sprite.addChild( bitmap );
				}
				
				// DRAW NEEDLES
					// DRAW SECOND NEEDLE
					var color:Number = 0xFF0000;
					
					var centerX:Number = 200;
					var centerY:Number = 200;
					
					var needleH:Number = 150;
					var needleW:Number = 8;
					
					var shape:Shape = new Shape();
					g = shape.graphics;
					g.beginFill( color, 0.45 );
					g.lineStyle( 2, color, 0.65 );
					g.moveTo( 0, needleH );
					g.lineTo( needleW, needleH );
					g.lineTo( needleW / 2, 0 );
					g.lineTo( 0, needleH );
					g.endFill();
					
					var matrix:Matrix = shape.transform.matrix;
					matrix.translate( -needleW / 2, -needleH );
					//matrix.rotate( 0 * 3.1415 );
					matrix.rotate( ( this._second / 30 ) * 3.1415 );
					matrix.translate( centerX, centerY );
										
					shape.transform.matrix = matrix;
										
					sprite.addChild( shape );
					
					// DRAW MINUTE NEEDLE
					var color:Number = 0x00FF00;
					
					var centerX:Number = 200;
					var centerY:Number = 200;
					
					var needleH:Number = 125;
					var needleW:Number = 20;
					
					var shape:Shape = new Shape();
					g = shape.graphics;
					g.beginFill( color, 0.45 );
					g.lineStyle( 2, color, 0.65 );
					g.moveTo( 0, needleH );
					g.lineTo( needleW, needleH );
					g.lineTo( needleW / 2, 0 );
					g.lineTo( 0, needleH );
					g.endFill();
					
					var matrix:Matrix = shape.transform.matrix;
					matrix.translate( -needleW / 2, -needleH );
					//matrix.rotate( 0 * 3.1415 );
					matrix.rotate( ( this._minute / 30 ) * 3.1415 );
					matrix.translate( centerX, centerY );
										
					shape.transform.matrix = matrix;
										
					sprite.addChild( shape );
					
					// DRAW HOUR NEEDLE
					var color:Number = 0xFFFF00;
					
					var centerX:Number = 200;
					var centerY:Number = 200;
					
					var needleH:Number = 100;
					var needleW:Number = 40;
					
					var shape:Shape = new Shape();
					g = shape.graphics;
					g.beginFill( color, 0.45 );
					g.lineStyle( 2, color, 0.65 );
					g.moveTo( 0, needleH );
					g.lineTo( needleW, needleH );
					g.lineTo( needleW / 2, 0 );
					g.lineTo( 0, needleH );
					g.endFill();
					
					var _h:Number = this._hour;
					
					if( _h > 12 ) {
						_h = _h - 12;
					} else if( _h === 12 ) {
						_h = 0;
					}
					
					var matrix:Matrix = shape.transform.matrix;
					matrix.translate( -needleW / 2, -needleH );
					//matrix.rotate( 0 * 3.1415 );
					matrix.rotate( ( _h / 6 ) * 3.1415 );
					matrix.translate( centerX, centerY );
										
					shape.transform.matrix = matrix;
										
					sprite.addChild( shape );
				
			this._stage.addChild( sprite );
		}
	}
}