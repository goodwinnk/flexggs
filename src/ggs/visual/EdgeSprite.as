package ggs.visual 
{
	import flash.geom.Point;
	import ggs.graphcore.Edge;
	import ggs.graphcore.Vertex;
	import spark.core.SpriteVisualElement;
	/**
	 * ...
	 * @author goodwinnk
	 */
	public class EdgeSprite extends SpriteVisualElement
	{
		private var edge: Edge;
		private var _isHighlited:Boolean;
		
		public function EdgeSprite(edge:Edge) 
		{
			this.edge = edge;
			this.z = -1;
		}
		
		public function get graphEdge():Edge { return edge; }
		
		public function get isHighlighted():Boolean { return _isHighlited; }
		public function set isHighlighted(value:Boolean):void 
		{ 
			if (value == _isHighlited)
			{
				return;
			}
			
			_isHighlited = value;
			invalidateParentSizeAndDisplayList();
		}	
		
		public function setEnd(x: int, y: int):void 
		{
			edge.end.point.setCoordinates(x, y);
			invalidateParentSizeAndDisplayList();
		}
		
		public function setEndVertex(vertex:Vertex):void
		{
			if (edge.end.id != vertex.id)
			{
				edge.graph.removeVertex(edge.end);
				edge.end = vertex;
				invalidateParentSizeAndDisplayList();
			}
		}
		
		override public function setLayoutBoundsSize(width:Number, height:Number, postLayoutTransform:Boolean = true):void
		{
			super.setLayoutBoundsSize(width, height, postLayoutTransform);
			draw();
		}
		
		private function draw():void
		{
			graphics.clear();
			graphics.lineStyle(4, (!_isHighlited ? 0xff0000 : 0x00ff00));
			graphics.moveTo(edge.begin.point.x, edge.begin.point.y);
			graphics.lineTo(edge.end.point.x, edge.end.point.y);
		}
	}

}