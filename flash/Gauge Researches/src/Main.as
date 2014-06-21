package {
	import devgauge.Gauge;
	import devgauge.IGaugeStyle;
	import devgauge.SimpleGauge;
	import devgauge.Utilities;
	
	import draw.Circle;
	import draw.Needle;
	
	import flash.display.Bitmap;
	import flash.display.PixelSnapping;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.filters.BlurFilter;
	import flash.system.System;
	import flash.utils.Timer;

	[SWF(width="600", height="600", backgroundColor="#FFFFFF", frameRate="30")]
	public class Main extends Sprite {
		public function Main() {
			this.addEventListener( Event.ADDED_TO_STAGE, listenerADDED_TO_STAGE );
		}		
		private function listenerADDED_TO_STAGE( e:Event ):void {
			this.removeEventListener( Event.ADDED_TO_STAGE, listenerADDED_TO_STAGE );
			
			trace( ">>> START >>>" ); trace(); trace();
			
			//draw.Circle.drawCircle( this.stage );
			//draw.Circle.drawCircle2( this.stage );
			//draw.Circle.drawCircle3( this.stage );
			//draw.Circle.drawCircle4( this.stage );
			//draw.Circle.drawCircle5( this.stage );
			//draw.Circle.drawCircle6( this.stage );
			
			//draw.Needle.drawNeedle1( this.stage );
			
			//var ga:SimpleGauge = new SimpleGauge( 110 );
			//var gb:SimpleGauge = new SimpleGauge( 220 );
			//var gc:SimpleGauge = new SimpleGauge( 330 );
			
			//var gauge:Gauge = new Gauge();
				//gauge.style = new SimpleGauge();
				
			//this.addChild( gauge );
			
			//var g:SimpleGauge = new SimpleGauge();
			//var bm:Bitmap = new Bitmap( g.bitmapData, PixelSnapping.NEVER, true );
			
			//this.addChild( bm );
			
			//g.percent = 0;
			var pct:int = 0;
			var increasing:Boolean = true;
			
			var timer:Timer = new Timer( 1000 / 30 );
				timer.addEventListener( TimerEvent.TIMER, function( e:TimerEvent ):void {
					//trace( "..." );
					//g.percent += 29.543212345;
					
					//g.percent += 9;
					//g.percent += 9;
					//g.percent += 9;
					//g.percent += 9;
					
					if( pct <= 0 ) {
						increasing = true;
					}
					
					if( pct >= 100 ) {
						increasing = false;
					}
					
					if( pct < 0 ) { pct = 0; }
					if( pct > 100 ) { pct = 100; }
					
					//g.percent = pct * 0.01;
					//trace( increasing, pct, pct * 0.01 );
					
					pct += 1 * ( increasing ? 1 : -1 );
				} );
			//timer.start();
			
			// DEVELOPMENT OF UTILITIES
			var s:Shape = new Shape();
			Utilities.g = s.graphics;
			
			//Utilities.drawArc();
			Utilities.drawArc2();
			
			this.addChild( s );
				
			trace(); trace(); trace( "<<< END <<<" );			
			//System.exit( 0 );
		}
	}
}