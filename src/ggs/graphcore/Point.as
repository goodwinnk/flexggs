package ggs.graphcore {
	
	public class Point {
		
		private var _x:int;
		private var _y:int;
		
		public function Point(x:int, y:int)
		{
			_x = x;
			_y = y;
		}
		
		public function get x():int { return _x; }
		public function set x(value:int):void { _x = value; }
		
		public function get y():int { return _y; }
		public function set y(value:int):void { _y = value; }
		
		public function setCoordinates(x:int, y:int):void 
		{ 
			_x = x; 
			_y = y; 
		}
		
		public function toString() : String 
		{
			return "Point(x=" + this.x + ", y=" + this.y + ")";
		}
	}
}
