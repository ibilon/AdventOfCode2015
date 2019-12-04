package days;

import sys.io.File;

enum Connection {
	Signal(value:Int);
	And(a:String, b:String);
	Or(a:String, b:String);
	Not(a:String);
	LShift(a:String, f:Int);
	RShift(a:String, f:Int);
	Pass(a:String);
}

class Day07 {
	static function compute(?signalOverrides:Map<String, Int>):Int {
		if (signalOverrides == null) {
			signalOverrides = [];
		}

		var ready = [];
		var wires = new Map<String, Connection>();
		var reverse = new Map<String, Array<String>>();
		var values = new Map<String, Int>();

		function set(wire:String, conn:Connection) {
			function addToReverse(key:String, value:String) {
				if (!reverse.exists(key)) {
					reverse.set(key, []);
				}
				reverse.get(key).push(value);

				switch (Std.parseInt(key)) {
					case null:
					case i:
						values.set(key, i);
						ready.push(key);
				}
			}

			wires.set(wire, conn);
			switch (conn) {
				case Signal(_):
					ready.push(wire);
				case And(a, b), Or(a, b):
					addToReverse(a, wire);
					addToReverse(b, wire);
				case Not(a), LShift(a, _), RShift(a, _), Pass(a):
					addToReverse(a, wire);
			}
		}

		for (conn in File.getContent("data/day07.txt").split("\n")) {
			var conn = conn.split(" ");

			switch (conn.length) {
				case 3:
					if (signalOverrides.exists(conn[2])) {
						var i = signalOverrides.get(conn[2]);
						set(conn[2], Signal(i));
						values.set(conn[0], i);
						continue;
					}

					switch (Std.parseInt(conn[0])) {
						case null:
							set(conn[2], Pass(conn[0]));
						case i:
							set(conn[2], Signal(i));
							values.set(conn[0], i);
					}

				case 4:
					set(conn[3], Not(conn[1]));

				case 5:
					set(conn[4], switch (conn[1]) {
						case "AND": And(conn[0], conn[2]);
						case "OR": Or(conn[0], conn[2]);
						case "LSHIFT": LShift(conn[0], Std.parseInt(conn[2]));
						case "RSHIFT": RShift(conn[0], Std.parseInt(conn[2]));
						default: throw "unknown op";
					});
			}
		}

		function isReady(wire:String):Bool {
			return switch (wires.get(wire)) {
				case Signal(_): true;
				case And(a, b), Or(a, b): values.exists(a) && values.exists(b);
				case Not(a), LShift(a, _), RShift(a, _), Pass(a): values.exists(a);
			}
		}

		function compute(wire:String):Int {
			if (values.exists(wire)) {
				return values.get(wire);
			}
			return switch (wires.get(wire)) {
				case Signal(i): i;
				case And(a, b): values.get(a) & values.get(b);
				case Or(a, b): values.get(a) | values.get(b);
				case Not(a): (~values.get(a)) & 0xFFFF;
				case LShift(a, f): values.get(a) << f;
				case RShift(a, f): values.get(a) >> f;
				case Pass(a): values.get(a);
			}
		}

		while (ready.length != 0) {
			var w = ready.pop();
			values.set(w, compute(w));

			if (reverse.exists(w)) {
				for (lw in reverse.get(w)) {
					if (!values.exists(lw) && isReady(lw)) {
						ready.push(lw);
					}
				}
			}
		}

		return values.get("a");
	}

	public static function part1():Int {
		return compute();
	}

	public static function part2():Int {
		return compute(["b" => 46065]);
	}
}
