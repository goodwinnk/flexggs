package ggs.visual 
{
	import ggs.graphcore.Vertex;
	import spark.core.SpriteVisualElement;
	/**
	 * ...
	 * @author goodwinnk
	 */
	public class VertexSprite extends SpriteVisualElement implements IHighlightable
	{	
		private var _vertex:Vertex;
		private var _isHighlited:Boolean;
		
		public function VertexSprite(vertex:Vertex) 
		{
			_vertex = vertex;
			this.z = 0;
		}
		
		public function get graphVertex():Vertex { return _vertex; }
		
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
		
		override public function setLayoutBoundsSize(width:Number, height:Number, postLayoutTransform:Boolean = true):void
		{
			super.setLayoutBoundsSize(width, height, postLayoutTransform);
			draw();
		}
		
		private function draw():void
		{
			graphics.clear();
			graphics.beginFill(!_isHighlited ? 0xff0000 : 0x0000ff);
			graphics.drawCircle(_vertex.point.x, _vertex.point.y, 6);
			graphics.endFill()
		}
	}
}