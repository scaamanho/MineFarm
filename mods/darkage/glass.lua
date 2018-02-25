--[[
	Medival glasses.
	The glasses can be colorized using dye. 
	Colorization requires unifieddyes installed.

	Special thanks to Semmett9 for the glass textures.
]]

minetest.register_node("darkage:glass", {
	description = "Clean Medieval Glass",
	drawtype = "glasslike",
	tiles = {"darkage_glass.png"},
	use_texture_alpha=false,
	paramtype = "light",
	sunlight_propagates = true,
	groups = {cracky = 3, oddly_breakable_by_hand = 3, not_cuttable=1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_craft({
	output = "darkage:glass 8",
	recipe = {
		{"default:glass", "default:steel_ingot", "default:glass"},
		{"default:steel_ingot", "default:glass", "default:steel_ingot"},
		{"default:glass", "default:steel_ingot", "default:glass"},
	}
})

if minetest.get_modpath("unifieddyes") then
	minetest.register_node("darkage:milk_glass", {
		description = "Milky Medieval Glass (Good for colorization)",
		drawtype = "glasslike",
		tiles = {"darkage_milk_glass.png"},
		use_texture_alpha=true,
		paramtype = "light",
		paramtype2 = "color",
		palette = "unifieddyes_palette.png",
		sunlight_propagates = true,
		groups = {cracky = 3, oddly_breakable_by_hand = 3, not_cuttable=1, ud_param2_colorable = 1},
		sounds = default.node_sound_glass_defaults(),
		after_dig_node = unifieddyes.after_dig_node
	})

-- Craft
	minetest.register_craft({
		output = "darkage:milk_glass 1",
		type = "shapeless",
		recipe = {"darkage:glass", "dye:white"}
	})

-- Recycling
	minetest.register_craft({
		output = "darkage:glass 1",
		recipe = {{"darkage:milk_glass"}}
	})
end

--[[
	Glow Glass
]]
minetest.register_node("darkage:glow_glass", {
	description = "Medieval Glow Glass",
	drawtype = "glasslike",
	tiles = {"darkage_glass.png"},
	use_texture_alpha=true,
	paramtype = "light",
	sunlight_propagates = true,
	light_source = default.LIGHT_MAX-1,
	groups = {cracky = 3, oddly_breakable_by_hand = 3, not_cuttable=1},
	sounds = default.node_sound_glass_defaults(),
})

-- Craft
minetest.register_craft({
	output = "darkage:glass 1",
	recipe = {
		{"darkage:glow_glass"},
	}
})

-- Recycling
minetest.register_craft({
	output = "darkage:glow_glass 1",
	recipe = {
		{"darkage:glass"},
		{"default:mese_crystal"},
	}
})

--[[
	Round Glass
	By Semmett9 aka Infinatum
]]
minetest.register_node("darkage:glass_round", {
	description = "Round Glass",
	drawtype = "glasslike",
	tiles = { "darkage_glass_round.png" },
	paramtype = "light",
	use_texture_alpha = true,
	sunlight_propagates = true,
	sounds = default.node_sound_glass_defaults(),
	groups = {cracky=3,oddly_breakable_by_hand=3},
})

minetest.register_craft({
	output = "darkage:glass_round 8",
	recipe = {
		{"default:steel_ingot", "default:glass", "default:steel_ingot"},
		{"default:glass", "default:glass", "default:glass"},
		{"default:steel_ingot", "default:glass", "default:steel_ingot"},
	}
})

-- If unifieddyes installed provide a colorizeable variant
if minetest.get_modpath("unifieddyes") then
	minetest.register_node("darkage:milk_glass_round", {
		description = "Milky Medieval Round Glass (Good for colorization)",
		drawtype = "glasslike",
		tiles = {"darkage_milk_glass_round.png"},
		use_texture_alpha=true,
		paramtype = "light",
		paramtype2 = "color",
		palette = "unifieddyes_palette.png",
		sunlight_propagates = true,
		groups = {cracky = 3, oddly_breakable_by_hand = 3, not_cuttable=1, ud_param2_colorable = 1},
		sounds = default.node_sound_glass_defaults(),
		after_dig_node = unifieddyes.after_dig_node
	})

-- Craft
	minetest.register_craft({
		output = "darkage:milk_glass_round 1",
		type = "shapeless",
		recipe = {"darkage:glass_round", "dye:white"}
	})

-- Recycling
	minetest.register_craft({
		output = "darkage:glass_round 1",
		recipe = {{"darkage:milk_glass_round"}}
	})
end

--[[
	Square glass
	By Semmett9 aka Infinatum
]]
minetest.register_node("darkage:glass_square", {
	description = "Square Glass",
	drawtype = "glasslike",
	tiles = { "darkage_glass_square.png" },
	paramtype = "light",
	use_texture_alpha = true,
	sunlight_propagates = true,
	sounds = default.node_sound_glass_defaults(),
	groups = {cracky=3,oddly_breakable_by_hand=3},
})

minetest.register_craft({
	output = "darkage:glass_square 8",
	recipe = {
		{"default:glass",		"default:steel_ingot", "default:glass"},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
		{"default:glass",		"default:steel_ingot", "default:glass"},
	}
})

-- If unifieddyes installed provide a colorizeable variant
if minetest.get_modpath("unifieddyes") then
	minetest.register_node("darkage:milk_glass_square", {
		description = "Milky Medieval Square Glass (Good for colorization)",
		drawtype = "glasslike",
		tiles = {"darkage_milk_glass_square.png"},
		use_texture_alpha=true,
		paramtype = "light",
		paramtype2 = "color",
		palette = "unifieddyes_palette.png",
		sunlight_propagates = true,
		groups = {cracky = 3, oddly_breakable_by_hand = 3, not_cuttable=1, ud_param2_colorable = 1},
		sounds = default.node_sound_glass_defaults(),
		after_dig_node = unifieddyes.after_dig_node
	})

-- Craft
	minetest.register_craft({
		output = "darkage:milk_glass_square 1",
		type = "shapeless",
		recipe = {"darkage:glass_square", "dye:white"}
	})

-- Recycling
	minetest.register_craft({
		output = "darkage:glass_square 1",
		recipe = {{"darkage:milk_glass_square"}}
	})
end
