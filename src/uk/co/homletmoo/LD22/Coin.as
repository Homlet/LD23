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
			img = Image.createCircle(6, 6, 0xE0E022);
			super(x, y, img);
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
				
			}
			
			super.update();
		}
		
	}

}