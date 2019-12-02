package days;

import sys.io.File;

class Day03 {
	public static function part1():Int {
		var houses = 1;

		var x = 0;
		var y = 0;
		var visited = new Map<String, Bool>();

		visited.set("0-0", true);

		for (direction in File.getContent("data/day03.txt").split("")) {
			switch (direction) {
				case ">":
					x += 1;
				case "<":
					x -= 1;
				case "^":
					y -= 1;
				case "v":
					y += 1;
			}

			var id = '$x-$y';

			if (!visited.exists(id)) {
				visited.set(id, true);
				++houses;
			}
		}

		return houses;
	}

	public static function part2():Int {
		var houses = 1;

		var santa_x = 0;
		var santa_y = 0;

		var robo_x = 0;
		var robo_y = 0;

		var visited = new Map<String, Bool>();
		visited.set("0-0", true);

		var santa = true;

		for (direction in File.getContent("data/day03.txt").split("")) {
			switch (direction) {
				case ">" if (santa):
					santa_x += 1;
				case "<" if (santa):
					santa_x -= 1;
				case "^" if (santa):
					santa_y -= 1;
				case "v" if (santa):
					santa_y += 1;
				case ">":
					robo_x += 1;
				case "<":
					robo_x -= 1;
				case "^":
					robo_y -= 1;
				case "v":
					robo_y += 1;
			}

			var id = santa ? '$santa_x-$santa_y' : '$robo_x-$robo_y';

			if (!visited.exists(id)) {
				visited.set(id, true);
				++houses;
			}

			santa = !santa;
		}

		return houses;
	}
}
