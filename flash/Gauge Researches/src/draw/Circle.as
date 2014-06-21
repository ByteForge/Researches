package draw {
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	public class Circle {
		
		public static function drawCircle( stage:Stage ): void {
		
			var bitmapData:BitmapData = new BitmapData( 200, 200, true );
			var bitmap:Bitmap = new Bitmap( bitmapData, PixelSnapping.ALWAYS, true );
			bitmap.width = 500;
			bitmap.height = 500;
			
			//bitmapData.setPixel( 50, 50, 0x000000 );
			
			var r:Number = 75;
			var O:Point = new Point( 100, 100 );
			
			//trace( Math.PI );
			var segments:uint = 25;
			
			var degrees:Number = 90;
			
			for( var i:uint = 0; i <= segments; i++ ) {
				
				var percent:Number = i / segments;
				var radians:Number = ( ( degrees * percent ) / 180 ) * Math.PI;
				
				radians = ( Math.PI * 2 ) - radians;
				
				if( radians > ( degrees / 180 * Math.PI ) ) {
					//break;
				}
				
				//var t:Number = ( 2 * Math.PI ) * percent;
				var t:Number = radians;
				
				var x:Number = O.x + ( r * Math.cos( t ) )
				var y:Number = O.y + ( r * Math.sin( t ) )
				
				trace( i, percent, t, radians );
				
				//bitmapData.setPixel( x, y, 0x000000 );
				bitmapData.setPixel( Math.round( x ), Math.round( y ), 0x000000 );
			}
			
			stage.addChild( bitmap );
		}
		
		public static function drawCircle2( stage:Stage ): void {
		
			var bmd:BitmapData = new BitmapData( 250, 250 );
			
			var radius:Number = 75;
			var center:Point = new Point( 125, 125 );
			
			//var startAngle:Number = 225;
			//var endAngle:Number = 315;
			
			var startAngle:Number = 315;
			var endAngle:Number = 225;
			
			var segments:uint = 180;
						
			for( var i:uint = 0; i <= segments; i++ ) {
				
				var percent:Number = i / segments;
				
				var rad:Number = ( 2 * Math.PI ) - ( ( 2 * Math.PI ) * percent );
				var deg:Number = 360 - ( rad * 180 / Math.PI );
				
				trace( rad, deg );
				//trace( rad, 360 - ( rad * 180 / Math.PI ) );
				
				var x:Number;
				var y:Number;
				
				if( startAngle < endAngle ) {				
					if( deg >= startAngle && deg <= endAngle ) {
						//trace( "draw" );
						
						x = center.x + ( radius * Math.cos( rad ) );
						y = center.y + ( radius * Math.sin( rad ) );
						
						bmd.setPixel( Math.round( x ), Math.round( y ), 0x000000 );
					}
				} else {
				
					if( deg <= endAngle || deg >= startAngle ) {
					
						x = center.x + ( radius * Math.cos( rad ) );
						y = center.y + ( radius * Math.sin( rad ) );
						
						bmd.setPixel( Math.round( x ), Math.round( y ), 0x000000 );
						
						x = center.x + ( ( radius + 5 ) * Math.cos( rad ) );
						y = center.y + ( ( radius + 5 ) * Math.sin( rad ) );						
						bmd.setPixel( Math.round( x ), Math.round( y ), 0xFF0000 );
						
						x = center.x + ( ( radius + 6 ) * Math.cos( rad ) );
						y = center.y + ( ( radius + 6 ) * Math.sin( rad ) );						
						bmd.setPixel( Math.round( x ), Math.round( y ), 0xFF0000 );
						
						x = center.x + ( ( radius + 7 ) * Math.cos( rad ) );
						y = center.y + ( ( radius + 7 ) * Math.sin( rad ) );						
						bmd.setPixel( Math.round( x ), Math.round( y ), 0xFF0000 );
						
					}
				}
				
				
				/*
				var t:Number = rad;				
				var x:Number = center.x + ( radius * Math.cos( t ) );
				var y:Number = center.y + ( radius * Math.sin( t ) );
				
				bmd.setPixel( Math.round( x ), Math.round( y ), 0x000000 );
				*/
			}
			
			var bm:Bitmap = new Bitmap( bmd, PixelSnapping.ALWAYS, true );
			bm.width = 500;
			bm.height = 500;
			stage.addChild( bm );
		}
		
		public static function drawCircle3( stage:Stage ): void {
			
			var sprite:Sprite = new Sprite();
			var g:Graphics = sprite.graphics;
			
			//g.lineStyle( 1, 0x000000, 1, false );
			//g.moveTo( 10, 10 );
			//g.lineTo( 11, 11 );
			
			//g.beginFill( 0x000000, 1 );
			//g.drawCircle( 10, 10, 5 );
			//g.endFill();
			
			var radius:Number = 100;
			var center:Point = new Point( 250, 250 );
			
			var startAngle:Number = -45; // degrees
			var endAngle:Number = 225; // degrees
			
			// draw horizontal and vertical dividers
			g.lineStyle( 1, 0x000000, 0.25 );
			g.moveTo( 0, center.y ); // horizontal
			g.lineTo( 500, center.y ); 
			g.moveTo( center.x, 0 ); // vertical
			g.lineTo( center.x, 500 );
			g.lineStyle();	
			
			// draw blue dot to the center of the circle
			g.beginFill( 0x0000FF, 0.25 );
			g.drawCircle( center.x, center.y, 5 );
			g.endFill();
			
			var segments:uint = 20;
			var MathPI_2:Number = Math.PI * 2;
			
			/*
				radians = degrees * Math.PI/180
				degrees = radians * 180/Math.PI
			*/
			
			var rad:Number;
			var x:Number;
			var y:Number;
			
			//draw startAngle
			/*
			rad = MathPI_2 - ( startAngle * Math.PI / 180 );
			x = center.x + ( radius * Math.cos( rad ) );
			y = center.y + ( radius * Math.sin( rad ) );
			g.beginFill( 0x000000, 1 );
			g.drawCircle( x, y, 5 );
			g.endFill();
			*/
			// draw endAngle;
			/*
			rad = MathPI_2 - ( endAngle * Math.PI / 180 );
			x = center.x + ( radius * Math.cos( rad ) );
			y = center.y + ( radius * Math.sin( rad ) );
			g.beginFill( 0x000000, 1 );
			g.drawCircle( x, y, 5 );
			g.endFill();
			*/
			
			// draw segments
			var startRad:Number = MathPI_2 - ( startAngle * Math.PI / 180 );
			var distance:Number = endAngle - startAngle; // in degrees
			var radDistance:Number = ( distance / ( segments - 1 ) ) * Math.PI / 180; // distance between segments in radian
						
			for( var i:uint = 0; i < segments; ++i ) {
				rad = startRad - ( i * radDistance );
				x = center.x + ( radius * Math.cos( rad ) );
				y = center.y + ( radius * Math.sin( rad ) );
				
				if( i === 0 ) {
					g.beginFill( 0x00FF00, 1 );
				} else if ( i === segments - 1 ) {
					g.beginFill( 0xFF0000, 1 );					
				} else {
					g.beginFill( 0x000000, 0.5 );
				}
				
				g.drawCircle( x, y, 3 );				
			}	
			
			g.endFill();
			
			stage.addChild( sprite );
		}
		
		public static function drawCircle4( stage:Stage ): void {
			var sprite:Sprite = new Sprite();
			var g:Graphics = sprite.graphics;
			
			var radius:Number = 100;
			var centerX:Number = 250;
			var centerY:Number = 250;
			
			var startAngle:Number = -45;
			var endAngle:Number = 225;
			
			var segments:uint = 15;
			
			// draw guidelines;
			g.lineStyle( 1, 0x000000, 0.25 );
				// horizontal line
				g.moveTo( 0, centerY ); g.lineTo( 500, centerY );
				// vertical line
				g.moveTo( centerX, 0 ); g.lineTo( centerX, 500 );
			g.lineStyle();
			
			// draw the center of the circle
			g.beginFill( 0x0000FF, 0.5 );
				g.drawCircle( centerX, centerY, 5 );
			g.endFill();
			
			// prepare for drawing						
			var startRadian:Number = ( Math.PI * 2 ) - ( startAngle * Math.PI / 180 );
			var radianSegment:Number = ( ( endAngle - startAngle ) / ( segments - 1 ) ) * Math.PI / 180;
			
			var lastX:Number = 0;
			var lastY:Number = 0;
			
			var i:uint;
			var rad:Number
			var x:Number
			var y:Number
			
			// draw interpolation lines
			for( i = 0; i < segments; ++i ) {
				rad = startRadian - ( radianSegment * i );
				x = centerX + ( radius * Math.cos( rad ) );
				y = centerY + ( radius * Math.sin( rad ) );
				
				g.lineStyle( 1, 0x000000, 0.5 );
				
				if( i > 0 ) {
					g.moveTo( lastX, lastY );
					g.lineTo( x, y );
				} 
				
				lastX = x;
				lastY = y;								
			}
						
			// draw marker dots
			for( i = 0; i < segments; ++i ) {
				rad = startRadian - ( radianSegment * i );
				x = centerX + ( radius * Math.cos( rad ) );
				y = centerY + ( radius * Math.sin( rad ) );
				
				if( i === 0 ) {
					g.lineStyle( 1, 0x00FF00, 0.5 );
					g.beginFill( 0x00FF00, 0.25 );
						g.drawCircle( x, y, 9 );
					g.endFill();
				} else if( i === segments - 1 ) {
					g.lineStyle( 1, 0xFF0000, 0.5 );
					g.beginFill( 0xFF0000, 0.25 );
						g.drawCircle( x, y, 9 );
					g.endFill();
				} else {
					g.lineStyle( 1, 0x000000, 0.25 );
						g.drawCircle( x, y, 7 );
				}
			}
			
			stage.addChild( sprite );
		}
		
		public static function drawCircle5( stage:Stage ): void {
			var sprite:Sprite = new Sprite();
			var g:Graphics = sprite.graphics;
			
			var radius:Number = 100;
			var centerX:Number = 250;
			var centerY:Number = 250;
			
			var startAngle:Number = -45;
			var endAngle:Number = 225;
			
			var startScale:uint = 0;
			var endScale:uint = 100;
			var scaleSegments:uint = 10;
			
			var segments:uint = 20;
			
			// draw guidelines;
			g.lineStyle( 1, 0x000000, 0.25 );
			// horizontal line
			g.moveTo( 0, centerY ); g.lineTo( 500, centerY );
			// vertical line
			g.moveTo( centerX, 0 ); g.lineTo( centerX, 500 );
			g.lineStyle();
			// draw the center of the circle
			g.beginFill( 0x0000FF, 0.5 );
			g.drawCircle( centerX, centerY, 5 );
			g.endFill();
			
			var startRadian:Number;
			var radianSegment:Number;
			var lastX:Number;
			var lastY:Number;
			
			var i:uint;
			var rad:Number
			var x:Number
			var y:Number
						
			// prepare for drawing the lines
			startRadian = ( Math.PI * 2 ) - ( startAngle * Math.PI / 180 );
			radianSegment = ( ( endAngle - startAngle ) / ( segments - 1 ) ) * Math.PI / 180;
			
			lastX = 0;
			lastY = 0;
						
			// draw interpolation lines
			for( i = 0; i < segments; ++i ) {
				rad = startRadian - ( radianSegment * i );
				x = centerX + ( radius * Math.cos( rad ) );
				y = centerY + ( radius * Math.sin( rad ) );
				
				g.lineStyle( 1, 0x000000, 0.5 );
				
				if( i > 0 ) {
					g.moveTo( lastX, lastY );
					g.lineTo( x, y );
				} 
				
				lastX = x;
				lastY = y;								
			}
			
			// prepare for drawing the scale markers
			startRadian = ( Math.PI * 2 ) - ( startAngle * Math.PI / 180 );
			radianSegment = ( ( endAngle - startAngle ) / ( scaleSegments - 1 ) ) * Math.PI / 180;
			
			var startX:Number;
			var startY:Number;
			var endX:Number;
			var endY:Number;
			
			for( i = 0; i < scaleSegments; ++i ) {
				rad = startRadian - ( radianSegment * i );
				startX = centerX + ( ( radius + 5 ) * Math.cos( rad ) );
				startY = centerY + ( ( radius + 5 ) * Math.sin( rad ) )
				endX = centerX + ( ( radius + 25 ) * Math.cos( rad ) );
				endY = centerY + ( ( radius + 25 ) * Math.sin( rad ) )
					
				g.lineStyle( 2, 0xFF0000, 0.75 );
				g.moveTo( startX, startY );
				g.lineTo( endX, endY );
			}
			
			stage.addChild( sprite );
		}
		
		public static function drawCircle6( stage:Stage ): void {
			var sprite:Sprite = new Sprite();
			var g:Graphics = sprite.graphics;
			
			var radius:Number = 100;
			var centerX:Number = 250;
			var centerY:Number = 250;
			
			var startAngle:Number = -45;
			var endAngle:Number = 225;
			
			var startScale:uint = 0;
			var endScale:uint = 100;
			var scaleSegments:uint = 10;
			
			var segments:uint = 20;
			
			// draw guidelines;
			g.lineStyle( 1, 0x000000, 0.25 );
			// horizontal line
			g.moveTo( 0, centerY ); g.lineTo( 500, centerY );
			// vertical line
			g.moveTo( centerX, 0 ); g.lineTo( centerX, 500 );
			g.lineStyle();
			// draw the center of the circle
			g.beginFill( 0x0000FF, 0.5 );
			g.drawCircle( centerX, centerY, 5 );
			g.endFill();
			
			var startRadian:Number;
			var radianSegment:Number;
			var lastX:Number;
			var lastY:Number;
			
			var i:uint;
			var rad:Number
			var x:Number
			var y:Number
			
			// prepare for drawing the lines
			startRadian = ( Math.PI * 2 ) - ( startAngle * Math.PI / 180 );
			radianSegment = ( ( endAngle - startAngle ) / ( segments - 1 ) ) * Math.PI / 180;
			
			lastX = 0;
			lastY = 0;
			
			// draw interpolation lines
			for( i = 0; i < segments; ++i ) {
				rad = startRadian - ( radianSegment * i );
				x = centerX + ( radius * Math.cos( rad ) );
				y = centerY + ( radius * Math.sin( rad ) );
				
				g.lineStyle( 1, 0x000000, 0.5 );
				
				if( i > 0 ) {
					g.moveTo( lastX, lastY );
					g.lineTo( x, y );
				} 
				
				lastX = x;
				lastY = y;								
			}
			
			// prepare for drawing the scale markers
			startRadian = ( Math.PI * 2 ) - ( startAngle * Math.PI / 180 );
			radianSegment = ( ( endAngle - startAngle ) / ( scaleSegments - 1 ) ) * Math.PI / 180;
			
			var startX:Number;
			var startY:Number;
			var endX:Number;
			var endY:Number;
			
			for( i = 0; i < scaleSegments; ++i ) {
				rad = startRadian - ( radianSegment * i );
				startX = centerX + ( ( radius + 5 ) * Math.cos( rad ) );
				startY = centerY + ( ( radius + 5 ) * Math.sin( rad ) )
				endX = centerX + ( ( radius + 25 ) * Math.cos( rad ) );
				endY = centerY + ( ( radius + 25 ) * Math.sin( rad ) )
				
				g.lineStyle( 2, 0xFF0000, 0.75 );
				g.moveTo( startX, startY );
				g.lineTo( endX, endY );
			}
			
			stage.addChild( sprite );
			
			// prepare for adding the texts of the scale
			var textFormat:TextFormat = new TextFormat( "Arial", 12, 0xFF0000 );
			textFormat.align = TextFormatAlign.LEFT;
			textFormat.rightMargin = 0.75;
			
			startRadian = ( Math.PI * 2 ) - ( startAngle * Math.PI / 180 );
			radianSegment = ( ( endAngle - startAngle ) / ( scaleSegments - 1 ) ) * Math.PI / 180;
			
			for( i = 0; i < scaleSegments; ++i ) {
				rad = startRadian - ( radianSegment * i );
				
				var tf:TextField = new TextField();
					tf.text = ( ( i * 10 ) + 10 ).toString();
					tf.selectable = false;
					tf.autoSize = TextFieldAutoSize.LEFT;
					tf.setTextFormat( textFormat );
					tf.background = false;
					tf.border = false;
					tf.x = 10;
					tf.y = 10;
				
				var bounds:Rectangle = tf.getBounds( stage );
				
				var bmd:BitmapData = new BitmapData( bounds.width, bounds.height, true, 0x00FFFFFF );
				bmd.draw( tf, null, null, null, new Rectangle( 0, 0, bounds.width, bounds.height ) );
				
				var bitmap:Bitmap = new Bitmap( bmd, PixelSnapping.NEVER, true );
				bitmap.rotation = ( rad * 180 / Math.PI ) - 90;
								
				x = centerX + ( ( radius + 50 - bitmap.width ) * Math.cos( rad ) );
				y = centerY + ( ( radius + 50 - bitmap.height ) * Math.sin( rad ) );
				
				bitmap.x = x;
				bitmap.y = y;
				
				stage.addChild( bitmap );
			}
			
			/*
			var tf:TextField = new TextField();
				tf.text = "100";
				tf.selectable = false;
				tf.autoSize = TextFieldAutoSize.LEFT;
				tf.setTextFormat( textFormat );
				tf.background = false;
				tf.border = false;
				
				tf.x = 10;
				tf.y = 10;
				
				var bounds:Rectangle = tf.getBounds( stage );								
			//trace( tf.getBounds( stage ) );
			//trace( tf.textWidth, tf.textHeight );
			//stage.addChild( tf );
				
			var bmd:BitmapData = new BitmapData( bounds.width, bounds.height, true, 0x00FFFFFF );
			bmd.draw( tf, null, null, null, new Rectangle( 0, 0, bounds.width, bounds.height ) );
			
			var bitmap:Bitmap = new Bitmap( bmd, PixelSnapping.NEVER, true );
			bitmap.x = 10;
			bitmap.y = 10;
			//bitmap.rotation = 45;
			
			//trace( bitmap.width, bitmap.height );
			
			stage.addChild( bitmap );
			
			var center:Sprite = new Sprite();
			center.graphics.beginFill( 0x000000, 0.75 );
			center.graphics.drawCircle( bitmap.width * 0.5, bitmap.height * 0.5, 3 );
			center.graphics.endFill();
			
			center.x = bitmap.x;
			center.y = bitmap.y;
			
			stage.addChild( center );
			
			*/
		}
	}
}






























