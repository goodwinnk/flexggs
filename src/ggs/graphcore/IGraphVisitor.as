package ggs.graphcore {
	public interface IGraphVisitor 
	{
		function visitGraph(graph:Graph):void;
		function visitEdge(edge:Edge):void;
		function visitVertex(vertex:Vertex):void;
	}
}
