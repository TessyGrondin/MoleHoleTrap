package;

import js.lib.webassembly.Global;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class HighScore {
    public static var s1:Int = 0;
    public static var s2:Int = 0;
    public static var s3:Int = 0;
}

class EndState extends FlxState
{
	var background:FlxSprite;
	var score:FlxText;
	public var finalScore:Int;

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

        var tmp:Int;

        if (HighScore.s1 < HighScore.s2 && HighScore.s2 >= HighScore.s3) {
            tmp = HighScore.s1;
            HighScore.s1 = HighScore.s2;
            HighScore.s2 = tmp;
        } else if (HighScore.s1 >= HighScore.s2 && HighScore.s2 < HighScore.s3) {
            tmp = HighScore.s2;
            HighScore.s2 = HighScore.s3;
            HighScore.s3 = tmp;
        } else if (HighScore.s1 < HighScore.s2 && HighScore.s2 < HighScore.s3) {
            tmp = HighScore.s1;
            HighScore.s1 = HighScore.s3;
            HighScore.s3 = tmp;
        }
        if (finalScore > HighScore.s1) {
            HighScore.s3 = HighScore.s2;
            HighScore.s2 = HighScore.s1;
            HighScore.s1 = finalScore;
        } else if (finalScore > HighScore.s2) {
            HighScore.s3 = HighScore.s2;
            HighScore.s2 = finalScore;
        } else if (finalScore > HighScore.s3)
            HighScore.s3 = finalScore;
		score = new FlxText(100, 20, 200, "Final result: " + finalScore + "\n\n\nHigh scores :\n" + HighScore.s1 + "\n" + HighScore.s2 + "\n" + HighScore.s3, 20);
		add(score);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.mouse.justPressed) {
			FlxG.camera.fade(FlxColor.BLACK, 0.33, false, function()
			{
				FlxG.switchState(new MenuState());
			});
		}
	}
}
