package org.Invader
{
	import org.flixel.*;
	
	public class Bullet extends FlxSprite
	{
		[Embed(source='../../data/bullet.png')] private var ImgBullet:Class;
		
		public function Bullet(X:Number, Y:Number, XVelocity:Number, YVelocity:Number):void
		{
			super(ImgBullet, X, Y, true, false);
			width = 2;
			height = 10;
			exists = false;
		}
		override public function update():void
		{
			if (x <= 0 || x >= 448 || y <= 0 || y >= 640)
			{
				kill();
			}

			super.update();
		}
		
		public function reset(X:Number, Y:Number, XVelocity:Number, YVelocity:Number):void
		{
			x = X;
			y = Y;
			velocity.x = XVelocity;
			velocity.y = YVelocity;
			exists = true;
			visible = true;
			dead = false;
		}
	}
}