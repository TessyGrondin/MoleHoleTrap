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
	var col:FlxRandom;
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
			col = new FlxRandom();
			moles.push(new Mole(1, x[i], y[i], col.int(0, 4)));
			add(moles[i]);
		}

		score_disp = new FlxText(10, 5, 200, "SCORE: " + score, 20);
		add(score_disp);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		for (i in 0...4)	{
			pos = new FlxRandom();
			if((pos.int(1, 8) < 3)) {
				if (moles[i].animation.name == "full_down")
					moles[i].animation.play("up");
				break;
			}
			if (moles[i].animation.name == "up" && FlxG.mouse.justPressed && FlxG.mouse.overlaps(moles[i])) {
				score = score + moles[i].value;
				score_disp.text = "SCORE: " + score;
				moles[i].animation.play("down");
			} else if (moles[i].animation.name == "down" && moles[i].animation.finished) {
				col = new FlxRandom();
				moles[i].destroy();
				moles[i] = new Mole(1, x[i], y[i], col.int(0, 4));
				add(moles[i]);
			}
		}
	}
}
