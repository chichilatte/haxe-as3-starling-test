import flash.display3D.Context3DRenderMode;
import flash.display3D.Context3DProfile;
import flash.events.*;
import flash.display.Sprite;
import flash.display.Stage3D;
import flash.errors.Error;
import flash.external.ExternalInterface;


import starling.core.Starling;
import starling.events.Event;

/** A test to see if we can get as3 Starling working in haxe.
 *	All it does is turn Starling on, show the Starling stats, then place an embedded logo on screen.
 */
class Main extends Sprite {

	private var mStarling:Starling;
	private var game:StarlingGame;

	public function new () {
		super ();


		if (stage==null)
			addEventListener(flash.events.Event.ADDED_TO_STAGE, initContinued);
		else 
			initContinued();
	}

	private function initContinued(?event:flash.events.Event):Void {

		var stage3D:Stage3D = stage.stage3Ds[0];

		// Listen for successful profile creation
		stage3D.addEventListener(flash.events.Event.CONTEXT3D_CREATE, function(event:flash.events.Event) {
			log("Created stage3D context: " + JSON.stringify(stage3D.context3D));
		});
		stage3D.addEventListener(ErrorEvent.ERROR, function(event:ErrorEvent) {
			log("Error creating stage3D context: " + event.errorID);
		});

		// Start up Starling
		mStarling = new Starling(StarlingGame, stage, null, null, "auto", Context3DProfile.BASELINE);
		mStarling.enableErrorChecking = true;

		// Show the stats at the top left of the screen. 
		// Should show even if atlas embedding isn't working for some reason.
		mStarling.showStats = true;

		// Wait for Starling to create its display list
		mStarling.addEventListener(starling.events.Event.ROOT_CREATED, function():Void
		{
			game = cast (mStarling.root, StarlingGame);
			game.start();
		});
		mStarling.start();
	}

	/** Log function so we can see traces in the console if we're testing in the browser */
	static public function log(o:Dynamic) {
		if (ExternalInterface.available) {
			ExternalInterface.call("console.log", o);
		}
		else {
			trace(o);
		}
	}

}

