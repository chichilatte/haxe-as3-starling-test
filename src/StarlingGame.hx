
import starling.display.Image;
import starling.display.Sprite;
import starling.textures.Texture;
import starling.textures.TextureAtlas;

import flash.utils.ByteArray;
import flash.xml.XML;
import flash.display.BitmapData;



@:bitmap("assets/atlas.png") class AtlasTexture extends BitmapData { }
@:file("assets/atlas.xml") class AtlasXML extends ByteArray { }



/** Our Starling game – a Starling Sprite at the top of the Starling display list */
class StarlingGame extends Sprite {

	public function new() {
		super();
	}

	public function start() {
		Main.log("Start starling game!");

		// Create an XML object from the embedded xml bytearray
		var xmlFile:ByteArray = new AtlasXML();
		var str:String = xmlFile.toString();
		var xml:XML = new XML(str);

		// We have a bitmap class which when instantiated will use the embedded atlas bitmapdata
		// (haxe embeds are BitmapData class, rather than flash's Bitmap class)
		AtlasBitmap.bmd = new AtlasTexture(1024,1024);
		var texture:Texture = Texture.fromEmbeddedAsset(AtlasBitmap);

		// Create the atlas using the texture and the xml
		var atlas:TextureAtlas = new TextureAtlas(texture, xml);

		// Chuck it onto the screen (logo is a texture defined in atlas.xml)
		var logoTexture:Texture = atlas.getTexture("logo");
		var logo:Image = new Image(logoTexture);
		addChild(logo);
	}

}
