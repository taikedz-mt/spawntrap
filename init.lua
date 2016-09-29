-- Step on a node, spawn a mob

spawnstep = {}

dofile(minetest.get_modpath("spawnstep").."/settings.lua")
dofile(minetest.get_modpath("spawnstep").."/spawndefs.lua")

spawnstep.spawn_mob = function(pos,mobname)
	-- spawn a mob within spawnrange nodes of position pos
	local mobdef = minetest.registered_entities[mobname]
	if mobdef == nil then return end

	local spawninnode = {"air"}
	if mobdef.fly_in then spawninnode = {mobdef.fly_in} end

	local range = spawnstep.spawnrange
	local candidatenodes = minetest.find_nodes_in_area(
		{x = pos.x -range, y = pos.y - range, z = pos.z -range},
		{x = pos.x +range, y = pos.y + range, z = pos.z +range},
		spawninnode
	)
	local newpos = candidatenodes[ math.random(1,#candidatenodes) ]

	minetest.add_entity(newpos,mobname)
end

dofile(minetest.get_modpath("spawnstep").."/trap.lua")
dofile(minetest.get_modpath("spawnstep").."/command.lua")
