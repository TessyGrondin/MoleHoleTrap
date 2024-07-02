package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;

class EndState extends FlxState
{
	var background:FlxSprite;
	var score:FlxText;
	var finalScore:Int;

	public function new(finalScore:Int)
	{
		super();
		this.finalScore = finalScore;
	}

	override public function create()
	{
		super.create();

		background = new FlxSprite();
		background.loadGraphic(AssetPaths.background__png, true, 320, 480);
		add(background);

		score = new FlxText(100, FlxG.height / 2, 200, "Final result: " + finalScore, 20);
		add(score);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
