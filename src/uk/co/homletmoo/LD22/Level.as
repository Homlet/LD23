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
			
			_tiles = new Tilemap(Assets.TILES_RAW, 1280, 720, 16, 16);
			graphic = _tiles;
			_grid = new Grid(1280, 720, 16, 16);
			mask = _grid;
			
			loadLevel(Assets.OGMO_ISLAND);
			
			type = Assets.TYPE_LEVEL;
		}
		
		private function loadLevel(xml:Class):void
		{
			var rawData:ByteArray = new xml;
			var dataString:String = rawData.readUTFBytes(rawData.length);
			var xmlData:XML = new XML(dataString);
			var dataElement:XML;
			
			var tileList:XMLList;
			var gridData:String;
			var entityList:XMLList;
			
			tileList = xmlData.Tiles.tile;
			gridData = xmlData.Grid.*;
			
			for each(dataElement in tileList)
			{
				var x:int = dataElement.@x;
				var y:int = dataElement.@y;
				var id:int = dataElement.@id;
				
				_tiles.setTile(x, y, id);
			}
			
			_grid.loadFromString(gridData, "", "\n");
			
			entityList = xmlData.Entities.turret;
			for each(dataElement in entityList)
			{
				x = dataElement.@x;
				y = dataElement.@y;
				
				FP.world.add(new Turret(x, y));
			}
			
			entityList = xmlData.Entities.rocket;
			for each(dataElement in entityList)
			{
				x = dataElement.@x;
				y = dataElement.@y;
				
				FP.world.add(new Rocket(x, y));
			}
			
		}
		
	}

}