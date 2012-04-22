package uk.co.homletmoo.LD23 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Text;
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class HUD extends Entity
	{
		protected var score:Text;
		protected var health:Spritemap;
		protected var healthLevel:Array;
		
		public function HUD()
		{
			score = new Text("Score: " + Globals.SCORE.toString(), FP.camera.x, FP.camera.y);
			score.scrollX = score.scrollY = 0;
			score.relative = false;
			health = new Spritemap(Assets.HEARTS_RAW, 30, 10);
			health.add("4", [0]);
			health.add("3", [1]);
			health.add("2", [2]);
			health.add("1", [3]);
			healthLevel = new Array("1", "2", "3", "4");
			health.play(healthLevel[Globals.PLAYER_HEALTH - 1]);
			health.scrollX = health.scrollY = 0;
			health.relative = false;
			health.scale = 2;
			health.x = FP.width - health.scaledWidth - 2;
			health.y += 2;
			super(0, 0, new Graphiclist(score, health));
			layer = -30;
		}
		
		override public function update():void
		{
			score.text = "Score: " + Globals.SCORE.toString();
			
			if (Globals.PLAYER_HEALTH > 0) health.play(healthLevel[Globals.PLAYER_HEALTH - 1]);
			else health.play("1");
			
			super.update();
		}
		
	}

}