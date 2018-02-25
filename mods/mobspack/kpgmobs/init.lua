
-- horse functions

local function is_ground(pos)
	local nn = minetest.get_node(pos).name
	return minetest.get_item_group(nn, "crumbly") ~= 0
end

local function get_sign(i)
	if i == 0 then
		return 0
	else
		return i/math.abs(i)
	end
end

local function get_velocity(v, yaw, y)
	local x = math.cos(yaw)*v
	local z = math.sin(yaw)*v
	return {x=x, y=y, z=z}
end

local function get_v(v)
	return math.sqrt(v.x^2+v.z^2)
end

function merge(a, b)
    if type(a) == 'table' and type(b) == 'table' then
        for k,v in pairs(b) do if type(v)=='table' and type(a[k] or false)=='table' then merge(a[k],v) else a[k]=v end end
    end
    return a
end

-- HORSE go go goooo :)

--[[

local horse = {
	physical = true,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	visual = "mesh",
	stepheight = 1.1,
	visual_size = {x=1,y=1},
	mesh = "mobs_horseh1.x",
	driver = nil,
	v = 0,

	on_rightclick = function(self, clicker)
		if not clicker or not clicker:is_player() then
			return
		end
		if self.driver and clicker == self.driver then
			self.driver = nil
			clicker:set_detach()
		elseif not self.driver then
			self.driver = clicker
			clicker:set_attach(self.object, "", {x=0,y=5,z=0}, {x=0,y=0,z=0})
			self.object:setyaw(clicker:get_look_yaw())
		end
	end,
	
	on_activate = function(self, staticdata, dtime_s)
		self.object:set_armor_groups({immortal=1})
		print (self.texture, self.jmp)
	end,

	on_punch = function(self, puncher, time_from_last_punch, tool_capabilities, direction)
		if puncher and puncher:is_player() then
			puncher:get_inventory():add_item("main", self.name)
			self.object:remove()
		end
	end,
	
	on_step = function(self, dtime)

		self.v = get_v(self.object:getvelocity())*get_sign(self.v)

		if self.driver then

			local ctrl = self.driver:get_player_control()

			if ctrl.up then
				self.v = self.v + self.jmp
			end
			if ctrl.down then
				self.v = self.v-0.1
			end
			if ctrl.left then
				self.object:setyaw(self.object:getyaw()+math.pi/120+dtime*math.pi/120)
			end
			if ctrl.right then
				self.object:setyaw(self.object:getyaw()-math.pi/120-dtime*math.pi/120)
			end
			if ctrl.jump then
				local p = self.object:getpos()
				p.y = p.y-0.5
				if is_ground(p) then
					local pos = self.object:getpos()
					pos.y = math.floor(pos.y)+4
					self.object:setpos(pos)
					self.object:setvelocity(get_velocity(self.v, self.object:getyaw(), 0))
				end
			end
		end

		local s = get_sign(self.v)
		self.v = self.v - 0.02*s

		if s ~= get_sign(self.v) then
			self.object:setvelocity({x=0, y=0, z=0})
			self.v = 0
			return
		end

		if math.abs(self.v) > 4.5 then
			self.v = 4.5*get_sign(self.v)
		end
	
		local p = self.object:getpos()
		p.y = p.y-0.5

		if not is_ground(p) then
			if minetest.registered_nodes[minetest.get_node(p).name].walkable then
				self.v = 0
			end
			self.object:setacceleration({x=0, y=-10, z=0})
			self.object:setvelocity(get_velocity(self.v, self.object:getyaw(), self.object:getvelocity().y))
		else
			p.y = p.y+1
			if is_ground(p) then
				self.object:setacceleration({x=0, y=3, z=0})
				local y = self.object:getvelocity().y
				if y > 2 then
					y = 2
				end
				if y < 0 then
					self.object:setacceleration({x=0, y=10, z=0})
				end
				self.object:setvelocity(get_velocity(self.v, self.object:getyaw(), y))
			else
				self.object:setacceleration({x=0, y=0, z=0})
				if math.abs(self.object:getvelocity().y) < 1 then
					local pos = self.object:getpos()
					pos.y = math.floor(pos.y)+0.5
					self.object:setpos(pos)
					self.object:setvelocity(get_velocity(self.v, self.object:getyaw(), 0))
				else
					self.object:setvelocity(get_velocity(self.v, self.object:getyaw(), self.object:getvelocity().y))
				end
			end
		end
	end,
}

--END HORSE

-- backup table
local hbak = horse

-- Brown Horse

local hrs = {
	textures = {"mobs_horseh1.png"},
	jmp = 2,
}
minetest.register_entity("kpgmobs:horseh1", merge(hrs, horse))

-- White Horse

horse = hbak
local peg = {
	textures = {"mobs_horsepegh1.png"},
	jmp = 2,
}
minetest.register_entity("kpgmobs:horsepegh1", merge(peg, horse))

-- Black Horse

horse = hbak
local ara = {
	textures = {"mobs_horsearah1.png"},
	jmp = 3,
}
minetest.register_entity("kpgmobs:horsearah1", merge(ara, horse))

-- tamed horse spawn eggs
mobs:register_egg("kpgmobs:horseh1", "Tamed Brown Horse", "mobs_horse_inv.png", 0)
mobs:register_egg("kpgmobs:horsepegh1", "Tamed White Horse", "mobs_horse_peg_inv.png", 0)
mobs:register_egg("kpgmobs:horsearah1", "Tamed Arabic Horse", "mobs_horse_ara_inv.png", 0)

-- saddle
minetest.register_craftitem("kpgmobs:saddle", {
	description = "Saddle",
	inventory_image = "mobs_saddle.png",
})

minetest.register_craft({
	output = "kpgmobs:saddle",
	recipe = {
		{'mobs:leather', 'mobs:leather', 'mobs:leather'},
		{'mobs:leather', 'default:steel_ingot', 'mobs:leather'},
		{'mobs:leather', 'default:steel_ingot', 'mobs:leather'},
	}
})

mobs:register_mob("kpgmobs:horse", {
	type = "animal",
	hp_min = 5,
	hp_max = 10,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	textures = {
		{"mobs_horse.png"},
	},
	visual = "mesh",
	mesh = "mobs_horse.x",
	makes_footstep_sound = true,
	walk_velocity = 1,
	armor = 200,
	drops = {
		{name = "mobs:meat_raw",
		chance = 1,
		min = 2,
		max = 3,},
	},
	drawtype = "front",
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	animation = {
		speed_normal = 15,
		stand_start = 25,		stand_end = 75,
		walk_start = 75,		walk_end = 100,
	},
	follow = "farming:wheat",
	view_range = 5,

	on_rightclick = function(self, clicker)
		local tool = clicker:get_wielded_item()
		if tool:get_name() == "kpgmobs:saddle" then
			clicker:get_inventory():remove_item("main", "kpgmobs:saddle")
			local pos = self.object:getpos()
			self.object:remove()
			minetest.add_entity(pos, "kpgmobs:horseh1")			
		end
	end,
})
mobs:register_spawn("kpgmobs:horse", {"default:dirt_with_grass"}, 20, 8, 11000, 1, 31000)

mobs:register_mob("kpgmobs:horse2", {
	type = "animal",
	hp_min = 5,
	hp_max = 10,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	textures = {
		{"mobs_horsepeg.png"},
	},
	visual = "mesh",
	mesh = "mobs_horse.x",
	makes_footstep_sound = true,
	walk_velocity = 1,
	armor = 200,
	drops = {
		{name = "mobs:meat_raw",
		chance = 1,
		min = 2,
		max = 3,},
	},
	drawtype = "front",
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	animation = {
		speed_normal = 15,
		stand_start = 25,		stand_end = 75,
		walk_start = 75,		walk_end = 100,
	},
	follow = "farming:wheat",
	view_range = 5,

	on_rightclick = function(self, clicker)
		local tool = clicker:get_wielded_item()
		if tool:get_name() == "kpgmobs:saddle" then
			clicker:get_inventory():remove_item("main", "kpgmobs:saddle")
			local pos = self.object:getpos()
			self.object:remove()
			minetest.add_entity(pos, "kpgmobs:horsepegh1")			
		end
	end,
})
mobs:register_spawn("kpgmobs:horse2", {"default:dirt_with_grass"}, 20, 8, 11000, 1, 31000)

mobs:register_mob("kpgmobs:horse3", {
	type = "animal",
	hp_min = 5,
	hp_max = 10,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	textures = {
		{"mobs_horseara.png"},
	},
	visual = "mesh",
	mesh = "mobs_horse.x",
	makes_footstep_sound = true,
	walk_velocity = 1,
	armor = 200,
	drops = {
		{name = "mobs:meat_raw",
		chance = 1,
		min = 2,
		max = 3,},
	},
	drawtype = "front",
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	animation = {
		speed_normal = 15,
		stand_start = 25,		stand_end = 75,
		walk_start = 75,		walk_end = 100,
	},
	follow = "farming:wheat",
	view_range = 5,

	on_rightclick = function(self, clicker)
		local tool = clicker:get_wielded_item()
		if tool:get_name() == "kpgmobs:saddle" then
			clicker:get_inventory():remove_item("main", "kpgmobs:saddle")
			local pos = self.object:getpos()
			self.object:remove()
			minetest.add_entity(pos, "kpgmobs:horsearah1")			
		end
	end,
})
mobs:register_spawn("kpgmobs:horse3", {"default:desert_sand"}, 20, 8, 11000, 1, 31000)

-- wild horse spawn eggs
mobs:register_egg("kpgmobs:horse", "Brown Horse", "mobs_horse_inv.png", 0)
mobs:register_egg("kpgmobs:horse2", "White Horse", "mobs_horse_peg_inv.png", 0)
mobs:register_egg("kpgmobs:horse3", "Arabic Horse", "mobs_horse_ara_inv.png", 0)
]]--

mobs:register_mob("kpgmobs:jeraf", {
	type = "animal",
	hp_min = 5,
	hp_max = 10,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	textures = {
		{"mobs_jeraf.png"},
	},
	visual = "mesh",
	mesh = "mobs_jeraf.x",
	makes_footstep_sound = true,
	walk_velocity = 2,
	armor = 200,
	drops = {
		{name = "mobs_mc:beef_raw",
		chance = 1,
		min = 2,
		max = 3,},
	},
	drawtype = "front",
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	animation = {
		speed_normal = 15,
		stand_start = 0,		stand_end = 30,
		walk_start = 70,		walk_end = 100,
	},
	follow = "farming:wheat",
	view_range = 5,
})


mobs:register_spawn("kpgmobs:jeraf", {"default:desert_sand","default:dirt_with_dry_grass"}, 20, 8, 11000, 1, 31000)
mobs:register_egg("kpgmobs:jeraf", "Giraffe", "wool_yellow.png", 1)

mobs:register_mob("kpgmobs:medved", {
	type = "animal",
	hp_min= 5,
	hp_max = 15,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	damage = 2,
	attack_type = "dogfight",
	passive = false,
	textures = {
		{"mobs_medved.png"},
	},
	visual = "mesh",
	mesh = "mobs_medved.x",
	makes_footstep_sound = true,
	view_range = 7,
	walk_velocity = 1,
	run_velocity = 2,
	damage = 10,
	armor = 200,
	attack_type = "dogfight",
	drops = {
		{name = "mobs_mc:beef_raw",
		chance = 1,
		min = 5,
		max = 10,},
	},
	drawtype = "front",
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	animation = {
		speed_normal = 15,		speed_run = 15,
		stand_start = 0,		stand_end = 30,
		walk_start = 35,		walk_end = 65,
		run_start = 105,		run_end = 135,
		punch_start = 70,		punch_end = 100,
	},
})
mobs:register_spawn("kpgmobs:medved", {"default:dirt_with_grass","default:dirt","default:desert_sand"}, 20, 0, 11000, 3, 31000)
mobs:register_egg("kpgmobs:medved", "Bear", "wool_brown.png", 1)

mobs:register_mob("kpgmobs:deer", {
	type = "animal",
	hp_min = 4,
	hp_max = 8,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	textures = {
		{"mobs_deer.png"},
	},
	visual = "mesh",
	mesh = "mobs_deer2.x",
	makes_footstep_sound = true,
	walk_velocity = 1,
	armor = 200,
	drops = {
		{name = "mobs_mc:beef_raw",
		chance = 1,
		min = 2,
		max = 3,},
	},
	drawtype = "front",
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
	animation = {
		speed_normal = 15,
		stand_start = 25,		stand_end = 75,
		walk_start = 75,		walk_end = 100,
	},
	follow = "farming:wheat",
	view_range = 5,
})
mobs:register_spawn("kpgmobs:deer", {"default:dirt_with_grass"}, 20, 8, 9000, 1, 31000)
mobs:register_egg("kpgmobs:deer", "Deer", "wool_violet.png", 1)

--[[
-- Wolf

mobs:register_mob("kpgmobs:wolf", {
	type = "monster",
	hp_min = 5,
	hp_max = 10,
	collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
	textures = {
		{"mobs_wolf.png"},
	},
	visual = "mesh",
	mesh = "mobs_wolf.x",
	makes_footstep_sound = true,
	view_range = 7,
	walk_velocity = 2,
	run_velocity = 3,
	damage = 2,
	attacks_monsters = true,
	armor = 200,
	attack_type = "dogfight",
	drops = {
		{name = "mobs:meat_raw",
		chance = 1,
		min = 2,
		max = 3,},
	},
	drawtype = "front",
	water_damage = 1,
	lava_damage = 5,
	light_damage = 2,
	animation = {
		speed_normal = 15,		speed_run = 15,
		stand_start = 10,		stand_end = 20,
		walk_start = 75,		walk_end = 100,
		run_start = 100,		run_end = 130,
		punch_start = 135,		punch_end = 155,
	},
	on_rightclick = function(self, clicker)
		local item = clicker:get_wielded_item()
		if item:get_name() == "mobs:meat_raw" then
			if not minetest.setting_getbool("creative_mode") then
				item:take_item()
				clicker:set_wielded_item(item)
			end
			self.food = (self.food or 0) + 1
			if self.food >= 8 and self.tamed ~= true then
				self.food = 0
				self.tamed = true
				self.type = "npc"
				self.state = "stand"
				self.follow = "mobs:meat_raw"
				self.following = nil
				self.base_texture = {"mobs_medved.png"}
				self.object:set_properties({
					textures = self.base_texture,
				})
			else
				local hp = self.object:get_hp()
				self.follow = "mobs:meat_raw"
				if hp + 4 > self.hp_max then return end
				self.object:set_hp(hp+4)
			end
		end
	end,
})
mobs:register_spawn("kpgmobs:wolf", {"default:dirt_with_grass","default:dirt"}, 10, -1, 11000, 3, 31000)
mobs:register_egg("kpgmobs:wolf", "Wolf", "wool_green.png", 1)
]]

if minetest.setting_get("log_mods") then
	minetest.log("action", "kpgmobs loaded")
end
