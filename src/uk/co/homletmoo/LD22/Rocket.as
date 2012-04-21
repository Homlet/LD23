package uk.co.homletmoo.LD22 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.graphics.Graphiclist;
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class Rocket extends Entity
	{
		protected var gun:Image;
		protected var bulletTime:Number;
		
		public function Rocket(x:int, y:int)
		{
			gun = Image.createRect(2, 8, 0xAAAA44);
			gun.originX = 1;
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
			
			if (bulletTime > 20 && Assets.DistanceTwoPoints(x, (FP.world as GameWorld).player.x, y, (FP.world as GameWorld).player.y) < 450)
			{
				bulletTime = 0;
				FP.world.add(new RocketAmmo(x, y, angle, playerX, playerY))
			}
			
			super.update();
		}
	}

}