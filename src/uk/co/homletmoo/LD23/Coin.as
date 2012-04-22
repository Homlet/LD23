package uk.co.homletmoo.LD23 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class Coin extends Entity
	{
		protected var img:Spritemap;
		
		public function Coin(x:int, y:int)
		{
			img = new Spritemap(Assets.COIN_RAW, 14, 16);
			img.add('main', [0, 1, 2, 3], 8, true);
			img.play('main');
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
				if(Globals.BULLET_SPEED < 6) Globals.BULLET_SPEED += 0.1;
				if(Globals.ROCKET_SPEED < 2) Globals.ROCKET_SPEED += 0.1;
				if(Globals.BULLET_INTERVAL > 1.8) Globals.BULLET_INTERVAL -= 0.3;
				if (Globals.ROCKET_INTERVAL > 22) Globals.ROCKET_INTERVAL -= 0.3;
				Assets.S_COIN.play();
				Assets.placeCoin();
			}
			
			super.update();
		}
		
	}

}