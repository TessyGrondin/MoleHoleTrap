package;

import flixel.FlxSprite;

class Mole extends FlxSprite
{
	public var value = 300;
	public var touched = false;

	public function new(scaleF:Float, x:Int, y:Int, rarity:Int)
	{
		super(x, y);

        if (rarity == 0)
    		loadGraphic(AssetPaths.mole_var__png, true, 56, 64);
        else {
            loadGraphic(AssetPaths.mole__png, true, 56, 64);
			value = 100;
		}
		this.x = x;
		this.y = y;
		updateHitbox();
		animation.add("up", [0, 1, 2, 3], 5, false);
		animation.add("down", [3, 2, 1, 0], 5, false);
		animation.add("full_down", [0]);
		animation.play("full_down");
		scale.x = scaleF;
		scale.y = scaleF;
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
