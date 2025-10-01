/*
 * MIT License
 *
 * Copyright (c) 2025 Hackx2
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
 * Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
 * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH
 * THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

package mini;

/**
 * matter.ini's utility class.
 * 
 * This class contains all methods / variables utilized by matter.ini
 */
final class Utils {
	/**
	 * Determines whether the first character of the given string is a whitespace character.
	 * @param c The input string to check.
	 * @return `true` if the first character is a whitespace character; otherwise, `false`.
	 *
	 * @see https://en.wikipedia.org/wiki/Whitespace_character
	 */
	@:deprecated
	@:pure public inline static function isWhitespace(c:String):Bool {
		final _code:Null<Int> = c.charCodeAt(0);
		return _code == 32 /* space */
			|| _code == 9 /* character tabulation */
			|| _code == 13 /* carriage return */
			|| _code == 10 /* line feed ??? */;
	}

	/**
	 * Maps a iterator, i'll try find a better method but ayee
	 * @param it 
	 * @return Iterable<T>
	 */
	public static function mapIterator<T, R>(it:Iterator<T>, fn:T->R):Iterator<R> {
		return {
			hasNext: it.hasNext,
			next: () -> fn(it.next())
		};
	}

	/**
	 * Converts a iterator into a iterable.
	 * @param it 
	 * @return Iterable<T>
	 */
	public static function iterableFromIterator<T>(it:Iterator<T>):Iterable<T> {
		return {
			iterator: () -> it
		};
	}


	/**
	 * Trims trailing whitespace from the given string.
	 *
	 * This function is deprecated in favor of `StringTools.rtrim`, which provides the same behavior.
	 * It removes common trailing whitespace characters (space, tab, carriage return, line feed).
	 *
	 * @param s The input string to trim.
	 * @return A new string with trailing whitespace removed.
	 * 
	 * @see https://api.haxe.org/StringTools.html#rtrim
	 */
	@:deprecated
	public inline static function trim_right(s:String):String { // LET ME SLEEP PLEASE
		var i:Int = (s.length - 1);
		while (i >= 0 && isWhitespace(s.charAt(i))) { i--; }
		return s.substring(0, i + 1);
	}
	
	/**
	 * Wraps multiline strings.
	 * @param b given string
	 * @return wrapped string.
	 */
	public inline static function wrapMultiline(b:String):String { if (b == null || b.indexOf("\n") == -1) return b == null ? "" : b; return '"""\n$b\n"""'; }
	@:deprecated("mini.Utils.fixMultiline is deprecated, use mini.Utils.wrapMultiline instead")
	public static inline function fixMultiline(b:String):String { return Utils.wrapMultiline(b);}
}
