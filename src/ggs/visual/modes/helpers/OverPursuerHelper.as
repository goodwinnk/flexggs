package ggs.visual.modes.helpers 
{
	import ggs.visual.PursuerSprite;
	import flash.events.MouseEvent;
	import spark.components.Group;
	
	/**
	 * ...
	 * @author goodwinnk
	 */
	public class OverPursuerHelper
	{
		private var _overPursuer:PursuerSprite;
		private var _graphCanvas:Group;
		
		public function OverPursuerHelper(graphCanvas:Group) 
		{			
			_graphCanvas = graphCanvas;
		}
		
		public function get overPursuer():PursuerSprite { return _overPursuer;  }
		
		public function enable():void
		{	
			for (var i:int = 0; i < _graphCanvas.numElements; i++)
			{
				var pursuerSprite:PursuerSprite = _graphCanvas.getElementAt(i) as PursuerSprite;
				if (pursuerSprite)
				{
					pursuerSprite.addEventListener(MouseEvent.ROLL_OVER, pursuerMouseOver);
					pursuerSprite.addEventListener(MouseEvent.ROLL_OUT, pursuerMouseOut);
				}
			}
		}
		
		public function disable():void
		{
			for (var i:int = 0; i < _graphCanvas.numElements; i++)
			{
				var pursuerSprite:PursuerSprite = _graphCanvas.getElementAt(i) as PursuerSprite;
				if (pursuerSprite)
				{
					pursuerSprite.removeEventListener(MouseEvent.ROLL_OVER, pursuerMouseOver);
					pursuerSprite.removeEventListener(MouseEvent.ROLL_OUT, pursuerMouseOut);
				}
			}
		}
		
		private function pursuerMouseOver(event:MouseEvent):void
		{
			var sprite:PursuerSprite = event.currentTarget as PursuerSprite;
			sprite.isHighlighted = true;
		}

		private function pursuerMouseOut(event:MouseEvent):void
		{
			var sprite:PursuerSprite = event.currentTarget as PursuerSprite;
			sprite.isHighlighted = false;
		}
	}

}