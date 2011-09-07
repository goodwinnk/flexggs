package ggs.visual 
{
	import spark.core.SpriteVisualElement;
	/**
	 * ...
	 * @author goodwinnk
	 */
	public class PursuerSprite extends SpriteVisualElement implements IHighlightable
	{
		private var _x:int;
		private var _y:int;
		private var _radius:Number;		
		
		private var _isHighlited:Boolean;
		
		public function PursuerSprite(x:int, y:int, radius:Number) 
		{
			_x = x;
			_y = y;
			_radius = radius;
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
		
		override public function setLayoutBoundsSize(width:Number, height:Number, postLayoutTransform:Boolean = true):void
		{
			super.setLayoutBoundsSize(width, height, postLayoutTransform);
			draw();
		}
		
		public function draw():void
		{
			graphics.clear();
			
			graphics.beginFill(!_isHighlited ? 0xccffcc : 0xccaaaa);
			graphics.drawCircle(_x, _y, 4);
			graphics.endFill()
			
			graphics.lineStyle(2, _isHighlited ? 0xccffcc : 0xccaaaa);
			graphics.drawCircle(_x, _y, _radius);
		}
	}

}