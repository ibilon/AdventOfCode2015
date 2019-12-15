package days;

class Day20 {
	static inline var data = 33100000;

	public static function part1():Int {
		var d = Std.int(data / 10);
		var house = [for (_ in 0...d) 0];

		for (i in 1...d) {
			var j = i;
			while (j < d) {
				house[j] += i * 10;
				j += i;
			}
		}

		for (i in 1...d) {
			if (house[i] >= data) {
				return i;
			}
		}

		return -1;
	}

	public static function part2():Int {
		var d = Std.int(data / 10);
		var house = [for (_ in 0...d) 0];

		for (i in 1...d) {
			var j = i;
			var u = 0;
			while (j < d && ++u < 50) {
				house[j] += i * 11;
				j += i;
			}
		}

		for (i in 1...d) {
			if (house[i] >= data) {
				return i;
			}
		}

		return -1;
	}
}
