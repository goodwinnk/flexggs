package ggs.visual.modes 
{
	import flash.events.MouseEvent;
	import ggs.visual.modes.helpers.OverPursuerHelper;
	import ggs.visual.PursuerSprite;
	import mx.containers.Canvas;
	import mx.core.IVisualElement;
	import spark.components.Group;
	/**
	 * ...
	 * @author goodwinnk
	 */
	public class EvaluationMode implements IGraphCanvasMode
	{
		private var _graphCanvas:Group;
		private var _selectedPursuer:PursuerSprite;
		
		private var _overPursuerHelper:OverPursuerHelper;
		
		public function EvaluationMode(graphCanvas:Group) 
		{
			_graphCanvas = graphCanvas;
			
			_overPursuerHelper = new OverPursuerHelper(graphCanvas);
		}
		
		public function register():void
		{
			_overPursuerHelper.enable();
			
			for (var i:int = 0; i < _graphCanvas.numElements; i++)
			{
				var pursuerSprite:PursuerSprite = _graphCanvas.getElementAt(i) as PursuerSprite;
				if (pursuerSprite)
				{
					pursuerSprite.addEventListener(MouseEvent.CLICK, selectPursuer);
				}
			}
			
			_graphCanvas.addEventListener(MouseEvent.MOUSE_MOVE, emulationModeMouseMove);
		}
		
		public function unregister():void
		{
			_overPursuerHelper.disable();
			
			for (var i:int = 0; i < _graphCanvas.numElements; i++)
			{
				var pursuerSprite:PursuerSprite = _graphCanvas.getElementAt(i) as PursuerSprite;
				if (pursuerSprite)
				{
					pursuerSprite.removeEventListener(MouseEvent.CLICK, selectPursuer);
				}
			}
			
			_graphCanvas.removeEventListener(MouseEvent.MOUSE_MOVE, emulationModeMouseMove);
		}
		
		private function selectPursuer(event:MouseEvent):void
		{
			var sprite:PursuerSprite = event.currentTarget as PursuerSprite;
			
			if (_selectedPursuer == sprite)
			{
				_selectedPursuer.isSelected = false;
				_selectedPursuer = null;
			}
			else
			{
				if (_selectedPursuer)
				{
					_selectedPursuer.isSelected = false;
				}
				
				_selectedPursuer = sprite;
				_selectedPursuer.isSelected = true;				
			}
		}
		
		private function emulationModeMouseMove(event:MouseEvent):void
		{
			/*if (overVertex != null || overEdge != null)
			{
				CursorManager.setBusyCursor();
			}
			else
			{
				CursorManager.removeBusyCursor();
			}*/
		}
	}
}