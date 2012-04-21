package uk.co.homletmoo.LD22 
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
	public class Bullet extends Entity
	{
		protected var shot:Image;
		protected var flash:Image;
		protected var flashFade:VarTween;
		
		protected var playerX:Number;
		protected var playerY:Number;
		
		protected var start:Point;
		
		public function Bullet(x:int, y:int, angle:Number, pX:int, pY:int)
		{
			shot = Image.createCircle(2);
			flash = Image.createRect(2, 1280, 0xffffff, 0.6);
			flashFade = new VarTween();
			flashFade.tween(flash, "alpha", 0, 0.2, Ease.expoIn);
			
			super(x, y, new Graphiclist(shot, flash));
			setHitbox(2, 2);
			
			flash.angle = angle + 180;
			
			flash.relative = false;
			flash.x = x;
			flash.y = y;
			
			playerX = pX + 6;
			playerY = pY + 6;
			
			start = new Point(x, y);
			
			addTween(flashFade, true);
		}
		
		override public function update():void
		{
			moveTowards((playerX - start.x) * 100, (playerY - start.y) * 100, Assets.BULLET_SPEED);
			
			if (Assets.DistanceTwoPoints(playerX, x, playerY, y) > 1000)
			{
				FP.world.remove(this);
			}
			
			if (y > Assets.BOUND.bottom + FP.halfHeight) y = -FP.halfHeight;
			
			super.update();
		}
		
	}

}