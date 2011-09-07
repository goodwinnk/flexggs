package ggs.graphcore {
	
	public class Edge 
	{	
		private var _id:int;
		private var _begin:Vertex;
		private var _end:Vertex;
		private var _label:*;
		private var _graph:Graph;
		
		public function Edge(id:int, graph:Graph, begin:Vertex, end:Vertex, label:*)
		{
			_id = id;
			_begin = begin;
			_end = end;
			_label = label;
			_graph = graph;
		}
		
		public function get id():int { return _id; }
		public function get graph():Graph { return _graph; }
		
		public function get begin():Vertex { return _begin; }
		public function set begin(value:Vertex):void { _begin = value; }
		
		public function get end():Vertex { return _end; }
		public function set end(value:Vertex):void { _end = value; }
		
		public function get length():Number { return getLength(); }
		
		public function toString():String 
		{
			return "graphcore.Edge(id=" + _id + 
				", label=" + _label + 
				", begin=" + _begin.toString() + 
				", end=" + _end.toString() + 
				", length=" + this.getLength() + 
				")";
		}
				
		private function getLength():Number 
		{
			var xdiff:int = _begin.point.x - _end.point.x;
			var ydiff:int = _begin.point.y - _end.point.y;
			return Math.sqrt(xdiff * xdiff + ydiff * ydiff);
		}
		
		public function accept(visitor:IGraphVisitor):void 
		{
			visitor.visitEdge(this);
		}		
	}
}
