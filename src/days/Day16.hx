package days;

import sys.io.File;

class Day16 {
	static function run(match:(name:String, data:Int, found:Int) -> Bool):Int {
		var data = {
			name: [
				"children", "cats", "samoyeds", "pomeranians", "akitas", "vizslas", "goldfish", "trees", "cars", "perfumes"
			],
			value: [3, 7, 2, 3, 0, 0, 5, 3, 2, 1]
		};

		for (sue in File.getContent("data/day16.txt").split("\n")) {
			final p = sue.indexOf(":");
			final n = Std.parseInt(sue.substring(4, p));
			var m = true;

			for (e in sue.substring(p + 2).split(", ").map(e -> e.split(": "))) {
				var i = data.name.indexOf(e[0]);

				if (!match(e[0], data.value[i], Std.parseInt(e[1]))) {
					m = false;
					break;
				}
			}

			if (m) {
				return n;
			}
		}

		return -1;
	}

	public static function part1():Int {
		return run((name, data, found) -> data == found);
	}

	public static function part2():Int {
		return run((name, data, found) -> switch (name) {
			case "cats", "tree": found > data;
			case "pomeranians", "goldfish": found < data;
			default: found == data;
		});
	}
}
