package days;

class Day10 {
	static inline var data = "3113322113";

	static function compute(runs:Int):Int {
		var data = data;

		for (_ in 0...runs) {
			var groups = [[data.charAt(0)]];

			for (j in 1...data.length) {
				var c = data.charAt(j);

				if (c == groups[groups.length - 1][0]) {
					groups[groups.length - 1].push(c);
				} else {
					groups.push([c]);
				}
			}

			var newdata = new StringBuf();

			for (group in groups) {
				newdata.add('${group.length}${group[0]}');
			}

			data = newdata.toString();
		}

		return data.length;
	}

	public static function part1():Int {
		return compute(40);
	}

	public static function part2():Int {
		return compute(50);
	}
}
