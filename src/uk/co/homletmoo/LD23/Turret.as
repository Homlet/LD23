package uk.co.homletmoo.LD23 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class Turret extends Entity 
	{
		protected var gun:Image;
		protected var bulletTime:Number;
		
		public function Turret(x:int, y:int)
		{
			gun = new Image(Assets.TURRET_RAW);
			gun.originX = 8;
			gun.originY = 8;
			
			super(x, y, gun);
			layer = -5;
			
			bulletTime = 0;
		}
		
		override public function update():void
		{
			var playerX:Number = (FP.world as GameWorld).player.x;
			var playerY:Number = (FP.world as GameWorld).player.y;
			
			var angle:Number = (Math.atan2(playerY + (FP.world as GameWorld).player.halfHeight - y, playerX + (FP.world as GameWorld).player.halfWidth - x)) * 180 / Math.PI;
			angle = -angle - 90;
			gun.angle = angle;
			
			bulletTime += FP.elapsed;
			
			if (bulletTime > Globals.BULLET_INTERVAL
				&& Assets.DistanceTwoPoints(x, (FP.world as GameWorld).player.x, y, (FP.world as GameWorld).player.y) < 380
				&& Assets.DistanceTwoPoints(x, (FP.world as GameWorld).player.x, y, (FP.world as GameWorld).player.y) > 50)
			{
				bulletTime = 0;
				FP.world.add(new Bullet(x, y, angle, playerX, playerY));
			}
			
			super.update();
		}
	}

}