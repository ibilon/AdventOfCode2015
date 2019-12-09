package days;

import sys.io.File;

class Day18 {
	static inline var HEIGHT = 100;
	static inline var WIDTH = 100;

	static function run(postLoop:(set:(x:Int, y:Int, v:Bool) -> Void) -> Void):Int {
		var grid = [];

		for (line in File.getContent("data/day18.txt").split("\n")) {
			grid.push(line.split("").map(e -> e == "#"));
		}

		var grid = [grid, [for (line in grid) line.copy()]];
		var i = 1;

		function get(x:Int, y:Int):Bool {
			if (x < 0 || x >= WIDTH || y < 0 || y >= HEIGHT) {
				return false;
			}
			return grid[i][y][x];
		}

		function set(x:Int, y:Int, v:Bool) {
			grid[(i + 1) % 2][y][x] = v;
		}

		postLoop(set);
		i = 0;

		for (_ in 0...100) {
			for (y in 0...HEIGHT) {
				for (x in 0...WIDTH) {
					var count = 0;

					for (dy in -1...2) {
						for (dx in -1...2) {
							if (dy == 0 && dx == 0) {
								continue;
							}

							if (get(x + dx, y + dy)) {
								++count;
							}
						}
					}

					if (get(x, y)) {
						set(x, y, count == 2 || count == 3);
					} else {
						set(x, y, count == 3);
					}
				}
			}

			postLoop(set);

			i = (i + 1) % 2;
		}

		var count = 0;

		for (y in 0...HEIGHT) {
			for (x in 0...WIDTH) {
				if (get(x, y)) {
					++count;
				}
			}
		}

		return count;
	}

	public static function part1():Int {
		return run(set -> {});
	}

	public static function part2():Int {
		return run(set -> {
			set(0, 0, true);
			set(0, HEIGHT - 1, true);
			set(WIDTH - 1, 0, true);
			set(WIDTH - 1, HEIGHT - 1, true);
		});
	}
}
