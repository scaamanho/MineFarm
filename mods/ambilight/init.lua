--[[
	Ambilight mod for minetest
	Copyright (C) 2018 Santiago Caamaño  <scaamanho@gmail.com>
	hereby released under the GNU LESSER GENERAL PUBLIC LICENSE v3 license.
]]--

local modpath = minetest.get_modpath(minetest.get_current_modname())
--local creative_mode = minetest.setting_getbool("creative_mode")

ambilight = {}

-- load api with the function ambilight.register_light api
-- `ambilight.register_light(name, node, recipe)`
dofile(modpath .. "/api.lua")




-- default mod lights
ambilight.register_light("glasslamp",
--node
{id = 1,light_source = default.LIGHT_MAX-2, enable_interact = true},
-- recipe
{{"default:paper","default:paper","default:paper"},
{"default:glass","default:torch","default:glass"},
{"default:paper","default:paper","default:paper"}})



ambilight.register_light("stonelamp",{
	id=2,
	light_source = default.LIGHT_MAX-2,
	enable_interact = true
},
-- recipe
{{"default:paper","default:paper","default:paper"},
{"default:stone","default:torch","default:stone"},
{"default:paper","default:paper","default:paper"}})

ambilight.register_light("paperlamp",{
	id=3,
	light_source = default.LIGHT_MAX-2,
	enable_interact = true
},
-- recipe
{{"default:paper","default:paper","default:paper"},
{"default:paper","default:torch","default:paper"},
{"default:paper","default:paper","default:paper"}})

ambilight.register_light("chineselamp",{
	id=4,
	light_source = default.LIGHT_MAX-3,
	enable_interact = true
},
-- recipe
{{"default:paper","default:paper","default:paper"},
{"dye:red","default:torch","dye:red"},
{"default:paper","default:paper","default:paper"}})



--Circle lamps
ambilight.register_light("glasslamp_cicle",{
	id=5,
	light_source = default.LIGHT_MAX-4,
	enable_interact = true
},
-- recipe
{{"","default:stick",""},
{"default:stick","ambilight:glasslamp","default:stick"},
{"","default:stick",""}})

ambilight.register_light("stonelamp_cicle",{
	id=6,
	light_source = default.LIGHT_MAX-4,
	enable_interact = true
},
-- recipe
{{"","default:stick",""},
{"default:stick","ambilight:stonelamp","default:stick"},
{"","default:stick",""}})


ambilight.register_light("paperlamp_cicle",{
	id=7,
	light_source = default.LIGHT_MAX-4,
	enable_interact = true
},
-- recipe
{{"","default:stick",""},
{"default:stick","ambilight:paperlamp","default:stick"},
{"","default:stick",""}})


--Square lamps
ambilight.register_light("glasslamp_square",{
	id=8,
	light_source = default.LIGHT_MAX-4,
	enable_interact = true
},
-- recipe
{{"default:stick","","default:stick"},
{"default:stick","ambilight:glasslamp","default:stick"},
{"default:stick","","default:stick"}})

ambilight.register_light("stonelamp_square",{
	id=9,
	light_source = default.LIGHT_MAX-4,
	enable_interact = true
},
-- recipe
{{"default:stick","","default:stick"},
{"default:stick","ambilight:stonelamp","default:stick"},
{"default:stick","","default:stick"}})



ambilight.register_light("paperlamp_square",{
	id=10,
	light_source = default.LIGHT_MAX-1,
	enable_interact = true
},
-- recipe
{{"default:stick","","default:stick"},
{"default:stick","ambilight:paperlamp","default:stick"},
{"default:stick","","default:stick"}})


--Chinese lamp tail
ambilight.register_light("chinese_tail",{
	light_source = 0,
	drawtype ="plantlike",
	type = "fixed",
	tiles = {"chinese_tail.png"},
	walkable = false,
	sounds = default.node_sound_leaves_defaults(),
	fixed = {-0.25, -0.5, -0.25, 0.25, 0.4, 0.25},
	enable_interact = false
},
-- recipe
{{"dye:red","dye:yellow","farming:cotton"},
{"","",""},
{"","",""}})
