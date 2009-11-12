package org.Invader
{
	import org.flixel.*;
	
	public class Invader extends FlxSprite
	{
		[Embed(source='../../data/invader_01.png')] private var ImgShip1:Class;
						
		public var moveSpeed:int = 50;
		public var dropSpeed:int = 10;
		public var dropTimer:int = 2;
		public var attackTimer:int = 0;
		public var drop:Boolean;
		public var sorte:Number = 0;
		
		public function Invader(X:Number, Y:Number, Type:Number):void
		{

			super(ImgShip1, X, Y, true, false);
			sorte = Type;
			maxVelocity.x = 100;
			maxVelocity.y = 10;
			velocity.x = 20;
			width = 32;
			height = 29;
			addAnimation("1", [0, 1], 5, true);
			addAnimation("2", [2, 3], 5, true);
			addAnimation("3", [4, 5], 5, true);
		}
		override public function update():void
		{
			if (dead)
			{
				if (finished) exists = false;
				else
					super.update();
			}
			else play(sorte.toString());

			if (attackTimer > 0)
				attackTimer -= FlxG.elapsed * 3;
						
			if (FlxG.kB)
			{
				FlxG.quake(0.02, 0.75);
			}
			super.update();
		}
	}
}