package com.kingforge.webparser {
	
	import flash.events.Event;
	
	public class WebParserEvent extends Event {
		
		public static const PROJECT_START:String = 'projectStart';
		public static const PROJECT_DONE:String = 'projectDone';
		public static const PROJECT_ERROR:String = 'projectError';		
		public static const TASK_START:String = 'taskStart';
		public static const TASK_DONE:String = 'taskDone';
		public static const TASK_ERROR:String = 'taskError';
		
		public function WebParserEvent() {
		}
	}
}