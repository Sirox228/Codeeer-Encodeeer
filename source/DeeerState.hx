package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.addons.ui.FlxUIInputText;
import android.AndroidTools;
import flixel.ui.FlxButton;
import flixel.addons.ui.FlxUIButton;

class DeeerState extends FlxState {
	
	var inputText:FlxUIInputText;
	var resText:FlxText;
	var temp:String = null;
	var result:String = null;
	
	override public function create()
	{
		FlxG.camera.bgColor = FlxColor.BLACK;
		inputText = new FlxUIInputText(50, 200, FlxG.width, '', 24, FlxColor.WHITE);
		inputText.setFormat("font/font.ttf", 24, FlxColor.WHITE, LEFT);
		inputText.focusGained = () -> FlxG.stage.window.textInputEnabled = true;
		add(inputText);
		resText = new FlxText(inputText.x, inputText.y + 500, FlxG.width, "", 24);
		resText.setFormat("font/font.ttf", 24, FlxColor.WHITE, LEFT);
		add(resText);
		var savebutton = new FlxUIButton(FlxG.width / 2, 900, "copy", () -> {
			openfl.system.System.setClipboard(resText.text);
		});
		savebutton.resize(250,50);
		savebutton.setLabelFormat("VCR OSD Mono",24,FlxColor.BLACK,"center");
		add(savebutton);
		//MapsThing.initMaps();
                super.create();
	}
	
	override public function update(elapsed:Float)
	{
		for (touch in FlxG.touches.list) {
			if (touch.overlaps(inputText) && touch.justPressed) {
				FlxG.stage.window.textInputEnabled = true;
			}
		}
		resText.text = inputText.text;

                super.update(elapsed);
	}
}
