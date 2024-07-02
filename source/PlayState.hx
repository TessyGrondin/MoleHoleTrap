package;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.math.FlxRandom;
import flixel.FlxG;
import haxe.iterators.ArrayIterator;
import flixel.text.FlxText;

class PlayState extends FlxState
{
	var background:FlxSprite;
	var moles:Array<Mole>;
	var score = 0;
	var pos:FlxRandom;
	var x = [80, 170, 80, 170];
	var y = [100, 100, 250, 250];
	var score_disp:FlxText;

	override public function create()
	{
		super.create();

		background = new FlxSprite(0, 0);
		background.loadGraphic(AssetPaths.background__png, true, 320, 480);
		add(background);

		moles = new Array<Mole>();
		for (i in 0...4) {
			moles.push(new Mole(1, x[i], y[i]));
			add(moles[i]);
		}

		score_disp = new FlxText(10, 5, 200, "SCORE: " + score, 20);
		add(score_disp);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		for (mole in moles)	{
			pos = new FlxRandom();
			if((pos.int(1, 8) < 6)) {
				if (mole.animation.name != "up")
					mole.animation.play("up");
				break;
			}
			if (mole.animation.name == "up" && FlxG.mouse.justPressed && FlxG.mouse.overlaps(mole)) {
				score = score + mole.value;
				score_disp.text = "SCORE: " + score;
				mole.animation.play("down");
			}
		}
	}
}
