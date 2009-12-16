package org.Invader
{
	import org.flixel.*;
	
	public class Defender extends FlxSprite
	{
		[Embed(source='../../data/ship.png')] private var ImgShip:Class;
		[Embed(source='../../data/Explosion.mp3')] private var SoundExplosion:Class;
		[Embed(source = '../../data/Laser.mp3')] private var SoundLaser:Class;	
		
		public var moveSpeed:int = 60;
		public var attackTimer:Number = 0;
		public var deaths:uint = 0;
		private var bullets:FlxArray;
		private var iBullets:FlxArray;
		public var lives:FlxArray;
		private var curLife:uint = 3;
		private var shootRand:uint = 1;
		private var attackLevel:uint = 4;
		
		public function Defender(X:Number, Y:Number, Bullets:FlxArray, Ibullets:FlxArray, Lives:FlxArray):void
		{
			super(ImgShip, X, Y, false);
			health = 4;
			bullets = Bullets;
			iBullets = Ibullets;
			lives = Lives;
			
		}
		override public function update():void
		{
			if (health <= 1)
			{
				if (deaths < 3)
				{
					FlxG.play(SoundExplosion);
					FlxG.score += 3;
					dead = false;
					x = 240;
					y = 580;
					flicker(3);
					health = 4;
					deaths += 1;
					lives[curLife].kill();
					--curLife;
					shootRand += 10;
					attackLevel -= 1;
				}
				else
				{
					kill();
					FlxG.switchState(WinState);
				}
			}
			
			var left:uint = 0;
			var right:uint = 0;
			
			for (var i:uint = 0; i < iBullets.length; ++i)
			{
				if (iBullets[i].exists)
				{
					if (x < iBullets[i].x) ++right;
					else ++left;
				}
			}
			
			var change:int = Math.round(Math.random()*50);
			var shoot:int = Math.round(Math.random()*60);
			
			attackTimer -= FlxG.elapsed * 3;
			
			if ((shoot >= 0 && shoot <= shootRand )&& attackTimer <= 0)
			{
				shootBullet();
				attackTimer = attackLevel;
			}
			
			if (change == 10) velocity.x *= -1;
			else
			{
				if (left >= right)
				{
					if (facing) velocity.x += moveSpeed * FlxG.elapsed;
					else
					{
						facing = true;
						velocity.x = moveSpeed * FlxG.elapsed;
					}
				}
				else if (right >= left)
				{
					if (!facing) velocity.x -= moveSpeed * FlxG.elapsed;
					else
					{
						facing = false;
						velocity.x = - moveSpeed * FlxG.elapsed;
					}
				}
				else velocity.x *= 0.7;
			}
						
			if (x <= 0 || x >= 448) velocity.x *= -1;

			super.update();
			
		}
		
		private function shootBullet():void
		{
			FlxG.play(SoundLaser);
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