package uk.co.homletmoo.LD23
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	
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
		
		// Hearts
		[Embed(source = 'res/health.png')]
		public static const HEARTS_RAW:Class;
		
		// Turret
		[Embed(source = 'res/turret.png')]
		public static const TURRET_RAW:Class;
		
		// Rocket
		[Embed(source = 'res/rocket.png')]
		public static const ROCKET_RAW:Class;
		
		// Rocket ammo
		[Embed(source = 'res/rocketammo.png')]
		public static const ROCKETAMMO_RAW:Class;
		
		// Coin
		[Embed(source = 'res/coin.png')]
		public static const COIN_RAW:Class;
		
		// Coin pointer
		[Embed(source = 'res/pointer.png')]
		public static const POINT_RAW:Class;
		
		// Help
		[Embed(source = 'res/help.png')]
		public static const HELP_RAW:Class;
		
		// Credits
		[Embed(source = 'res/credits.png')]
		public static const CREDS_RAW:Class;
		
		// Player
		[Embed(source = 'res/player.png')]
		public static const PLAYER_RAW:Class;
		
		// Vignette overlay
		[Embed(source = 'res/vignette.png')]
		public static const VIG_RAW:Class;
		
		// Sounds ---------------------------------------------
		
		// Coin
		[Embed(source = 'snd/coin.mp3')]
		public static const S_COIN_RAW:Class;
		public static const S_COIN:Sfx = new Sfx(S_COIN_RAW);
		
		// Death
		[Embed(source = 'snd/die.mp3')]
		public static const S_DEATH_RAW:Class;
		public static const S_DEATH:Sfx = new Sfx(S_DEATH_RAW);
		
		// Menu enter
		[Embed(source = 'snd/enter.mp3')]
		public static const S_ENTER_RAW:Class;
		public static const S_ENTER:Sfx = new Sfx(S_ENTER_RAW);
		
		// Menu Select
		[Embed(source = 'snd/select.mp3')]
		public static const S_SELECT_RAW:Class;
		public static const S_SELECT:Sfx = new Sfx(S_SELECT_RAW);
		
		// Explosion
		[Embed(source = 'snd/explode.mp3')]
		public static const S_EXPLODE_RAW:Class;
		public static const S_EXPLODE:Sfx = new Sfx(S_EXPLODE_RAW);
		
		// Hit
		[Embed(source = 'snd/hurt.mp3')]
		public static const S_HIT_RAW:Class;
		public static const S_HIT:Sfx = new Sfx(S_HIT_RAW);
		
		// Death
		[Embed(source = 'snd/jump.mp3')]
		public static const S_JUMP_RAW:Class;
		public static const S_JUMP:Sfx = new Sfx(S_JUMP_RAW);
		
		// Shoot
		[Embed(source = 'snd/shoot.mp3')]
		public static const S_SHOOT_RAW:Class;
		public static const S_SHOOT:Sfx = new Sfx(S_SHOOT_RAW);
		
		// Rocket
		[Embed(source = 'snd/rocket.mp3')]
		public static const S_ROCKET_RAW:Class;
		public static const S_ROCKET:Sfx = new Sfx(S_ROCKET_RAW);
		
		// Music
		[Embed(source = 'snd/music.mp3')]
		public static const S_MUSIC_RAW:Class;
		public static const S_MUSIC:Sfx = new Sfx(S_MUSIC_RAW);
		
		// OGMO -----------------------------------------------
		
		// Island
		[Embed(source = 'level/island.oel', mimeType = 'application/octet-stream')]
		public static const OGMO_ISLAND:Class
		
		// Island 2
		[Embed(source = 'level/island2.oel', mimeType = 'application/octet-stream')]
		public static const OGMO_ISLAND2:Class
		
		// Constants ------------------------------------------
		
		// Screen scale
		public static const SCALE:int = 2;
		
		// Gravity
		public static const GRAV:Number = 7.5;
		
		// Bounding box for camera
		public static const BOUND:Rectangle = new Rectangle(0, 0, 1280, 720);
		
		// Camera quake
		public static const QUAKE:Quake = new Quake();
		
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
		
		// Bullet and rocket
		public static const TYPE_BULLET:String = 'b';
		
		// Player
		public static const TYPE_PLAYER:String = 'p';
		
		// Coin
		public static const TYPE_COIN:String = 's';
		
		// Functions -----------------------------------------
		
		// Find the difference between two points
		public static function DistanceTwoPoints(x1:Number, x2:Number,  y1:Number, y2:Number):Number
		{
			var dx:Number = x1 - x2;
			var dy:Number = y1 - y2;
			return Math.sqrt(dx * dx + dy * dy);
		}
		
		// Place a new coin
		public static function placeCoin():void
		{
			var coinPoint:Point = Globals.COINPOINTS[Math.floor(Math.random() * Globals.COINPOINTS.length)];
			FP.world.add(new Coin(coinPoint.x, coinPoint.y));
		}
	}

}