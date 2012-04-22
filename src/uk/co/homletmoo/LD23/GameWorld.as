package uk.co.homletmoo.LD23 
{
	import flash.filters.ConvolutionFilter;
	import net.flashpunk.*;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.tweens.misc.MultiVarTween;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.utils.Ease;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class GameWorld extends World
	{
		public var level:Level;
		public var player:Player;
		
		protected var hud:HUD;
		
		protected var background:Entity;
		protected var bglist:Graphiclist;
		protected var sky:Image;
		
		protected var clouds:Entity;
		protected var cloudlist:Graphiclist;
		
		override public function begin():void
		{			
			Input.define(Assets.I_JUMP, Key.UP, Key.SPACE, Key.W);
			Input.define(Assets.I_LEFT, Key.LEFT, Key.A);
			Input.define(Assets.I_RIGHT, Key.RIGHT, Key.D);
			
			genClouds();
			
			level = new Level();
			player = new Player(620, 240);
			hud = new HUD();
			
			FP.setCamera(int(player.x + player.halfWidth - FP.halfWidth), int(FP.camera.y));
			FP.setCamera(int(FP.camera.x), int(player.y + player.halfHeight - FP.halfHeight));
			
			Assets.S_MUSIC.loop();
			
			add(background);
			add(level);
			add(player);
			add(clouds);
			add(hud);
		}
		
		override public function update():void
		{
			super.update();
			
			FP.setCamera(int(player.x + player.halfWidth - FP.halfWidth), int(FP.camera.y));
			if (player.y < Assets.BOUND.bottom + FP.height) FP.setCamera(int(FP.camera.x), int(player.y + player.halfHeight - FP.halfHeight));
		}
		
		private function genClouds():void
		{
			cloudlist = new Graphiclist();
			for (var i:int = 0; i < 12; i++)
			{
				var cloud:Image = new Image(Assets.CLOUDS_RAW);
				cloud.x = int(Math.random() * 1680);
				cloud.y = int(Math.random() * 720);
				cloud.scrollX = Math.random() * 1 + 1;
				cloud.scrollY = Math.random() * 1 + 1;
				cloud.alpha = cloud.scrollX / cloud.scrollY / 5;
				cloud.scaleX = cloud.scaleY = 1 * cloud.scrollX;
				cloudlist.add(cloud);
			}
			clouds = new Entity(0, 0, cloudlist);
			clouds.layer = -20;
			
			sky = new Image(Assets.BG_RAW);
			sky.scrollX = sky.scrollY = 0;
			
			bglist = new Graphiclist(sky);
			for (var j:int = 0; j < 10; j++)
			{
				var bgcloud:Image = new Image(Assets.CLOUDS_RAW);
				bgcloud.x = int(Math.random() * 660) + 360;
				bgcloud.y = int(Math.random() * 340) + 190;
				bgcloud.scrollX = Math.random() * 0.3 + 0.5;
				bgcloud.scrollY = Math.random() * 0.2 + 0.4;
				bgcloud.alpha = bgcloud.scrollX / bgcloud.scrollY / 3;
				bgcloud.scaleX = bgcloud.scaleY = 1 * bgcloud.scrollX;
				bglist.add(bgcloud);
			}
			background = new Entity(FP.camera.x, FP.camera.y, bglist);
			background.layer = 5;
		}
		
	}

}