package uk.co.homletmoo.LD22
{
	import flash.utils.ByteArray;
	import net.flashpunk.*;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	
	/**
	 * ...
	 * @author Homletmoo
	 */
	public class Level extends Entity
	{
		private var _tiles:Tilemap;
		private var _grid:Grid;
		
		public function Level()
		{
			super(0, 0);
		}
		
		override public function added():void
		{
			
			_tiles = new Tilemap(/* TODO */);
			graphic = _tiles;
			_grid = new Grid(/* TODO */);
			mask = _grid;
			
			loadLevel(/* TODO */);
		}
		
		private function loadLevel(xml:Class):void
		{
			var rawData:ByteArray = new xml;
			var dataString:String = rawData.readUTFBytes(rawData.length);
			var xmlData:XML = new XML(dataString);
			var dataElement:XML;
			
			var tileList:XMLList;
			var gridData:String;
			
			var playerList:XMLList;
			
			tileList = xmlData.Tiles.tile;
			gridData = xmlData.Grid.*;
			
			playerList = xmlData.Entities.Player;
			
			for each(dataElement in tileList)
			{
				var x:int = dataElement.@x;
				var y:int = dataElement.@y;
				var id:int = dataElement.@id;
				
				_tiles.setTile(x, y, id);
			}
			trace(gridData);
			_grid.loadFromString(gridData, "", "\n");
			trace(_grid.saveToString());
			
			for each(dataElement in playerList)
			{
				var playerX:int = dataElement.@x;
				var playerY:int = dataElement.@y;
				
				FP.world.add(/* TODO */);
			}
		}
		
	}

}