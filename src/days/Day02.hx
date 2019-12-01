package days;

import sys.io.File;

class Day02 {
	static inline function imin(a:Int, b:Int):Int {
		return a < b ? a : b;
	}

	public static function part1():Int {
		var paper = 0;

		for (pack in File.getContent("data/day02.txt").split("\n")) {
			var dim = pack.split("x").map(Std.parseInt);

			var f1 = dim[0] * dim[1];
			var f2 = dim[0] * dim[2];
			var f3 = dim[1] * dim[2];

			paper += 2 * f1 + 2 * f2 + 2 * f3 + imin(f1, imin(f2, f3));
		}

		return paper;
	}

	public static function part2():Int {
		var ribbon = 0;

		for (pack in File.getContent("data/day02.txt").split("\n")) {
			var dim = pack.split("x").map(Std.parseInt);

			dim.sort((a, b) -> a - b);

			ribbon += 2 * dim[0] + 2 * dim[1] + dim[0] * dim[1] * dim[2];
		}

		return ribbon;
	}
}
