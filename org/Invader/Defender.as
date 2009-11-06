package org.Invader
{
	import org.flixel.*;
	
	public class Defender extends FlxSprite
	{
		[Embed(source='../../data/ship.png')] private var ImgShip:Class;
		public var moveSpeed:int = 50;
		public var attackTimer:Number;
		
		public function Defender(X:Number, Y:Number):void
		{
			super(ImgShip, X, Y, false)
		}
	}
}