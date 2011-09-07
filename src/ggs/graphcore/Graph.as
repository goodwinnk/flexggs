package ggs.graphcore {
	
	public class Graph {
		
		private var nextEdgeId:int = 0;
		private var nextVertexId:int = 0;
		
		private var verticies:Vector.<Vertex>;
		private var edges:Vector.<Edge>;
		
		public function Graph()
		{
			verticies = new Vector.<Vertex>();
			edges = new Vector.<Edge>();
		}
		
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
			verticies = verticies.filter(function (item:Vertex, index:int, vector:Vector.<Vertex>):Boolean { 
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
			edges = edges.filter(function (item:Edge, index:int, vector:Vector.<Edge>):Boolean { 
				return item.id != edge.id;
			});
		}
		
		public function accept(visitor:IGraphVisitor):void 
		{
			visitor.visitGraph(this);
		}		
	}
}
