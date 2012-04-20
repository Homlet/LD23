package uk.co.homletmoo.LD22 
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
	public class MenuWorld extends World
	{
		private var _selected:int;
		private var _pressed:Number = 0.3;
		private var _select:Boolean = false;
		private var BUTTONS:uint = 4;
		
		private var _art:Entity;
		private var _bPlay:Entity;
		private var _bHelp:Entity;
		private var _bOptions:Entity;
		private var _bCredits:Entity;
		
		private var _artG:Image = new Image(Assets.ART_RAW);
		private var _bPlayG:Spritemap = new Spritemap(Assets.BUTTONS_RAW, 125, 15);
		private var _bHelpG:Spritemap = new Spritemap(Assets.BUTTONS_RAW, 125, 15);
		private var _bOptionsG:Spritemap = new Spritemap(Assets.BUTTONS_RAW, 125, 15);
		private var _bCreditsG:Spritemap = new Spritemap(Assets.BUTTONS_RAW, 125, 15);
		
		private var _fader:NumTween = new NumTween(finish);
		private var _fadeRect:Image = Image.createRect(FP.width, FP.height, 0);
		private var _fadeEnt:Entity;
		
		
		//============================= --- Debug --- =============================//
																				   /*
		private var _debugText:Text = new Text("Selected: " + _selected.toString());
		private var _debugTextEnt:Entity = new Entity(0, 580, _debugText);
																				   */
		//=========================================================================//
		
		override public function begin():void
		{
			FP.screen.color = 0;
			
			Input.define("down", Key.DOWN, Key.S);
			Input.define("up", Key.UP, Key.W);
			Input.define("select", Key.SPACE, Key.ENTER, Key.Z, Key.X, Key.C);
			
			_art = new Entity(0, 0, _artG);
			_bPlay = new Entity(FP.halfWidth - (500 / 2), FP.height - 320, _bPlayG);
			_bHelp = new Entity(FP.halfWidth - (500 / 2), FP.height - 240, _bHelpG);
			_bOptions = new Entity(FP.halfWidth - (500 / 2), FP.height - 160, _bOptionsG);
			_bCredits = new Entity(FP.halfWidth - (500 / 2), FP.height - 80, _bCreditsG);
			
			_artG.scale = 4;
			_bPlayG.scale = 4;
			_bHelpG.scale = 4;
			_bOptionsG.scale = 4;
			_bCreditsG.scale = 4;
			
			_bPlayG.add("unselected", [0], 0, false);
			_bPlayG.add("selected", [1], 0, false);
			_bHelpG.add("unselected", [2], 0, false);
			_bHelpG.add("selected", [3], 0, false);
			_bOptionsG.add("unselected", [4], 0, false);
			_bOptionsG.add("selected", [5], 0, false);
			_bCreditsG.add("unselected", [6], 0, false);
			_bCreditsG.add("selected", [7], 0, false);
			
			_bPlayG.play("selected");
			_bHelpG.play("unselected");
			_bOptionsG.play("unselected");
			_bCreditsG.play("unselected");
			
			_fadeEnt = new Entity(0, 0, _fadeRect);
			fadeIn();
			
			add(_art);
			add(_debugTextEnt);
			add(_bPlay);
			add(_bHelp);
			add(_bOptions);
			add(_bCredits);
			
			add(_fadeEnt);
			addTween(_fader);
		}
		
		override public function update():void
		{
			_fadeRect.alpha = _fader.value;
			
			if (Input.pressed("up") && _pressed > 0.1)
			{
				_pressed = 0;
				_selected--;
			}
			
			if (Input.pressed("down") && _pressed > 0.1)
			{
				_pressed = 0;
				_selected++;
			}
			
			if (Input.pressed("select") && _pressed > 0.1)
			{
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
					_bHelpG.play("unselected");
					_bOptionsG.play("unselected");
					_bCreditsG.play("unselected");
				break;
				
				case 1:
					_bPlayG.play("unselected");
					_bHelpG.play("selected");
					_bOptionsG.play("unselected");
					_bCreditsG.play("unselected");
				break;
				
				case 2:
					_bPlayG.play("unselected");
					_bHelpG.play("unselected");
					_bOptionsG.play("selected");
					_bCreditsG.play("unselected");
				break;
				
				case 3:
					_bPlayG.play("unselected");
					_bHelpG.play("unselected");
					_bOptionsG.play("unselected");
					_bCreditsG.play("selected");
				break;
			}
			
			//================= --- Debug --- =================//
															   /*
			_debugText.text = "Selected: " + _selected.toString();
															   */
			//=================================================//
			
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
					break;
					
					// Placeholders ---
					case 1:
						_select = false;
						fadeIn();
					break;
					
					case 2:
						_select = false;
						fadeIn();
					break;
					
					case 3:
						_select = false;
						fadeIn();
					break;
					// ----------------
				}
			}
		}
		
	}

}