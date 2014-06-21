// ActionScript file

package{
	public function TRACE( tabs:uint = 0 ): Function {
		var t:String = "";
		while( tabs-- ) {
			t += "\t";
		}
		return function( ...arg ): void {
			if( arg.length === 0 ) {
				trace( "" );
			} else {
				if( t !== "" ) {
					arg.unshift( t );
				}					
				trace.apply( null, arg ); 
			}
		};
	}
}