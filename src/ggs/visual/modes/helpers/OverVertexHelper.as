package ggs.visual.modes.helpers 
{
	import flash.events.EventDispatcher;
	import ggs.visual.VertexSprite;
	import flash.events.MouseEvent;
	import spark.components.Group;
	
	/**
	 * ...
	 * @author goodwinnk
	 */
	public class OverVertexHelper extends EventDispatcher
	{		
		private var _overVertex:VertexSprite;
		private var _graphCanvas:Group;
		
		public function OverVertexHelper(graphCanvas:Group) 
		{			
			_graphCanvas = graphCanvas;
		}
		
		public function get overVertex():VertexSprite { return _overVertex;  }
		
		public function enable():void
		{	
			for (var i:int = 0; i < _graphCanvas.numElements; i++)
			{
				var vertexSprite:VertexSprite = _graphCanvas.getElementAt(i) as VertexSprite;
				if (vertexSprite)
				{
					vertexSprite.addEventListener(MouseEvent.ROLL_OVER, vertexMouseOver);
					vertexSprite.addEventListener(MouseEvent.ROLL_OUT, vertexMouseOut);
				}
			}
		}
		
		public function disable():void
		{
			for (var i:int = 0; i < _graphCanvas.numElements; i++)
			{
				var vertexSprite:VertexSprite = _graphCanvas.getElementAt(i) as VertexSprite;
				if (vertexSprite)
				{
					vertexSprite.removeEventListener(MouseEvent.ROLL_OVER, vertexMouseOver);
					vertexSprite.removeEventListener(MouseEvent.ROLL_OUT, vertexMouseOut);
				}
			}
		}
		
		public function refresh():void
		{
			disable();
			enable();
		}
		
		private function vertexMouseOver(event:MouseEvent):void
		{
			var sprite:VertexSprite = event.currentTarget as VertexSprite;
			sprite.isHighlighted = true;
			_overVertex = sprite;
		}

		private function vertexMouseOut(event:MouseEvent):void
		{
			var sprite:VertexSprite = event.currentTarget as VertexSprite;
			_overVertex = null;
			sprite.isHighlighted = false;
		}
	}

}