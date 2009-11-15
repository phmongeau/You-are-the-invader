package org.Invader
{
	import org.flixel.*;
	
	public class Bunker extends FlxSprite
	{
		[Embed(source='../../data/blocks.png')] private var ImgBlock:Class;
		public var state:uint = 1;
		
		public function Bunker(X:Number, Y:Number):void
		{
			super(ImgBlock, X, Y, true, false);
			width = 8;
			height = 8;
			addAnimation("1", [0]);
			addAnimation("2", [1]);
			addAnimation("3", [2]);
			addAnimation("4", [3]);
			
			play("1");
		}
		override public function update():void
		{
			play(state.toString());
			super.update();
		}
	}
}