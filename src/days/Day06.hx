package days;

import sys.io.File;

enum Mode {
	Off;
	On;
	Toggle;
}

class Day06 {
	static inline function imax(a:Int, b:Int):Int {
		return a > b ? a : b;
	}

	public static function part1():Int {
		var lights = [for (_ in 0...1000) [for (_ in 0...1000) 0]];

		for (instruction in File.getContent("data/day06.txt").split("\n")) {
			var instruction = instruction.split(" ");

			if (instruction[0] == "turn") {
				instruction.shift();
			}

			var mode = switch (instruction[0]) {
				case "off": Off;
				case "on": On;
				case "toggle": Toggle;
				default: throw "unknown mode";
			}

			var start = instruction[1].split(",").map(Std.parseInt);
			var end = instruction[3].split(",").map(Std.parseInt);

			for (x in start[0]...end[0] + 1) {
				for (y in start[1]...end[1] + 1) {
					lights[y][x] = switch (mode) {
						case Off: 0;
						case On: 1;
						case Toggle: lights[y][x] == 0 ? 1 : 0;
					}
				}
			}
		}

		var number = 0;

		for (line in lights) {
			for (light in line) {
				number += light;
			}
		}

		return number;
	}

	public static function part2():Int {
		var lights = [for (_ in 0...1000) [for (_ in 0...1000) 0]];

		for (instruction in File.getContent("data/day06.txt").split("\n")) {
			var instruction = instruction.split(" ");

			if (instruction[0] == "turn") {
				instruction.shift();
			}

			var mode = switch (instruction[0]) {
				case "off": Off;
				case "on": On;
				case "toggle": Toggle;
				default: throw "unknown mode";
			}

			var start = instruction[1].split(",").map(Std.parseInt);
			var end = instruction[3].split(",").map(Std.parseInt);

			for (x in start[0]...end[0] + 1) {
				for (y in start[1]...end[1] + 1) {
					lights[y][x] = switch (mode) {
						case Off:
							imax(0, lights[y][x] - 1);
						case On:
							lights[y][x] + 1;
						case Toggle:
							lights[y][x] + 2;
					}
				}
			}
		}

		var brightness = 0;

		for (line in lights) {
			for (light in line) {
				brightness += light;
			}
		}

		return brightness;
	}
}
