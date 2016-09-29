

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
	spawnstep.spawn_mob(pos,mobname)
end

minetest.register_chatcommand("spawnto",{
	privs = "spawner",
	params = "<PLAYER> <MOBSTRING>",
	func = chat_spawn_mob
})
