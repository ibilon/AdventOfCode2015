package days;

import sys.io.File;

class Day09 {
	static function costs(onCost:(cost:Int) -> Void) {
		var towns = new Map<String, Bool>();
		var dist = new Map<String, Int>();

		for (line in File.getContent("data/day09.txt").split("\n")) {
			var line = line.split(" ");
			var t1 = line[0];
			var t2 = line[2];
			var d = Std.parseInt(line[4]);

			towns.set(t1, true);
			towns.set(t2, true);
			dist.set('$t1 $t2', d);
			dist.set('$t2 $t1', d);
		}

		var towns = [for (t in towns.keys()) t];
		var routes = [[0, 1], [1, 0]];

		for (i in 3...towns.length + 1) {
			var np = [];
			for (j in 0...i) {
				for (p in routes) {
					var pp = [j];
					for (k in p) {
						if (k == j) {
							pp.push(i - 1);
						} else {
							pp.push(k);
						}
					}
					np.push(pp);
				}
			}
			routes = np;
		}

		for (route in routes) {
			var cost = 0;

			for (i in 0...route.length - 1) {
				cost += dist.get('${towns[route[i]]} ${towns[route[i + 1]]}');
			}

			onCost(cost);
		}
	}

	public static function part1():Int {
		var min = 2147483647;
		costs(c -> if (c < min) min = c);
		return min;
	}

	public static function part2():Int {
		var max = 0;
		costs(c -> if (c > max) max = c);
		return max;
	}
}
