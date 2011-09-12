package ggs.visual.modes 
{
	import flash.events.MouseEvent;
	import ggs.visual.modes.helpers.OverPursuerHelper;
	import ggs.visual.PursuerSprite;
	import mx.containers.Canvas;
	import mx.core.IVisualElement;
	import spark.components.Group;
	import mx.managers.CursorManager;
	
	/**
	 * ...
	 * @author goodwinnk
	 */
	public class EvaluationMode implements IGraphCanvasMode
	{
		private var graphCanvas:Group;
		private var selectedPursuer:PursuerSprite;
		
		private var overPursuerHelper:OverPursuerHelper;
		
		private var selectedMode:EvaluationModePursuerSelected;
		
		public function EvaluationMode(graphCanvas:Group) 
		{
			this.graphCanvas = graphCanvas;
			this.overPursuerHelper = new OverPursuerHelper(graphCanvas);
		}
		
		public function register():void
		{
			overPursuerHelper.enable();
			
			for (var i:int = 0; i < graphCanvas.numElements; i++)
			{
				var pursuerSprite:PursuerSprite = graphCanvas.getElementAt(i) as PursuerSprite;
				if (pursuerSprite)
				{
					pursuerSprite.addEventListener(MouseEvent.CLICK, selectPursuer);
				}
			}
			
			graphCanvas.addEventListener(MouseEvent.MOUSE_MOVE, emulationModeMouseMove);
		}
		
		public function unregister():void
		{
			overPursuerHelper.disable();
			
			for (var i:int = 0; i < graphCanvas.numElements; i++)
			{
				var pursuerSprite:PursuerSprite = graphCanvas.getElementAt(i) as PursuerSprite;
				if (pursuerSprite)
				{
					pursuerSprite.removeEventListener(MouseEvent.CLICK, selectPursuer);
				}
			}
			
			graphCanvas.removeEventListener(MouseEvent.MOUSE_MOVE, emulationModeMouseMove);
			
			if (selectedMode)
			{
				selectedMode.unregister();
				selectedMode = null;
			}
			
			if (selectedPursuer)
			{
				selectedPursuer.isSelected = false;
			}
		}
		
		private function selectPursuer(event:MouseEvent):void
		{
			var sprite:PursuerSprite = event.currentTarget as PursuerSprite;
			
			if (selectedMode)
			{
				selectedMode.unregister();
				selectedMode = null;
			}
			
			if (selectedPursuer == sprite)
			{
				selectedPursuer.isSelected = false;
				selectedPursuer = null;
			}
			else
			{
				if (selectedPursuer)
				{
					selectedPursuer.isSelected = false;
				}
				
				selectedPursuer = sprite;
				selectedPursuer.isSelected = true;				
				
				selectedMode = new EvaluationModePursuerSelected(graphCanvas, selectedPursuer);
				selectedMode.register();
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