package uk.co.homletmoo.LD22 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class Coin extends Entity
	{
		protected var img:Image;
		
		public function Coin(x:int, y:int)
		{
			img = Image.createCircle(6, 0xE0E044);
			super(x, y, img);
			setHitbox(12, 12);
			layer = -1;
			
			type = Assets.TYPE_COIN;
		}
		
		override public function added():void
		{
			x += 2;
			y += 2;
		}
		
		override public function update():void
		{
			if (collide(Assets.TYPE_PLAYER, x, y))
			{
				FP.world.remove(this);
				Globals.SCORE += Globals.COIN_VALUE;
				Globals.COIN_VALUE += 20;
				if(Globals.BULLET_SPEED < 6) Globals.BULLET_SPEED += 0.1;
				if(Globals.ROCKET_SPEED < 2) Globals.ROCKET_SPEED += 0.1;
				if(Globals.BULLET_INTERVAL > 1.8) Globals.BULLET_INTERVAL -= 0.3;
				if(Globals.ROCKET_INTERVAL > 22) Globals.ROCKET_INTERVAL -= 0.3;
				Assets.placeCoin();
			}
			
			super.update();
		}
		
	}

}