--[[

   Stonebrick Dungeons init.lua

   Copyright 2017 Hamlet <h4mlet@riseup.net>

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
   MA 02110-1301, USA.

]]--

local COBBLE = minetest.get_content_id"default:cobble"
local COBBLE_MOSSY = minetest.get_content_id"default:mossycobble"
local STAIR_COBBLE = minetest.get_content_id"stairs:stair_cobble"
local STAIR_COBBLE_MOSSY = minetest.get_content_id"stairs:stair_mossycobble"
local STONE_BRICKS = ""
local STONE_BRICKS_STAIR = ""


if minetest.get_modpath("castle_masonry") then

   STONE_BRICKS = minetest.get_content_id"castle_masonry:dungeon_stone"
   STONE_BRICKS_STAIR = minetest.get_content_id"stairs:stair_dungeon_stone"

else

   STONE_BRICKS = minetest.get_content_id"default:stonebrick"
   STONE_BRICKS_STAIR = minetest.get_content_id"stairs:stair_stonebrick"

end


minetest.register_on_generated(function()

	local vm, emin, emax = minetest.get_mapgen_object"voxelmanip"
	local data = vm:get_data()
	local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
   
   for i in area:iterp(emin, emax) do

      if (data[i] == COBBLE) or (data[i] == COBBLE_MOSSY) then
          data[i] = STONE_BRICKS
      end
      
      if (data[i] == STAIR_COBBLE) or 
         (data[i] == STAIR_COBBLE_MOSSY) then
          data[i] = STONE_BRICKS_STAIR
      end
      
   end

   vm:set_data(data)
   vm:write_to_map()

end)
