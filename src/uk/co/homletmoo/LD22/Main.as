package uk.co.homletmoo.LD22
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
			super(640, 360, 59.97, false);
			FP.screen.scale = Assets.SCALE;
			//FP.console.enable();
			FP.console.toggleKey = Key.TAB;
		}
		
		override public function init():void
		{
			FP.world = new MenuWorld();
		}
		
	}
	
}