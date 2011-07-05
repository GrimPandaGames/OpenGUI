package
{
  import gui.GuiBtn;
  import gui.Panel;
  import gui.ToggleBtn;
  import org.flixel.*;

  public class MenuState extends FlxState
  {
	[Embed(source = '../data/options.json', mimeType = 'application/octet-stream')]
	  static private const JsonData:Class;
	
	private var background:FlxSprite;
	private var panel:Panel;

	override public function create():void {
	  add( background = new FlxSprite().createGraphic(FlxG.width, FlxG.height, 0xaa000000) );
	  add( panel = new Panel(JsonData, Main.atlas) );

	  GuiBtn(panel.getElement("back.btn")).callback = back;
	  GuiBtn(panel.getElement("reset.btn")).callback = reset;
	  ToggleBtn(panel.getElement("sound.btn")).callback = sound;
	  ToggleBtn(panel.getElement("twitter_connect.btn")).callback = twitter;
	  ToggleBtn(panel.getElement("fb_connect.btn")).callback = facebook;
	  
	  FlxG.mouse.show();
	}

	private function back():void {
	  FlxG.log("back button");
	}
	
	private function reset():void {
	  FlxG.log("reset button");
	}
	
	private function sound(on:Boolean):void {
	  FlxG.log("sound : "+on);
	}
	
	private function twitter(on:Boolean):void {
	  FlxG.log("twitter : "+on);
	}
	
	private function facebook(on:Boolean):void {
	  FlxG.log("facebook : "+on);
	}
  }

}

