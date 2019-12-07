package days;

import sys.io.File;

typedef Data = {
	map:Map<String, Int>,
	people:Array<String>
}

class Day13 {
	static function permutations(min:Int, max:Int):Array<Array<Int>> {
		var perms = [[min, min + 1], [min + 1, min]];

		for (i in 2...max - min + 1) {
			var np = [];
			for (j in 0...i + 1) {
				for (p in perms) {
					var pp = [j + min];
					for (k in p) {
						if (k == j + min) {
							pp.push(i + min);
						} else {
							pp.push(k);
						}
					}
					np.push(pp);
				}
			}
			perms = np;
		}

		return perms;
	}

	static function parse():Data {
		var people = new Map<String, Bool>();
		var map = new Map<String, Int>();

		for (line in File.getContent("data/day13.txt").split("\n")) {
			var line = line.substring(0, line.length - 1).split(" ");
			people.set(line[0], true);
			map.set('${line[0]} ${line[10]}', Std.parseInt(line[3]) * (line[2] == "gain" ? 1 : -1));
		}

		return {
			map: map,
			people: [for (p in people.keys()) p]
		};
	}

	static function run(data:Data):Int {
		var n = data.people.length - 1;
		var max = 0;

		for (perm in permutations(0, n)) {
			var sum = 0;

			function add(i:Int, j:Int) {
				sum += data.map.get('${data.people[perm[i]]} ${data.people[perm[j]]}');
				sum += data.map.get('${data.people[perm[j]]} ${data.people[perm[i]]}');
			}

			for (i in 0...n) {
				add(i, i + 1);
			}

			add(0, n);

			if (sum > max) {
				max = sum;
			}
		}

		return max;
	}

	public static function part1():Int {
		return run(parse());
	}

	public static function part2():Int {
		var data = parse();

		for (p in data.people) {
			data.map.set('$p YOU', 0);
			data.map.set('YOU $p', 0);
		}

		data.people.push("YOU");

		return run(data);
	}
}
