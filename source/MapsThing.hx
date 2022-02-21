package;

import sys.io.File;

class MapsThing {
	
	public var encodeMap:Map<String, String>;
	public var decodeMap:Map<String, String>;
	public var inited:Bool = false;
	
	public function initMaps() {
		encodeMap = new Map<String, String>();
		decodeMap = new Map<String, String>();
		var codecText = File.getContent(Main.getDataPath() + "codec.txt").trim();
		for (i in 0...codecText.length) {
			codecText[i] = codecText[i].trim();
		}
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
		trace("DEEERCODERLOG: parsed array = " + parsedArray);
		for (i in 0...parsedArray.length) {
			encodeMap.set(parsedArray[i][0], parsedArray[i][1]);
			decodeMap.set(parsedArray[i][1], parsedArray[i][0]);
		}
		trace("DEEERCODERLOG: encode map = " + encodeMap);
		trace("DEEERCODERLOG: decode map = " + decodeMap);
		inited = true;
	}
}