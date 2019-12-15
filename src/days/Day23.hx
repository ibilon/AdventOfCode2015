package days;

import haxe.Int64;
import sys.io.File;

class Day23 {
	static inline function imax(a:Int64, b:Int64):Int64 {
		return a > b ? a : b;
	}

	public static function run(a:Int64):Int {
		function parseOffset(o:String):Int {
			return if (o.charAt(0) == "+") {
				Std.parseInt(o.substr(1));
			} else {
				Std.parseInt(o);
			}
		}

		var code = File.getContent("data/day23.txt").split("\n").map(e -> [e.substring(0, 3), e.substr(4)]);

		var b:Int64 = 0;
		var pointer = 0;

		while (true) {
			if (a < 0 || b < 0) {
				throw "bug";
			}

			var cell = code[pointer];

			if (cell == null) {
				break;
			}

			switch (cell[0]) {
				case "hlf":
					if (cell[1] == "a") {
						a = imax(0, a / 2);
					} else {
						b = imax(0, b / 2);
					}
					++pointer;

				case "tpl":
					if (cell[1] == "a") {
						a *= 3;
					} else {
						b *= 3;
					}
					++pointer;

				case "inc":
					if (cell[1] == "a") {
						++a;
					} else {
						++b;
					}
					++pointer;

				case "jmp":
					pointer += parseOffset(cell[1]);

				case "jie":
					var args = cell[1].split(", ");

					if ((args[0] == "a" && a % 2 == 0) || (args[0] == "b" && b % 2 == 0)) {
						pointer += parseOffset(args[1]);
					} else {
						++pointer;
					}

				case "jio":
					var args = cell[1].split(", ");

					if ((args[0] == "a" && a == 1) || (args[0] == "b" && b == 1)) {
						pointer += parseOffset(args[1]);
					} else {
						++pointer;
					}

				default:
					throw "unknown instruction";
			}
		}

		return b.low;
	}

	public static function part1():Int {
		return run(0);
	}

	public static function part2():Int {
		return run(1);
	}
}
