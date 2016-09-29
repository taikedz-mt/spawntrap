# Minetest Mod : Spawn Trap

Add a block that will start spawning mobs when a player is near.

The type of mob spawned depends on the block that is placed underneath the trap.

node -> mob correspondencies are defined in `spawndefs.lua`

You do not need to add any dependencies to depends.txt per mob mod.

Place a `spawnstep:spawntrap` node directly on top of a node as configured in `spawndefs.lua` and the corresponding mob will spawn.

## `/spawnto` command

You can use the `/spawnto` command to spawn a specific mob near a player.

	/spawnto Player2 mobs_monster:dirt_monster

If you defined a monster in `spawndefs.lua`, you can use its shortname:

	-- definition in spawndefs.lua:

		stonem = {
		  node="default:stone",
		  mob="mobs_monster:stone_monster",
		}
	
	-- example command

		/spawnto Player2 stonem

Requires the
