package org.Invader
{
	import org.flixel.*;
	
	public class Defender extends FlxSprite
	{
		[Embed(source='../../data/ship.png')] private var ImgShip:Class;
		public var moveSpeed:int = 400;
		public var attackTimer:Number = 0;
		public var deaths:uint = 0;
		private var bullets:FlxArray;
		
		public function Defender(X:Number, Y:Number, Bullets:FlxArray):void
		{
			super(ImgShip, X, Y, false)
			health = 4;
			bullets = Bullets;
		}
		override public function update():void
		{
			if (health <= 1)
			{
				if (deaths < 3)
				{
					FlxG.score += 3;
					dead = false;
					x = 240;
					y = 580;
					flicker(3);
					health = 4;
					deaths += 1;
				}
				else
				{
					kill();
					FlxG.switchState(WinState);
				}
			}
			var move:int = Math.round(Math.random()*10);
			var shoot:int = Math.round(Math.random()*50);
			
			attackTimer -= FlxG.elapsed * 3;
			
			if (shoot == 10 && attackTimer <= 0)
			{
				shootBullet();
				attackTimer = 6;
			}
						
			if (move == 5)
			{
				if (!facing) velocity.x = 0;
				facing = true;
				velocity.x += moveSpeed * FlxG.elapsed;
			}
			else if (move == 0)
			{
				if (facing) velocity.x = 0;
				facing = false;
				velocity.x -= moveSpeed * FlxG.elapsed;
			}
			if (x <= 0 || x >= 448) velocity.x *= -1;

			super.update();
			
		}
		
		private function shootBullet():void
		{
			var XVelocity:Number = 0;
			var YVelocity:Number = -200;
			for (var i:uint = 0; i< bullets.length; ++i)
			{
				if (!bullets[i].exists)
				{
					bullets[i].reset(x + 16, y, XVelocity, YVelocity);
					return;
				}
			}
			
			var bullet:Bullet = new Bullet(x + 16, y, XVelocity, YVelocity);
			bullet.reset(x + 16, y, XVelocity, YVelocity);
			bullets.add(PlayState.layerBullets.add(bullet));
			
		}
	}
}