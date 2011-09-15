package ggs 
{
	import ggs.graphcore.Graph;
	import ggs.graphcore.Vertex;
	import ggs.problem.Task;
	import ggs.problem.Pursuer;
	
	public class InitTaskGenerator
	{
		public static function generate():Task
		{
			var graph:Graph = new Graph();
			var v1:Vertex = graph.createVertex(20, 20, null);
			var v2:Vertex = graph.createVertex(200, 20, null);
			var v3:Vertex = graph.createVertex(110, 110, null);
			var v4:Vertex = graph.createVertex(110, 200, null);
			
			graph.createEdge(v1, v3, null);
			graph.createEdge(v2, v3, null);
			graph.createEdge(v3, v4, null);
			
			var pursuers:Vector.<Pursuer> = new Vector.<Pursuer>();
			pursuers.push(new Pursuer(20, v4));
			
			return new Task(graph, pursuers);
		}
	}
}