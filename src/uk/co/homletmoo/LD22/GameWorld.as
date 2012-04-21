package uk.co.homletmoo.LD22 
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.Image;
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
		
		protected var background:Entity;
		protected var sky:Image;
		
		override public function begin():void
		{
			sky = new Image(Assets.BG_RAW);
			background = new Entity(FP.camera.x, FP.camera.y, sky);
			
			Input.define(Assets.I_JUMP, Key.UP, Key.SPACE, Key.W);
			Input.define(Assets.I_LEFT, Key.LEFT, Key.A);
			Input.define(Assets.I_RIGHT, Key.RIGHT, Key.D);
			
			level = new Level();
			player = new Player(620, 240);
			
			FP.setCamera(int(player.x + player.halfWidth - FP.halfWidth), int(FP.camera.y));
			FP.setCamera(int(FP.camera.x), int(player.y + player.halfHeight - FP.halfHeight));
			
			add(background);
			add(level);
			add(player);
		}
		
		override public function update():void
		{
			super.update();
			
			if (player.x > Assets.BOUND.left && player.x < Assets.BOUND.right) FP.setCamera(int(player.x + player.halfWidth - FP.halfWidth), int(FP.camera.y));
			FP.setCamera(int(FP.camera.x), int(player.y + player.halfHeight - FP.halfHeight));
			
			background.x = FP.camera.x;
			background.y = FP.camera.y;
		}
		
	}

}