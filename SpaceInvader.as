package
{
	import org.flixel.*;
	import org.Invader.MenuState;
	[SWF(width="480", height="640", backgroundColor="#000000")]
	[Frame(factoryClass="Preloader")]
		
	public class SpaceInvader extends FlxGame
	{
		public function SpaceInvader():void
		{
			super(480, 640, MenuState, 1, 0xff000000, true, 0xffffffff);
			help("Nothing", "Nothing", "Shoot", "Nothing");
		}
	}
}