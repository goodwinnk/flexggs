package ggs.visual 
{
	import adobe.utils.CustomActions;
	import ggs.graphcore.Edge;
	import ggs.graphcore.Vertex;
	import ggs.visual.EdgeSprite;
	import ggs.visual.VertexSprite;
	import ggs.visual.PursuerSprite;
	import mx.core.IVisualElement;
	
	import spark.components.Group;
	/**
	 * ...
	 * @author goodwinnk
	 */
	public class GraphCanvasHelper
	{	
		static public function getEdgeSprite(garphCanvas:Group, edge:Edge):EdgeSprite
		{
			for (var i:int = 0; i < garphCanvas.numElements; i++)
			{
				var edgeSprite:EdgeSprite = garphCanvas.getElementAt(i) as EdgeSprite;
				if (edgeSprite && edgeSprite.graphEdge.id == edge.id)
				{
					return edgeSprite;
				}
			}
			
			return null;
		}
		
		static public function getVertexSprite(garphCanvas:Group, vertex:Vertex):VertexSprite
		{
			for (var i:int = 0; i < garphCanvas.numElements; i++)
			{
				var vertexSprite:VertexSprite = garphCanvas.getElementAt(i) as VertexSprite;
				if (vertexSprite && vertexSprite.graphVertex.id == vertex.id)
				{
					return vertexSprite;
				}
			}
			
			return null;
		}
		
		
		/*
		private var edgeSprites:Vector.<EdgeSprite> = new Vector.<EdgeSprite>();
		private var vertexSprites:Vector.<VertexSprite> = new Vector.<VertexSprite>();
		
		public function addElement(element:IVisualElement):IVisualElement 
		{
			registerElement(element);
			return super.addElement(element);
		}
		
		public function addElementAt(element:IVisualElement, index:int):IVisualElement 
		{
			registerElement(element);
			return super.addElementAt(element, index);
		}
		
		override public function removeElement(element:IVisualElement):IVisualElement 
		{
			unregisterElement(element);
			return super.addElement(element);
		}
		
		override public function removeElementAt(index:int):IVisualElement 
		{
			unregisterElement(element);
			return super.removeElementAt(index);
		}
		
		static public function getEdgeSprite(edge:Edge):EdgeSprite
		{
			var found:Vector.<EdgeSprite> = edgeSprites.filter(
				function (item:EdgeSprite, index:int, vector:Vector.<EdgeSprite>):Boolean { 
					return edge.id == item.graphEdge.id;
				});
			
			if (found.length == 1)
			{
				return found[0];
			}
			else if (found.length == 0)
			{
				return null;
			}
			
			throw Error("More than one sprite for edge");
		}
		
		public function getVertexSprite(vertex:Vertex):VertexSprite
		{
			var found:Vector.<VertexSprite> = vertexSprites.filter(
				function (item:VertexSprite, index:int, vector:Vector.<VertexSprite>):Boolean { 
					return vertex.id == item.graphVertex.id;
				});
			
			if (found.length == 1)
			{
				return found[0];
			}
			else if (found.length == 0)
			{
				return null;
			}
			
			throw Error("More than one sprite for edge");
		}
		
		private function registerElement(element:IVisualElement):void
		{
			if (element is EdgeSprite)
			{
				registerEdgeSprite(element as EdgeSprite)
			}
			else if (element is VertexSprite)
			{
				registerVertesSprite(element as VertexSprite);
			}
		}
		
		private function unregisterElement(element:IVisualElement):void
		{
			if (element is EdgeSprite)
			{
				unregisterEdgeSprite(element as EdgeSprite);
			}
			else if (element is VertexSprite)
			{
				unregisterVertesSprite(element as VertexSprite);
			}
		}
		
		private function registerEdgeSprite(edgeSprite:EdgeSprite):void
		{
			if (edgeSprites.some(function (item:EdgeSprite, index:int, vector:Vector.<EdgeSprite>):Boolean { 
				return edgeSprite == item || edgeSprite.graphEdge.id == item.graphEdge.id;
			})) 
			{
				throw Error("Can't add same edgeSprite or other sprite with same edge");
			}
			
			edgeSprites.push(edgeSprite);
		}
		
		private function unregisterEdgeSprite(edgeSprite:EdgeSprite):void
		{
			edgeSprites = edgeSprites.splice(edgeSprites.indexOf(edgeSprite), 1);
		}
		
		private function registerVertesSprite(vertexSprite:VertexSprite):void
		{
			if (vertexSprite.some(function (item:VertexSprite, index:int, vector:Vector.<VertexSprite>):Boolean { 
				return vertexSprite == item || vertexSprite.graphVertex.id == item.graphVertex.id;
			})) 
			{
				throw Error("Can't add same vertexSprite or other sprite with same vertex");
			}
			
			vertexSprite.push(vertexSprite);
		}
		
		private function unregisterVertesSprite(vertexSprite:VertexSprite):void
		{
			vertexSprites = vertexSprites.splice(vertexSprites.indexOf(vertexSprite), 1);
		}
		*/
	}

}