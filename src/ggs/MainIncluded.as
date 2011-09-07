import flash.events.KeyboardEvent;
import ggs.ApplicationMode;
import ggs.GGSApplication;
import mx.core.FlexGlobals;
import spark.components.ButtonBar;
import spark.events.IndexChangeEvent; 


private var app:GGSApplication;

private function onApplicationComplete():void
{
	app = new GGSApplication(canvas);
	FlexGlobals.topLevelApplication.addEventListener(KeyboardEvent.KEY_UP, keyHandler);
}

private function changeButtonSelection(event:IndexChangeEvent):void
{
	var buttonName:String = ButtonBar(event.target).selectedItem;
	
	switch (buttonName)
	{
		case "Canvas":
			app.changeMode(ApplicationMode.CANVAS_MODE);
			break;
		case "Vertex":
			app.changeMode(ApplicationMode.VERTEX_MODE);
			break;
		case "Edge":
			app.changeMode(ApplicationMode.EDGE_MODE);
			break;
		case "Pursuer":
			app.changeMode(ApplicationMode.PURSUER_MODE);
			break;
		case "Emulation":
			app.changeMode(ApplicationMode.EMULATION_MODE);
			break;
	}
}

private function keyHandler(event:KeyboardEvent):void 
{
	app.onDelete();
}