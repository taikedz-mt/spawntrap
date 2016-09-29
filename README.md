# Minetest Mod : Spawn Trap

Add a block that will start spawning mobs when a player is near.

## License

(C) 2016 Tai "DuCake" Kedzierski

Provided under LGPLv3 - see `LICENSE.txt` or https://www.gnu.org/licenses/lgpl.html for the full text.

This software is Free Software : you can distribute, change and distribute the modified versions of this software provided that the copyright notice and license remain unchanged, and you provide the source code of the modifications to whomever asks.

You are not compelled to license your own software under the same license, provided that the source code to your software does not directly incorporate parts of the source code of this software.

## Spawn Trap

The type of mob spawned depends on the block that is placed underneath the trap.

node -> mob correspondencies are defined in `spawndefs.lua`

You do not need to add any dependencies to depends.txt per mob mod.

Place a `spawnstep:spawntrap` node directly on top of a node as configured in `spawndefs.lua` and the corresponding mob will spawn.

To dig traps, you need the `digsawntrap` privilege.

You can change the spawn trap's texture in `spawndefs.lua`

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

Requires the `spawner` privilege.

