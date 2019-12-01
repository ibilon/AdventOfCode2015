package days;

import sys.io.File;

class Day01 {
	public static function part1():Int {
		var floor = 0;

		for (c in File.getContent("data/day01.txt").split("")) {
			switch (c) {
				case "(":
					++floor;
				case ")":
					--floor;
			}
		}

		return floor;
	}

	public static function part2():Int {
		var floor = 0;
		var position = 0;

		for (c in File.getContent("data/day01.txt").split("")) {
			++position;

			switch (c) {
				case "(":
					++floor;
				case ")":
					--floor;
			}

			if (floor == -1) {
				return position;
			}
		}

		return -1;
	}
}
