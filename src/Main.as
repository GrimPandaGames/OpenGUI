package
{
	import gui.Atlas;
	import org.flixel.*;
	
	[SWF(width="480", height="320", backgroundColor="#000000")]
	[Frame(factoryClass="Preloader")]

	public class Main extends FlxGame {

	  [Embed(source = '../data/gui.png')]
	  private static const GuiTexture:Class;
	  [Embed(source = '../data/gui.json', mimeType = 'application/octet-stream')]
	  private static const GuiDescriptor:Class;

	  static private var _atlas:Atlas;
	  
	  static public function get atlas():Atlas {
		if (!_atlas) _atlas = new Atlas(GuiTexture, GuiDescriptor, Assets);
		return _atlas;
	  }
	  
	  public function Main() {
		super(480, 320, MenuState, 1);
	  }

	}

}

