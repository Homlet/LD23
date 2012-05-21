package uk.co.homletmoo.LD23
{
	import net.flashpunk.debug.Console;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Key;
	
	[SWF(width = "1280", height = "720", backgroundColor = "#FFFFFF")]
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class Main extends Engine
	{
		public function Main():void
		{
			super(640, 360, 60, false);
			FP.screen.scale = Assets.SCALE;
			//FP.console.enable();
			FP.console.toggleKey = Key.TAB;
			FP.volume = 0.8;
		}
		
		override public function init():void
		{
			FP.world = new MenuWorld();
		}
		
		override public function update():void
		{
			Assets.QUAKE.update();
			
			super.update();
		}
		
	}
	
}