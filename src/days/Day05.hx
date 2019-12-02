package days;

import sys.io.File;

class Day05 {
	public static function part1():Int {
		var nice = 0;

		for (word in File.getContent("data/day05.txt").split("\n")) {
			var vowels = 0;

			for (i in 0...word.length) {
				switch (word.charAt(i)) {
					case "a", "e", "i", "o", "u":
						++vowels;
				}
			}

			if (vowels < 3) {
				continue;
			}

			var twice = 0;
			var forbidden = 0;

			for (i in 0...word.length - 1) {
				var c1 = word.charAt(i);
				var c2 = word.charAt(i + 1);

				if (c1 == c2) {
					++twice;
				}

				switch ([c1, c2]) {
					case ["a", "b"], ["c", "d"], ["p", "q"], ["x", "y"]:
						++forbidden;
					default:
				}
			}

			if (twice >= 1 && forbidden == 0) {
				++nice;
			}
		}

		return nice;
	}

	public static function part2():Int {
		var nice = 0;

		for (word in File.getContent("data/day05.txt").split("\n")) {
			var hasRule1 = false;

			for (i in 0...word.length - 1) {
				var c1 = word.charAt(i);
				var c2 = word.charAt(i + 1);

				if (word.indexOf('$c1$c2', i + 2) != -1) {
					hasRule1 = true;
					break;
				}
			}

			if (!hasRule1) {
				continue;
			}

			var hasRule2 = false;

			for (i in 0...word.length - 2) {
				var c1 = word.charAt(i);
				var c3 = word.charAt(i + 2);

				if (c1 == c3) {
					hasRule2 = true;
					break;
				}
			}

			if (hasRule2) {
				++nice;
			}
		}

		return nice;
	}
}
