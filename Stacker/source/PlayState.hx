package;

import GlobalVar;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;

class PlayState extends FlxState
{
	var Ticker:Int = 0;
	var LeftOrRight:Bool = false;
	var BlockAmount:Int = 8;
	var BlockResolves:Int = 0;
	var Speed:Int = 20;
	var BlockMove = 0;

	override public function create()
	{
		GlobalVar.Score = 1;
		GlobalVar.GameState = 0;
		GlobalVar.Direction = false;
		GlobalVar.MoveOver = false;
		var bg = new FlxSprite();
		bg.loadGraphic("assets/images/stacker_bg.png");
		add(bg);
		bg.scale.set(2, 2);
		bg.screenCenter();
		super.create();
	}

	override public function update(elapsed:Float)
	{
		var zbutton:Bool = false;
		zbutton = FlxG.keys.anyPressed([Z]);
		if (GlobalVar.GameState == 0)
		{
			Ticker += 1;
			if (Ticker > 24)
			{
				GlobalVar.BlocksHanging = 0;
				GlobalVar.GameState = 1;
				Ticker = 0;
				if (LeftOrRight == false)
				{
					for (i in 0...BlockAmount)
					{
						var dablock = new Block();
						dablock.setPosition(51 * 2 + (26 * i), 166 * 2 - (24 * GlobalVar.Score));
						dablock.scale.set(2, 2);
						add(dablock);
					}
				}
			}
		}
		if (GlobalVar.GameState == 1)
		{
			Ticker += 1;
			if (Ticker == 1 && GlobalVar.MoveOver == true)
				GlobalVar.MoveOver = false;
			if (Ticker > Speed - 1 && GlobalVar.MoveOver == false)
			{
				GlobalVar.MoveOver = true;
				BlockMove += 1;
				Ticker = 0;
				if (BlockMove > 18 - BlockAmount)
				{
					BlockMove = 0;
					if (GlobalVar.Direction == false)
						GlobalVar.Direction = true;
					else if (GlobalVar.Direction == true)
						GlobalVar.Direction = false;
				}
			}
		}
		if (GlobalVar.GameState == 2)
		{
			Ticker += 1;
			if (Ticker > 24)
			{
				GlobalVar.Score += 1;
				GlobalVar.Direction = false;
				BlockMove = 0;
				Ticker = 0;
				if (GlobalVar.BlocksHanging == 0)
					GlobalVar.GameState = 0;
				else if (GlobalVar.BlocksHanging > 0)
					GlobalVar.GameState = 3;
			}
		}
		if (GlobalVar.GameState == 3)
		{
			Ticker += 1;
			if (Ticker == 6)
				GlobalVar.MoveOver = true;
			if (Ticker > 6)
			{
				GlobalVar.MoveOver = false;
				Ticker = 0;
				if (GlobalVar.BlocksHanging < 1)
				{
					switch (GlobalVar.Score)
					{
						case 3:
							Speed -= 4;
							if (BlockAmount > 7)
								BlockAmount = 7;
						case 5:
							Speed -= 6;
							if (BlockAmount > 5)
								BlockAmount = 5;
						case 7:
							Speed = 8;
							if (BlockAmount > 3)
								BlockAmount = 3;
						case 9:
							Speed = 4;
							if (BlockAmount > 2)
								BlockAmount = 2;
						case 10:
							Speed = 2;
							if (BlockAmount > 1)
								BlockAmount = 1;
					}
					GlobalVar.GameState = 0;
				}
			}
		}
		if (FlxG.mouse.justPressed || zbutton)
		{
			if (GlobalVar.GameState == 1)
			{
				Ticker = 0;
				GlobalVar.BlocksHanging = BlockAmount;
				GlobalVar.GameState = 2;
			}
		}
		super.update(elapsed);
	}
}
