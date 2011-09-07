package ggs 
{
	import flash.events.MouseEvent;
	import ggs.graphcore.Graph;
	import ggs.graphcore.Vertex;
	import ggs.visual.EdgeSprite;
	import ggs.visual.IHighlightable;
	import ggs.visual.PursuerSprite;
	import ggs.visual.VertexSprite;
	import mx.core.IVisualElement;
	import spark.components.Group;
	import spark.core.SpriteVisualElement;
	/**
	 * ...
	 * @author goodwinnk
	 */
	public class GGSApplication 
	{
		private var graph:Graph;
		
		private var overEdge:EdgeSprite;
		private var overVertex:VertexSprite;
		
		private var mode:int;		
		
		// Copy of mxml elements;
		private var canvasGroup:Group;
		
		public function GGSApplication(canvasGroup:Group)
		{
			graph = new Graph();
			
			this.canvasGroup = canvasGroup;
			toCanvasMode();
		}
		
		public function changeMode(newMode:int):void
		{
			unregisterPreviousMode(mode);
		
			switch (newMode)
			{
				case ApplicationMode.CANVAS_MODE:
					toCanvasMode();
					break;
				case ApplicationMode.VERTEX_MODE:
					toVertexMode();
					break;
				case ApplicationMode.EDGE_MODE:
					toEdgeMode();
					break;
				case ApplicationMode.PURSUER_MODE:
					toPursuerMode();
					break;
				case ApplicationMode.EMULATION_MODE:
					toEmulationMode();
					break;
			}
		}
		
		/* - MXML handlers --------------------------------------------- */
		public function toCanvasMode():void
		{
			mode = ApplicationMode.CANVAS_MODE;
		}

		public function toVertexMode():void
		{	
			trace("Vertex mode");
			mode = ApplicationMode.VERTEX_MODE;		
			registerVertexodeListeners();
		}
		
		public function toEdgeMode():void
		{
			mode = ApplicationMode.EDGE_MODE;
			registerEdgeModeListeners();
		}
		
		public function toPursuerMode():void
		{
			mode = ApplicationMode.PURSUER_MODE;
			registerPursuerListeners();
		}
		
		public function toEmulationMode():void
		{
			mode = ApplicationMode.EMULATION_MODE;
		}
		
		public function traceGraph():void
		{
			trace(graph.toString());
		}
		
		/* ---------------------------------------------- */
		private function registerPursuerListeners():void
		{
			canvasGroup.addEventListener(MouseEvent.CLICK, pursuerModeMouseClick);
		}

		private function unregisterPursuerModeListeners():void
		{
			canvasGroup.removeEventListener(MouseEvent.MOUSE_MOVE, pursuerModeMouseClick);
		}
		
		private function pursuerModeMouseClick(event:MouseEvent):void
		{
			if (overVertex)
			{
				var sprite:PursuerSprite = new PursuerSprite(overVertex.graphVertex.point.x, overVertex.graphVertex.point.y, 20);
			
				// sprite.addEventListener(MouseEvent.ROLL_OVER, vertexMouseOver);
				// sprite.addEventListener(MouseEvent.ROLL_OUT, vertexMouseOut);	
				
				canvasGroup.addElement(sprite);
			}
		}
		
		/* ---------------------------------------------- */
		
		private function registerVertexodeListeners():void
		{
			canvasGroup.addEventListener(MouseEvent.CLICK, vertexModeMouseClick);
		}

		private function unregisterVertexModeListeners():void
		{
			canvasGroup.removeEventListener(MouseEvent.CLICK, vertexModeMouseClick);
		}
		
		private var vertexSprite:VertexSprite = null;

		private function  vertexModeMouseClick(event:MouseEvent):void
		{
			vertexSprite = createVertexSprite(graph.createVertex(canvasGroup.mouseX, canvasGroup.mouseY, null));
		}
		
		private function createVertexSprite(vertex:Vertex):VertexSprite
		{
			var sprite:VertexSprite = new VertexSprite(vertex);
			
			sprite.addEventListener(MouseEvent.ROLL_OVER, vertexMouseOver);
			sprite.addEventListener(MouseEvent.ROLL_OUT, vertexMouseOut);	
			
			canvasGroup.addElement(sprite);
			
			return sprite;
		}

		private function  vertexMouseOver(event:MouseEvent):void
		{
			var sprite:VertexSprite = event.currentTarget as VertexSprite;
			sprite.isHighlighted = true;
			overVertex = sprite;
		}

		private function vertexMouseOut(event:MouseEvent):void
		{
			var sprite:VertexSprite = event.currentTarget as VertexSprite;
			overVertex = null;
			sprite.isHighlighted = false;
		}

		private function unregisterPreviousMode(mode:int):void
		{
			switch (mode)
			{
				case ApplicationMode.EDGE_MODE:
					unregisterEdgeModeListeners();
					break;
				case ApplicationMode.VERTEX_MODE:
					unregisterVertexModeListeners();
					break;
				case ApplicationMode.PURSUER_MODE:
					unregisterPursuerModeListeners();
					break;
			}
		}

		private function registerEdgeModeListeners():void
		{
			canvasGroup.addEventListener(MouseEvent.MOUSE_MOVE, edgeModeMouseMove);
			canvasGroup.addEventListener(MouseEvent.MOUSE_DOWN, edgeModeMouseDown);
			canvasGroup.addEventListener(MouseEvent.MOUSE_UP, edgeModeMouseUp);
		}

		private function unregisterEdgeModeListeners():void
		{
			canvasGroup.removeEventListener(MouseEvent.MOUSE_MOVE, edgeModeMouseMove);
			canvasGroup.removeEventListener(MouseEvent.MOUSE_DOWN, edgeModeMouseDown);
			canvasGroup.removeEventListener(MouseEvent.MOUSE_UP, edgeModeMouseUp);
		}

		private var drawEdge:Boolean = false;
		private var edgeSprite:EdgeSprite = null;

		private var edgeStartX:int = 0;
		private var edgeStartY:int = 0;

		private function edgeModeMouseDown(event:MouseEvent):void
		{
			drawEdge = true;
			
			edgeStartX = canvasGroup.mouseX;
			edgeStartY = canvasGroup.mouseY;
			
			var startVertex:Vertex;
			
			if (overVertex)
			{
				startVertex = overVertex.graphVertex;
			}
			else
			{
				startVertex = graph.createVertex(edgeStartX, edgeStartY, null);
				createVertexSprite(startVertex);
			}

			edgeSprite = new EdgeSprite(graph.createEdge(
				startVertex, 
				graph.createVertex(edgeStartX, edgeStartY, null),
				null));
			
			canvasGroup.addElementAt(edgeSprite, 0);
		}

		private function edgeMouseOver(event:MouseEvent):void
		{
			if (!drawEdge)
			{
				var sprite:EdgeSprite = event.currentTarget as EdgeSprite;
				sprite.isHighlighted = false;
			}
		}

		private function edgeMouseOut(event:MouseEvent):void
		{
			if (!drawEdge)
			{
				var sprite:EdgeSprite = event.currentTarget as EdgeSprite;
				overEdge = sprite;
				sprite.isHighlighted = true;
			}
		}

		private function edgeModeMouseUp(event:MouseEvent):void
		{
			if (drawEdge)
			{
				if (overVertex != null)
				{
					edgeSprite.setEndVertex(overVertex.graphVertex);
				}
				else
				{
					edgeSprite.setEnd(canvasGroup.mouseX, canvasGroup.mouseY);
					createVertexSprite(edgeSprite.graphEdge.end);
				}
				
				edgeSprite.addEventListener(MouseEvent.ROLL_OVER, edgeMouseOver);
				edgeSprite.addEventListener(MouseEvent.ROLL_OUT, edgeMouseOut);
				
				drawEdge = false;
			}
		}

		private function edgeModeMouseMove(event:MouseEvent):void
		{
			if (drawEdge)
			{
				edgeSprite.setEnd(canvasGroup.mouseX, canvasGroup.mouseY);
			}
		}
		
		public function onDelete():void
		{
			if (overEdge)
			{
				graph.removeEdge(overEdge.graphEdge);
				canvasGroup.removeElement(overEdge);				
			}
			
			if (overVertex)
			{
				graph.removeVertex(overVertex.graphVertex);
				canvasGroup.removeElement(overVertex);				
			}
		}
	}

}