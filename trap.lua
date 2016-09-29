-- The trap node

minetest.register_node("spawnstep:spawntrap",{
	description = "Spawn a mob depending on the block beneath it",
	tiles = spawnstep.tiles,
	drawtype = "normal",
	groups = {crumbly = 1},
	on_dig = function(pos,node,player)
		if minetest.check_player_privs(player:get_player_name(), {digspawntrap=true}) then
			minetest.remove_node(pos)
		end
	end
})

core.register_craft({
	output="spawnstep:spawntrap",
	recipe={
		{"","default:mese",""},
		{"","default:obsidian",""},
		{"default:diamondblock","default:obsidian","default:diamondblock"},
	}
})


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

minetest.register_abm{
        nodenames = {"spawnstep:spawntrap"},
        neighbors = nil,
        interval = spawnstep.interval,
        chance = 1,
        action = function(pos)
		for _,obj in pairs(minetest.get_objects_inside_radius(pos ,spawnstep.proximity)) do
			if obj:is_player() then
				minetest.debug("Player "..obj:get_player_name().." triggered spawn trap")
				if count_nearby_mobs(pos,math.ceil(spawnstep.spawnrange*1.4)) < spawnstep.maxmobs then
					local mobname = get_mob_from_node(pos)
					if mobname ~= nil then
						local mobnicename = mobname:sub(mobname:find(':')+1,#mobname )
						minetest.chat_send_player(obj:get_player_name(),"A wild "..mobnicename.." appeared!")
						spawnstep.spawn_mob(pos,mobname)
					else
						minetest.debug("Failed to determine a mob.")
					end
				else
					minetest.debug("Too many mobs. Not spawning.")
				end
			end
		end
        end,
}
