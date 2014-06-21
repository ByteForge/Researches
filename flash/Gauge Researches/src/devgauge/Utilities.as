package devgauge {
	import flash.display.Graphics;
	import flash.geom.Point;
	
	public class Utilities {
		
		public static const DIRECTION_CW:uint = 	0x01;
		public static const DIRECTION_CCW:uint = 	0x02;
		
		public static const FROM_TOP:uint =	0x01;
		public static const FROM_RIGHT:uint =	0x02;
		public static const FROM_BOTTOM:uint =	0x04;
		public static const FROM_LEFT:uint =	0x08;
		
		// OBSOLETE
		public static const ORIENTATION_CW_FROM_TOP:uint = 	0x01;
		public static const ORIENTATION_CW_FROM_RIGHT:uint = 	0x02;
		public static const ORIENTATION_CW_FROM_BOTTOM:uint = 	0x04;
		public static const ORIENTATION_CW_FROM_LEFT:uint = 	0x08;
		public static const ORIENTATION_CCW_FROM_TOP:uint = 	0x10;
		public static const ORIENTATION_CCW_FROM_RIGHT:uint = 	0x20;
		public static const ORIENTATION_CCW_FROM_BOTTOM:uint = 	0x40;
		public static const ORIENTATION_CCW_FROM_LEFT:uint = 	0x80;
		
		public static const ANGLE_DEGREE:uint = 	0x01;
		public static const ANGLE_RADIAN:uint = 	0x02;
		public static const ANGLE_GRADIAN:uint = 	0x04;
		public static const ANGLE_TURN:uint = 		0x08;
		
		public static const SEGMENT_LINE:uint = 	0x01;
		public static const SEGMENT_CURVE:uint = 	0x02;
		
		public static const RANGE_UNDERCIRCLE:uint = 	0x01;
		public static const RANGE_OVERCIRCLE:uint = 	0x02;
		
		/*
			drawCircle from:
				- center, radius
				- center, diameter
				- 2 points
				- 3 points
				- tan, tan, radius
				- tan, tan, tan
			drawEllipsis from:
				- 
			drawArc from:
				- 3 points
				- 
			drawEllipticalArc
			drawSpiral
			
			drawTriangle
			drawSquare
			drawStar
			drawPolygon
				- radius
				- inscribed / circumscribed
				- sides
				- corner radius
		*/
		
		//public static function drawArc( graphics:Graphics, center:Point, radius:Number, startAngle:Number, endAngle:Number, resolution:uint ): void {
		public static var g:Graphics;
		
		public static function drawArc(): void {
		
			/*
			var g:Graphics = graphics;
			var cX:Number = center.x;
			var cY:Number = center.y;
			var r:Number = radius;
			var sA:Number = startAngle;
			var eA:Number = endAngle;
			*/
			
			var centerX:Number = 150;
			var centerY:Number = 150;
			var radius:Number = 145;
			
			var start:Number = 180;
			//var start:Number = 45;
			var end:Number = 360 + 180 + 90;
			//var end:Number = 135;
			
			var resolution:uint = 10;
			var radianStep:Number = 0;
			
			// CHECK AND FORMAT ANGLES
			if( start < 0 ) {
				if( start < -360 ) {
					start = start % -360;
				}					
			} else {
				if( start > 360 ) {
					start = start % 360;					
				}
			}
			
			if( end < 0 ) {
				if( end < -360 ) {
					end = end % -360;
				}					
			} else {
				if( end > 360 ) {
					end = end % 360;
				}
			}
			
			trace( "start:", start );
			trace( "end:", end );
			
			if( start > end ) {
				trace( "draw bigger" );
				trace( "draw degree:", 360 - ( start - end ) );
				trace( "draw degree step:", ( 360 - ( start - end ) ) / ( resolution - 1 ) );
				
				radianStep = ( Math.PI / 180 ) * ( ( 360 - ( start - end ) ) / ( resolution -1 ) );
				trace( "radianStep:", radianStep );
				
				start = start * ( Math.PI / 180 );
				trace( "start from:", start );
			} else if( end > start ) {
				trace( "draw smaller" );
				trace( "draw degree:", end - start );
				trace( "draw degree step:", ( end - start ) / ( resolution - 1 ) );
				
				radianStep = ( Math.PI / 180 ) * ( ( end - start ) / ( resolution -1 ) );
				trace( "radianStep:", radianStep );
				
				start = start * ( Math.PI / 180 );
				trace( "start from:", start );
			} else {
				trace( "draw whole circle" );
			}
			
			// DRAW ARC
			var i:uint = 0;
			var L:uint = 0;
			
				g.lineStyle( 1, 0xFF0000, 1 );
				// 1st MOVE_TO
				g.moveTo(
					centerX + ( radius * Math.cos( start ) ),
					centerY + ( radius * Math.sin( start ) )
				);
			for( i = 1, L = resolution; i < L; ++i ) {
				//trace( i );
				g.lineTo(
					centerX + ( radius * Math.cos( start + ( i * radianStep ) ) ),
					centerY + ( radius * Math.sin( start + ( i * radianStep ) ) )
				);
			}
		}
		
		public static function drawArc2(): void {
			
			var orientation:uint = ORIENTATION_CW_FROM_RIGHT;
			var angleType:uint = ANGLE_DEGREE;
			
			var centerX:Number = 150;
			var centerY:Number = 150;
			var radius:Number = 135; // if( radius === 0 ) { drawTheArc = false }
			
			var drawTheArc:Boolean = true;
			var onDirection:Boolean = true;
			
			var start:Number = 1;
			var end:Number = 1;
			if( start < 0 && end < 0 ) {
				onDirection = false; // counter direction
			}

			var resolution:uint = 10; // if( resolution === 0 ) { drawTheArc = false }
			var step:Number = 0;
			
			var i:uint;
			var j:uint;
			var L:uint;
			
			// if( drawTheArc === false ) DON'T DO BELOW
			// properly format start and end based on angleType
			switch( angleType ) {
				default:
					// FALL THROUGH
				case ANGLE_DEGREE:
					if( start > 0 ) {
						if( start > 360 ) {
							start = start % 360;
						}
					} else {
						if( start < -360 ) {
							start = start % -360;
						}
						start += 360;
					}
					if( end > 0 ) {
						if( end > 360 ) {
							end = end % 360;
						}
					} else {
						if( end < -360 ) {
							end = end % -360;
						}
						end += 360;
					}
					break;
				case ANGLE_RADIAN:
					if( start < -2 * Math.PI ) {
						start = start % ( -2 * Math.PI );
					} else if( start > 2 * Math.PI ) {
						start = start % ( 2 * Math.PI );
					}
					if( end < -2 * Math.PI ) {
						end = end % ( -2 * Math.PI );
					} else if( end > 2 * Math.PI ) {
						end = end % ( 2 * Math.PI );
					}
					break;
				case ANGLE_GRADIAN:
					if( start < -400 ) {
						start = start % -400;
					} else if( start > 400 ) {
						start = start % 400;
					}
					if( end < -400 ) {
						end = end % -400;
					} else if( end > 400 ) {
						end = end % 400;
					}
					break;
				case ANGLE_TURN:
					if( start < -1 ) {
						start = start % -1;
					} else if( start > 1 ) {
						start = start % 1;
					}
					if( end < -1 ) {
						end = end % -1;
					} else if( end > 1 ) {
						end = end % 1;
					}
					break;
			}
			
			switch( angleType ) {
				case ANGLE_DEGREE:
					trace( "angleType:", "degree", angleType );
					break;
				case ANGLE_RADIAN:
					trace( "angleType:", "radian", angleType );
					break;
				case ANGLE_GRADIAN:
					trace( "angleType:", "gradian", angleType );
					break;
				case ANGLE_TURN:
					trace( "angleType:", "turn", angleType );
					break;
			}
			trace( "start:", start );
			trace( "end:", end );
			
			//total = ( start > 0 ? start : -start ) + ( end > 0 ? end : -end );			
			
			if( start > end ) {
				//total = 360 - ( start - end );
				
				trace( "start > end" );
				//trace( "draw degree:", 360 - ( start - end ) );
				trace( "draw degree step:", ( 360 - ( start - end ) ) / ( resolution - 1 ) );
				
				step = ( Math.PI / 180 ) * ( ( 360 - ( start - end ) ) / ( resolution -1 ) );
				trace( "step:", step );
				
				start = start * ( Math.PI / 180 );
				trace( "start from:", start );
			} else if( end > start ) {
				//total = end - start;
				
				trace( "start < end" );
				//trace( "draw degree:", end - start );
				trace( "draw degree step:", ( end - start ) / ( resolution - 1 ) );
				
				step = ( Math.PI / 180 ) * ( ( end - start ) / ( resolution -1 ) );
				trace( "step:", step );
				
				start = start * ( Math.PI / 180 );
				trace( "start from:", start );
			} else {
				//trace( "draw whole circle" );
				if( start !== 0 ) {
					trace( "draw whole circle" );
					
					trace( "draw degree step:", 360 );
					
					step = ( Math.PI * 2 ) / ( resolution - 1 );
					trace( "step:", step );
					
					start = 0;
					trace( "start from:", start );
				} else {
					trace( "draw nothing" );
					drawTheArc = false;
				}
			}
			
			//trace( "total:", total );
			
			g.lineStyle( 2, 0xFF0000, 1 );
			// 1st MOVE_TO
			g.moveTo(
				centerX + ( radius * Math.cos( start ) ),
				centerY + ( radius * Math.sin( start ) )
			);
			for( i = 1, L = resolution; i < L; ++i ) {
				//trace( i );
				var rad:Number = start + ( i * step );
				g.lineTo(
					centerX + ( radius * Math.cos( rad ) ),
					centerY + ( radius * Math.sin( rad ) )
				);
			}
		}
	}
}