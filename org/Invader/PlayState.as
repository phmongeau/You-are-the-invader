package org.Invader
{
	import org.flixel.*;
	
	public class PlayState extends FlxState
	{
		[Embed(source='../../data/cursor.png')] private var ImgCursor:Class;

		
		public var ships:FlxArray;
		public var _d:FlxSprite;
		public var _b:Bullet;
		public var iBullets:FlxArray;
		public var dBullets:FlxArray;
		public var attackTimer:Number = 0;
		
		public static var layerShips:FlxLayer;
		public static var layerDefender:FlxLayer;
		public static var layerBullets:FlxLayer;
		
		public function PlayState():void
		{
			layerShips = new FlxLayer;
			layerDefender = new FlxLayer;
			layerBullets = new FlxLayer;
			
			iBullets = new FlxArray;
			dBullets = new FlxArray;
			for (var i:uint = 0; i < 40; ++i)
			{
				dBullets.add(layerBullets.add(new Bullet(0, 0, 0, 0)));
				iBullets.add(layerBullets.add(new Bullet(0, 0, 0, 0)));
			}
						
			_d = new Defender(240, 580, dBullets);
			layerDefender.add(_d);
			
			setShips();
			
			
			this.add(layerBullets);
			this.add(layerDefender);
			this.add(layerShips);
			FlxG.setCursor(ImgCursor);
		}
		public function setShips():void
		{
			ships = new FlxArray;
			for (var i:int = 0; i <= 4; ++i)
			{
				ships.add(layerShips.add(new Invader(50 + i*60, 20, 1, iBullets)))
			}
			for (i = 0; i <= 4; ++i)
			{
				ships.add(layerShips.add(new Invader(50 + i*60, 55, 2, iBullets)));
			}			
			for (i = 0; i <= 4; ++i)
			{
				ships.add(layerShips.add(new Invader(50 + i*60, 90, 2, iBullets)));
			}
			for (i = 0; i <= 4; ++i)
			{
				ships.add(layerShips.add(new Invader(50 + i*60, 124, 3, iBullets)));
			}
			for (i = 0; i <= 4; ++i)
			{
				ships.add(layerShips.add(new Invader(50 + i*60, 160, 3, iBullets)));
			}
			for (i = 0; i <= 4; ++i)
			{
				ships.add(layerShips.add(new Invader(50 + i*60, 195, 3, iBullets)));
			}
		}
		
		override public function update():void
		{
			var edge:Boolean = false;
			for (var i:int = 0; i < ships.length; ++i)
			{
				if (ships[i].x <= 0 || ships[i].x >= 448)
				{
					edge = true;
					break;
				}
			}
			if (edge)
			{
				for (var n:int = 0; n < ships.length; ++n)
				{
					if (ships[n].x < 0)
						ships[n].x = 1;
					else if
						(ships[n].x > 448) ships[n].x = 447; 
					ships[n].velocity.x *= -1.2;
					ships[n].y += 20;
				}
			}
			
			attackTimer -= FlxG.elapsed * 6;
			
			if (FlxG.justPressed(FlxG.MOUSE) && attackTimer <= 0)
			{
				shootBullet();
				FlxG.log(attackTimer.toString());
				attackTimer = 2;
			}
			FlxG.overlapArray(iBullets, _d, killD);
			FlxG.overlapArrays(dBullets, ships, killI);
			super.update();
		}
		
		private function shootBullet():void
		{
			var XVelocity:Number;
			var YVelocity:Number;
			var ship:Invader = ships[Math.round(Math.random() * ships.length)];
						
			XVelocity = ((FlxG.mouse.x - ship.x) / (FlxG.mouse.y - ship.y)) * 200;
			YVelocity = 200;
			
			for (var i:uint = 0; i< iBullets.length; ++i)
			{
				if (!iBullets[i].exists)
				{
					iBullets[i].reset(ship.x, ship.y, XVelocity, YVelocity);
					return;
				}
			}
			
			var bullet:Bullet = new Bullet(ship.x, ship.y, XVelocity, YVelocity);
			bullet.reset(ship.x, ship.y, XVelocity, YVelocity);
			iBullets.add(PlayState.layerBullets.add(bullet));
			
		}
		
		private function killD(b:FlxSprite, d:Defender):void
		{
			b.kill();
			if (!d.flickering()) d.hurt(1);
		}

		private function killI(b:FlxSprite, i:Invader):void
		{
			b.kill();
			i.kill();
		}

		
	}
}