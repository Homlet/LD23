package uk.co.homletmoo.LD23 
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.tweens.misc.NumTween;
	import net.flashpunk.utils.Ease;
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class DeadWorld extends World
	{
		private var _selected:int;
		private var _pressed:Number = 0.3;
		private var _select:Boolean = false;
		private var BUTTONS:uint = 2;
		
		private var _over:Entity;
		private var _bPlay:Entity;
		private var _bMenu:Entity;
		
		private var _overG:Text = new Text("Game Over\nScore: " + Globals.SCORE.toString(), FP.halfWidth, 30);
		private var _bPlayG:Spritemap = new Spritemap(Assets.BUTTONS_RAW, 250, 30);
		private var _bMenuG:Spritemap = new Spritemap(Assets.BUTTONS_RAW, 250, 30);
		
		private var _fader:NumTween = new NumTween(finish);
		private var _fadeRect:Image = Image.createRect(FP.width, FP.height, 0);
		private var _fadeEnt:Entity;
		
		override public function begin():void
		{
			Input.define("down", Key.DOWN, Key.S);
			Input.define("up", Key.UP, Key.W);
			Input.define("select", Key.SPACE, Key.ENTER, Key.Z, Key.X, Key.C);
			
			_overG.scale = 4;
			_overG.x -= _overG.scaledWidth / 2;
			_over = new Entity(0, 0, _overG);
			_bPlay = new Entity(FP.halfWidth - _bPlayG.width / 2, FP.height - _bPlayG.height * 4.5, _bPlayG);
			_bMenu = new Entity(FP.halfWidth - _bMenuG.width / 2, FP.height - _bMenuG.height * 3, _bMenuG);
			
			_bPlayG.add("unselected", [0], 0, false);
			_bPlayG.add("selected", [1], 0, false);
			_bMenuG.add("unselected", [4], 0, false);
			_bMenuG.add("selected", [5], 0, false);
			
			_bPlayG.play("selected");
			_bMenuG.play("unselected");
			
			_fadeEnt = new Entity(0, 0, _fadeRect);
			fadeIn();
			
			Assets.S_ROCKET.stop();
			Assets.S_MUSIC.stop();
			Assets.S_DEATH.play();
			
			add(_over);
			add(_bPlay);
			add(_bMenu);
			
			add(_fadeEnt);
			addTween(_fader);
		}
		
		override public function update():void
		{
			_fadeRect.alpha = _fader.value;
			
			if (Input.pressed("up") && _pressed > 0.1)
			{
				Assets.S_SELECT.play();
				_pressed = 0;
				_selected--;
			}
			
			if (Input.pressed("down") && _pressed > 0.1)
			{
				Assets.S_SELECT.play();
				_pressed = 0;
				_selected++;
			}
			
			if (Input.pressed("select") && _pressed > 0.1)
			{
				Assets.S_ENTER.play();
				_pressed = 0;
				_select = true;
				fadeOut();
			}
			
			if (_selected >= BUTTONS)
				_selected = 0;
			
			if (_selected < 0)
				_selected = BUTTONS - 1;
			
			if(!_select)
				_pressed += FP.elapsed;
			
			// Play the selected frame for the relevant button
			switch(_selected)
			{
				case 0:
					_bPlayG.play("selected");
					_bMenuG.play("unselected");
				break;
				
				case 1:
					_bPlayG.play("unselected");
					_bMenuG.play("selected");
				break;
			}
			
			super.update();
		}
		
		// Fade the sceen in
		private function fadeIn():void
		{
			_fader.tween(1, 0, 1.5, Ease.cubeOut);
		}
		
		// Fade the screen out
		private function fadeOut():void
		{
			_fader.tween(0, 1, 1.5, Ease.cubeIn);
		}
		
		private function finish():void
		{
			if (_select)
			{
				switch(_selected)
				{
					case 0:
						FP.world = new GameWorld;
						Globals.reset();
					break;
					
					case 1:
						FP.world = new MenuWorld;
					break;
				}
			}
		}
		
	}

}