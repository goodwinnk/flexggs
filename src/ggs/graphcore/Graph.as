package ggs.graphcore {
	
	public class Graph {
		
		private var nextEdgeId:int = 0;
		private var nextVertexId:int = 0;
		
		private var _verticies:Vector.<Vertex>;
		private var _edges:Vector.<Edge>;
		
		public function Graph()
		{
			_verticies = new Vector.<Vertex>();
			_edges = new Vector.<Edge>();
		}
		
		public function get verticies():Vector.<Vertex> { return _verticies; }
		public function get edges():Vector.<Edge> { return _edges; }
		
		public function toString() : String {
			var str:String = "Graph:\n";
			
			for each(var vertex:Vertex in verticies) 
			{
				str += vertex.toString() + "\n";
			}
			
			for each(var edge:Edge in edges) 
			{
				str += edge.toString() + "\n";
			}
			
			return str;
		}
		
		public function createVertex(x:int, y:int, label:*) : Vertex 
		{
			var vertex:Vertex = new Vertex(nextVertexId++, this, new Point(x, y), label);
			verticies.push(vertex);
			return vertex;
		}
		
		public function removeVertex(vertex:Vertex):void
		{
			_verticies = verticies.filter(function (item:Vertex, index:int, vector:Vector.<Vertex>):Boolean { 
				return item.id != vertex.id; 
			});
		}
		
		public function createEdge(begin:Vertex, end:Vertex, label:*):Edge 
		{
			var edge:Edge = new Edge(nextEdgeId++, this, begin, end, label);
			edges.push(edge);
			return edge;
		}
		
		public function removeEdge(edge:Edge):void
		{
			_edges = edges.filter(function (item:Edge, index:int, vector:Vector.<Edge>):Boolean { 
				return item.id != edge.id;
			});
		}
		
		public function getBeginEdges(vertex:Vertex):Vector.<Edge>
		{
			return edges.filter(function (item:Edge, index:int, vector:Vector.<Edge>):Boolean { 
				return item.begin.id == vertex.id;
			});
		}
		
		public function getEndEdges(vertex:Vertex):Vector.<Edge>
		{
			return edges.filter(function (item:Edge, index:int, vector:Vector.<Edge>):Boolean { 
				return item.end.id == vertex.id;
			});
		}		
		
		public function getIncidentEdges(vertex:Vertex):Vector.<Edge>
		{
			return getBeginEdges(vertex).concat(getEndEdges(vertex));
		}
		
		public function accept(visitor:IGraphVisitor):void 
		{
			visitor.visitGraph(this);
		}		
	}
}
