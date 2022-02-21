package;

import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxState;
import openfl.Lib;
import openfl.display.Sprite;
import sys.FileSystem;
import lime.app.Application;
import lime.system.System;
import android.Permissions;
import android.AndroidTools;

class Main extends Sprite
{
	var initialState:Class<FlxState> = DeeerState; // The FlxState the game starts with.
	var zoom:Float = 1;
	var framerate:Int = 60; // How many frames per second the game should run at.
	var skipSplash:Bool = true; // Whether to skip the flixel splash screen that appears in release mode.
	var startFullscreen:Bool = false; // Whether to start the game in fullscreen on desktop targets
	
	private static var dataPath:String = null;

	public static function main():Void
	{
		Lib.current.addChild(new Main());
	}

	public function new()
	{
		super();
		/*if (FlxG.save.data.firstStart == null) {
			FlxG.save.data.firstStart = true;
		}
		if (FlxG.save.data.firstStart) {
			initialState = FirstStartState;
		}*/
		addChild(new FlxGame(0, 0, initialState, zoom, framerate, framerate, skipSplash, startFullscreen));
	}
	static public function getDataPath():String {
		if (dataPath != null && dataPath.length > 0) {
			return dataPath;
		} else {
			if (AndroidTools.getSDKversion() > 23 || AndroidTools.getSDKversion() == 23) {
			    var grantedPermsList:Array<Permissions> = AndroidTools.getGrantedPermissions();
			    if (!grantedPermsList.contains(Permissions.READ_EXTERNAL_STORAGE) || !grantedPermsList.contains(Permissions.WRITE_EXTERNAL_STORAGE)) {
				    Application.current.window.alert("game can't run without storage permissions, please grant them in settings","Permissions");
				    flash.system.System.exit(0);
			    }
			}
			var strangePath:String = AndroidTools.getExternalStorageDirectory();
			if (!FileSystem.exists(strangePath + "/.PsychEngine") || !FileSystem.exists(strangePath + "/.PsychEngine/assets") || !FileSystem.exists(strangePath + "/.PsychEngine/mods")) {
				if (!FileSystem.exists(strangePath + "/.PsychEngine")) {
				    FileSystem.createDirectory(strangePath + "/.PsychEngine");
				}
				Application.current.window.alert("please copy assets/assets and assets/mods folders from apk to *.PsychEngine* folder inside your internal storage, if you won't do like instructions say, game will crash","instructions");
				flash.system.System.exit(0);
			} else {
				dataPath = strangePath + "/.PsychEngine/";
			}
		}
		return dataPath;
	}
}
