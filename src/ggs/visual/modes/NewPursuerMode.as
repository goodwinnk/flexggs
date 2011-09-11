package ggs.visual.modes 
{
	import ggs.graphcore.Graph;
	import ggs.problem.Pursuer;
	import ggs.visual.modes.helpers.OverVertexHelper;
	import ggs.visual.PursuerSprite;
	import spark.components.Group;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author goodwinnk
	 */
	public class NewPursuerMode implements IGraphCanvasMode
	{	
		private var _graphCanvas:Group;
		private var _graph:Graph;
		
		private var _overVertexHelper:OverVertexHelper;
		
		public function NewPursuerMode(graphCanvas:Group, graph:Graph) 
		{
			_graphCanvas = graphCanvas;
			_graph = graph;
			
			_overVertexHelper = new OverVertexHelper(graphCanvas);
		}
		
		public function register():void
		{
			_overVertexHelper.enable();
			
			_graphCanvas.addEventListener(MouseEvent.CLICK, newPursuer);
		}
		
		public function unregister():void
		{
			_overVertexHelper.disable();
			
			_graphCanvas.removeEventListener(MouseEvent.CLICK, newPursuer);
		}
		
		private function newPursuer(event:MouseEvent):void
		{
			if (_overVertexHelper.overVertex)
			{
				var sprite:PursuerSprite = new PursuerSprite(
					new Pursuer(20, _overVertexHelper.overVertex.graphVertex));
					
				_graphCanvas.addElement(sprite);
			}
		}
	}

}