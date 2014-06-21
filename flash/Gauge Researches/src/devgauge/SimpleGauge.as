package devgauge {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.CapsStyle;
	import flash.display.Graphics;
	import flash.display.GraphicsPathCommand;
	import flash.display.GraphicsPathWinding;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.display.PixelSnapping;
	import flash.display.Shape;
	import flash.filters.BlurFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	public class SimpleGauge extends GaugeStyle {
		
		private var _canvas:Shape;
		private var _graphics:Graphics;
		private var _dashBitmapData:BitmapData;
		private var _needleBitmapData:BitmapData;
		
		private var _matrix:Matrix;
		private var _bitmap:Bitmap;
		private var _minRadian:Number;
		private var _maxRadian:Number;
		private var _distRadian:Number;
		
		public function SimpleGauge() {
			// FUNDAMENTAL INITIALIZATION
			this._mode = BITMAP_MODE;			
			this.bitmapData = new BitmapData( 300, 300, true, 0x00000000 );
			// DRAWING INITIALIZATION
			this._canvas = new Shape();
			this._graphics = this._canvas.graphics;
			this._dashBitmapData = new BitmapData( 300, 300, true, 0x00000000 );
			this._needleBitmapData = new BitmapData( 300, 300, true, 0x00000000 );
			
			var command:Vector.<int>;
			var path:Vector.<Number>;
			
			var centerX:Number = 150;
			var centerY:Number = 150;
			var radius:Number = 145;
			var resolution:uint = 2000;
			
			var commandNumber:uint = resolution + 1;
			var pathNumber:uint = commandNumber * 2;
			var i:uint;
			var j:uint;
			var L:uint;
			var PI:Number = Math.PI;
			var PI_scale:Number;
			// DRAW DASH
				// DRAW DISC
				command = new Vector.<int>( commandNumber, true );
					command[ 0 ] = GraphicsPathCommand.MOVE_TO;
				for( i = 1, L = commandNumber; i < L; ++i ) {
					command[ i ] = GraphicsPathCommand.LINE_TO;
				}
				
				path = new Vector.<Number>( pathNumber, true );
					path[ 0 ] = centerX + ( radius * Math.cos( 0 ) );
					path[ 1 ] = centerY + ( radius * Math.sin( 0 ) );
				for( i = 2, L = pathNumber, j = 1; i < L ; i += 2 ) {
					PI_scale = PI * ( j / ( resolution * 0.5 ) );
					path[ i ] = centerX + ( radius * Math.cos( PI_scale ) );
					path[i+1] = centerY + ( radius * Math.sin( PI_scale ) );
					++j;
				}
				
				this._graphics.lineStyle( 
					/* thickness*/		1, 
					/* color */		0x000000, 
					/* alpha*/		1, 
					/* pixelHinting */	false,
					/* scaleMode */		LineScaleMode.NORMAL,
					/* caps */		CapsStyle.ROUND,
					/* joints */		JointStyle.ROUND,
					/* miterLimit */	3
					);
				this._graphics.beginFill( 0x000000, 0.10 );
				this._graphics.drawPath( command, path );
				//this._graphics.drawCircle( centerX, centerY, radius );
				this._graphics.endFill();
				// DRAW MARKS;
				command = new Vector.<int>( 22, true );
				for( i = 0, L = 22; i < L; i += 2 ) {
					command[ i ] = GraphicsPathCommand.MOVE_TO;
					command[i+1] = GraphicsPathCommand.LINE_TO;
				}
				path = new Vector.<Number>( 44, true );
				for( i = 0, L = 44, j = 0; i < L; i += 4 ) {
					// MOVE_TO
					path[ i ] = centerX + ( ( radius - 50 ) * Math.cos( 
							( 0.75 + ( 1.5 * ( j/10 ) ) ) * Math.PI
						) );
					path[i+1] = centerY + ( ( radius - 50 ) * Math.sin( 
							( 0.75 + ( 1.5 * ( j/10 ) ) ) * Math.PI
						) );
					// LINE_TO
					path[i+2] = centerX + ( ( radius - 10 ) * Math.cos( 
							( 0.75 + ( 1.5 * ( j/10 ) ) ) * Math.PI
						) );
					path[i+3] = centerY + ( ( radius - 10 ) * Math.sin( 
							( 0.75 + ( 1.5 * ( j/10 ) ) ) * Math.PI
						) );
					
					++j;					
				}
				this._graphics.lineStyle( 
					/* thickness*/		2, 
					/* color */		0xFF0000, 
					/* alpha*/		1, 
					/* pixelHinting */	true,
					/* scaleMode */		LineScaleMode.NORMAL,
					/* caps */		CapsStyle.ROUND,
					/* joints */		JointStyle.ROUND,
					/* miterLimit */	3
				);
				/*
				PI_scale = ( 0.75 + ( 1.5 * 0 ) ) * Math.PI;
				this._graphics.moveTo( 
					centerX + ( ( radius - 40 ) * Math.cos( PI_scale ) ),
					centerY + ( ( radius - 40 ) * Math.sin( PI_scale ) )
				);
				this._graphics.lineTo(
					centerX + ( ( radius - 5 ) * Math.cos( PI_scale ) ),
					centerY + ( ( radius - 5 ) * Math.sin( PI_scale ) )
				);
				*/
				this._graphics.drawPath( command, path );
				
			this._dashBitmapData.draw( this._canvas );			
			this._graphics.clear();
			
			this.bitmapData.copyPixels( 
				this._dashBitmapData, 
				this._dashBitmapData.rect, 
				new Point(), null, null, 
				true 
				);
			
			// DRAW NEEDLE
			radius = 25;
			
			var peakX:Number = 150;
			var peakY:Number = 55;
			var radianDiff:Number = 0.08;
			var leftRadian:Number = PI * ( 1.5 - radianDiff );
			var rightRadian:Number = PI * ( 1.5 + radianDiff );
			
				resolution = 250;
				commandNumber = resolution + 1 + 3;
				pathNumber = commandNumber * 2;
				
				command = new Vector.<int>( commandNumber, true );
					command[ 0 ] = GraphicsPathCommand.MOVE_TO;
					command[ commandNumber - 3 ] = GraphicsPathCommand.MOVE_TO;
					command[ commandNumber - 2 ] = GraphicsPathCommand.LINE_TO;
					command[ commandNumber - 1 ] = GraphicsPathCommand.LINE_TO;
				for( i = 1, L = commandNumber - 3; i < L; ++i ) {
					command[ i ] = GraphicsPathCommand.LINE_TO;
				}
				
				path = new Vector.<Number>( pathNumber, true );
					path[ 0 ] = centerX + ( radius * Math.cos( 0 ) );
					path[ 1 ] = centerY + ( radius * Math.sin( 0 ) );
					// MOVE TO
					path[ pathNumber - 6 ] = centerX + ( radius * Math.cos( leftRadian ) );
					path[ pathNumber - 5 ] = centerY + ( radius * Math.sin( leftRadian ) );
					// LINE TOs
					path[ pathNumber - 4 ] = peakX;
					path[ pathNumber - 3 ] = peakY;
					path[ pathNumber - 2 ] = centerX + ( radius * Math.cos( rightRadian ) );
					path[ pathNumber - 1 ] = centerY + ( radius * Math.sin( rightRadian ) );
				for( i = 2, L = pathNumber - 6, j = 1; i < L ; i += 2 ) {
					PI_scale = PI * ( j / ( resolution * 0.5 ) );
					path[ i ] = centerX + ( radius * Math.cos( PI_scale ) );
					path[i+1] = centerY + ( radius * Math.sin( PI_scale ) );
					++j;
				}
				
			this._graphics.lineStyle( 
				/* thickness*/		1, 
				/* color */		0xFF0000, 
				/* alpha*/		1, 
				/* pixelHinting */	false,
				/* scaleMode */		LineScaleMode.NORMAL,
				/* caps */		CapsStyle.ROUND,
				/* joints */		JointStyle.ROUND,
				/* miterLimit */	3
			);
			this._graphics.beginFill( 0x000000, 0.75 );
			this._graphics.drawPath( command, path, GraphicsPathWinding.NON_ZERO );
			
			this._graphics.endFill();
			drawArc( this._graphics, 0, 0, 0, 0, 0, 0 );
						
			this._needleBitmapData.draw( this._canvas );			
			this._graphics.clear();
			
			this.bitmapData.copyPixels( 
				this._needleBitmapData, 
				this._needleBitmapData.rect, 
				new Point(), null, null, 
				true 
			);
			// GAUGE POSITIONING AND OTHER SETTINGS
			this._bitmap = new Bitmap( this._needleBitmapData, PixelSnapping.NEVER, true );
			this._matrix = this._bitmap.transform.matrix;
			
			this._minRadian = 1.25;
			this._maxRadian = 0.75;
			this._distRadian = ( ( 1 + this._minRadian ) - this._maxRadian ) * Math.PI;
			this._minRadian *= Math.PI;
			this._maxRadian *= Math.PI;
						
		}
		
		private static function drawArc( graphic:Graphics, centerX:Number, centerY:Number, radius:Number, startDegree:Number, endDegree:Number, resolution:uint ):void {
		
			startDegree = -135;
			endDegree = 90;
			
			resolution = 1000;
			
			centerX = 150;
			centerY = 150;
			radius = 140;
			
			var coords:Vector.<int>;
			var data:Vector.<Number>;
			
			var startRadian:Number;
			var endRadian:Number;
			var radUnit:Number;
			
			var i:uint;
			var j:uint;
			var L:uint;
			
			if( startDegree < 0 ) {
				if( startDegree < -360 ) {
					startDegree = startDegree % -360;
				}					
			} else {
				if( startDegree > 360 ) {
					startDegree = startDegree % 360;
				}
			}
			
			if( endDegree < 0 ) {
				if( endDegree < -360 ) {
					endDegree = endDegree % -360;
				}					
			} else {
				if( endDegree > 360 ) {
					endDegree = endDegree % 360;
				}
			}
			
			if( startDegree < endDegree ) {
				trace( "clockwise" );
				
				trace( "startDegree:", startDegree );
				trace( "endDegree:", endDegree );
				
				// ROTATE startDegree and endDegree with CCW 90 deg
				if( startDegree < 0 ) {
					startDegree = 360 + startDegree;
				}
				startDegree -= 90;
				endDegree -= 90;
				
				trace( "startDegree:", startDegree );
				trace( "endDegree:", endDegree );
				
				startRadian = startDegree * ( Math.PI / 180 );
				endRadian = endDegree * ( Math.PI / 180 );
				
				trace( "startRadian:", startRadian );
				trace( "endRadian:", endRadian );
				
				//startRadian = ( ( ( startDegree < 0 ) ? 360 - startDegree : startDegree ) * ( Math.PI / 180 ) ) + ( 1.5 * Math.PI );
				//endRadian = ( ( ( endDegree < 0 ) ? 360 - endDegree : endDegree ) * ( Math.PI / 180 ) ) + ( 1.5 * Math.PI );
				
				//trace( "startRadian:", startRadian / Math.PI );
				//trace( "endRadian:", endRadian / Math.PI );
				
				radUnit = ( ( startDegree - endDegree ) / ( resolution - 1 ) ) * ( Math.PI / 180 );
				
				trace();
				trace( "radUnit:", radUnit );
				
				coords = new Vector.<int>( resolution + 1, true );
					coords[ 0 ] = GraphicsPathCommand.MOVE_TO;
					for( i = 1, L = resolution + 1; i < L; ++i ) {
						//trace( i );
						coords[ i ] = GraphicsPathCommand.LINE_TO;
					}
				data = new Vector.<Number>( ( resolution + 1 ) * 2 , true );
					data[ 0 ] = centerX + ( radius * Math.cos( startRadian ) );
					data[ 1 ] = centerY + ( radius * Math.sin( startRadian ) );
					for( i = 2, L = ( resolution + 1 ) * 2, j = 0; i < L; i+=2 ) {
						//trace( i );
						var tRad:Number = startRadian + ( radUnit * j );
						data[ i ] = centerX + ( radius * Math.cos( tRad ) );
						data[i+1] = centerY + ( radius * Math.sin( tRad ) );
						
						//trace( j, j / ( resolution - 1 ) );
						//trace( tRad );
						j++
					}
				graphic.drawPath( coords, data );
					
			} else if( startDegree > endDegree ) {
				trace( "COUNTERclockwise" );
			} else {
				trace( "they're equal" );
			}
			
			//var radUint:Number = ( Math.PI / 180 )
		};
		
		override public function get percent():Number {
			return this._percent;
		}
		
		override public function set percent( value:Number ):void {
			this._percent = value;
			
			this.bitmapData.fillRect( this.bitmapData.rect, 0x00000000 );
			
			this.bitmapData.copyPixels( 
				this._dashBitmapData, 
				this._dashBitmapData.rect, 
				new Point(), null, null, 
				true 
			);
			
			//var bitmap:Bitmap = new Bitmap( this._needleBitmapData, PixelSnapping.NEVER, true );
			//var m:Matrix = bitmap.transform.matrix;
			
			var m:Matrix = _bitmap.transform.matrix.clone();
			
			var pX:Number = 150;
			var pY:Number = 150;
			
			var sX:Number = 0;
			var sY:Number = 0;
			
			//var r:Number = 45 * ( Math.PI / 180 );
			//var r:Number = value * ( Math.PI / 180 );
			//var r:Number = ( -135 + ( 270 * value ) ) * ( Math.PI / 180 );
			
			//var r:Number = -90 * ( Math.PI / 180 );
			//value = 0.5;
			var r:Number = this._minRadian + ( this._distRadian * value );
			
			m.a = Math.cos( r );
			m.b = Math.sin( r );
			m.c = -Math.sin( r );
			m.d = Math.cos( r );
			m.tx = sX + ( ( pX * ( 1 - Math.cos( r ) ) ) + ( pY * Math.sin( r ) ) );
			m.ty = sY + ( ( pY * ( 1 - Math.cos( r ) ) ) - ( pX * Math.sin( r ) ) );
			
			/*
			m.translate( -pX, -pY );
			m.rotate( r );
			m.translate( pX, pY );
			*/
				
			//bitmap.transform.matrix = m;
			
			//bitmap.filters = [ new BlurFilter( 12, 12, 3 ) ];
			
			this.bitmapData.draw( this._bitmap, m );
		}
	}
}