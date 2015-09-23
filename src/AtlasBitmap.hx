
import flash.display.BitmapData;
import flash.display.Bitmap;

/**
 *	We need a bitmap class which will use a specific bitmapdata when instantiated.
 *	We use this to get around the fact that haxe embeds are BitmapData class, 
 *	rather than flash's Bitmap class.
 */
class AtlasBitmap extends Bitmap {
	static public var bmd:BitmapData;

	public function new() {
		super(bmd);
	}
}
