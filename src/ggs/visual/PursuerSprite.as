package ggs.visual 
{
	import ggs.problem.Pursuer;
	import spark.core.SpriteVisualElement;
	/**
	 * ...
	 * @author goodwinnk
	 */
	public class PursuerSprite extends SpriteVisualElement implements IHighlightable
	{
		private var _pursuer:Pursuer;
		
		private var _isSelected:Boolean;		
		private var _isHighlited:Boolean;
		
		public function PursuerSprite(pursuer:Pursuer) 
		{
			_pursuer = pursuer;
		}
		
		public function get isHighlighted():Boolean { return _isHighlited; }
		public function set isHighlighted(value:Boolean):void 
		{ 
			if (value == _isHighlited)
			{
				return;
			}
			
			_isHighlited = value;
			invalidateParentSizeAndDisplayList();			
		}
		
		public function get isSelected():Boolean { return _isSelected; }
		public function set isSelected(value:Boolean):void 
		{ 
			if (value == _isSelected)
			{
				return;
			}
			
			_isSelected = value;
			invalidateParentSizeAndDisplayList();			
		}
		
		override public function setLayoutBoundsSize(width:Number, height:Number, postLayoutTransform:Boolean = true):void
		{
			super.setLayoutBoundsSize(width, height, postLayoutTransform);
			draw();
		}
		
		public function draw():void
		{
			graphics.clear();
			
			graphics.beginFill(getColor());
			graphics.drawCircle(_pursuer.getX(), _pursuer.getY(), 4);
			graphics.endFill()
			
			graphics.lineStyle(2, getColor());
			graphics.drawCircle(_pursuer.getX(), _pursuer.getY(), _pursuer.radius);
		}
		
		private function getColor():int
		{
			if (_isSelected)
			{
				return 0x88eeff;
			}
			
			if (_isHighlited)
			{
				return 0xccaaaa;
			}
			
			return 0xccffcc;
		}
	}

}