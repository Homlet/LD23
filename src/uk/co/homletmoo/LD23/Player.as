package uk.co.homletmoo.LD23 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class Player extends Entity
	{
		protected var v:Point;
		protected var a:Point;
		
		protected var onGround:Boolean;
		protected var dirRight:Boolean;
		
		// Is the player walljumping -1 = left, 0 = no, 1 = right
		protected var wallJump:int;
		protected var onWall:int;
		
		protected var fell:Boolean;
		protected var dead:Boolean;
		protected var grace:Number;
		
		protected var img:Image;
		
		public function Player(x:int, y:int)
		{
			img = Image.createRect(12, 12, 0xFF0000);
			super(x, y, img);
			setHitbox(12, 12);
			layer = -10;
			
			v = new Point();
			a = new Point();
			
			onGround = false;
			dirRight = true;
			
			wallJump = 0;
			onWall = 0;
			
			fell = false;
			dead = false;
			grace = 0;
			
			type = Assets.TYPE_PLAYER;
		}
		
		override public function update():void
		{
			if (dead)
			{
				FP.world = new DeadWorld();
				FP.world.remove(this);
			}
			
			// Is the player colliding with the ground
			onGround = false;
			if (collide(Assets.TYPE_LEVEL, x, y + 1))
			{
				onGround = true;
				fell = false;
				wallJump = 0;
			}
			
			// Is the player colliding with a wall
			onWall = 0;
			if (collide(Assets.TYPE_LEVEL, x + 1, y))
				onWall = 1;
			else if (collide(Assets.TYPE_LEVEL, x - 1, y))
				onWall = -1;
			
			a.x = 0;
			
			// Handle left + right input
			if (Input.check(Assets.I_LEFT) && v.x > -Assets.P_MAXSPEED.x) { a.x = -Assets.P_SPEED.x; dirRight = false };
			if (Input.check(Assets.I_RIGHT) && v.x < Assets.P_MAXSPEED.x) { a.x = Assets.P_SPEED.x; dirRight = true };
			
			// Apply friction when not moving or moving too fast
			if ((!Input.check(Assets.I_LEFT) && !Input.check(Assets.I_RIGHT)) || Math.abs(v.x) > Assets.P_MAXSPEED.x) friction();
			
			// Jump logic here
			if (Input.pressed(Assets.I_JUMP))
			{
				var jumped:Boolean = false;
				
				// Normal jump
				if (onGround)
				{
					jumped = true;
					v.y = -Assets.P_SPEED.y;
					Assets.S_JUMP.play();
				}
				
				//Wall jump left
				if (!jumped && onWall == 1)
				{
					jumped = true;
					wallJump = -1;
					if (Input.check(Assets.I_RIGHT))
						v.x = -Assets.P_MAXSPEED.x * 2.5;
					else
						v.x = -Assets.P_MAXSPEED.x * 1.5;
					v.y = -Assets.P_SPEED.y;
					Assets.S_JUMP.play();
				}
				
				//Wall jump right
				if (!jumped && onWall == -1)
				{
					jumped = true;
					wallJump = -1;
					if (Input.check(Assets.I_LEFT))
						v.x = Assets.P_MAXSPEED.x * 2.5;
					else
						v.x = Assets.P_MAXSPEED.x * 1.5;
					v.y = -Assets.P_SPEED.y;
					Assets.S_JUMP.play();
				}
			}
			
			// Apply gravity
			gravity(1);
			
			// Limit y motion
			limitY();
			
			// Triple gravity if jump key not held down
			if (!Input.check(Assets.I_JUMP)) gravity(2);
			
			// If on wall, slow fall
			if (onWall == -1 && v.y > 0)
				if (Input.check(Assets.I_LEFT))
					v.y /= 1.5;
				else
					v.y /= 1.1;
			
			if (onWall == 1 && v.y > 0)
				if (Input.check(Assets.I_RIGHT))
					v.y /= 1.5;
				else
					v.y /= 1.1;
					
			
			motion();
			
			if (y > Assets.BOUND.bottom + FP.height && !fell) { y = -FP.height; fell = true }
			
			if (grace >= 3 && !dead)
			{
				img.alpha = 1;
				if (collide(Assets.TYPE_BULLET, x, y))
				{
					img.alpha = 0.5;
					Globals.PLAYER_HEALTH--;
					grace = 0;
				}
			}else grace += FP.elapsed;
			
			if (Globals.PLAYER_HEALTH == 0 || y > Assets.BOUND.bottom + FP.height * 2)
				dead = true;
			
			super.update();
		}
		
		private function friction():void
		{
			if (FP.sign(v.x) == 1)
			{
				v.x -= Assets.P_FRICTION;
				if (v.x < 0) v.x = 0;
			}
			
			if (FP.sign(v.x) == -1)
			{
				v.x += Assets.P_FRICTION;
				if (v.x > 0) v.x = 0;
			}
		}
		
		private function gravity(iterations:uint):void
		{
			for (var i:uint = 0; i < iterations; i++)
			{
				v.y += Assets.GRAV;
			}
		}
		
		private function limitY():void
		{
			if (Math.abs(v.y) > Assets.P_MAXSPEED.y)
				v.y = Assets.P_MAXSPEED.y * FP.sign(v.y);
		}
		
		private function motion():void
		{
			if (!mx(v.x)) v.x = 0;
			v.x += a.x;
			
			if (!my(v.y)) v.y = 0;
			v.y += a.y;
		}
		
		private function mx(velocity:int):Boolean
		{
			for (var i:int = 0; i < Math.abs(velocity); i++)
			{
				if (!collide(Assets.TYPE_LEVEL, x + FP.sign(velocity), y)) x += FP.sign(velocity) * FP.elapsed;
				else return false;
			}
			
			return true;
		}
		
		private function my(velocity:int):Boolean
		{
			for (var i:int = 0; i < Math.abs(velocity); i++)
			{
				if (!collide(Assets.TYPE_LEVEL, x, y + FP.sign(velocity))) y += FP.sign(velocity) * FP.elapsed;
				else return false;
			}
			
			return true;
		}
		
	}

}