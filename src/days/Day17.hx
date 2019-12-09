package days;

import sys.io.File;

class Day17 {
	static function run(onFind:(use:Array<Bool>) -> Void) {
		var containers = File.getContent("data/day17.txt").split("\n").map(Std.parseInt);
		var use = [for (_ in 0...containers.length) false];

		function capacity() {
			var c = 0;
			for (i in 0...containers.length) {
				if (use[i]) {
					c += containers[i];
				}
			}
			return c;
		}

		function increase(d:Int) {
			if (d == -1) {
				return false;
			}

			if (use[d]) {
				use[d] = false;
				return increase(d - 1);
			} else {
				use[d] = true;
			}

			return true;
		}

		while (true) {
			if (capacity() == 150) {
				onFind(use);
			}

			if (!increase(containers.length - 1)) {
				break;
			}
		}
	}

	public static function part1():Int {
		var count = 0;
		run(use -> ++count);
		return count;
	}

	public static function part2():Int {
		var min = 99999999;
		var count = 0;

		run(use -> {
			var s = 0;
			for (u in use) {
				if (u) {
					++s;
				}
			}

			if (s < min) {
				min = s;
				count = 1;
			} else if (s == min) {
				++count;
			}
		});

		return count;
	}
}
