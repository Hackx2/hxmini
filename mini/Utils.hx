package mini;

final class Utils {
	/**
	 * @see https://en.wikipedia.org/wiki/Whitespace_character
	 */
	@:pure public inline static function isWhitespace(c:String):Bool {
		final _code:Null<Int> = c.charCodeAt(0);
		return _code == 32 /* space */
			|| _code == 9 /* character tabulation */
			|| _code == 13 /* carriage return */
			|| _code == 10 /* line feed ??? */;
	}

	public inline static function trim_right(s:String):String { // LET ME SLEEP PLEASE
		var i:Int = (s.length - 1);
		while (i >= 0 && isWhitespace(s.charAt(i))) { i--; }
		return s.substring(0, i + 1);
	}

	public inline static function fixMultiline(b:String):String {
		if (b == null) {
			return "";
		}
		if (b.indexOf("\n") != -1) {
			return '"""\n$b\n"""';
		}
		return b;
	}
}
