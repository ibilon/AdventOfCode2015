package days;

class Day11 {
	static inline var data = "vzbxkghb";

	static function next(password:String):String {
		var password = password.split("");

		function charNext(i:Int) {
			var c = password[i].charCodeAt(0);

			if (c == "z".code) {
				password[i] = "a";
				charNext(i - 1);
			} else {
				password[i] = String.fromCharCode(c + 1);
			}
		}

		while (true) {
			charNext(password.length - 1);

			var rule1 = false;

			for (i in 0...password.length - 2) {
				var c1 = password[i].charCodeAt(0);
				var c2 = password[i + 1].charCodeAt(0);
				var c3 = password[i + 2].charCodeAt(0);

				if (c2 == c1 + 1 && c3 == c2 + 1) {
					rule1 = true;
					break;
				}
			}

			if (!rule1 || password.indexOf("i") != -1 || password.indexOf("o") != -1 || password.indexOf("l") != -1) {
				continue;
			}

			var pairs = 0;
			var i = -1;
			while (++i < password.length - 1) {
				if (password[i] == password[i + 1]) {
					++pairs;
					++i;
				}
			}

			if (pairs >= 2) {
				return password.join("");
			}
		}
	}

	public static function part1():String {
		return next(data);
	}

	public static function part2():String {
		return next(next(data));
	}
}
