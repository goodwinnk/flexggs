package ggs.visual.modes.helpers 
{
	import ggs.visual.EdgeSprite;
	import spark.components.Group;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author goodwinnk
	 */
	public class OverEdgeHelper 
	{	
		private var _overEdge:EdgeSprite;
		private var _graphCanvas:Group;
		
		public function OverEdgeHelper(graphCanvas:Group) 
		{			
			_graphCanvas = graphCanvas;
		}
		
		public function get overEdge():EdgeSprite { return _overEdge;  }
		
		public function enable():void
		{	
			for (var i:int = 0; i < _graphCanvas.numElements; i++)
			{
				var edgeSprite:EdgeSprite = _graphCanvas.getElementAt(i) as EdgeSprite;
				if (edgeSprite)
				{
					edgeSprite.addEventListener(MouseEvent.ROLL_OVER, edgeMouseOver);
					edgeSprite.addEventListener(MouseEvent.ROLL_OUT, edgeMouseOut);
				}
			}
		}
		
		public function disable():void
		{
			for (var i:int = 0; i < _graphCanvas.numElements; i++)
			{
				var edgeSprite:EdgeSprite = _graphCanvas.getElementAt(i) as EdgeSprite;
				if (edgeSprite)
				{
					edgeSprite.removeEventListener(MouseEvent.ROLL_OVER, edgeMouseOver);
					edgeSprite.removeEventListener(MouseEvent.ROLL_OUT, edgeMouseOut);
				}
			}
		}
		
		private function edgeMouseOver(event:MouseEvent):void
		{
			var sprite:EdgeSprite = event.currentTarget as EdgeSprite;
			sprite.isHighlighted = true;
				
			_overEdge = sprite;
		}

		private function edgeMouseOut(event:MouseEvent):void
		{
			var sprite:EdgeSprite = event.currentTarget as EdgeSprite;
			sprite.isHighlighted = false;
			
			_overEdge = null;
		}		
	}
}