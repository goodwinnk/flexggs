package ggs 
{
	import flash.events.MouseEvent;
	import ggs.graphcore.Graph;
	import ggs.graphcore.Vertex;
	import ggs.problem.Pursuer;
	import ggs.visual.EdgeSprite;
	import ggs.visual.IHighlightable;
	import ggs.visual.modes.EvaluationMode;
	import ggs.visual.modes.IGraphCanvasMode;
	import ggs.visual.modes.NewEdgeMode;
	import ggs.visual.modes.NewPursuerMode;
	import ggs.visual.modes.NewVertexMode;
	import ggs.visual.modes.SelectMode;
	import ggs.visual.PursuerSprite;
	import ggs.visual.VertexSprite;
	import mx.core.IVisualElement;
	import mx.managers.CursorManager;
	import spark.components.Group;
	import spark.core.SpriteVisualElement;
	/**
	 * ...
	 * @author goodwinnk
	 */
	public class GGSApplication 
	{
		private var graph:Graph;
		
		private var mode:int;	
		private var _canvasMode:IGraphCanvasMode;
		
		// Copy of mxml elements;
		private var _canvasGroup:Group;
		
		public function GGSApplication(canvasGroup:Group)
		{
			graph = new Graph();
			_canvasGroup = canvasGroup;
			
			changeMode(ApplicationMode.CANVAS_MODE);
		}
		
		public function changeMode(newMode:int):void
		{
			if (_canvasMode)
			{
				_canvasMode.unregister();
			}
		
			switch (newMode)
			{
				case ApplicationMode.CANVAS_MODE:
					_canvasMode = new SelectMode(_canvasGroup);
					break;
				case ApplicationMode.VERTEX_MODE:
					_canvasMode = new NewVertexMode(_canvasGroup, graph);
					break;
				case ApplicationMode.EDGE_MODE:
					_canvasMode = new NewEdgeMode(_canvasGroup, graph);
					break;
				case ApplicationMode.PURSUER_MODE:
					_canvasMode = new NewPursuerMode(_canvasGroup, graph);
					break;
				case ApplicationMode.EMULATION_MODE:
					_canvasMode = new EvaluationMode(_canvasGroup);
					break;
			}
			
			_canvasMode.register();
		}
		
		public function traceGraph():void
		{
			trace(graph.toString());
		}

		/* ---------------------------------------------- */
		public function onDelete():void
		{
			/*if (overEdge)
			{
				graph.removeEdge(overEdge.graphEdge);
				canvasGroup.removeElement(overEdge);				
			}
			
			if (overVertex)
			{
				graph.removeVertex(overVertex.graphVertex);
				canvasGroup.removeElement(overVertex);				
			}*/
		}
	}

}