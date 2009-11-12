package org.Invader
{
	import org.flixel.*;
	
	public class PlayState extends FlxState
	{
		public var ships:FlxArray;
		public var _d:FlxSprite;
		
		public static var layerShips:FlxLayer;
		public static var layerDefender:FlxLayer;
		
		public function PlayState():void
		{
			layerShips = new FlxLayer;
			layerDefender = new FlxLayer;
			
			_d = new Defender(240, 580);
			layerDefender.add(_d);
			
			setShips();
			
			
			this.add(layerDefender)
			this.add(layerShips)
		}
		public function setShips():void
		{
			ships = new FlxArray;
			for (var i:int = 0; i <= 4; ++i)
			{
				ships.add(layerShips.add(new Invader(50 + i*60, 20, 1)))
			}
			for (i = 0; i <= 4; ++i)
			{
				ships.add(layerShips.add(new Invader(50 + i*60, 55, 2)));
			}			
			for (i = 0; i <= 4; ++i)
			{
				ships.add(layerShips.add(new Invader(50 + i*60, 90, 2)));
			}
			for (i = 0; i <= 4; ++i)
			{
				ships.add(layerShips.add(new Invader(50 + i*60, 124, 3)));
			}
			for (i = 0; i <= 4; ++i)
			{
				ships.add(layerShips.add(new Invader(50 + i*60, 160, 3)));
			}
			for (i = 0; i <= 4; ++i)
			{
				ships.add(layerShips.add(new Invader(50 + i*60, 195, 3)));
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
			super.update();
		}
	}
}