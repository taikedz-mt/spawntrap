-- Settings for the spawn trap

spawnstep.proximity = 3 -- radius range of player detection, around trap node
spawnstep.spawnrange = 4 -- radius range of where the mob will spawn

spawnstep.interval = 1 -- how frequently to try to spawn a new mob (seconds)

spawnstep.maxmobs = 1 -- maxiumum number of mobs to allow in area defined by spawn range, around the trap node

spawnstep.overmode = false -- whether to look at node above instead of under
spawnstep.remove = false -- whether to remove the node after spawning
spawnstep.removeteller = false -- whether to remove the mob determining node after spawning
spawnstep.craftable = false -- whether the spawn trap is craftable

spawnstep.tiles = { -- define the tiles for the trap node
	"default_stone.png^default_mese_crystal.png"
}

minetest.register_privilege("spawner","Allow player to spawn mobs")
minetest.register_privilege("digspawntrap","Allow player to dig spawn traps")
