package ggs.visual.modes 
{
	import ggs.graphcore.Graph;
	import ggs.graphcore.Vertex;
	import ggs.visual.EdgeSprite;
	import ggs.visual.modes.helpers.OverVertexHelper;
	import ggs.visual.VertexSprite;
	import spark.components.Group;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author goodwinnk
	 */
	public class NewEdgeMode implements IGraphCanvasMode
	{
		private var _graphCanvas:Group;
		private var _graph:Graph;
		
		private var _overVertexHelper:OverVertexHelper;
		
		// New edge state
		private var _drawEdge:Boolean = false;
		private var _edgeSprite:EdgeSprite = null;
		
		public function NewEdgeMode(graphCanvas:Group, graph:Graph) 
		{
			_graphCanvas = graphCanvas;
			_graph = graph;
			
			_overVertexHelper = new OverVertexHelper(graphCanvas);
		}
		
		public function register():void
		{
			_overVertexHelper.enable();
			
			_graphCanvas.addEventListener(MouseEvent.MOUSE_MOVE, edgeModeMouseMove);
			_graphCanvas.addEventListener(MouseEvent.MOUSE_DOWN, edgeModeMouseDown);
			_graphCanvas.addEventListener(MouseEvent.MOUSE_UP, edgeModeMouseUp);
		}
		
		public function unregister():void
		{
			_overVertexHelper.disable();
			
			_graphCanvas.removeEventListener(MouseEvent.MOUSE_MOVE, edgeModeMouseMove);
			_graphCanvas.removeEventListener(MouseEvent.MOUSE_DOWN, edgeModeMouseDown);
			_graphCanvas.removeEventListener(MouseEvent.MOUSE_UP, edgeModeMouseUp);
		}		
		
		private function edgeModeMouseDown(event:MouseEvent):void
		{
			if (!_drawEdge)
			{
				_drawEdge = true;
				
				var edgeStartX:Number = _graphCanvas.mouseX;
				var edgeStartY:Number = _graphCanvas.mouseY;
				
				var startVertex:Vertex;
				
				if (_overVertexHelper.overVertex)
				{
					startVertex = _overVertexHelper.overVertex.graphVertex;
				}
				else
				{
					startVertex = _graph.createVertex(edgeStartX, edgeStartY, null);
					_graphCanvas.addElement(new VertexSprite(startVertex));
				}

				_edgeSprite = new EdgeSprite(_graph.createEdge(
					startVertex, 
					_graph.createVertex(edgeStartX, edgeStartY, null),
					null));
				
				_graphCanvas.addElementAt(_edgeSprite, 0);
			}
		}
		
		private function edgeModeMouseUp(event:MouseEvent):void
		{
			if (_drawEdge)
			{
				if (_overVertexHelper.overVertex != null)
				{
					_edgeSprite.setEndVertex(_overVertexHelper.overVertex.graphVertex);
				}
				else
				{
					_edgeSprite.setEnd(_graphCanvas.mouseX, _graphCanvas.mouseY);
					_graphCanvas.addElement(new VertexSprite(_edgeSprite.graphEdge.end));
					
					_overVertexHelper.refresh();
				}

				_drawEdge = false;
			}
		}

		private function edgeModeMouseMove(event:MouseEvent):void
		{
			if (_drawEdge)
			{
				_edgeSprite.setEnd(_graphCanvas.mouseX, _graphCanvas.mouseY);
			}
		}
	}

}