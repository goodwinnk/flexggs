package ggs 
{
	import flash.events.MouseEvent;
	import ggs.graphcore.Edge;
	import ggs.graphcore.Graph;
	import ggs.graphcore.Vertex;
	import ggs.problem.Pursuer;
	import ggs.problem.Task;
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
		
		public function GGSApplication(canvasGroup:Group, task:Task = null)
		{
			_canvasGroup = canvasGroup;
			
			if (task)
			{
				load(task);
			}
			else
			{
				graph = new Graph();
			}
			
			changeMode(ApplicationMode.CANVAS_MODE);
		}
		
		private function load(task:Task):void
		{
			changeMode(ApplicationMode.CANVAS_MODE);
			
			// Remove all previous elements
			for (var i:int = 0; i < _canvasGroup.numChildren; i++)
			{
				_canvasGroup.removeElementAt(i);
			}
			
			graph = task.graph;
			
			// Edges should be added before verticies to be in background
			for (var ei:int = 0; ei < graph.edges.length; ei++)
			{
				_canvasGroup.addElement(new EdgeSprite(graph.edges[ei]));
			}
			
			for (var vi:int = 0; vi < graph.verticies.length; vi++)
			{
				_canvasGroup.addElement(new VertexSprite(graph.verticies[vi]));
			}
			
			for (var pi:int = 0; pi < task.pursuers.length; pi++)
			{
				_canvasGroup.addElement(new PursuerSprite(task.pursuers[pi]));
			}
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