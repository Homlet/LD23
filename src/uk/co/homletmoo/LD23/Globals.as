package uk.co.homletmoo.LD23 
{
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class Globals
	{
		public static var SCORE:uint = 0;
		public static var COIN_VALUE:uint = 20;
		public static var COINPOINTS:Array = new Array(0);
		public static var BULLET_SPEED:Number = 4;
		public static var ROCKET_SPEED:Number = 1.2;
		public static var BULLET_INTERVAL:Number = 8;
		public static var ROCKET_INTERVAL:Number = 30;
		
		public static var PLAYER_HEALTH:uint = 4;
		
		public static function reset():void
		{
			SCORE = 0;
			COIN_VALUE = 20;
			COINPOINTS = new Array(0);
			BULLET_SPEED = 4;
			ROCKET_SPEED = 0.8;
			BULLET_INTERVAL = 3;
			ROCKET_INTERVAL = 3;
			
			PLAYER_HEALTH = 4;
		}
		
	}

}