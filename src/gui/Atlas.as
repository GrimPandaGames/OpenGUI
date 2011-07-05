package gui
{
  import com.adobe.serialization.json.JSON;
  import flash.utils.ByteArray;
  import org.flixel.FlxSprite;

  /**
   * Loads a Texture Atlas prepared by TexturePacker
   */
  public class Atlas extends FlxSprite 
  {
	private var json:*;
	private var assets:Class;
	
	private function loadJson(Data:Class):void {
	  var byteArray:ByteArray = new Data;
	  var str:String = byteArray.readUTFBytes(byteArray.length);
		
	  json = JSON.decode(str);
	}
	
	/**
	 * 
	 * @param	Image 	Texture file
	 * @param	Data	Description file, contains the position and size of each sprite
	 * @param	assets	optional class that contains the Embedded assets
	 */
	public function Atlas(Image:Class, Data:Class, assets:Class = null ) {
	  super(0, 0, Image);
	  loadJson(Data);
	  
	  this.assets = assets;
	}

	public function getSprite(name:String, X:Number = 0, Y:Number = 0):FlxSprite {
	  var sprite:* = json.frames[name];
	  if (sprite != undefined)
		return _getSprite( name, sprite.frame.x, sprite.frame.y, sprite.frame.w, sprite.frame.h, sprite.rotated );
	  else if (assets) return new FlxSprite(X, Y, assets[name]);
	  else throw new Error("Asset '" + name + "' not found");
	}
	
	private function _getSprite(Key:String, X:Number, Y:Number, W:int, H: int, rotated:Boolean = false):FlxSprite {
	  var sprite:FlxSprite = new FlxSprite().createGraphic(W, H, 0, false, Key);

	  if (rotated) {
		_mtx.identity();
		_mtx.translate( -X - H, -Y);
		_mtx.rotate(-90 * 0.017453293);
		sprite.pixels.draw(_pixels, _mtx, null, blend, null, antialiasing);
		sprite.frame = 0;
	  } else {
		_flashPoint.x = 0;
		_flashPoint.y = 0;
		
		_flashRect2.x = X;
		_flashRect2.y = Y;
		_flashRect2.width = W;
		_flashRect2.height = H;

		sprite.pixels.copyPixels(_pixels, _flashRect2, _flashPoint, null, null, false);
		sprite.frame = 0; // provoque the copy of pixel into framePixels
	  }
	  
	  return sprite;
	}
  }

}