minetest.register_craft({
	output = 'library:corner 8',
	recipe = {
		{'group:wood', 'group:wood', 'group:wood'},
		{'group:wood', 'group:wood', ''},
		{'group:wood', '', ''},
	}
})

minetest.register_craft({
	output = 'library:corner 8',
	recipe = {
		{'group:wood', 'group:wood', 'group:wood'},
		{'', 'group:wood', 'group:wood'},
		{'', '', 'group:wood'},
	}
})

minetest.register_craft({
	output = 'library:inside_corner 12',
	recipe = {
		{'group:wood', 'group:wood'},
		{'', 'group:wood'},
	}
})

minetest.register_craft({
	output = 'library:inside_corner 12',
	recipe = {
		{'group:wood', 'group:wood'},
		{'group:wood', ''},
	}
})

minetest.register_craft({
	output = 'library:card_catalogue',
	recipe = {
		{'group:wood', 'group:stick', 'group:wood'},
		{'default:paper', 'default:paper', 'default:paper'},
		{'group:wood', 'group:stick', 'group:wood'},
	}
})

minetest.register_craft({
	output = 'library:bookshelf_1 2',
	recipe = {
		{'group:wood', 'group:stick', 'group:wood'},
		{'', 'group:book', ''},
		{'group:wood', 'group:stick', 'group:wood'},
	}
})

minetest.register_craft({
	output = 'library:bookshelf_1 2',
	recipe = {
		{'default:bookshelf'},
	}
})

minetest.register_craft({
	output = 'library:nonfiction_bookshelf_1 2',
	recipe = {
		{'group:wood', 'group:stick', 'group:wood'},
		{'group:book', 'group:book', 'group:book'},
		{'group:wood', 'group:stick', 'group:wood'},
	}
})

minetest.register_craft({
	output = 'library:empty_bookshelf 2',
	recipe = {
		{'group:wood', 'group:stick', 'group:wood'},
		{'', '', ''},
		{'group:wood', 'group:stick', 'group:wood'},
	}
})

minetest.register_craft({
	output = 'library:empty_bookshelf_1 2',
	recipe = {
		{'group:wood', 'group:stick', 'group:wood'},
		{'', 'farming:string', ''},
		{'group:wood', 'group:stick', 'group:wood'},
	}
})

minetest.register_craft({
	output = 'library:shelf_1 2',
	recipe = {
		{'group:wood', 'group:stick', 'group:wood'},
		{'group:stick', '', 'group:stick'},
		{'group:wood', 'group:stick', 'group:wood'},
	}
})

minetest.register_craft({
	type = "shapeless",
	output = 'library:shelf_2 2',
	recipe = {'library:shelf_1', 'library:shelf_1'},
})

minetest.register_craft({
	type = "shapeless",
	output = 'library:shelf_1 2',
	recipe = {'library:shelf_2', 'library:shelf_2'},
})

minetest.register_craft({
	output = 'library:antique_bookshelf_1',
	recipe = {
		{'', 'group:stick', ''},
		{'group:wood', 'group:book', 'group:wood'},
		{'group:wood', 'farming:string', 'group:wood'},
	}
})

minetest.register_craft({
	output = 'library:antique_bookshelf_3',
	recipe = {
		{'group:wood', 'group:stick', 'group:wood'},
		{'', 'group:book', ''},
		{'group:wood', 'farming:string', 'group:wood'},
	}
})

minetest.register_craft({
	type = "shapeless",
	output = 'library:book_Green',
	recipe = {'group:book', 'dye:dark_green'},
})

minetest.register_craft({
	type = "shapeless",
	output = 'library:book_Cyan',
	recipe = {'group:book', 'dye:cyan'},
})

minetest.register_craft({
	type = "shapeless",
	output = 'library:book_Red',
	recipe = {'group:book', 'dye:red'},
})

minetest.register_craft({
	type = "shapeless",
	output = 'library:book_Purple',
	recipe = {'group:book', 'dye:violet'},
})

minetest.register_craft({
	type = "shapeless",
	output = 'library:book_Brown',
	recipe = {'group:book', 'dye:brown'},
})

minetest.register_craft({
	type = "shapeless",
	output = 'library:book_Orange',
	recipe = {'group:book', 'dye:orange'},
})

minetest.register_craft({
	type = "shapeless",
	output = 'library:book_Black',
	recipe = {'group:book', 'dye:black'},
})

minetest.register_craft({
	type = "shapeless",
	output = 'default:book',
	recipe = {'group:book'},
})

minetest.register_craft({
	output = 'default:paper',
	recipe = {
		{'farming:string', 'farming:string', 'farming:string'},
	}
})

minetest.register_craft({
	output = 'default:paper',
	recipe = {
		{'library:wood_pulp', 'library:wood_pulp', 'library:wood_pulp'},
	}
})

minetest.register_craft({
	type = "cooking",
	output = 'library:wood_pulp',
	recipe = 'group:stick',
	cooktime = 5,
})

minetest.register_craft({
	type = "fuel",
	recipe = "library:wood_pulp",
	burntime = 1,
})

minetest.register_craft({
	type = "fuel",
	recipe = "library:bookshelf_1",
	burntime = 30,
})

minetest.register_craft({
	type = "fuel",
	recipe = "library:antique_bookshelf_1",
	burntime = 30,
})

minetest.register_craft({
	type = "fuel",
	recipe = "library:antique_bookshelf_3",
	burntime = 30,
})

minetest.register_craft({
	type = "fuel",
	recipe = "library:nonfiction_bookshelf_1",
	burntime = 30,
})

minetest.register_craft({
	type = "fuel",
	recipe = "library:shelf_1",
	burntime = 30,
})

minetest.register_craft({
	type = "fuel",
	recipe = "library:shelf_2",
	burntime = 30,
})

minetest.register_craft({
	type = "fuel",
	recipe = "library:empty_bookshelf_1",
	burntime = 30,
})

minetest.register_craft({
	type = "fuel",
	recipe = "library:empty_bookshelf",
	burntime = 30,
})

minetest.register_craft({
	type = "fuel",
	recipe = "library:book_Green",
	burntime = 3,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:book_Red",
	burntime = 3,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:book_Cyan",
	burntime = 3,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:book_Purple",
	burntime = 3,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:book_Black",
	burntime = 3,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:book_Orange",
	burntime = 3,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:book_Brown",
	burntime = 3,
})

minetest.register_craft({
	type = "fuel",
	recipe = "library:book_Green_written",
	burntime = 3,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:book_Red_written",
	burntime = 3,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:book_Cyan_written",
	burntime = 3,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:book_Purple_written",
	burntime = 3,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:book_Black_written",
	burntime = 3,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:book_Orange_written",
	burntime = 3,
})

minetest.register_craft({
	type = "fuel",
	recipe = "default:book_Brown_written",
	burntime = 3,
})