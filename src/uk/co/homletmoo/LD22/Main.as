package uk.co.homletmoo.LD22
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	
	[SWF(width = "800", height = "600", backgroundColor = "#FFFFFF")]
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class Main extends Engine
	{
		public function Main():void
		{
			super(800, 600, 60, false);
		}
		
		override public function init():void
		{
			FP.world = new SplashWorld();
		}
		
	}
	
}