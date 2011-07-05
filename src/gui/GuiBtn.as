package gui
{
  import org.flixel.FlxG;
  import org.flixel.FlxSprite;
  
  /**
   * Simple Sprite Button with color change when hovered/clicked
   */
  public class GuiBtn extends FlxSprite
  {
	private var hovered:Boolean;

	private var _cb:Function;

	public var onColor:uint = 0xffffffff;
	public var offColor:uint = mul(onColor, .6);

	public function set callback(Callback:Function):void {
	  _cb = Callback;
	}
	
	public function GuiBtn(X:Number, Y:Number, Image:FlxSprite, Callback:Function = null) {
	  super();
	  _cb = Callback;
	  pixels = Image.pixels;
	  reset(X, Y);
	}

	override public function update():void  {
	  if (hovered != overlaps(FlxG.mouse.cursor)) {
		hovered = !hovered;
	  }

	  if (hovered && !FlxG.mouse.pressed()) {
		color = offColor;		  
	  } else {
		color = onColor;
	  }

	  if (_cb != null && hovered && FlxG.mouse.justReleased()) {
		_cb();
	  }

	  super.update();
	}

	/**
	 * Inspired from : http://lab.revoke.ca/2009/04/as3-color-functions/
	 */
	private static function mul(color:uint, ratio:Number):uint {
	  var r:uint = (color >> 16) & 0xFF;
	  var g:uint = (color >> 8) & 0xFF;
	  var b:uint = color & 0xFF;
	  var a:uint = (color >> 24) & 0xFF;
	  
	  r = r * ratio;
	  g = g * ratio;
	  b = b * ratio;
	  
	  return a << 24 | r << 16 | g << 8 | b;
	}

  }

}