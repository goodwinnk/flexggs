package ggs.visual.modes 
{
	import ggs.graphcore.Graph;
	import ggs.visual.VertexSprite;
	import spark.components.Group;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author goodwinnk
	 */
	public class NewVertexMode implements IGraphCanvasMode
	{	
		private var _graphCanvas:Group;
		private var _graph:Graph
		
		public function NewVertexMode(graphCanvas:Group, graph:Graph) 
		{
			_graphCanvas = graphCanvas;
			_graph = graph;
		}
		
		public function register():void
		{
			_graphCanvas.addEventListener(MouseEvent.CLICK, newVertex);
		}
		
		public function unregister():void
		{
			_graphCanvas.removeEventListener(MouseEvent.CLICK, newVertex);
		}
		
		public function newVertex(event:MouseEvent):void
		{
			var sprite:VertexSprite = new VertexSprite(
				_graph.createVertex(_graphCanvas.mouseX, _graphCanvas.mouseY, null));
				
			_graphCanvas.addElement(sprite);
		}
	}

}