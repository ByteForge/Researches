package com.kingforge.aie {	
	
	import flash.events.Event;
	
	public class AieMouseEvent extends Event {
		
		public static const MOUSE_OVER:int = 1;
		public static const MOUSE_OUT:int = 2;
		public static const MOUSE_MOVE:int = 3;
		public static const MOUSE_WHEEL:int = 4;		
			public static const PRIMARY_UP:int = 5;
			public static const PRIMARY_DOWN:int = 6;
			public static const PRIMARY_OUTSIDE:int = 7;
			public static const PRIMARY_CLICK:int = 8;
			
			public static const MIDDLE_UP:int = 9;
			public static const MIDDLE_DOWN:int = 10;
			public static const MIDDLE_OUTSIDE:int = 11;
			public static const MIDDLE_CLICK:int = 12;
			
			public static const SECONDARY_UP:int = 13;
			public static const SECONDARY_DOWN:int = 14;
			public static const SECONDARY_OUTSIDE:int = 15;
			public static const SECONDARY_CLICK:int = 16;
		
		public function AieMouseEvent() {
		}
	}
}