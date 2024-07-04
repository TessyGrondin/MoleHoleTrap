package;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.math.FlxRandom;
import flixel.FlxG;
import haxe.iterators.ArrayIterator;
import flixel.text.FlxText;
import flixel.util.FlxTimer;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	var background:FlxSprite;
	var moles:Array<Mole>;
	var score = 0;
	var pos:FlxRandom;
	var col:FlxRandom;
	var x = [40, 100, 160, 220, 40, 100, 160, 220, 40, 100, 160, 220, 40, 100, 160, 220];
	var y = [100, 100, 100, 100, 170, 170, 170, 170, 240, 240, 240, 240, 310, 310, 310, 310];
	var score_disp:FlxText;
	var timer:FlxTimer;
	var score_modifier:FlxSprite;
	var timer_disp:FlxText;

	override public function create()
	{
		super.create();

		background = new FlxSprite(0, 0);
		background.loadGraphic(AssetPaths.background__png, true, 320, 480);
		add(background);

		moles = new Array<Mole>();
		for (i in 0...16) {
			col = new FlxRandom();
			moles.push(new Mole(1, x[i], y[i], col.int(0, 4)));
			add(moles[i]);
		}

		score_disp = new FlxText(10, 5, 200, "SCORE: " + score, 20);
		add(score_disp);

		timer = new FlxTimer();
		timer.start(90, change, 0);

		score_modifier = new FlxSprite(0, 0);
		score_modifier.loadGraphic(AssetPaths.score__png, true, 32, 32);
		score_modifier.scale.set(2, 2);
		score_modifier.animation.add("50", [0]);
		score_modifier.animation.add("100", [1]);
		score_modifier.animation.add("300", [2]);
		score_modifier.animation.play("100");
		add(score_modifier);

		timer_disp = new FlxText(FlxG.width - 50, 10, 200, "" + Std.int(timer.timeLeft), 20);
		add(timer_disp);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		timer_disp.text = "" + Std.int(timer.timeLeft);

		score_modifier.x = FlxG.mouse.x;
		score_modifier.y = FlxG.mouse.y - 50;

		if (!FlxG.mouse.pressed)
			score_modifier.alpha = 0;
		else
			score_modifier.alpha = 255;

		if (missed()) {
			score = score - 50;
			if (score < 0)
				score = 0;
			score_disp.text = "SCORE: " + score;
			score_modifier.animation.play("50");
		}

		for (i in 0...16)	{
			pos = new FlxRandom();
			if((pos.int(1, 100) < 3)) {
				if (moles[i].animation.name == "full_down")
					moles[i].animation.play("up");
			}
			if (moles[i].animation.name == "up" && moles[i].animation.finished)
				moles[i].animation.play("down");
			if ((moles[i].animation.name != "full_down" && FlxG.mouse.justPressed && FlxG.mouse.overlaps(moles[i]))) {
				score = score + moles[i].value;
				score_modifier.animation.play("" + moles[i].value);
				score_disp.text = "SCORE: " + score;
				moles[i].animation.play("down");
				moles[i].touched = true;
			} else if (moles[i].animation.name == "down" && moles[i].animation.finished) {
				col = new FlxRandom();
				moles[i].destroy();
				moles[i] = new Mole(1, x[i], y[i], col.int(0, 4));
				add(moles[i]);
			}
		}
	}

	public function change(_):Void
	{
		FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
		{
			FlxG.switchState(new EndState(score));
		});
	}

	private function missed():Bool
	{
		if (!FlxG.mouse.justPressed)
			return false;
		for (mole in moles) {
			if (FlxG.mouse.overlaps(mole)) {
				if (mole.animation.name == "full_down" || mole.touched)
					return true;
				return false;
			}
		}
		return true;
	}
}
