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
		
		protected var lifespan:Number;
		
		public function Bullet(x:int, y:int, angle:Number, pX:int, pY:int)
		{
			shot = Image.createCircle(2);
			flash = Image.createRect(2, 1280, 0xffffff, 0.4);
			flashFade = new VarTween();
			flashFade.tween(flash, "alpha", 0, 0.3, Ease.expoIn);
			
			super(x, y, new Graphiclist(shot, flash));
			setHitbox(4, 4);
			layer = -3;
			
			flash.angle = angle + 180;
			
			flash.relative = false;
			flash.x = x;
			flash.y = y;
			
			playerX = pX + 6;
			playerY = pY + 6;
			
			start = new Point(x, y);
			lifespan = 5;
			
			type = Assets.TYPE_BULLET;
			
			addTween(flashFade, true);
		}
		
		override public function update():void
		{
			moveTowards((playerX - start.x) * 100, (playerY - start.y) * 100, Globals.BULLET_SPEED);
			
			lifespan -= FP.elapsed;
			
			if (lifespan <= 0 || collide(Assets.TYPE_PLAYER, x, y))
				FP.world.remove(this);
			
			super.update();
		}
		
	}

}