package org.Invader
{
	import org.flixel.*;
	
	public class MenuState extends FlxState
	{
		[Embed(source='../../data/cursor.png')] private var ImgCursor:Class;
			
		override public function MenuState():void
		{
			this.add(new FlxText(0, (FlxG.width/2) - 80, FlxG.width, 80, "You Are The Invader!", 0xFFFFFFFF, null, 16, "center")) as FlxText;
			this.add(new FlxText(0, FlxG.height - 24, FlxG.width, 8, "Click to start", 0xFFFFFFFF, null, 8, "center"));
			
			FlxG.setCursor(ImgCursor);

		}
		
		private function onFade():void
		{
			FlxG.switchState(PlayState);
		}
		
		override public function update():void
		{
			if (FlxG.kMouse)
			{
				FlxG.flash(0xFFFFFFFF, 0.75);
				FlxG.fade(0xFF000000, 1, onFade);
			}
//			if(!FlxG.kong) (FlxG.kong = parent.addChild(new FlxKong()) as FlxKong).init();
			super.update();
		}
	}
}