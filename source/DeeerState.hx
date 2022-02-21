package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.addons.ui.FlxUIInputText;
import android.AndroidTools;
import flixel.ui.FlxButton;
import flixel.addons.ui.FlxUIButton;
using StringTools;

class DeeerState extends FlxState {
	
	var inputText:FlxUIInputText;
	var resText:FlxText;
	var hiddenText:String = '';
	
	override public function create()
	{
		FlxG.camera.bgColor = FlxColor.BLACK;
		inputText = new FlxUIInputText(50, 200, FlxG.width, '', 24, FlxColor.BLACK);
		inputText.setFormat("font/font.ttf", 24, FlxColor.BLACK, LEFT);
		inputText.focusGained = () -> FlxG.stage.window.textInputEnabled = true;
		inputText.resize(inputText.width, 300);
		add(inputText);
		resText = new FlxText(inputText.x, inputText.y + 400, FlxG.width - 50, "", 24);
		resText.setFormat("font/font.ttf", 24, FlxColor.WHITE, LEFT);
		add(resText);
		var savebutton = new FlxUIButton(FlxG.width / 2, 900, "copy", () -> {
			openfl.system.System.setClipboard(hiddenText.trim() + resText.text.trim());
		});
		savebutton.resize(250,50);
		savebutton.setLabelFormat("VCR OSD Mono",24,FlxColor.BLACK,"center");
		add(savebutton);
		MapsThing.initMaps();
		
		super.create();
	}
	
	function clearMess() {
		var textArray = resText.text.split("\n");
		var g:Int = 0;
		for (i in 0...textArray.length) {
			g++;
		}
		if (g > 10) {
			hiddenText += resText.text;
		    resText.text = '';
		}
		if (g = 0 && resText.text = '' && hiddenText != '') {
			var thing = hiddenText.substr(hiddenText.length - 10, hiddenText.length);
			hiddenText = hiddenText.replace(thing, "");
			resText.text += thing;
		}
	}
	
	override public function update(elapsed:Float)
	{
		for (touch in FlxG.touches.list) {
			if (touch.overlaps(inputText) && touch.justPressed) {
				FlxG.stage.window.textInputEnabled = true;
			}
		}
		
		if (MapsThing.inited) {
		    resText.text = Parser.parse(inputText.text);
		    clearMess();
		}
		
		super.update(elapsed);
	}
}