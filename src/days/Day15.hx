package days;

import haxe.ds.Option;
import sys.io.File;

typedef Ingredients = {
	c:Int,
	d:Int,
	f:Int,
	t:Int,
	cal:Int,
}

class PermGen {
	var a:Array<Int>;
	var size:Int;

	public function new(size:Int) {
		this.size = size - 1;
		this.a = [for (_ in 0...this.size) 0];
		this.a[this.size - 1] = -1;
	}

	function sum(to:Int):Int {
		var s = 0;
		for (i in 0...to) {
			s += a[i];
		}
		return s;
	}

	function increase(d:Int) {
		if (d == -1) {
			return false;
		}

		if (++a[d] > 100 - sum(d)) {
			a[d] = 0;
			return increase(d - 1);
		}

		return true;
	}

	public function next():Option<Array<Int>> {
		if (!increase(size - 1)) {
			return None;
		}

		var n = a.copy();
		n.push(100 - sum(size));
		return Some(n);
	}
}

class Day15 {
	static function sum(i:Array<Ingredients>, q:Array<Int>, s:(i:Ingredients) -> Int):Int {
		var t = 0;

		for (j in 0...i.length) {
			t += s(i[j]) * q[j];
		}

		return t < 0 ? 0 : t;
	}

	static function run(filter:(i:Array<Ingredients>, q:Array<Int>) -> Bool):Int {
		var i = [];

		for (line in File.getContent("data/day15.txt").split("\n")) {
			var line = line.split(":");
			var list = line[1].split(",").map(e -> e.split(" "));

			i.push({
				c: Std.parseInt(list[0][2]),
				d: Std.parseInt(list[1][2]),
				f: Std.parseInt(list[2][2]),
				t: Std.parseInt(list[3][2]),
				cal: Std.parseInt(list[4][2]),
			});
		}

		var max = 0;
		var gen = new PermGen(i.length);

		while (true) {
			switch (gen.next()) {
				case Some(q):
					if (!filter(i, q)) {
						continue;
					}

					var c = sum(i, q, i -> i.c);
					var d = sum(i, q, i -> i.d);
					var f = sum(i, q, i -> i.f);
					var t = sum(i, q, i -> i.t);

					var total = c * d * f * t;

					if (total > max) {
						max = total;
					}

				case None:
					break;
			}
		}

		return max;
	}

	public static function part1():Int {
		return run((i, q) -> true);
	}

	public static function part2():Int {
		return run((i, q) -> sum(i, q, i -> i.cal) == 500);
	}
}
