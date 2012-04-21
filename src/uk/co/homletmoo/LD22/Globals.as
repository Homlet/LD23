package uk.co.homletmoo.LD22 
{
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class Globals
	{
		public static var SCORE:uint = 0;
		public static var COIN_VALUE:uint = 0;
		public static var COINPOINTS:Array = new Array(0);
		
		public static function reset():void
		{
			SCORE = 0;
			COIN_VALUE = 100;
			COINPOINTS = new Array(0);
		}
		
	}

}