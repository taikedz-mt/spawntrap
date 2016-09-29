
spawnstep.proximity = 5 -- radius range of player detection, around trap node
spawnstep.spawnrange = 7 -- radius range of where the mob will spawn

spawnstep.interval = 1 -- how frequently to try to spawn a new mob (seconds)

spawnstep.maxmobs = 4 -- maxiumum number of mobs to allow in area defined by spawn range, around the trap node

spawnstep.tiles = { -- define the tiles for the trap node
	"default_stone.png^default_mese_crystal.png"
}

-- ++++++++++++++++++++

spawnstep.mobnodes = {
	dirtmonster = {
		node="default:dirt",
		mob="mobs_monster:dirt_monster",
	},
	stonemonster = {
		node="default:stone",
		mob="mobs_monster:stone_monster",
	},
	dungeonmaster = {
		node="default:obsidian",
		mob="mobs_monster:dungeon_master"
	},
	bossdm = {
		node="default:nyancat",
		mob="mobs_monster:dungeon_master_boss"
	},
}

