package org.Invader
{
	import org.flixel.*;
	
	public class PlayState extends FlxState
	{
		[Embed(source='../../data/cursor.png')] private var ImgCursor:Class;
		[Embed(source = '../../data/Laser.mp3')] private var SoundLaser:Class;
		[Embed(source='../../data/Explosion.mp3')] private var SoundExplosion:Class;

		
		public var ships:FlxArray;
		public var _d:FlxSprite;
		public var _b:Bullet;
		public var iBullets:FlxArray;
		public var dBullets:FlxArray;
		public var attackTimer:Number = 0;
		public var blocks:FlxArray;
		private var scoreDisplay:FlxText;
		
		public static var layerShips:FlxLayer;
		public static var layerDefender:FlxLayer;
		public static var layerBullets:FlxLayer;
		public static var layerBunker:FlxLayer;
		public static var layerHud:FlxLayer;
		
		public function PlayState():void
		{
			layerShips = new FlxLayer;
			layerDefender = new FlxLayer;
			layerBullets = new FlxLayer;
			layerBunker = new FlxLayer;
			layerHud = new FlxLayer;
			
			iBullets = new FlxArray;
			dBullets = new FlxArray;
			for (var i:uint = 0; i < 40; ++i)
			{
				dBullets.add(layerBullets.add(new Bullet(0, 0, 0, 0)));
				iBullets.add(layerBullets.add(new Bullet(0, 0, 0, 0)));
			}
						
			_d = new Defender(240, 580, dBullets, iBullets);
			layerDefender.add(_d);
			
			setShips();
			
			//blocks = new FlxArray;
			//blocks.add(layerBunker.add(new Bunker(240, 480)));
			
			setBunker();
			
			FlxG.score = 10;
			scoreDisplay = new FlxText(2, 2, 48, 40, FlxG.score.toString(), 0xFFFFFFFF, null, 16, "left");
			scoreDisplay.setText(FlxG.score.toString());
			layerHud.add(scoreDisplay);
			
			this.add(layerHud);
			this.add(layerBunker);
			this.add(layerBullets);
			this.add(layerDefender);
			this.add(layerShips);
			FlxG.setCursor(ImgCursor);
		}
		private function setShips():void
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
		
		private function setBunker():void
		{
			blocks = new FlxArray;
			for (var n:uint; n <= 2; ++n)
			{
				for (var i:uint = 0; i <= 3; ++i)
				{
					blocks.add(layerBunker.add(new Bunker(50 + i*8 + n * 175, 480)));
					if (i == 1 || i == 2) null
					else blocks.add(layerBunker.add(new Bunker(50 + i*8 + n * 175, 488)))
				}				
			}
		}
		
		override public function update():void
		{
			var edge:Boolean = false;
			
			scoreDisplay.setText(FlxG.score.toString());
			
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
				attackTimer = 2;
			}
			FlxG.overlapArray(iBullets, _d, killD);
			FlxG.overlapArrays(dBullets, ships, killI);
			FlxG.overlapArrays(iBullets, blocks, hitBlock);
			FlxG.overlapArrays(dBullets, blocks, hitBlock);
			super.update();
		}
		
		private function shootBullet():void
		{
			FlxG.play(SoundLaser);
			if (FlxG.score > 0) FlxG.score -= 1;
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
			FlxG.score += 3;
		}

		private function killI(b:FlxSprite, i:Invader):void
		{
			FlxG.play(SoundExplosion);
			b.kill();
			i.kill();
			if (FlxG.score >= 3) FlxG.score -= 3;
		}
		private function hitBlock(bullet:FlxSprite, block:Bunker):void
		{
			bullet.kill();
			if (block.state <= 3) block.state += 1;
			else block.kill();
			FlxG.score += 1;
		}
	}
}