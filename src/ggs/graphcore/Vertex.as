package ggs.graphcore {
	
	public class Vertex 
	{		
		private var _id:int;
		private var _label:*;
		private var _point:Point;
		private var _graph:Graph;
		
		public function Vertex(id:int, graph:Graph, point:Point, label:*)
		{
			_id = id;
			_point = point;
			_label = label;
			_graph = graph;
		}
		
		public function get id():int { return _id; }
		public function get graph():Graph { return _graph; }
		
		public function get point():Point { return _point; }
		
		public function toString():String 
		{
			return "ghraphcore.Vertex(id=" + this._id + 
				", label=" + this._label + 
				", coord=" + this._point.toString() + ")";
		}
		
		public function accept(visitor:IGraphVisitor):void {
			visitor.visitVertex(this);
		}
	}
}
