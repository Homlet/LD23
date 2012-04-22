package uk.co.homletmoo.LD23
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.tweens.misc.NumTween;
	import net.flashpunk.utils.Ease;
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class SplashWorld extends World 
	{
		private var _logos:Entity;
		private var _fpStrip:Spritemap;
		private var _hmImage:Image;
		
		private var _fader:NumTween = new NumTween(finish);
		private var _fadeRect:Image = Image.createRect(FP.width, FP.height, 0);
		private var _fadeEnt:Entity;
		private var _fadeIterator:Number = 0;
		
		private const FADE_SCREENS:Number = 2;
		
		override public function begin():void
		{
			_logos = new Entity(0, 0);
			_fpStrip = new Spritemap(Assets.FP_RAW, 100, 100);
			_fpStrip.scale = 2;
			_fpStrip.y = FP.height - _fpStrip.scaledHeight;
			_fpStrip.add("run", [0, 1, 2, 3, 4], 8, true);
			_fpStrip.play("run");
			
			_hmImage = new Image(Assets.HM_RAW);
			_hmImage.scale = 1.5;
			_hmImage.x = FP.width;
			
			_logos.graphic = new Graphiclist(_fpStrip, _hmImage);
			
			_fadeEnt = new Entity(0, 0, _fadeRect);
			fadeIn();
			
			add(_logos);
			add(_fadeEnt);
			addTween(_fader);
		}
		
		override public function update():void
		{
			_fadeRect.alpha = _fader.value;
			
			super.update();
		}
		
		private function fadeIn():void
		{
			_fader.tween(1, 0, 2, Ease.cubeOut);
			
			if (_fadeIterator == 1)
			{
				_fpStrip.x = FP.width;
				
				_hmImage.x = (FP.width / 2) - (_hmImage.scaledWidth / 2);
				_hmImage.y = (FP.height / 2) - (_hmImage.scaledHeight / 2);
			}
		}
		
		private function fadeOut():void
		{
			_fader.tween(0, 1, 3, Ease.cubeIn);
		}
		
		public function finish():void
		{
			if (_fader.value == 0)
				fadeOut()
			else if (_fadeIterator++ < FADE_SCREENS - 1)
				fadeIn()
			else
				FP.world = new MenuWorld();
		}
		
	}

}