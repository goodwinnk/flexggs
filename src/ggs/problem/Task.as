package ggs.problem 
{
	import ggs.graphcore.Graph;
	/**
	 * ...
	 * @author goodwinnk
	 */
	public class Task 
	{
		private var _graph:Graph;
		private var _pursuers:Vector.<Pursuer>
		
		public function Task(graph:Graph, pursuers:Vector.<Pursuer>) 
		{
			_graph = graph;
			_pursuers = pursuers;
		}
		
		public function get pursuers():Vector.<Pursuer> { return _pursuers; }
		public function get graph():Graph { return _graph; }
	}

}