package days;

import sys.io.File;

class Day08 {
	static function compute():{code:Int, memory:Int, extra:Int} {
		var code = 0;
		var memory = 0;
		var extra = 0;

		for (string in File.getContent("data/day08.txt").split("\n")) {
			var string = string.split("");

			code += string.length;
			extra += 2;

			var i = -1;

			while (++i < string.length) {
				switch (string[i]) {
					case '"':
						++extra;
					case "\\":
						switch (string[i + 1]) {
							case '"', "\\":
								++i;
								extra += 2;
							case "x":
								i += 3;
								++extra;
						}
						++memory;
					default:
						++memory;
				}
			}
		}

		return {code: code, memory: memory, extra: extra};
	}

	public static function part1():Int {
		var result = compute();
		return result.code - result.memory;
	}

	public static function part2():Int {
		return compute().extra;
	}
}
