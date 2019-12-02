package days;

import haxe.crypto.Md5;

using StringTools;

class Day04 {
	static inline var data = "ckczppom";

	static function find(prefix:String):Int {
		var i = 0;
		while (!Md5.encode('$data${++i}').startsWith(prefix)) {}
		return i;
	}

	public static function part1():Int {
		return find("00000");
	}

	public static function part2():Int {
		return find("000000");
	}
}
