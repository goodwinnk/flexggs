package ggs.visual.modes 
{
	import ggs.graphcore.Graph;
	import ggs.visual.EdgeSprite;
	import ggs.visual.modes.helpers.OverEdgeHelper;
	import ggs.visual.modes.helpers.OverPursuerHelper;
	import ggs.visual.modes.helpers.OverVertexHelper;
	import ggs.visual.VertexSprite;
	import spark.components.Group;
	/**
	 * ...
	 * @author goodwinnk
	 */
	public class SelectMode implements IGraphCanvasMode
	{	
		private var _overVertexHelper:OverVertexHelper;
		private var _overEdgeHelper:OverEdgeHelper;
		private var _overPursuerHelper:OverPursuerHelper;
		
		public function SelectMode(graphCanvas:Group) 
		{
			_overVertexHelper = new OverVertexHelper(graphCanvas);
			_overEdgeHelper = new OverEdgeHelper(graphCanvas);
			_overPursuerHelper = new OverPursuerHelper(graphCanvas);
		}
		
		public function register():void
		{
			_overVertexHelper.enable();
			_overEdgeHelper.enable();
			_overPursuerHelper.enable();
		}
		
		public function unregister():void
		{
			_overVertexHelper.disable();
			_overEdgeHelper.disable();
			_overPursuerHelper.disable();
		}
	}

}