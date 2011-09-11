package ggs.problem 
{
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
		private var _edgeRatio:Number;
		
		public function Pursuer(radius:Number, vertex:Vertex, edge:Edge = null, edgeRatio:Number = 0) 
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
				moveToEdge(edge, edgeRatio);
			}
			else
			{
				throw new Error("Position is not defined");
			}
		}
		
		public function get isInVertex():Boolean { return _onVertex != null; }
		public function get isOnEdge():Boolean { return _onEdge != null; }
		
		public function get vertex():Vertex { return _onVertex;  }
		public function get edge():Edge { return _onEdge;  }
		public function get edgeRatio():Number { return _edgeRatio; }
		
		public function get radius():Number { return _radius; }
		
		public function moveToVertex(vertex:Vertex):void
		{
			_onEdge = null;
			_edgeRatio = 0;
			
			_onVertex = vertex;
		}
		
		public function moveToEdge(edge:Edge, edgeRatio:Number):void
		{
			_onVertex = null;
			
			_onEdge = edge;
			_edgeRatio = edgeRatio;
		}
		
		public function getX():int
		{
			if (isInVertex)
			{
				return vertex.point.x;
			}
			
			if (isOnEdge)
			{
				var x1:int = edge.begin.point.x;
				var x2:int = edge.end.point.x;
				
				return x1 + (x2 - x1) * edgeRatio;
			}
			
			throw new Error("Position is not defined");
		}
		
		public function getY():int
		{
			if (isInVertex)
			{
				return vertex.point.y;
			}
			
			if (isOnEdge)
			{
				var y1:int = edge.begin.point.y;
				var y2:int = edge.end.point.y;
				
				return y1 + (y2 - y1) * edgeRatio;
			}
			
			throw new Error("Position is not defined");
		}
	}

}