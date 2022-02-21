package;

import flixel.FlxG;
import flixel.FlxState;
import android.Permissions;
import android.AndroidTools;

class FirstStartState extends FlxState {

	override public function create()
	{
		if (AndroidTools.getSDKversion() > 23 || AndroidTools.getSDKversion() == 23) {
		    AndroidTools.requestPermissions([Permissions.READ_EXTERNAL_STORAGE, Permissions.WRITE_EXTERNAL_STORAGE]);
		}
		FlxG.save.data.firstStart = false;
		FlxG.save.flush();
		super.create();
	}
	
	override public function update(elapsed:Float)
	{
		for (touch in FlxG.touches.list) {
			if (touch.justPressed) {
				FlxG.switchState(new DeeerState());
			}
		}
		super.update(elapsed);
	}
}