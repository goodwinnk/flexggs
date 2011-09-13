package ggs.problem 
{
	import flash.display.InteractiveObject;
	import ggs.graphcore.Edge;
	import ggs.graphcore.Graph;
	import ggs.graphcore.Vertex;
	/**
	 * ...
	 * @author goodwinnk
	 */
	public class Pursuer 
	{
		private var _graph:Graph;
		
		private var _radius:Number;
		
		private var _onVertex:Vertex;
		
		private var _onEdge:Edge;
		
		public function Pursuer(radius:Number, vertex:Vertex, edge:Edge = null, edgeX:Number = 0) 
		{ 
			_radius = radius;
			
			if (vertex != null)
			{
				_graph = vertex.graph;
				moveToVertex(vertex);
			}
			else if (edge != null)
			{
				_graph = edge.graph;
				moveToEdge(edge, edgeX);
			}
			else
			{
				throw new Error("Position is not defined");
			}
		}
		
		public function get graph():Graph { return _graph; }
		
		public function get isInVertex():Boolean { return _onVertex != null; }
		public function get isOnEdge():Boolean { return _onEdge != null; }
		
		public function get vertex():Vertex { return _onVertex; }
		public function get edge():Edge { return _onEdge; }

		private var _x:int;
		public function get x():int { return _x; }
		
		private var _y:int;
		public function get y():int { return _y; }
		
		public function get radius():Number { return _radius; }
		
		public function moveToVertex(vertex:Vertex):void
		{
			_onEdge = null;
			_onVertex = vertex;
			
			_x = vertex.point.x;
			_y = vertex.point.y;
		}
		
		public function moveToEdge(edge:Edge, newX:Number):void
		{
			var x1:int = edge.begin.point.x;
			var x2:int = edge.end.point.x;
			
			if (!(Math.min(x1, x2) <= newX && newX <= Math.max(x1, x2)))
			{
				throw Error("newX should be on the edge");
			}
			
			_onVertex = null;
			_onEdge = edge;
			
			_x = newX;
			
			var y1:int = edge.begin.point.y;
			var y2:int = edge.end.point.y;
			_y = Math.abs((newX - x1) / (x1 - x2)) * (y2 - y1) + y1;
		}
	}

}