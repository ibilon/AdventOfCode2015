package days;

import sys.io.File;

typedef Reindeer = {
	final speed:Int;
	final flyTime:Int;
	final restTime:Int;
	var dist:Int;
	var points:Int;
	var state:State;
}

enum State {
	Flying(left:Int);
	Resting(left:Int);
}

class Day14 {
	static inline function imin(a:Int, b:Int):Int {
		return a < b ? a : b;
	}

	static function max<T>(a:Array<T>, fn:(e:T) -> Int):Int {
		var max = 0;

		for (e in a) {
			var v = fn(e);
			if (v > max) {
				max = v;
			}
		}

		return max;
	}

	static function run():Array<Reindeer> {
		var reindeers = [];

		for (reindeer in File.getContent("data/day14.txt").split("\n")) {
			var reindeer = reindeer.split(" ");
			var speed = Std.parseInt(reindeer[3]);
			var flyTime = Std.parseInt(reindeer[6]);
			var restTime = Std.parseInt(reindeer[13]);

			reindeers.push({
				speed: speed,
				flyTime: flyTime,
				restTime: restTime,
				dist: 0,
				points: 0,
				state: Flying(flyTime)
			});
		}

		for (_ in 0...2503) {
			var max = 0;

			for (r in reindeers) {
				switch (r.state) {
					case Flying(left):
						r.dist += r.speed;

						r.state = if (left == 1) {
							Resting(r.restTime);
						} else {
							Flying(left - 1);
						}
					case Resting(left):
						r.state = if (left == 1) {
							Flying(r.flyTime);
						} else {
							Resting(left - 1);
						}
				}

				if (r.dist > max) {
					max = r.dist;
				}
			}

			for (r in reindeers) {
				if (r.dist == max) {
					++r.points;
				}
			}
		}

		return reindeers;
	}

	public static function part1() {
		return max(run(), r -> r.dist);
	}

	public static function part2():Int {
		return max(run(), r -> r.points);
	}
}
