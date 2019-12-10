package days;

import sys.io.File;

class Day19 {
	public static function part1():Int {
		var data = File.getContent("data/day19.txt");
		var s = data.indexOf("\n\n");

		var mol = [];
		var buf = new StringBuf();
		for (c in data.substr(s + 2).split("")) {
			if (c.toUpperCase() == c) {
				if (buf.length > 0) {
					mol.push(buf.toString());
					buf = new StringBuf();
				}
			}
			buf.add(c);
		}
		if (buf.length > 0) {
			mol.push(buf.toString());
		}

		var trans = new Map<String, Array<String>>();
		for (t in data.substr(0, s).split("\n")) {
			var t = t.split(" => ");
			if (!trans.exists(t[0])) {
				trans.set(t[0], []);
			}
			trans.get(t[0]).push(t[1]);
		}

		var res = new Map<String, Bool>();

		for (i in 0...mol.length) {
			var c = mol[i];
			if (trans.exists(c)) {
				for (t in trans.get(c)) {
					var m = mol.copy();
					m[i] = t;
					res.set(m.join(""), true);
				}
			}
		}

		return Lambda.count(res);
	}

	public static function part2():Int {
		return 0;
	}
}
