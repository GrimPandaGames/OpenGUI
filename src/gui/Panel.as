package gui 
{
  import com.adobe.serialization.json.JSON;
  import flash.geom.Point;
  import flash.utils.ByteArray;
  import org.flixel.FlxGroup;
  import org.flixel.FlxObject;
  import org.flixel.FlxSprite;
  import org.flixel.FlxText;
  
  /**
   * a FlxGroup that is populated using a JSON file
   */
  public class Panel extends FlxGroup
  {
	private var elements:Array/*FlxObject*/;

	public function Panel(JsonData:Class, atlas:Atlas) {
	  var ba:ByteArray = new JsonData;
	  var json:* = JSON.decode(ba.readUTFBytes(ba.length));	  
	  
	  elements = new Array;
	  
	  var pos:Point = new Point;
	  var atlas:Atlas = Main.atlas;
	  
	  for each (var datum:* in json) {
		var element:FlxObject = null;
		
		if (datum.type == "toggle") {
		  element = new ToggleBtn( datum.x, datum.y, atlas.getSprite(datum.toggleOn), atlas.getSprite(datum.toggleOff) );
		
		} else if (datum.type == "button") {
		  element = new GuiBtn(datum.x, datum.y, atlas.getSprite(datum.icon) );
		
		} else if (datum.type == "text") {
		  var alignment:String = null;
		  if (datum.alignment != undefined) alignment = datum.alignment;
		
		  element = new FlxText( datum.x, datum.y, datum.width, datum.text )
			.setFormat( datum.font, datum.size, uint(datum.color), alignment );

		} else if (datum.type == "asset") {
		  element = atlas.getSprite( datum.icon, datum.x, datum.y );
		}
	  
		if (element) {
		  add(element);
		  if (datum.id != undefined) elements[datum.id] = element;
		}
	  }

	  pos.x = pos.y = 0;
	  if (json.x != undefined) pos.x = json.x;
	  if (json.y != undefined) pos.y = json.y;
	  reset(pos.x, pos.y);
	  
	  computeSize();
	}

	private function computeSize():void {
	  var _left:int = int.MAX_VALUE;
	  var _right:int = int.MIN_VALUE;
	  var _top:int = int.MAX_VALUE;
	  var _bottom:int = int.MIN_VALUE;

	  for each ( var obj:FlxObject in members ) {
		if (obj.left < _left) _left = obj.left;
		if (obj.right > _right) _right = obj.right;
		if (obj.top < _top) _top = obj.top;
		if (obj.bottom > _bottom) _bottom = obj.bottom;
	  }
	  
	  width = _right - _left;
	  height = _bottom - _top;
	}
	
	/**
	 * @param	id
	 * @return the Gui Element with the given 'id'
	 */
	public function getElement(id:String):FlxObject {
	  return elements[id];
	}
  }

}