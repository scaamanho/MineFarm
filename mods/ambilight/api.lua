--[[
	Ambilight mod for minetest
	Copyright (C) 2018 Santiago Caamaño  <scaamanho@gmail.com>
  hereby released under the GNU LESSER GENERAL PUBLIC LICENSE v3 license.
  
  Define all functionality to register ambilight nodes
  ambilight.register_light(subname, node, recipe)

  custom node properties:
    * reg_pane
    * reg_stair [boolean]
    * enable_interact [boolean]
    *
  
    set node values as default
]]--


function ambilight.clone( t1 )
        local t2 = { }
        if #t1 > 0 then
                -- ordered copy of arrays
                t2 = { unpack( t1 ) }
        else
                -- shallow copy of hashes
                for k, v in pairs( t1 ) do t2[ k ] = v end
        end
        return t2
end


function ambilight.register_recipe(name, recipe, type)
	minetest.register_craft({
		type = type,
		output = "ambilight:"..name,
		recipe = recipe
	})
end

-- TODO: check mod stairs
function ambilight.register_stairs(name,node)
	-- Register default stairs and slabs
	stairs.register_stair_and_slab("anbilight"..name, "ambilight:"..name,
    {snappy = 2, choppy = 2, oddly_breakable_by_hand = 2},
		node.tiles,
		name.." Stair",
		name.." Slab",
		default.node_sound_glass_defaults())
  --[[
  -- TODO: override light_source
  stair = ambilight.clone(minetest.registered_nodes["stairs:stair_anbilight"..name])
  stair.light_source = 10
  minetest.registered_nodes["stairs:stair_anbilight"..name]=stair
  ]]--
end

function ambilight.register_pane(name, node)
	
	--create default recipe for ambilight panes based in ambilight nodes
	recipe={{"ambilight:"..name,"ambilight:"..name,"ambilight:"..name},
			{"ambilight:"..name,"ambilight:"..name,"ambilight:"..name},
			{"","",""}}
	
	-- writed this code as it is for show clear sample of register nodes
	-- feel free to change it if you wish 
	pane={ 
		description = node.description.." Pane",
		drawtype = "torchlike",
		tiles = node.tiles,
		inventory_image = node.tiles[1],
		wield_image = node.tiles[1],
		paramtype = "light",
		paramtype2 = "wallmounted",
		sunlight_propagates = true,
		walkable = true,
		groups = {choppy=2,dig_immediate=3},
		legacy_wallmounted = false,
		buildable_to = true,
		selection_box = {
			type = "wallmounted",
			wall_side = {-0.5, -0.5, -0.05, 0.5, 0.5, 0.05},
		}}
		
		minetest.register_node("ambilight:"..name.."_pane", pane)
		minetest.register_craft({
			output = "ambilight:"..name.."_pane 12",
			recipe = recipe
		})
		--[[]]--
end

--[[
	TODO: Doc API and defatult values
]]--
function ambilight.register_light(name, node, recipe)
	if not node.drawtype then
		node.drawtype="nodebox"
	end

	if not node.tiles then
		if not node.id then
			-- default texture
			node.tiles = {"ambilight_light1.png"} 
		else
			-- ambilight predefined id
			node.tiles = {"ambilight_light"..node.id..".png"}
		end
	end

	-- set default node description
	if not node.description then
		node.description = "Ambilight "..name
	end

  -- TODO: ????? remove ??????
	-- set default light intensity
	if not node.light_source then
		node.light_source = default.LIGHT_MAX - 5
	end

  --TODO: cambiar a click derecho y el punch para dyes
	if node.enable_interact then
		node.on_punch = function(pos, node, clicker, itemstack, pointed_thing)
		minetest.set_node(pos, {name = "ambilight:"..name.."_off"})
		end
	end
  
  
	if not node.groups then
		node.groups = {dig_immediate=2}--TODO: Set consistent group
	end
	
	if not node.sounds then
		node.sounds = default.node_sound_glass_defaults()
	end
	
	-- set default ambilight parametes
	if not node.paramtype then
		node.paramtype = "light"
	end
	
	if not node.sunlight_propagates then
		node.sunlight_propagates = true
	end
	
	minetest.register_node("ambilight:"..name, node)

	-- register recipe for block
	if recipe then
		ambilight.register_recipe(name, recipe)
	end

	--register panes for block
	if node.reg_pane then 
		ambilight.register_pane(name,node)
	end

	-- register stairs and slabs
	if node.reg_stair then
		ambilight.register_stairs(name,node)
	end

	-- set light off if is enabled
	if node.enable_interact then
	
		node_off = ambilight.clone(node)
		node_off.description = node.description.." off"
		node_off.light_source = 0
		node_off.drop = "ambilight:"..name
		node_off.groups = {dig_immediate=2, not_in_creative_inventory=1}
		node_off.on_punch = function(pos, node, clicker, itemstack, pointed_thing)
			minetest.set_node(pos, {name = "ambilight:"..name})	  
		end
		
		
		minetest.register_node("ambilight:"..name.."_off", node_off)
	end

end --register_light
