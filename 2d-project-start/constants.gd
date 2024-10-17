extends Node
enum COLORS {
	GREEN,
	RED
}

enum WEAPON_TYPES {
	BULLET,
	BOMB
}

const RED = Color(0.855, 0.329, 0.392)


const UPGRADES = [
	{
		'req': {
			'color': COLORS.RED,
			'amt': 4,
		},
		'unlocks': {
			'type': WEAPON_TYPES.BULLET,
			'color': COLORS.GREEN
		}
	},
	{
		'req': {
			'color': COLORS.GREEN,
			'amt': 4,
		},
		'unlocks': {
			'type': WEAPON_TYPES.BOMB,
			'color': COLORS.RED
		}
	}
]
