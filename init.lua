-- Step on a node, spawn a mob

spawnstep = {}

spawnstep.proximity = 5 -- radius range of node detection
spawnstep.spawnrange = 7 -- radius range of where the mob will spawn

spawnstep.interval = 1

spawnstep.maxmobs = 4 -- maxiumum number of mobs to allow in area


dofile(minetest.get_modpath("spawnstep").."/spawndefs.lua")

minetest.register_privilege("spawner","Allow player to spawn mobs")
minetest.register_privilege("digspawntrap","Allow player to dig spawn traps")

minetest.register_node("spawnstep:spawntrap",{
	description = "Spawn a mob depending on the block beneath it",
	tiles = {"default_mese_block.png"},
	drawtype = "normal",
	groups = {crumbly = 1},
	on_dig = function(pos,node,player)
		if minetest.check_player_privs(player:get_player_name(), {digspawntrap=true}) then
			minetest.remove_node(pos)
		end
	end
})

local spawn_mob = function(pos,mobname)
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

local count_nearby_mobs = function(pos,radius)
	-- check if there are entities around already
	local objcount = 0
	for _,obj in pairs(minetest.get_objects_inside_radius(pos ,radius)) do
		if not obj:is_player() then
			objcount = objcount+1
		end
	end
	return objcount
end

local get_mob_from_node = function(pos)
	-- return the expected mob, or nil if none matches
	-- get node under position
	local underpos = {x=pos.x, y=pos.y-1, z=pos.z}
	local tellernode = minetest.get_node(underpos).name
	-- iterate spawnstep.mobnodes, check against nodename
	for _,mobnode in pairs(spawnstep.mobnodes) do
		-- if match, return mobstring
		if mobnode.node == tellernode then return mobnode.mob end
	end
	return nil
end

local chat_spawn_mob = function(playername,paramstring) -- used by chat command and by global step
	local piterator = string.gmatch(paramstring,"%S+")
	-- get player name
	local victim = piterator()
	-- get mob name
	local mobname = piterator()

	if mobname == nil or victim == nil then
		minetest.chat_send_player(playername,"Usage: /spawnto <PLAYER> <MOB NAME>")
		return
	end

	if not minetest.registered_entities[mobname] then
		if not spawnstep.mobnodes[mobname] then
			minetest.chat_send_player(playername,"No such mob "..mobname)
			return
		end
		mobname = spawnstep.mobnodes[mobname].mob
		if not minetest.registered_entities[mobname] then
			minetest.chat_send_player(playername,"No such mob "..mobname.." - contact the admin.")
			return
		end
	end

	-- get player position
	local pos = vector.round(minetest.get_player_by_name(victim):getpos())
	-- add entity near player's position
	spawn_mob(pos,mobname)
end

minetest.register_chatcommand("spawnto",{
	privs = "spawner",
	params = "<PLAYER> <MOBSTRING>",
	func = chat_spawn_mob
})

minetest.register_abm{
        nodenames = {"spawnstep:spawntrap"},
        neighbors = {"group:liquid","air"},
        interval = spawnstep.interval,
        chance = 1,
        action = function(pos)
		for _,obj in pairs(minetest.get_objects_inside_radius(pos ,spawnstep.proximity)) do
			if obj:is_player() then
				if count_nearby_mobs(pos,math.ceil(spawnstep.spawnrange*3)) < spawnstep.maxmobs then
					local mobname = get_mob_from_node(pos)
					if mobname ~= nil then
						local mobnicename = mobname:sub(mobname:find(':')+1,#mobname )
						minetest.chat_send_player(obj:get_player_name(),"A wild "..mobnicename.." appeared!")
						spawn_mob(pos,mobname)
					end
				end
			end
		end
        end,
}

