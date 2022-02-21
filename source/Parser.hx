package;

import flixel.FlxG;

class Parser {
	public static function parse(text:String):String {
		var temp:String = null;
		var result:String = null;
		for (i in 0...text.length) {
		    temp = text.substr(i, i);
		    trace("DEEERCODERLOG: temp = " + temp);
		    if (FlxG.save.data.encodeMode) {
			    if (MapsThing.encodeMap.exists(temp)) {
		            temp = MapsThing.encodeMap.get(temp);
		        } else {
			        temp = "unknown value";
			    }
		    } else {
			    if (MapsThing.decodeMap.exists(temp)) {
			        temp = MapsThing.decodeMap.get(temp);
			    } else {
				    temp = "unknown value";
				}
			}
			trace("DEEERCODERLOG: parsed temp = " + temp);
		    result += temp;
	    }
	    return result;
	}
}