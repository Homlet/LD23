package uk.co.homletmoo.LD23
{
	import flash.geom.Point;
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
			layer = 0;
			
			_tiles = new Tilemap(Assets.TILES_RAW, 1280, 720, 16, 16);
			graphic = _tiles;
			_grid = new Grid(1280, 720, 16, 16);
			mask = _grid;
			
			if(Math.floor(Math.random() * 2) == 0)
				loadLevel(Assets.OGMO_ISLAND);
			else
				loadLevel(Assets.OGMO_ISLAND2);
			
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
				
				FP.world.add(new Turret(x + 8, y + 8));
			}
			
			entityList = xmlData.Entities.rocket;
			for each(dataElement in entityList)
			{
				x = dataElement.@x;
				y = dataElement.@y;
				
				FP.world.add(new Rocket(x + 8, y + 8));
			}
			
			entityList = xmlData.Entities.coinpoint;
			for each(dataElement in entityList)
			{
				x = dataElement.@x;
				y = dataElement.@y;
				
				Globals.COINPOINTS.push(new Point(x, y));
			}
			
			Assets.placeCoin();
			
		}
		
	}

}