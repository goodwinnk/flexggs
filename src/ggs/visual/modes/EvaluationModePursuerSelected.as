package ggs.visual.modes 
{
	import flash.events.MouseEvent;
	import ggs.graphcore.Edge;
	import ggs.graphcore.Vertex;
	import ggs.visual.EdgeSprite;
	import ggs.visual.modes.helpers.OverEdgeHelper;
	import ggs.visual.modes.helpers.OverVertexHelper;
	import ggs.visual.GraphCanvasHelper;
	import ggs.visual.PursuerSprite;
	import ggs.visual.VertexSprite;
	import spark.components.Group;
	
	/**
	 * ...
	 * @author goodwinnk
	 */
	public class EvaluationModePursuerSelected implements IGraphCanvasMode
	{
		private var graphCanvas:Group;
		private var selectedPursuer:PursuerSprite;
		
		private var overVertexHelper:OverVertexHelper;
		private var overEdgeHelper:OverEdgeHelper;
				
		public function EvaluationModePursuerSelected(
			graphCanvas:Group, 
			pursuerSprite:PursuerSprite) 
		{
			this.graphCanvas = graphCanvas;
			this.selectedPursuer = pursuerSprite;
		}
		
		public function register():void
		{
			if (selectedPursuer.pursuer.isOnEdge)
			{
				var edgeSprite:EdgeSprite = GraphCanvasHelper.getEdgeSprite(
						graphCanvas, selectedPursuer.pursuer.edge);
				edgeSprite.addEventListener(MouseEvent.CLICK, onEdgeClick);
				
				var beginVertexSprite:VertexSprite = GraphCanvasHelper.getVertexSprite(
						graphCanvas, selectedPursuer.pursuer.edge.begin);
				beginVertexSprite.addEventListener(MouseEvent.CLICK, onVertexClick);
				
				var endVertexSprite:VertexSprite = GraphCanvasHelper.getVertexSprite(
						graphCanvas, selectedPursuer.pursuer.edge.end);
				endVertexSprite.addEventListener(MouseEvent.CLICK, onVertexClick);
			}
			else if (selectedPursuer.pursuer.isInVertex)
			{
				var currentVertex:Vertex = selectedPursuer.pursuer.vertex;
				
				selectedPursuer.pursuer.graph.getIncidentEdges(currentVertex).forEach(
					function callback(edge:Edge, index:int, vector:Vector.<Edge>):void 
					{
						var edgeSprite:EdgeSprite = GraphCanvasHelper.getEdgeSprite(graphCanvas, edge);
						edgeSprite.addEventListener(MouseEvent.CLICK, onEdgeClick);
					
						var otherVertexSprite:VertexSprite;
						
						if (edge.begin.id != currentVertex.id)
						{
							otherVertexSprite = GraphCanvasHelper.getVertexSprite(graphCanvas, edge.begin);
						}
						else
						{
							otherVertexSprite = GraphCanvasHelper.getVertexSprite(graphCanvas, edge.end);
						}
						
						otherVertexSprite.addEventListener(MouseEvent.CLICK, onVertexClick);
					});
			}
		}
		
		public function unregister():void
		{
			if (selectedPursuer.pursuer.isOnEdge)
			{
				var edgeSprite:EdgeSprite = GraphCanvasHelper.getEdgeSprite(
						graphCanvas, selectedPursuer.pursuer.edge);
				edgeSprite.removeEventListener(MouseEvent.CLICK, onEdgeClick);
				
				var beginVertexSprite:VertexSprite = GraphCanvasHelper.getVertexSprite(
						graphCanvas, selectedPursuer.pursuer.edge.begin);
				beginVertexSprite.removeEventListener(MouseEvent.CLICK, onVertexClick);
				
				var endVertexSprite:VertexSprite = GraphCanvasHelper.getVertexSprite(
						graphCanvas, selectedPursuer.pursuer.edge.end);
				endVertexSprite.removeEventListener(MouseEvent.CLICK, onVertexClick);
			}
			else if (selectedPursuer.pursuer.isInVertex)
			{
				var currentVertex:Vertex = selectedPursuer.pursuer.vertex;
				
				selectedPursuer.pursuer.graph.getIncidentEdges(currentVertex).forEach(
					function callback(edge:Edge, index:int, vector:Vector.<Edge>):void 
					{						
						var edgeSprite:EdgeSprite = GraphCanvasHelper.getEdgeSprite(graphCanvas, edge);
							
						edgeSprite.removeEventListener(MouseEvent.CLICK, onEdgeClick);
						
						var otherVertexSprite:VertexSprite;
						
						if (edge.begin.id != currentVertex.id)
						{
							otherVertexSprite = GraphCanvasHelper.getVertexSprite(graphCanvas, edge.begin);
						}
						else
						{
							otherVertexSprite = GraphCanvasHelper.getVertexSprite(graphCanvas, edge.end);
						}
						
						otherVertexSprite.removeEventListener(MouseEvent.CLICK, onVertexClick);
						
					});
			}
		}
		
		private function onVertexClick(event:MouseEvent):void
		{
			unregister();
			
			var vertexSprite:VertexSprite = event.target as VertexSprite;			
			selectedPursuer.pursuer.moveToVertex(vertexSprite.graphVertex);
			
			register();
		}
		
		private function onEdgeClick(event:MouseEvent):void
		{
			unregister();
			
			var edgeSprite:EdgeSprite = event.target as EdgeSprite;
			
			// var left:Number = edgeSprite.left;
			// var right:Number = edgeSprite.right;
			
			selectedPursuer.pursuer.moveToEdge(edgeSprite.graphEdge, 0.5);
			selectedPursuer.invalidateLayoutDirection();
			
			register();
		}		
	}
}