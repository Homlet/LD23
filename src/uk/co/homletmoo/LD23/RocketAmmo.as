package uk.co.homletmoo.LD23
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.utils.Ease;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class RocketAmmo extends Entity
	{
		protected var shot:Image;
		protected var start:Point;
		protected var lifespan:Number;
		
		protected var flash:Image;
		protected var flashFade:VarTween;
		
		public function RocketAmmo(x:int, y:int, angle:Number, pX:int, pY:int)
		{
			shot = Image.createCircle(2);
			flash = Image.createRect(2, 2600, 0xff5555, 1);
			flash.originX = 1;
			flash.originY = 2600;
			flashFade = new VarTween();
			flashFade.tween(flash, "alpha", 0, 7, Ease.expoIn);
			
			super(x, y, new Graphiclist(shot, flash));
			setHitbox(4, 4);
			layer = -3;
			
			start = new Point(x, y);
			lifespan = 7;
			
			type = Assets.TYPE_BULLET;
			
			Assets.S_SHOOT.play();
			
			addTween(flashFade, true);
		}
		
		override public function update():void
		{
			var playerX:Number = (FP.world as GameWorld).player.x;
			var playerY:Number = (FP.world as GameWorld).player.y;
			
			var angle:Number = (Math.atan2(playerY + (FP.world as GameWorld).player.halfHeight - y, playerX + (FP.world as GameWorld).player.halfWidth - x)) * 180 / Math.PI;
			angle = -angle - 90;
			flash.angle = angle;
			
			moveTowards(playerX, playerY, Globals.ROCKET_SPEED);
			
			lifespan -= FP.elapsed;
			
			if (lifespan <= 0 || collide(Assets.TYPE_PLAYER, x, y))
			{
				FP.world.remove(this);
				Assets.S_EXPLODE.play();
			}
			
			super.update();
		}
		
	}

}