package org.Invader
{
	import org.flixel.*;
	
	public class Defender extends FlxSprite
	{
		[Embed(source='../../data/ship.png')] private var ImgShip:Class;
		public var moveSpeed:int = 400;
		public var attackTimer:Number;
		
		public function Defender(X:Number, Y:Number):void
		{
			super(ImgShip, X, Y, false)
		}
		override public function update():void
		{
			var move:int = Math.round(Math.random()*10);
						
			if (move == 5)
			{
				if (!facing) velocity.x = 0;
				facing = true;
				velocity.x += moveSpeed * FlxG.elapsed;
				//FlxG.log('right');
			}
			else if (move == 0)
			{
				if (facing) velocity.x = 0;
				facing = false;
				velocity.x -= moveSpeed * FlxG.elapsed;
				//FlxG.log("left");
			}
			if (x <= 0 || x >= 448) velocity.x *= -1;

			super.update();
			
		}
	}
}