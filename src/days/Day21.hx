package days;

import sys.io.File;

class Day21 {
	static function imax(a:Int, b:Int):Int {
		return a > b ? a : b;
	}

	static function run(fightResult:(gold:Int, won:Bool) -> Void) {
		var data = File.getContent("data/day21.txt").split("\n").map(e -> e.split(": "));

		var weapons = [{c: 8, d: 4}, {c: 10, d: 5}, {c: 25, d: 6}, {c: 40, d: 7}, {c: 74, d: 8}];

		var armors = [
			{c: 0, a: 0},
			{c: 13, a: 1},
			{c: 31, a: 2},
			{c: 53, a: 3},
			{c: 75, a: 4},
			{c: 102, a: 5}
		];

		var rings = [
			{c: 0, d: 0, a: 0},
			{c: 0, d: 0, a: 0},
			{c: 25, d: 1, a: 0},
			{c: 50, d: 2, a: 0},
			{c: 100, d: 3, a: 0},
			{c: 20, d: 0, a: 1},
			{c: 40, d: 0, a: 2},
			{c: 80, d: 0, a: 3}
		];

		for (weapon in 0...weapons.length) {
			for (armor in 0...armors.length) {
				for (ring1 in 0...rings.length) {
					for (ring2 in 0...rings.length) {
						if (ring1 == ring2) {
							continue;
						}

						var gold = weapons[weapon].c + armors[armor].c + rings[ring1].c + rings[ring2].c;

						var boss_hp = Std.parseInt(data[0][1]);
						var boss_dammage = Std.parseInt(data[1][1]);
						var boss_armor = Std.parseInt(data[2][1]);

						var player_hp = 100;
						var player_dammage = weapons[weapon].d + rings[ring1].d + rings[ring2].d;
						var player_armor = armors[armor].a + rings[ring1].a + rings[ring2].a;

						while (player_hp > 0 && boss_hp > 0) {
							boss_hp -= imax(1, player_dammage - boss_armor);
							player_hp -= imax(1, boss_dammage - player_armor);
						}

						fightResult(gold, boss_hp <= 0);
					}
				}
			}
		}
	}

	public static function part1():Int {
		var min = 99999;
		run((gold, won) -> if (won && gold < min) min = gold);
		return min;
	}

	public static function part2():Int {
		var max = 0;
		run((gold, won) -> if (!won && gold > max) max = gold);
		return max;
	}
}
