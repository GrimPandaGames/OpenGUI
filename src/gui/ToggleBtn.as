package gui
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;

	/**
	 * Two states Button
	 */
	public class ToggleBtn extends FlxGroup 
	{
		private var onBtn:GuiBtn;
		private var offBtn:GuiBtn;
		private var Callback:Function;
		public var on:Boolean = true;
		
		public function set callback(c:Function):void {
		  Callback = c;
		}
		
		public function ToggleBtn(X:int, Y:int, onSprite:FlxSprite, offSprite:FlxSprite, Callback:Function = null) {
		  add(onBtn = new GuiBtn(X, Y, onSprite, _callback));
		  add(offBtn = new GuiBtn(X, Y, offSprite, _callback));
		  this.Callback = Callback;
		  
		  width = onBtn.width;
		  height = onBtn.height;
		}
		
		private function _callback():void {
		  on = !on;
		  if (Callback != null) Callback(on);
		}
		
		override public function update():void {
			onBtn.active = onBtn.visible = !on;
			offBtn.active = offBtn.visible = on;
			super.update();
		}
	}

}