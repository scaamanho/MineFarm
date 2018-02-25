-- Wooden_Bucket init.lua
-- Copyright Duane Robertson (duane@duanerobertson.com), 2017
-- Distributed under the LGPLv2.1 (https://www.gnu.org/licenses/old-licenses/lgpl-2.1.en.html)


local function register_liquid_wood(source, itemname, inventory_image, name, groups)
	if not (source and itemname and inventory_image and name and type(source) == 'string' and type(itemname) == 'string' and type(inventory_image) == 'string') then
		return
	end

	inventory_image = inventory_image..'^wooden_bucket_overlay.png'
	minetest.register_craftitem(itemname, {
		description = name,
		inventory_image = inventory_image,
		stack_max = 1,
		liquids_pointable = true,
		groups = groups,

		on_place = function(itemstack, user, pointed_thing)
			if not (user and pointed_thing) then
				return
			end

			-- Must be pointing to node
			if pointed_thing.type ~= "node" then
				return
			end

			local node = minetest.get_node_or_nil(pointed_thing.under)
			local ndef = node and minetest.registered_nodes[node.name]

			-- Call on_rightclick if the pointed node defines it
			if ndef and ndef.on_rightclick and
				user and not user:get_player_control().sneak then
				return ndef.on_rightclick(pointed_thing.under, node, user, itemstack)
			end

			local lpos

			-- Check if pointing to a buildable node
			if ndef and ndef.buildable_to then
				-- buildable; replace the node
				lpos = pointed_thing.under
			else
				-- not buildable to; place the liquid above
				-- check if the node above can be replaced
				lpos = pointed_thing.above
				local node = minetest.get_node_or_nil(lpos)
				if not node then
					return
				end

				local above_ndef = node and minetest.registered_nodes[node.name]

				if not above_ndef or not above_ndef.buildable_to then
					-- do not remove the bucket with the liquid
					return itemstack
				end
			end

			if minetest.is_protected(lpos, user and user:get_player_name() or "") then
				return
			end

			minetest.set_node(lpos, {name = source})
			return ItemStack("wooden_bucket:bucket_wood_empty")
		end
	})
end

for fluid, def in pairs(bucket.liquids) do
	if not fluid:find('flowing') and not fluid:find('lava') and not fluid:find('molten') and not fluid:find('weightless') then
		local item_name = def.itemname:gsub('[^:]+:bucket', 'wooden_bucket:bucket_wood')
		local original = minetest.registered_items[def.itemname]
		if original and item_name and item_name ~= def.itemname then
			local new_name = original.description:gsub('Bucket', 'Wooden Bucket')
			local new_image = original.inventory_image
			register_liquid_wood(fluid, item_name, new_image, new_name, original.groups)
		end
	end
end

if minetest.get_modpath("thirsty") then

	minetest.register_craft({
		output = 'wooden_bucket:bucket_wood_empty 1',
		recipe = {
			{'thirsty:wooden_bowl', '', 'thirsty:wooden_bowl'},
			{'', 'thirsty:wooden_bowl', ''},
		}
	})

else

	minetest.register_craft({
		output = 'wooden_bucket:bucket_wood_empty 1',
		recipe = {
			{'group:wood', '', 'group:wood'},
			{'', 'group:wood', ''},
		}
	})

end

minetest.register_craftitem("wooden_bucket:bucket_wood_empty", {
	description = "Empty Wooden Bucket",
	inventory_image = "wooden_bucket.png",
	stack_max = 99,
	liquids_pointable = true,
	on_use = function(itemstack, user, pointed_thing)
		-- Must be pointing to node
		if not (user and pointed_thing and pointed_thing.type == "node") then
			return
		end

		-- Check if pointing to a liquid source
		local node = minetest.get_node(pointed_thing.under)
		if not node then
			return
		end

		local liquiddef = bucket.liquids[node.name]
		if not liquiddef or node.name ~= liquiddef.source then
			return
		end

		if minetest.is_protected(pointed_thing.under, user:get_player_name()) then
			return
		end

		if node and node.name:find('lava') or node.name:find('molten') then
			itemstack:set_count(itemstack:get_count() - 1)
			return itemstack
		end

		local item_count = user:get_wielded_item():get_count()

		-- default set to return filled bucket
		local giving_back = liquiddef.itemname:gsub('^[^:]+:bucket', 'wooden_bucket:bucket_wood')

		-- check if holding more than 1 empty bucket
		if item_count > 1 then

			-- if space in inventory add filled bucket, otherwise drop as item
			local inv = user:get_inventory()
			if inv:room_for_item("main", {name=giving_back}) then
				inv:add_item("main", giving_back)
			else
				local pos = user:getpos()
				pos.y = math.floor(pos.y + 0.5)
				minetest.add_item(pos, giving_back)
			end

			-- set to return empty buckets minus 1
			giving_back = "wooden_bucket:bucket_wood_empty "..tostring(item_count-1)

		end

		minetest.add_node(pointed_thing.under, {name="air"})

		return ItemStack(giving_back)
	end,
})
