package uk.co.homletmoo.LD23 
{
	import flash.utils.Endian;
	import net.flashpunk.*;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.tweens.misc.VarTween;
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
		private var BUTTONS:uint = 3;
		
		private var _credg:Image = new Image(Assets.CREDS_RAW);
		private var _cred:Entity;
		private var _credTween:VarTween;
		private var _credTweenO:VarTween;
		
		private var _helpg:Image = new Image(Assets.HELP_RAW);
		private var _help:Entity;
		private var _helpTween:VarTween;
		private var _helpTweenO:VarTween;
		
		// 0 = menu, 1 = help, 2 = credits
		private var _screen:int = 0;
		
		private var _art:Entity;
		private var _bPlay:Entity;
		private var _bHelp:Entity;
		private var _bCredits:Entity;
		
		private var _artG:Image = new Image(Assets.ART_RAW);
		private var _bPlayG:Spritemap = new Spritemap(Assets.BUTTONS_RAW, 250, 30);
		private var _bHelpG:Spritemap = new Spritemap(Assets.BUTTONS_RAW, 250, 30);
		private var _bCreditsG:Spritemap = new Spritemap(Assets.BUTTONS_RAW, 250, 30);
		
		private var _fader:NumTween = new NumTween(finish);
		private var _fadeRect:Image = Image.createRect(FP.width, FP.height, 0);
		private var _fadeEnt:Entity;
		
		override public function begin():void
		{
			FP.screen.color = 0;
			
			Input.define("down", Key.DOWN, Key.S);
			Input.define("up", Key.UP, Key.W);
			Input.define("select", Key.SPACE, Key.ENTER, Key.Z, Key.X, Key.C);
			
			_art = new Entity(0, 0, _artG);
			_bPlay = new Entity(FP.halfWidth - _bPlayG.width / 2, FP.height - _bPlayG.height * 4.5, _bPlayG);
			_bHelp = new Entity(FP.halfWidth - _bHelpG.width / 2, FP.height - _bHelpG.height * 3, _bHelpG);
			_bCredits = new Entity(FP.halfWidth - _bCreditsG.width / 2, FP.height - _bCreditsG.height * 1.5, _bCreditsG);
			
			_help = new Entity(FP.width, 0, _helpg);
			_help.layer = -40;
			_helpTween = new VarTween();
			_helpTweenO = new VarTween();
			
			_cred = new Entity(-FP.width, 0, _credg);
			_cred.layer = -40;
			_credTween = new VarTween();
			_credTweenO = new VarTween();
			
			_bPlayG.add("unselected", [0], 0, false);
			_bPlayG.add("selected", [1], 0, false);
			_bHelpG.add("unselected", [2], 0, false);
			_bHelpG.add("selected", [3], 0, false);
			_bCreditsG.add("unselected", [6], 0, false);
			_bCreditsG.add("selected", [7], 0, false);
			
			_bPlayG.play("selected");
			_bHelpG.play("unselected");
			_bCreditsG.play("unselected");
			
			_fadeEnt = new Entity(0, 0, _fadeRect);
			_fadeEnt.layer = -50;
			fadeIn();
			
			add(_art);
			add(_bPlay);
			add(_bHelp);
			add(_bCredits);
			add(_help);
			add(_cred);
			
			add(_fadeEnt);
			addTween(_fader);
			addTween(_helpTween);
			addTween(_helpTweenO);
			addTween(_credTween);
			addTween(_credTweenO);
		}
		
		override public function update():void
		{
			_fadeRect.alpha = _fader.value;
			
			if (Input.pressed("up") && _pressed > 0.1 && _screen == 0)
			{
				Assets.S_SELECT.play();
				_pressed = 0;
				_selected--;
			}
			
			if (Input.pressed("down") && _pressed > 0.1 && _screen == 0)
			{
				Assets.S_SELECT.play();
				_pressed = 0;
				_selected++;
			}
			
			if (Input.pressed("select") && _pressed > 0.1)
			{
				if (_screen == 0)
				{
					Assets.S_ENTER.play();
					_pressed = 0;
					switch(_selected)
					{
						case 0:
							fadeOut();
							_select = true;
						break;
						
						case 1:
							_helpTween.tween(_help, "x", 0, 2, Ease.bounceOut);
							_helpTween.start();
							_screen = 1;
						break;
						
						case 2:
							_credTween.tween(_cred, "x", 0, 2, Ease.bounceOut);
							_credTween.start();
							_screen = 2;
						break;
					}
				}else if(_screen == 1)
				{
					_helpTweenO.tween(_help, "x", FP.width, 1, Ease.sineIn);
					_helpTweenO.start();
					_screen = 0;
				}else if(_screen == 2)
				{
					_credTweenO.tween(_cred, "x", -FP.width, 1, Ease.sineIn);
					_credTweenO.start();
					_screen = 0;
				}
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
					_bCreditsG.play("unselected");
				break;
				
				case 1:
					_bPlayG.play("unselected");
					_bHelpG.play("selected");
					_bCreditsG.play("unselected");
				break;
				
				case 2:
					_bPlayG.play("unselected");
					_bHelpG.play("unselected");
					_bCreditsG.play("selected");
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
				FP.world = new GameWorld;
				Globals.reset();
			}
		}
		
	}

}