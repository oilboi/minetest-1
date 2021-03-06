-- On world creating, create platform 10x10 starting from (1,0,1) to (10,0,10)

-- entity cube 
minetest.register_entity("practicemod:simple", {
	initial_properties = {
	hp_max = 20,
    physical = true,
    weight = 5,
    textures = { "default_stone.png", "default_stone.png", "default_stone.png", "default_stone.png", "default_stone.png", "default_stone.png" },
    visual = "cube",
    visual_size = {x=1, y=1},
    spritediv = {x=1, y=1},
    initial_sprite_basepos = {x=0, y=0},
    is_visible = true,
    makes_footstep_sound = false
	} 
})

minetest.register_on_generated(function(minp, maxp,  blockseed)
local start_pos = {x=0, y=0, z=0} -- starting position of platform
	if (minp.x <= start_pos.x and start_pos.x <= maxp.x
		and minp.y <= start_pos.y and start_pos.y <= maxp.y
		and minp.z <= start_pos.z and start_pos.z <= maxp.z)
	then 
		local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
		local data = vm:get_data()
		local area = VoxelArea:new{MinEdge = emin, MaxEdge = emax}
	
	-- iterave over starting and ending positions of platform
	for i in area:iter(0, 0, 0,
			  10, 0, 10) do
		-- set node
		local c_glass= minetest.get_content_id("default:glass")
		data[i] = c_glass
	end

	-- save data to map
	vm:set_data(data)
	vm:write_to_map() 
	end
end)

-- On join player will be placed at (10, 10, 10)
minetest.register_on_joinplayer(function(player)
	minetest.log("action", "hello world")
	player:set_pos({ x = 10, y = 10, z = 10})
	minetest.add_entity({x = 5, y = 5, z = 15}, "practicemod:simple") 
end)
	
