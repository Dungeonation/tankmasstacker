package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.ui.FlxButton;

class InsertCoinState extends FlxState
{
	var insertCoin:FlxButton;

	function coinInserted()
	{
		FlxG.switchState(new PlayState());
	}

	override public function create()
	{
		var bg = new FlxSprite();
		bg.loadGraphic("assets/images/stacker_bg.png");
		add(bg);
		bg.scale.set(2, 2);
		bg.screenCenter();
		insertCoin = new FlxButton(0, 0, "Insert Coin", coinInserted);
		add(insertCoin);
		insertCoin.screenCenter();
		insertCoin.scale.set(2, 2);
		super.create();
	}

	override public function update(elapsed:Float)
	{
		var zbutton:Bool = false;
		zbutton = FlxG.keys.anyPressed([Z]);
		if (zbutton)
			coinInserted();
		super.update(elapsed);
	}
}
