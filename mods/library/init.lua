local bookshelf_formspec =
	"size[8,7;]" ..
	default.gui_bg ..
	default.gui_bg_img ..
	default.gui_slots ..
	"list[context;books;0,0.3;8,2;]" ..
	"list[current_player;main;0,2.85;8,1;]" ..
	"list[current_player;main;0,4.08;8,3;8]" ..
	"listring[context;books]" ..
	"listring[current_player;main]" ..
	default.get_hotbar_bg(0,2.85)

local function get_bookshelf_formspec(inv)
	local formspec = bookshelf_formspec
	local invlist = inv and inv:get_list("books")
	-- Inventory slots overlay
	local bx, by = 0, 0.3
	for i = 1, 16 do
		if i == 9 then
			bx = 0
			by = by + 1
		end
		if not invlist or invlist[i]:is_empty() then
			formspec = formspec ..
				"image[" .. bx .. "," .. by .. ";1,1;default_bookshelf_slot.png]"
		end
		bx = bx + 1
	end
	return formspec
end

minetest.register_node("library:bookshelf_1", {
	description = "Bookshelf",
	drawtype = "nodebox",
	tiles = {"default_wood.png",
			"default_wood.png",
			"default_wood.png",
			"default_wood.png",
			"default_wood.png",
			"library_bookshelf_1.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0, 0.5, 0.5, 0.5},
		},
	is_ground_content = false,
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
	sunlight_propagates = true,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_bookshelf_formspec(nil))
		local inv = meta:get_inventory()
		inv:set_size("books", 8 * 2)
	end,
	can_dig = function(pos,player)
		local inv = minetest.get_meta(pos):get_inventory()
		return inv:is_empty("books")
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack)
		if minetest.get_item_group(stack:get_name(), "book") ~= 0 then
			return stack:get_count()
		end
		return 0
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name() ..
			" moves stuff in bookshelf at " .. minetest.pos_to_string(pos))
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_bookshelf_formspec(meta:get_inventory()))
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() ..
			" moves stuff to bookshelf at " .. minetest.pos_to_string(pos))
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_bookshelf_formspec(meta:get_inventory()))
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() ..
			" takes stuff from bookshelf at " .. minetest.pos_to_string(pos))
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_bookshelf_formspec(meta:get_inventory()))
	end,
	on_blast = function(pos)
		local drops = {}
		default.get_inventory_drops(pos, "books", drops)
		drops[#drops+1] = "library:bookshelf_1"
		minetest.remove_node(pos)
		return drops
	end,
	on_place = function(itemstack, placer, pointed_thing)
		local stack = ItemStack("library:bookshelf_" .. math.random(1,4))
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("library:bookshelf_1 " ..
			itemstack:get_count() - (1 - ret:get_count()))
	end,
})

for i = 2, 4 do
minetest.register_node("library:bookshelf_"..i, {
	description = "Bookshelf",
	drawtype = "nodebox",
	tiles = {"default_wood.png",
			"default_wood.png",
			"default_wood.png",
			"default_wood.png",
			"default_wood.png",
			"library_bookshelf_"..i..".png"},
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0, 0.5, 0.5, 0.5},
		},
	is_ground_content = false,
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3, not_in_creative_inventory = 1},
	sounds = default.node_sound_wood_defaults(),
	sunlight_propagates = true,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_bookshelf_formspec(nil))
		local inv = meta:get_inventory()
		inv:set_size("books", 8 * 2)
	end,
	can_dig = function(pos,player)
		local inv = minetest.get_meta(pos):get_inventory()
		return inv:is_empty("books")
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack)
		if minetest.get_item_group(stack:get_name(), "book") ~= 0 then
			return stack:get_count()
		end
		return 0
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name() ..
			" moves stuff in bookshelf at " .. minetest.pos_to_string(pos))
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_bookshelf_formspec(meta:get_inventory()))
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() ..
			" moves stuff to bookshelf at " .. minetest.pos_to_string(pos))
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_bookshelf_formspec(meta:get_inventory()))
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() ..
			" takes stuff from bookshelf at " .. minetest.pos_to_string(pos))
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_bookshelf_formspec(meta:get_inventory()))
	end,
	on_blast = function(pos)
		local drops = {}
		default.get_inventory_drops(pos, "books", drops)
		drops[#drops+1] = "library:bookshelf_1"
		minetest.remove_node(pos)
		return drops
	end,
	drop = "library:bookshelf_1",
})
end

minetest.register_node("library:nonfiction_bookshelf_1", {
	description = "Nonfiction Bookshelf",
	drawtype = "nodebox",
	tiles = {"default_wood.png",
			"default_wood.png",
			"default_wood.png",
			"default_wood.png",
			"default_wood.png",
			"library_nonfiction_bookshelf_1.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0, 0.5, 0.5, 0.5},
		},
	is_ground_content = false,
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
	sunlight_propagates = true,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_bookshelf_formspec(nil))
		local inv = meta:get_inventory()
		inv:set_size("books", 8 * 2)
	end,
	can_dig = function(pos,player)
		local inv = minetest.get_meta(pos):get_inventory()
		return inv:is_empty("books")
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack)
		if minetest.get_item_group(stack:get_name(), "book") ~= 0 then
			return stack:get_count()
		end
		return 0
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name() ..
			" moves stuff in bookshelf at " .. minetest.pos_to_string(pos))
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_bookshelf_formspec(meta:get_inventory()))
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() ..
			" moves stuff to bookshelf at " .. minetest.pos_to_string(pos))
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_bookshelf_formspec(meta:get_inventory()))
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() ..
			" takes stuff from bookshelf at " .. minetest.pos_to_string(pos))
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_bookshelf_formspec(meta:get_inventory()))
	end,
	on_blast = function(pos)
		local drops = {}
		default.get_inventory_drops(pos, "books", drops)
		drops[#drops+1] = "library:bookshelf_1"
		minetest.remove_node(pos)
		return drops
	end,
	on_place = function(itemstack, placer, pointed_thing)
		local stack = ItemStack("library:nonfiction_bookshelf_" .. math.random(1,3))
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("library:nonfiction_bookshelf_1 " ..
			itemstack:get_count() - (1 - ret:get_count()))
	end,
})

for i = 2, 3 do
minetest.register_node("library:nonfiction_bookshelf_"..i, {
	description = "Nonfiction Bookshelf",
	drawtype = "nodebox",
	tiles = {"default_wood.png",
			"default_wood.png",
			"default_wood.png",
			"default_wood.png",
			"default_wood.png",
			"library_nonfiction_bookshelf_"..i..".png"},
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0, 0.5, 0.5, 0.5},
		},
	is_ground_content = false,
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3, not_in_creative_inventory = 1},
	sounds = default.node_sound_wood_defaults(),
	sunlight_propagates = true,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_bookshelf_formspec(nil))
		local inv = meta:get_inventory()
		inv:set_size("books", 8 * 2)
	end,
	can_dig = function(pos,player)
		local inv = minetest.get_meta(pos):get_inventory()
		return inv:is_empty("books")
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack)
		if minetest.get_item_group(stack:get_name(), "book") ~= 0 then
			return stack:get_count()
		end
		return 0
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name() ..
			" moves stuff in bookshelf at " .. minetest.pos_to_string(pos))
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_bookshelf_formspec(meta:get_inventory()))
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() ..
			" moves stuff to bookshelf at " .. minetest.pos_to_string(pos))
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_bookshelf_formspec(meta:get_inventory()))
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() ..
			" takes stuff from bookshelf at " .. minetest.pos_to_string(pos))
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_bookshelf_formspec(meta:get_inventory()))
	end,
	on_blast = function(pos)
		local drops = {}
		default.get_inventory_drops(pos, "books", drops)
		drops[#drops+1] = "library:nonfiction_bookshelf_1"
		minetest.remove_node(pos)
		return drops
	end,
	drop = "library:nonfiction_bookshelf_1",
})
end

minetest.register_node("library:empty_bookshelf_1", {
	description = "Old Bookshelf",
	drawtype = "nodebox",
	tiles = {"default_wood.png",
			"default_wood.png",
			"default_wood.png",
			"default_wood.png",
			"default_wood.png",
			"library_empty_bookshelf_1.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0, 0.5, 0.5, 0.5},
		},
	is_ground_content = false,
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
	sunlight_propagates = true,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_bookshelf_formspec(nil))
		local inv = meta:get_inventory()
		inv:set_size("books", 8 * 2)
	end,
	can_dig = function(pos,player)
		local inv = minetest.get_meta(pos):get_inventory()
		return inv:is_empty("books")
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack)
		if minetest.get_item_group(stack:get_name(), "book") ~= 0 then
			return stack:get_count()
		end
		return 0
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name() ..
			" moves stuff in bookshelf at " .. minetest.pos_to_string(pos))
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_bookshelf_formspec(meta:get_inventory()))
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() ..
			" moves stuff to bookshelf at " .. minetest.pos_to_string(pos))
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_bookshelf_formspec(meta:get_inventory()))
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() ..
			" takes stuff from bookshelf at " .. minetest.pos_to_string(pos))
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_bookshelf_formspec(meta:get_inventory()))
	end,
	on_blast = function(pos)
		local drops = {}
		default.get_inventory_drops(pos, "books", drops)
		drops[#drops+1] = "library:empty_bookshelf_1"
		minetest.remove_node(pos)
		return drops
	end,
	on_place = function(itemstack, placer, pointed_thing)
		local stack = ItemStack("library:empty_bookshelf_" .. math.random(1,6))
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("library:empty_bookshelf_1 " ..
			itemstack:get_count() - (1 - ret:get_count()))
	end,
})

for i = 2, 6 do
minetest.register_node("library:empty_bookshelf_"..i, {
	description = "Old Bookshelf",
	drawtype = "nodebox",
	tiles = {"default_wood.png",
			"default_wood.png",
			"default_wood.png",
			"default_wood.png",
			"default_wood.png",
			"library_empty_bookshelf_"..i..".png"},
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0, 0.5, 0.5, 0.5},
		},
	is_ground_content = false,
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3, not_in_creative_inventory = 1},
	sounds = default.node_sound_wood_defaults(),
	sunlight_propagates = true,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_bookshelf_formspec(nil))
		local inv = meta:get_inventory()
		inv:set_size("books", 8 * 2)
	end,
	can_dig = function(pos,player)
		local inv = minetest.get_meta(pos):get_inventory()
		return inv:is_empty("books")
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack)
		if minetest.get_item_group(stack:get_name(), "book") ~= 0 then
			return stack:get_count()
		end
		return 0
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name() ..
			" moves stuff in bookshelf at " .. minetest.pos_to_string(pos))
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_bookshelf_formspec(meta:get_inventory()))
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() ..
			" moves stuff to bookshelf at " .. minetest.pos_to_string(pos))
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_bookshelf_formspec(meta:get_inventory()))
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() ..
			" takes stuff from bookshelf at " .. minetest.pos_to_string(pos))
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_bookshelf_formspec(meta:get_inventory()))
	end,
	on_blast = function(pos)
		local drops = {}
		default.get_inventory_drops(pos, "books", drops)
		drops[#drops+1] = "library:empty_bookshelf_1"
		minetest.remove_node(pos)
		return drops
	end,
	drop = "library:empty_bookshelf_1",
})
end

minetest.register_node("library:empty_bookshelf", {
	description = "Empty Bookshelf",
	drawtype = "nodebox",
	tiles = {"default_wood.png",
			"default_wood.png",
			"default_wood.png",
			"default_wood.png",
			"default_wood.png",
			"library_empty_bookshelf_4.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0, 0.5, 0.5, 0.5},
		},
	is_ground_content = false,
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
	sunlight_propagates = true,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_bookshelf_formspec(nil))
		local inv = meta:get_inventory()
		inv:set_size("books", 8 * 2)
	end,
	can_dig = function(pos,player)
		local inv = minetest.get_meta(pos):get_inventory()
		return inv:is_empty("books")
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack)
		if minetest.get_item_group(stack:get_name(), "book") ~= 0 then
			return stack:get_count()
		end
		return 0
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name() ..
			" moves stuff in bookshelf at " .. minetest.pos_to_string(pos))
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_bookshelf_formspec(meta:get_inventory()))
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() ..
			" moves stuff to bookshelf at " .. minetest.pos_to_string(pos))
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_bookshelf_formspec(meta:get_inventory()))
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() ..
			" takes stuff from bookshelf at " .. minetest.pos_to_string(pos))
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_bookshelf_formspec(meta:get_inventory()))
	end,
	on_blast = function(pos)
		local drops = {}
		default.get_inventory_drops(pos, "books", drops)
		drops[#drops+1] = "library:empty_bookshelf"
		minetest.remove_node(pos)
		return drops
	end,
})

minetest.register_node("library:empty_shelf", {
	description = "Empty Shelf",
	drawtype = "nodebox",
	tiles = {"default_wood.png",
			"default_wood.png",
			"default_wood.png",
			"default_wood.png",
			"default_wood.png",
			"library_empty_shelf_1.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0, 0.5, 0.5, 0.5},
		},
	is_ground_content = false,
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
	sunlight_propagates = true,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_bookshelf_formspec(nil))
		local inv = meta:get_inventory()
		inv:set_size("books", 8 * 2)
	end,
	can_dig = function(pos,player)
		local inv = minetest.get_meta(pos):get_inventory()
		return inv:is_empty("books")
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack)
		if minetest.get_item_group(stack:get_name(), "book") ~= 0 then
			return stack:get_count()
		end
		return 0
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name() ..
			" moves stuff in bookshelf at " .. minetest.pos_to_string(pos))
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_bookshelf_formspec(meta:get_inventory()))
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() ..
			" moves stuff to bookshelf at " .. minetest.pos_to_string(pos))
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_bookshelf_formspec(meta:get_inventory()))
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() ..
			" takes stuff from bookshelf at " .. minetest.pos_to_string(pos))
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_bookshelf_formspec(meta:get_inventory()))
	end,
	on_blast = function(pos)
		local drops = {}
		default.get_inventory_drops(pos, "books", drops)
		drops[#drops+1] = "library:empty_shelf"
		minetest.remove_node(pos)
		return drops
	end,
})

minetest.register_node("library:empty_shelf_2", {
	description = "Empty Shelf",
	drawtype = "nodebox",
	tiles = {"default_wood.png",
			"default_wood.png",
			"library_empty_shelf_1.png",
			"library_empty_shelf_1.png",
			"default_wood.png",
			"library_empty_shelf_2.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, 0, 0.5, 0.5, 0.5},
		},
	is_ground_content = false,
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
	sunlight_propagates = true,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_bookshelf_formspec(nil))
		local inv = meta:get_inventory()
		inv:set_size("books", 8 * 2)
	end,
	can_dig = function(pos,player)
		local inv = minetest.get_meta(pos):get_inventory()
		return inv:is_empty("books")
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack)
		if minetest.get_item_group(stack:get_name(), "book") ~= 0 then
			return stack:get_count()
		end
		return 0
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name() ..
			" moves stuff in bookshelf at " .. minetest.pos_to_string(pos))
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_bookshelf_formspec(meta:get_inventory()))
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() ..
			" moves stuff to bookshelf at " .. minetest.pos_to_string(pos))
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_bookshelf_formspec(meta:get_inventory()))
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() ..
			" takes stuff from bookshelf at " .. minetest.pos_to_string(pos))
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_bookshelf_formspec(meta:get_inventory()))
	end,
	on_blast = function(pos)
		local drops = {}
		default.get_inventory_drops(pos, "books", drops)
		drops[#drops+1] = "library:empty_shelf_2"
		minetest.remove_node(pos)
		return drops
	end,
})

minetest.register_node("library:antique_bookshelf_1", {
	description = "Antique Bookshelf Top",
	tiles = {"default_wood.png",
			"default_wood.png",
			"default_wood.png",
			"default_wood.png",
			"default_wood.png",
			"library_antique_bookshelf_1.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_bookshelf_formspec(nil))
		local inv = meta:get_inventory()
		inv:set_size("books", 8 * 2)
	end,
	can_dig = function(pos,player)
		local inv = minetest.get_meta(pos):get_inventory()
		return inv:is_empty("books")
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack)
		if minetest.get_item_group(stack:get_name(), "book") ~= 0 then
			return stack:get_count()
		end
		return 0
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name() ..
			" moves stuff in bookshelf at " .. minetest.pos_to_string(pos))
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_bookshelf_formspec(meta:get_inventory()))
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() ..
			" moves stuff to bookshelf at " .. minetest.pos_to_string(pos))
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_bookshelf_formspec(meta:get_inventory()))
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() ..
			" takes stuff from bookshelf at " .. minetest.pos_to_string(pos))
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_bookshelf_formspec(meta:get_inventory()))
	end,
	on_blast = function(pos)
		local drops = {}
		default.get_inventory_drops(pos, "books", drops)
		drops[#drops+1] = "library:antique_bookshelf_1"
		minetest.remove_node(pos)
		return drops
	end,
	on_place = function(itemstack, placer, pointed_thing)
		local stack = ItemStack("library:antique_bookshelf_" .. math.random(1,2))
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("library:antique_bookshelf_1 " ..
			itemstack:get_count() - (1 - ret:get_count()))
	end,
})

minetest.register_node("library:antique_bookshelf_2", {
	description = "Antique Bookshelf",
	tiles = {"default_wood.png",
			"default_wood.png",
			"default_wood.png",
			"default_wood.png",
			"default_wood.png",
			"library_antique_bookshelf_2.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3, not_in_creative_inventory = 1},
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_bookshelf_formspec(nil))
		local inv = meta:get_inventory()
		inv:set_size("books", 8 * 2)
	end,
	can_dig = function(pos,player)
		local inv = minetest.get_meta(pos):get_inventory()
		return inv:is_empty("books")
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack)
		if minetest.get_item_group(stack:get_name(), "book") ~= 0 then
			return stack:get_count()
		end
		return 0
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name() ..
			" moves stuff in bookshelf at " .. minetest.pos_to_string(pos))
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_bookshelf_formspec(meta:get_inventory()))
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() ..
			" moves stuff to bookshelf at " .. minetest.pos_to_string(pos))
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_bookshelf_formspec(meta:get_inventory()))
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() ..
			" takes stuff from bookshelf at " .. minetest.pos_to_string(pos))
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_bookshelf_formspec(meta:get_inventory()))
	end,
	on_blast = function(pos)
		local drops = {}
		default.get_inventory_drops(pos, "books", drops)
		drops[#drops+1] = "library:antique_bookshelf_1"
		minetest.remove_node(pos)
		return drops
	end,
	drop = "library:antique_bookshelf_1",
})

minetest.register_node("library:antique_bookshelf_3", {
	description = "Antique Bookshelf",
	tiles = {"default_wood.png",
			"default_wood.png",
			"default_wood.png",
			"default_wood.png",
			"default_wood.png",
			"library_antique_bookshelf_3.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_bookshelf_formspec(nil))
		local inv = meta:get_inventory()
		inv:set_size("books", 8 * 2)
	end,
	can_dig = function(pos,player)
		local inv = minetest.get_meta(pos):get_inventory()
		return inv:is_empty("books")
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack)
		if minetest.get_item_group(stack:get_name(), "book") ~= 0 then
			return stack:get_count()
		end
		return 0
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name() ..
			" moves stuff in bookshelf at " .. minetest.pos_to_string(pos))
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_bookshelf_formspec(meta:get_inventory()))
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() ..
			" moves stuff to bookshelf at " .. minetest.pos_to_string(pos))
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_bookshelf_formspec(meta:get_inventory()))
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() ..
			" takes stuff from bookshelf at " .. minetest.pos_to_string(pos))
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_bookshelf_formspec(meta:get_inventory()))
	end,
	on_blast = function(pos)
		local drops = {}
		default.get_inventory_drops(pos, "books", drops)
		drops[#drops+1] = "library:antique_bookshelf_3"
		minetest.remove_node(pos)
		return drops
	end,
	on_place = function(itemstack, placer, pointed_thing)
		local stack = ItemStack("library:antique_bookshelf_" .. math.random(3,4))
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("library:antique_bookshelf_3 " ..
			itemstack:get_count() - (1 - ret:get_count()))
	end,
})

minetest.register_node("library:antique_bookshelf_4", {
	description = "Antique Bookshelf",
	tiles = {"default_wood.png",
			"default_wood.png",
			"default_wood.png",
			"default_wood.png",
			"default_wood.png",
			"library_antique_bookshelf_4.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3, not_in_creative_inventory = 1},
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_bookshelf_formspec(nil))
		local inv = meta:get_inventory()
		inv:set_size("books", 8 * 2)
	end,
	can_dig = function(pos,player)
		local inv = minetest.get_meta(pos):get_inventory()
		return inv:is_empty("books")
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack)
		if minetest.get_item_group(stack:get_name(), "book") ~= 0 then
			return stack:get_count()
		end
		return 0
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name() ..
			" moves stuff in bookshelf at " .. minetest.pos_to_string(pos))
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_bookshelf_formspec(meta:get_inventory()))
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() ..
			" moves stuff to bookshelf at " .. minetest.pos_to_string(pos))
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_bookshelf_formspec(meta:get_inventory()))
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() ..
			" takes stuff from bookshelf at " .. minetest.pos_to_string(pos))
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", get_bookshelf_formspec(meta:get_inventory()))
	end,
	on_blast = function(pos)
		local drops = {}
		default.get_inventory_drops(pos, "books", drops)
		drops[#drops+1] = "library:antique_bookshelf_3"
		minetest.remove_node(pos)
		return drops
	end,
	drop = "library:antique_bookshelf_3",
})

minetest.register_node("library:corner", {
	description = "Corner",
	drawtype = "nodebox",
	tiles = {"default_wood.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, 0, 0.5, 0.5, 0.5},
				{-0.5, -0.5, -0.5, 0, 0.5, 0.5},
			}
		},
	is_ground_content = false,
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
	sunlight_propagates = true,
})

minetest.register_node("library:inside_corner", {
	description = "Inside Corner",
	drawtype = "nodebox",
	tiles = {"default_wood.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, 0, 0, 0.5, 0.5},
			}
		},
	is_ground_content = false,
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
	sunlight_propagates = true,
})

local CATALOGUE_FORMNAME = "library:catalogue_form"

local player_catalogue = {}

minetest.register_node("library:card_catalogue", {
	description = "Card Catalogue",
	tiles = {"library_card_catalogue_top.png",
			"library_card_catalogue_top.png",
			"library_card_catalogue_top.png",
			"library_card_catalogue_top.png",
			"library_card_catalogue_top.png",
			"library_card_catalogue.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 3},
	sounds = default.node_sound_wood_defaults(),
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
			local meta = minetest.get_meta(pos)
			local player_name = clicker:get_player_name()
			local title = meta:get_string("title") or ""
			local text1 = meta:get_string("text1") or ""
			local text2 = meta:get_string("text2") or ""
			local text3 = meta:get_string("text3") or ""
			local text4 = meta:get_string("text4") or ""
			local text5 = meta:get_string("text5") or ""
			local text6 = meta:get_string("text6") or ""
			local text7 = meta:get_string("text7") or ""
			local text8 = meta:get_string("text8") or ""
			local text9 = meta:get_string("text9") or ""
			local text10 = meta:get_string("text10") or ""
			local text11 = meta:get_string("text11") or ""
			local text12 = meta:get_string("text12") or ""
			local text13 = meta:get_string("text13") or ""
			local text14 = meta:get_string("text14") or ""
			local text15 = meta:get_string("text15") or ""
			local text16 = meta:get_string("text16") or ""
			local text17 = meta:get_string("text17") or ""
			local text18 = meta:get_string("text18") or ""
			local text19 = meta:get_string("text19") or ""
			local text20 = meta:get_string("text20") or ""
			local text21 = meta:get_string("text21") or ""
			local text22 = meta:get_string("text22") or ""
			local text23 = meta:get_string("text23") or ""
			local text24 = meta:get_string("text24") or ""
			local text25 = meta:get_string("text25") or ""
			local text26 = meta:get_string("text26") or ""
			local text27 = meta:get_string("text27") or ""
			local text28 = meta:get_string("text28") or ""
			local text29 = meta:get_string("text29") or ""
			local text30 = meta:get_string("text30") or ""
			local text31 = meta:get_string("text31") or ""
			local text32 = meta:get_string("text32") or ""
			local text33 = meta:get_string("text33") or ""
			local text34 = meta:get_string("text34") or ""
			local text35 = meta:get_string("text35") or ""
			local text36 = meta:get_string("text36") or ""
			local text37 = meta:get_string("text37") or ""
			local text38 = meta:get_string("text38") or ""
			local text39 = meta:get_string("text39") or ""
			local text40 = meta:get_string("text40") or ""
			local text41 = meta:get_string("text41") or ""
			local text42 = meta:get_string("text42") or ""
			local text43 = meta:get_string("text43") or ""
			local text44 = meta:get_string("text44") or ""
			local text45 = meta:get_string("text45") or ""
			local text46 = meta:get_string("text46") or ""
			local text47 = meta:get_string("text47") or ""
			local owner = meta:get_string("owner") or ""
			local formspec
			if owner == "" or owner == player_name then
				formspec = "size[16,8]"..default.gui_bg..default.gui_bg_img..
					"field[0.5,1;4.5,0;title;Description;"..
						minetest.formspec_escape(title).."]"..
					"field[7,1;1,0;text1;Col.;"..
						minetest.formspec_escape(text1).."]"..
					"field[6,1;1,0;text2;Row.;"..
						minetest.formspec_escape(text2).."]"..
					"field[5,1;1,0;text3;Sec.;"..
						minetest.formspec_escape(text3).."]"..
					
					"field[0.5,2;4.5,0;text4;;"..
						minetest.formspec_escape(text4).."]"..
					"field[7,2;1,0;text5;;"..
						minetest.formspec_escape(text5).."]"..
					"field[6,2;1,0;text6;;"..
						minetest.formspec_escape(text6).."]"..
					"field[5,2;1,0;text7;;"..
						minetest.formspec_escape(text7).."]"..
					
					"field[0.5,3;4.5,0;text8;;"..
						minetest.formspec_escape(text8).."]"..
					"field[7,3;1,0;text9;;"..
						minetest.formspec_escape(text9).."]"..
					"field[6,3;1,0;text10;;"..
						minetest.formspec_escape(text10).."]"..
					"field[5,3;1,0;text11;;"..
						minetest.formspec_escape(text11).."]"..
					
					"field[0.5,4;4.5,0;text12;;"..
						minetest.formspec_escape(text12).."]"..
					"field[7,4;1,0;text13;;"..
						minetest.formspec_escape(text13).."]"..
					"field[6,4;1,0;text14;;"..
						minetest.formspec_escape(text14).."]"..
					"field[5,4;1,0;text15;;"..
						minetest.formspec_escape(text15).."]"..
					
					"field[0.5,5;4.5,0;text16;;"..
						minetest.formspec_escape(text16).."]"..
					"field[7,5;1,0;text17;;"..
						minetest.formspec_escape(text17).."]"..
					"field[6,5;1,0;text18;;"..
						minetest.formspec_escape(text18).."]"..
					"field[5,5;1,0;text19;;"..
						minetest.formspec_escape(text19).."]"..
					
					"field[0.5,6;4.5,0;text20;;"..
						minetest.formspec_escape(text20).."]"..
					"field[7,6;1,0;text21;;"..
						minetest.formspec_escape(text21).."]"..
					"field[6,6;1,0;text22;;"..
						minetest.formspec_escape(text22).."]"..
					"field[5,6;1,0;text23;;"..
						minetest.formspec_escape(text23).."]"..
					
					"field[8.5,1;4.5,0;text24;Description;"..
						minetest.formspec_escape(text24).."]"..
					"field[15,1;1,0;text25;Sec.;"..
						minetest.formspec_escape(text25).."]"..
					"field[14,1;1,0;text26;Row.;"..
						minetest.formspec_escape(text26).."]"..
					"field[13,1;1,0;text27;Col.;"..
						minetest.formspec_escape(text27).."]"..
					
					"field[8.5,2;4.5,0;text28;;"..
						minetest.formspec_escape(text28).."]"..
					"field[15,2;1,0;text29;;"..
						minetest.formspec_escape(text29).."]"..
					"field[14,2;1,0;text30;;"..
						minetest.formspec_escape(text30).."]"..
					"field[13,2;1,0;text31;;"..
						minetest.formspec_escape(text31).."]"..
					
					"field[8.5,3;4.5,0;text32;;"..
						minetest.formspec_escape(text32).."]"..
					"field[15,3;1,0;text33;;"..
						minetest.formspec_escape(text33).."]"..
					"field[14,3;1,0;text34;;"..
						minetest.formspec_escape(text34).."]"..
					"field[13,3;1,0;text35;;"..
						minetest.formspec_escape(text35).."]"..
					
					"field[8.5,4;4.5,0;text36;;"..
						minetest.formspec_escape(text36).."]"..
					"field[15,4;1,0;text37;;"..
						minetest.formspec_escape(text37).."]"..
					"field[14,4;1,0;text38;;"..
						minetest.formspec_escape(text38).."]"..
					"field[13,4;1,0;text39;;"..
						minetest.formspec_escape(text39).."]"..
					
					"field[8.5,5;4.5,0;text40;;"..
						minetest.formspec_escape(text40).."]"..
					"field[15,5;1,0;text41;;"..
						minetest.formspec_escape(text41).."]"..
					"field[14,5;1,0;text42;;"..
						minetest.formspec_escape(text42).."]"..
					"field[13,5;1,0;text43;;"..
						minetest.formspec_escape(text43).."]"..
					
					"field[8.5,6;4.5,0;text44;;"..
						minetest.formspec_escape(text44).."]"..
					"field[15,6;1,0;text45;;"..
						minetest.formspec_escape(text45).."]"..
					"field[14,6;1,0;text46;;"..
						minetest.formspec_escape(text46).."]"..
					"field[13,6;1,0;text47;;"..
						minetest.formspec_escape(text47).."]"..
					------------------------------------------------------
					
					"button_exit[6.5,7;3,1;save;Save]"
			else
				formspec = "size[16,8]"..default.gui_bg..default.gui_bg_img..
				"button_exit[6.5,7;3,1;close;Exit]"..
					"field[0.5,1;4.5,0;title;Description;"..
						minetest.formspec_escape(title).."]"..
					"field[7,1;1,0;text1;Col.;"..
						minetest.formspec_escape(text1).."]"..
					"field[6,1;1,0;text2;Row.;"..
						minetest.formspec_escape(text2).."]"..
					"field[5,1;1,0;text3;Sec.;"..
						minetest.formspec_escape(text3).."]"..
					
					"field[0.5,2;4.5,0;text4;;"..
						minetest.formspec_escape(text4).."]"..
					"field[7,2;1,0;text5;;"..
						minetest.formspec_escape(text5).."]"..
					"field[6,2;1,0;text6;;"..
						minetest.formspec_escape(text6).."]"..
					"field[5,2;1,0;text7;;"..
						minetest.formspec_escape(text7).."]"..
					
					"field[0.5,3;4.5,0;text8;;"..
						minetest.formspec_escape(text8).."]"..
					"field[7,3;1,0;text9;;"..
						minetest.formspec_escape(text9).."]"..
					"field[6,3;1,0;text10;;"..
						minetest.formspec_escape(text10).."]"..
					"field[5,3;1,0;text11;;"..
						minetest.formspec_escape(text11).."]"..
					
					"field[0.5,4;4.5,0;text12;;"..
						minetest.formspec_escape(text12).."]"..
					"field[7,4;1,0;text13;;"..
						minetest.formspec_escape(text13).."]"..
					"field[6,4;1,0;text14;;"..
						minetest.formspec_escape(text14).."]"..
					"field[5,4;1,0;text15;;"..
						minetest.formspec_escape(text15).."]"..
					
					"field[0.5,5;4.5,0;text16;;"..
						minetest.formspec_escape(text16).."]"..
					"field[7,5;1,0;text17;;"..
						minetest.formspec_escape(text17).."]"..
					"field[6,5;1,0;text18;;"..
						minetest.formspec_escape(text18).."]"..
					"field[5,5;1,0;text19;;"..
						minetest.formspec_escape(text19).."]"..
					
					"field[0.5,6;4.5,0;text20;;"..
						minetest.formspec_escape(text20).."]"..
					"field[7,6;1,0;text21;;"..
						minetest.formspec_escape(text21).."]"..
					"field[6,6;1,0;text22;;"..
						minetest.formspec_escape(text22).."]"..
					"field[5,6;1,0;text23;;"..
						minetest.formspec_escape(text23).."]"..
					
					"field[8.5,1;4.5,0;text24;Description;"..
						minetest.formspec_escape(text24).."]"..
					"field[15,1;1,0;text25;Sec.;"..
						minetest.formspec_escape(text25).."]"..
					"field[14,1;1,0;text26;Row.;"..
						minetest.formspec_escape(text26).."]"..
					"field[13,1;1,0;text27;Col.;"..
						minetest.formspec_escape(text27).."]"..
					
					"field[8.5,2;4.5,0;text28;;"..
						minetest.formspec_escape(text28).."]"..
					"field[15,2;1,0;text29;;"..
						minetest.formspec_escape(text29).."]"..
					"field[14,2;1,0;text30;;"..
						minetest.formspec_escape(text30).."]"..
					"field[13,2;1,0;text31;;"..
						minetest.formspec_escape(text31).."]"..
					
					"field[8.5,3;4.5,0;text32;;"..
						minetest.formspec_escape(text32).."]"..
					"field[15,3;1,0;text33;;"..
						minetest.formspec_escape(text33).."]"..
					"field[14,3;1,0;text34;;"..
						minetest.formspec_escape(text34).."]"..
					"field[13,3;1,0;text35;;"..
						minetest.formspec_escape(text35).."]"..
					
					"field[8.5,4;4.5,0;text36;;"..
						minetest.formspec_escape(text36).."]"..
					"field[15,4;1,0;text37;;"..
						minetest.formspec_escape(text37).."]"..
					"field[14,4;1,0;text38;;"..
						minetest.formspec_escape(text38).."]"..
					"field[13,4;1,0;text39;;"..
						minetest.formspec_escape(text39).."]"..
					
					"field[8.5,5;4.5,0;text40;;"..
						minetest.formspec_escape(text40).."]"..
					"field[15,5;1,0;text41;;"..
						minetest.formspec_escape(text41).."]"..
					"field[14,5;1,0;text42;;"..
						minetest.formspec_escape(text42).."]"..
					"field[13,5;1,0;text43;;"..
						minetest.formspec_escape(text43).."]"..
					
					"field[8.5,6;4.5,0;text44;;"..
						minetest.formspec_escape(text44).."]"..
					"field[15,6;1,0;text45;;"..
						minetest.formspec_escape(text45).."]"..
					"field[14,6;1,0;text46;;"..
						minetest.formspec_escape(text46).."]"..
					"field[13,6;1,0;text47;;"..
						minetest.formspec_escape(text47).."]"
			end
			player_catalogue[player_name] = pos
			minetest.show_formspec(player_name, CATALOGUE_FORMNAME, formspec)
			return itemstack
		end,
})

minetest.register_on_player_receive_fields(function(player, form_name, fields)
	if form_name ~= CATALOGUE_FORMNAME or not fields.save then
		return
	end
	local player_name = player:get_player_name()
	local pos = player_catalogue[player_name]
	if not pos then return end
	local meta = minetest.get_meta(pos)
	meta:set_string("title", fields.title or "")
	meta:set_string("text1", fields.text1 or "")
	meta:set_string("text2", fields.text2 or "")
	meta:set_string("text3", fields.text3 or "")
	meta:set_string("text4", fields.text4 or "")
	meta:set_string("text5", fields.text5 or "")
	meta:set_string("text6", fields.text6 or "")
	meta:set_string("text7", fields.text7 or "")
	meta:set_string("text8", fields.text8 or "")
	meta:set_string("text9", fields.text9 or "")
	meta:set_string("text10", fields.text10 or "")
	meta:set_string("text11", fields.text11 or "")
	meta:set_string("text12", fields.text12 or "")
	meta:set_string("text13", fields.text13 or "")
	meta:set_string("text14", fields.text14 or "")
	meta:set_string("text15", fields.text15 or "")
	meta:set_string("text16", fields.text16 or "")
	meta:set_string("text17", fields.text17 or "")
	meta:set_string("text18", fields.text18 or "")
	meta:set_string("text19", fields.text19 or "")
	meta:set_string("text20", fields.text20 or "")
	meta:set_string("text21", fields.text21 or "")
	meta:set_string("text22", fields.text22 or "")
	meta:set_string("text23", fields.text23 or "")
	meta:set_string("text24", fields.text24 or "")
	meta:set_string("text25", fields.text25 or "")
	meta:set_string("text26", fields.text26 or "")
	meta:set_string("text27", fields.text27 or "")
	meta:set_string("text28", fields.text28 or "")
	meta:set_string("text29", fields.text29 or "")
	meta:set_string("text30", fields.text30 or "")
	meta:set_string("text31", fields.text31 or "")
	meta:set_string("text32", fields.text32 or "")
	meta:set_string("text33", fields.text33 or "")
	meta:set_string("text34", fields.text34 or "")
	meta:set_string("text35", fields.text35 or "")
	meta:set_string("text36", fields.text36 or "")
	meta:set_string("text37", fields.text37 or "")
	meta:set_string("text38", fields.text38 or "")
	meta:set_string("text39", fields.text39 or "")
	meta:set_string("text40", fields.text40 or "")
	meta:set_string("text41", fields.text41 or "")
	meta:set_string("text42", fields.text42 or "")
	meta:set_string("text43", fields.text43 or "")
	meta:set_string("text44", fields.text44 or "")
	meta:set_string("text45", fields.text45 or "")
	meta:set_string("text46", fields.text46 or "")
	meta:set_string("text47", fields.text47 or "")
	meta:set_string("owner", player_name)
	minetest.log("action", "@1 has written in a card catalogue (title: \"@2\"): \"@3\" at location @4",
			player:get_player_name(), fields.title, fields.text1, fields.text2, fields.text3, fields.text4, fields.text5, fields.text6, fields.text7, fields.text8, fields.text9,
									fields.text10, fields.text11, fields.text12, fields.text13, fields.text14, fields.text15, fields.text16, fields.text17, fields.text18, fields.text19,
									fields.text20, fields.text21, fields.text22, fields.text23, fields.text24, fields.text25, fields.text26, fields.text27, fields.text28, fields.text29,
									fields.text30, fields.text31, fields.text32, fields.text33, fields.text34, fields.text35, fields.text36, fields.text37, fields.text38, fields.text39,
									fields.text40, fields.text41, fields.text42, fields.text43, fields.text44, fields.text45, fields.text46, fields.text47,
									minetest.pos_to_string(player:getpos()))
end)

local color = {
	"Red",
	"Green",
	"Cyan",
	"Purple",
	"Black",
	"Orange",
	"Brown"
}

for c in ipairs(color) do
	local color = color[c]

local lpp = 14 -- Lines per book's page
local function book_on_use(itemstack, user)
	local player_name = user:get_player_name()
	local meta = itemstack:get_meta()
	local title, text, owner = "", "", player_name
	local page, page_max, lines, string = 1, 1, {}, ""

	-- Backwards compatibility
	local old_data = minetest.deserialize(itemstack:get_metadata())
	if old_data then
		meta:from_table({ fields = old_data })
	end

	local data = meta:to_table().fields

	if data.owner then
		title = data.title
		text = data.text
		owner = data.owner

		for str in (text .. "\n"):gmatch("([^\n]*)[\n]") do
			lines[#lines+1] = str
		end

		if data.page then
			page = data.page
			page_max = data.page_max

			for i = ((lpp * page) - lpp) + 1, lpp * page do
				if not lines[i] then break end
				string = string .. lines[i] .. "\n"
			end
		end
	end

	local formspec
	if owner == player_name then
		formspec = "size[8,8]" .. default.gui_bg ..
			default.gui_bg_img ..
			"field[0.5,1;7.5,0;title;Title:;" ..
				minetest.formspec_escape(title) .. "]" ..
			"textarea[0.5,1.5;7.5,7;text;Contents:;" ..
				minetest.formspec_escape(text) .. "]" ..
			"button_exit[2.5,7.5;3,1;save;Save]"
	else
		formspec = "size[8,8]" .. default.gui_bg ..
			default.gui_bg_img ..
			"label[0.5,0.5;by " .. owner .. "]" ..
			"tablecolumns[color;text]" ..
			"tableoptions[background=#00000000;highlight=#00000000;border=false]" ..
			"table[0.4,0;7,0.5;title;#FFFF00," .. minetest.formspec_escape(title) .. "]" ..
			"textarea[0.5,1.5;7.5,7;;" ..
				minetest.formspec_escape(string ~= "" and string or text) .. ";]" ..
			"button[2.4,7.6;0.8,0.8;book_prev;<]" ..
			"label[3.2,7.7;Page " .. page .. " of " .. page_max .. "]" ..
			"button[4.9,7.6;0.8,0.8;book_next;>]"
	end

	minetest.show_formspec(player_name, "library:book_"..color, formspec)
	return itemstack
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "library:book_"..color then return end
	local inv = player:get_inventory()
	local stack = player:get_wielded_item()

	if fields.save and fields.title ~= "" and fields.text ~= "" then
		local new_stack, data
		if stack:get_name() ~= "library:book_"..color.."_written" then
			local count = stack:get_count()
			if count == 1 then
				stack:set_name("library:book_"..color.."_written")
			else
				stack:set_count(count - 1)
				new_stack = ItemStack("library:book_"..color.."_written")
			end
		else
			data = stack:get_meta():to_table().fields
		end

		if data and data.owner and data.owner ~= player:get_player_name() then
			return
		end

		if not data then data = {} end
		data.title = fields.title
		data.owner = player:get_player_name()
		data.description = "\""..fields.title.."\" by "..data.owner
		data.text = fields.text
		data.text_len = #data.text
		data.page = 1
		data.page_max = math.ceil((#data.text:gsub("[^\n]", "") + 1) / lpp)

		if new_stack then
			new_stack:get_meta():from_table({ fields = data })
			if inv:room_for_item("main", new_stack) then
				inv:add_item("main", new_stack)
			else
				minetest.add_item(player:getpos(), new_stack)
			end
		else
			stack:get_meta():from_table({ fields = data })
		end

	elseif fields.book_next or fields.book_prev then
		local data = stack:get_meta():to_table().fields
		if not data or not data.page then
			return
		end

		data.page = tonumber(data.page)
		data.page_max = tonumber(data.page_max)

		if fields.book_next then
			data.page = data.page + 1
			if data.page > data.page_max then
				data.page = 1
			end
		else
			data.page = data.page - 1
			if data.page == 0 then
				data.page = data.page_max
			end
		end

		stack:get_meta():from_table({fields = data})
		stack = book_on_use(stack, player)
	end

	-- Update stack
	player:set_wielded_item(stack)
end)

minetest.register_craftitem("library:book_"..color, {
	description = color.." Book",
	inventory_image = "library_book_"..color..".png",
	groups = {book = 1, flammable = 3},
	on_use = book_on_use,
})

minetest.register_craftitem("library:book_"..color.."_written", {
	description = color.." Book With Text",
	inventory_image = "library_book_"..color.."_written.png",
	groups = {book = 1, not_in_creative_inventory = 1, flammable = 3},
	stack_max = 1,
	on_use = book_on_use,
})

minetest.register_craftitem("library:wood_pulp", {
	description = "Wood Pulp",
	inventory_image = "library_wood_pulp.png",
	groups = {flammable = 3},
})

end

dofile(minetest.get_modpath("library").."/crafting.lua")