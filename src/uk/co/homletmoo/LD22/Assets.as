package uk.co.homletmoo.LD22
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class Assets 
	{
		// ART ------------------------------------------------
		
		// Flashpunk logo (animated)
		[Embed(source = 'res/flashpunk.png')]
		public static const FP_RAW:Class;
		
		// HomletMedia logo
		[Embed(source = 'res/hm.png')]
		public static const HM_RAW:Class;
		
		// Button spritesheet
		[Embed(source = 'res/buttons.png')]
		public static const BUTTONS_RAW:Class;
		
		// Title art
		[Embed(source = 'res/art.png')]
		public static const ART_RAW:Class;
		
		// Tileset
		[Embed(source = 'res/tiles.png')]
		public static const TILES_RAW:Class;
		
		// Background
		[Embed(source = 'res/bg.png')]
		public static const BG_RAW:Class;
		
		// Clouds
		[Embed(source = 'res/clouds.png')]
		public static const CLOUDS_RAW:Class;
		
		// OGMO -----------------------------------------------
		
		// Island
		[Embed(source = 'level/island.oel', mimeType = 'application/octet-stream')]
		public static const OGMO_ISLAND:Class
		
		// Constants ------------------------------------------
		
		// Screen scale
		public static const SCALE:int = 2;
		
		// Gravity
		public static const GRAV:Number = 7.5;
		
		// Bounding box for camera
		public static const BOUND:Rectangle = new Rectangle(0, 0, 1280, 720);
		
		// Bullet speed
		public static const BULLET_SPEED:Number = 7;
		
		// Rocket speed
		public static const ROCKET_SPEED:Number = 1.8;
		
		// Player constants -----------------------------------
		
		// Speed
		public static const P_SPEED:Point = new Point(80, 300);
		
		// Maximum speed
		public static const P_MAXSPEED:Point = new Point(160, 650);
		
		// Friction
		public static const P_FRICTION:int = 10;
		
		// Inputs ---------------------------------------------
		
		// Jump
		public static const I_JUMP:String = 'jump';
		
		// Left
		public static const I_LEFT:String = 'left';
		
		// Right
		public static const I_RIGHT:String = 'right';
		
		// Types ---------------------------------------------
		
		// Level and sublevel
		public static const TYPE_LEVEL:String = 'l';
		
		// Functions -----------------------------------------
		
		// Find the difference between two points
		public static function DistanceTwoPoints(x1:Number, x2:Number,  y1:Number, y2:Number):Number
		{
			var dx:Number = x1 - x2;
			var dy:Number = y1 - y2;
			return Math.sqrt(dx * dx + dy * dy);
		}
	}

}