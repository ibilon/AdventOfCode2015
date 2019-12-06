package days;

import sys.io.File;

enum Json {
	JArray(arr:Array<Json>);
	JObject(obj:Map<String, Json>);
	JString(str:String);
	JInt(i:Int);
}

class JsonParser {
	final data:String;
	var cursor = 0;

	public function new(data:String) {
		this.data = data;
	}

	public function parse():Json {
		return parseAny();
	}

	function parseAny() {
		return switch (data.charAt(cursor)) {
			case "[":
				parseArray();
			case "{":
				++cursor;
				parseObject();
			case '"':
				parseString();
			case "-", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
				parseInt();
			case c:
				throw 'unknown type "$c" at $cursor';
		}
	}

	function parseArray() {
		var arr = [];
		var c;

		while ((c = data.charAt(++cursor)) != "]") {
			if (c == ",") {
				continue;
			}

			arr.push(parseAny());
		}

		return JArray(arr);
	}

	function parseObject() {
		var obj = new Map<String, Json>();

		while (true) {
			var key = switch (parseString()) {
				case JString(str): str;
				default: throw "should not happen";
			}

			cursor += 2;
			obj.set(key, parseAny());

			switch (data.charAt(++cursor)) {
				case "}":
					break;
				case ",":
					++cursor;
			}
		}

		return JObject(obj);
	}

	function parseString() {
		var buf = new StringBuf();
		var c;

		while ((c = data.charAt(++cursor)) != '"') {
			buf.add(c);
		}

		return JString(buf.toString());
	}

	function parseInt() {
		var number = 0;
		var negNumber = false;

		while (true) {
			switch (data.charAt(cursor)) {
				case "", "}", "]", ",":
					break;
				case "-":
					negNumber = true;
					++cursor;
				case i:
					number = number * 10 + Std.parseInt(i);
					++cursor;
			}
		}

		--cursor;
		return JInt(negNumber ? -number : number);
	}
}

class Day12 {
	static function compute(?ignoreProp:String):Int {
		var sum = 0;

		function walk(json:Json) {
			switch (json) {
				case JArray(arr):
					for (a in arr) {
						walk(a);
					}
				case JObject(obj):
					var valid = true;

					for (o in obj) {
						switch (o) {
							case JString(str) if (str == ignoreProp):
								valid = false;
								break;
							default:
						}
					}

					if (!valid) {
						return;
					}

					for (o in obj) {
						walk(o);
					}
				case JString(_):
				case JInt(i):
					sum += i;
			}
		}

		walk(new JsonParser(File.getContent("data/day12.txt")).parse());

		return sum;
	}

	public static function part1():Int {
		return compute();
	}

	public static function part2():Int {
		return compute("red");
	}
}
