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

	@:deprecated("Use Utils.wrapMultiline(v1) instead")
	public static inline function fixMultiline(b:String):String {
		return Utils.wrapMultiline(b);
	}
	
	public inline static function wrapMultiline(b:String):String {
		if (b == null || b.indexOf("\n") == -1) return b == null ? "" : b;
		return '"""\n$b\n"""';
	}
}
