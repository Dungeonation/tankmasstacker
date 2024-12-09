package;

import GlobalVar;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;

class Block extends FlxSprite
{
	// Group every Block instance made(?? No idea why collision isn't working lol)
	var Blockz = new FlxTypedGroup<Block>(500);
	var Active:Bool = true;
	var LocalMoveOver:Bool = false;
	var FallDownCheck:Bool = false;

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		loadGraphic('assets/images/block.png', false, 13, 12);
		setSize(26, 24);
		Blockz.add(this);
	}

	private function onBlockTouch(Block1:Block, Block2:Block)
	{
		y -= 24;
		GlobalVar.BlocksHanging -= 1;
		Active = false;
	}

	override public function update(elapsed:Float)
	{
		// Move every block one space left or right (This is what I predict to be
		// the methodology to accomplish stuff Squidly is most confused about)
		if (GlobalVar.MoveOver == true && LocalMoveOver == false)
		{
			if (GlobalVar.GameState == 1 && Active == true)
			{
				LocalMoveOver = true;
				if (GlobalVar.Direction == false)
					x += 26;
				if (GlobalVar.Direction == true)
					x -= 26;
			}
		}
		if (GlobalVar.GameState == 3 && GlobalVar.MoveOver == true && Active == true && LocalMoveOver == false)
		{
			// If you're a hanging-off block and unsettled, move down one space until you touch another block below, or the ground
			LocalMoveOver = true;
			y += 24;
			FlxG.collide(this, Blockz, onBlockTouch);
			if (y > 166 * 2 - 24)
			{
				y = 166 * 2 - 24;
				Active = false;
				GlobalVar.BlocksHanging -= 1;
			}
		}
		if (GlobalVar.GameState == 3 && GlobalVar.MoveOver == false && LocalMoveOver == true)
			LocalMoveOver = false;
		if (GlobalVar.GameState == 2 && FallDownCheck == false)
		{
			LocalMoveOver = false;
			FallDownCheck = true;
			// Row movement stopped - check if you are stacked on top of a block or not
			if (GlobalVar.Score > 1)
			{
				FlxG.collide(this, Blockz, onBlockTouch);
			}
			// On the first row stacking logic is moot
			else if (GlobalVar.Score == 1)
				GlobalVar.BlocksHanging -= 1;
		}
		if (GlobalVar.GameState == 0 && Active == true)
			Active = false;
		if (GlobalVar.MoveOver == false && LocalMoveOver == true)
			LocalMoveOver = false;
		super.update(elapsed);
	}
}
