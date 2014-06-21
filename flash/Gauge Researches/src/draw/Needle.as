package draw {
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
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.TimerEvent;
	import flash.geom.Matrix;
	import flash.utils.Timer;
	
	import org.osmf.layout.ScaleMode;
	
	public class Needle {
		
		public static function drawNeedle1( stage:Stage ):void {
		
			var c:Shape = new Shape();
			var g:Graphics = c.graphics;
			
			var commands:Vector.<int>;
			var coords:Vector.<Number>
						
			var cX:Number = 25;
			var cY:Number = 75;
			var radius:Number = 10;
			var circleMarkOffset:Number = 1;
			 
			// DRAW NEEDLE
			commands = new Vector.<int>();
				commands.push(
					// CIRCLE STROKES
					GraphicsPathCommand.MOVE_TO,					
					
					GraphicsPathCommand.LINE_TO,
					GraphicsPathCommand.LINE_TO,
					GraphicsPathCommand.LINE_TO,
					GraphicsPathCommand.LINE_TO,
					
					GraphicsPathCommand.LINE_TO,
					GraphicsPathCommand.LINE_TO,
					GraphicsPathCommand.LINE_TO,
					GraphicsPathCommand.LINE_TO,
					
					// CIRCLE CENTER MARK
					GraphicsPathCommand.MOVE_TO,
					GraphicsPathCommand.LINE_TO,
					GraphicsPathCommand.MOVE_TO,
					GraphicsPathCommand.LINE_TO,
					
					// NEEDLE
					GraphicsPathCommand.MOVE_TO,
					GraphicsPathCommand.LINE_TO,
					GraphicsPathCommand.LINE_TO
				);				
			coords = new Vector.<Number>();
				coords.push(
					// CIRCLE STROKE
					/* MOVE_TO x, y */ cX + ( radius * Math.cos( Math.PI * 1.5 ) ), cY + ( radius * Math.sin( Math.PI * 1.5 ) ),
					
					/* LINE_TO x, y */ cX + ( radius * Math.cos( Math.PI * 1.75 ) ), cY + ( radius * Math.sin( Math.PI * 1.75 ) ),
					/* LINE_TO x, y */ cX + ( radius * Math.cos( 0 ) ), cY + ( radius * Math.sin( 0 ) ),
					/* LINE_TO x, y */ cX + ( radius * Math.cos( Math.PI * 0.25 ) ), cY + ( radius * Math.sin( Math.PI * 0.25 ) ),
					/* LINE_TO x, y */ cX + ( radius * Math.cos( Math.PI * 0.5 ) ), cY + ( radius * Math.sin( Math.PI * 0.5 ) ),
					
					/* LINE_TO x, y */ cX + ( radius * Math.cos( Math.PI * 0.75 ) ), cY + ( radius * Math.sin( Math.PI * 0.75 ) ),
					/* LINE_TO x, y */ cX + ( radius * Math.cos( Math.PI ) ), cY + ( radius * Math.sin( Math.PI ) ),
					/* LINE_TO x, y */ cX + ( radius * Math.cos( Math.PI * 1.25 ) ), cY + ( radius * Math.sin( Math.PI * 1.25 ) ),
					/* LINE_TO x, y */ cX + ( radius * Math.cos( Math.PI * 1.5 ) ), cY + ( radius * Math.sin( Math.PI * 1.5 ) ),
					
					// CIRCLE CENTER MARK
					/* MOVE_TO x, y */ cX , cY - circleMarkOffset,
					/* LINE_TO x, y */ cX , cY + circleMarkOffset,
					/* MOVE_TO x, y */ cX - circleMarkOffset, cY,
					/* LINE_TO x, y */ cX + circleMarkOffset, cY,
					
					// NEEDLE
					/* MOVE_TO x, y */ cX + ( radius * Math.cos( Math.PI ) ), cY + ( radius * Math.sin( Math.PI ) ),
					/* LINE_TO x, y */ cX , 10,
					/* LINE_TO x, y */ cX + ( radius * Math.cos( 0 ) ), cY + ( radius * Math.sin( 0 ) )
				);
			
			g.lineStyle( 0, 0x000000, 1, false, LineScaleMode.NORMAL, CapsStyle.NONE );
			g.beginFill( 0x000000, 0.10 );
			g.drawPath( commands, coords, GraphicsPathWinding.NON_ZERO );
			g.endFill();
			
			// DRAW BOUNDING MARKS
			commands = new Vector.<int>();
				commands.push(
					GraphicsPathCommand.MOVE_TO,
					GraphicsPathCommand.LINE_TO,
					GraphicsPathCommand.LINE_TO,
					GraphicsPathCommand.LINE_TO,
					GraphicsPathCommand.LINE_TO
				);
			coords = new Vector.<Number>();
				coords.push(
					/* MOVE_TO x, y */ 0, 0,
					/* LINE_TO x, y */ 50-1, 0,
					/* LINE_TO x, y */ 50-1, 100-1,
					/* LINE_TO x, y */ 0, 100-1,
					/* LINE_TO x, y */ 0, 0
				);
				g.lineStyle( 1, 0xFF0000, 0.25, false, LineScaleMode.NORMAL, CapsStyle.NONE );
				g.drawPath( commands, coords, GraphicsPathWinding.NON_ZERO );
			
			var needle:Bitmap = new Bitmap( new BitmapData( 50, 100, true, 0x00000000 ), PixelSnapping.NEVER, true );
			
			needle.bitmapData.draw( c );
			
			needle.x = 0;
			needle.y = 0;
			//needle.rotation = 15;
			
			var OM:Matrix = needle.transform.matrix;
			var m:Matrix = OM;
			var r:Number = 0;
			
			//var rotation:Number = -35; // in DEGREES;
				/* than convert TO RADIANS */ //rotation = rotation * Math.PI / 180;
			
			trace( "original matrix:" , m );
			
			//m.a = Math.cos( rotation );
			//m.b = Math.sin( rotation );
			//m.c = -Math.sin( rotation );
			//m.d = Math.cos( rotation );
			
			/*
			m.translate( -25, -75 );
			m.rotate( 5 * ( Math.PI / 180 ) );
			m.translate( 25, 75 );
			
			trace( "modified matrix:" , m );
			
			needle.transform.matrix = m;
			*/
			
			var pX:Number = 25;
			var pY:Number = 75;
			
			var sX:Number = 100;
			var sY:Number = 100;
						
			r = 0
			var R:Number = 5 * ( Math.PI / 180 );
			//var R:Number = 10;
			var i:Number = 0;
			
			stage.addChild( needle );
			
			var timer:Timer = new Timer( 50 );
				timer.addEventListener( TimerEvent.TIMER, 
					function( e:TimerEvent ):void {
						m = OM;
						
						r = i * R;
																		
						//m.translate( -pX, -pY );
						//m.rotate( r * ( Math.PI / 180 ) );
						//m.translate( pX, pY );
						
						//m.tx += -pX;
						//m.ty += -pY;
						
						//m.tx = -25;
						//m.ty = -75;
						
						m.a = Math.cos( r );
						m.b = Math.sin( r );
						m.c = -Math.sin( r );
						m.d = Math.cos( r );						
						m.tx = sX + ( ( pX * ( 1 - Math.cos( r ) ) ) + ( pY * Math.sin( r ) ) );
						m.ty = sY + ( ( pY * ( 1 - Math.cos( r ) ) ) - ( pX * Math.sin( r ) ) );
						
						//m.tx = 0;
						//m.ty = 0;
						
						//m.tx += pX;
						//m.ty += pY;
						
						trace( "modified matrix:" , m );
						
						i++;
												
						needle.transform.matrix = m;
					}
				);
			timer.start();
		}
				
		public function Needle() {
			
		}
	}
}