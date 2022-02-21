package;

import sys.io.File;

class MapsThing {
	
	public static var encodeMap:Map<String, String>;
	public static var decodeMap:Map<String, String>;
	public static var inited:Bool = false;
	
	public static function initMaps() {
		encodeMap = new Map<String, String>();
		decodeMap = new Map<String, String>();
		var codecText = File.getContent(Main.getDataPath() + "codec.txt");
		var parsedArray:Array<Array<String>> = new Array<Array<String>>();
		var omg = codecText.split('\n');
		var g:Int = 0;
		for (i in 0...omg.length) {
		    parsedArray.push([]);
		    var theThing = omg[i].split('%=%');
		    while (!(g > 1)) {
		        parsedArray[i].push(theThing[g]);
		        g++;
		    }
		    g = 0;
		}
		if (Main.debugMode) {
		    Application.current.window.alert("parsed array = " + parsedArray, "debug");
		}
		for (i in 0...parsedArray.length) {
			encodeMap.set(parsedArray[i][1], parsedArray[i][0]);
			decodeMap.set(parsedArray[i][0], parsedArray[i][1]);
		}
		if (Main.debugMode) {
		    Application.current.window.alert("encode map = " + encodeMap, "debug");
		}
		if (Main.debugMode) {
		    Application.current.window.alert("decode map = " + decodeMap, "debug");
		}
		inited = true;
	}
}