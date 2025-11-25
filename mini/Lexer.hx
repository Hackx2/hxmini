package mini;

import haxe.io.Bytes;

using StringTools;

// backwards compatibility
@:deprecated typedef LToken = Token;

enum Token {
	Section(section:String); // [ blah ]
	Key(key:String); // what =
	Value(value:String); // = muhehehe
	Comment(comment:String); // ; hi
	Equals; // =
	Newline; // \n
	Eof; // end of file
}

// make into an instance, or?

@:nullSafety(Strict)
class Lexer {
	/**
	 * Turns the inputted string into a list of tokens.
	 * @param input input string
	 * @return Outputs Array<LToken>
	 */
	public static function tokenize(data:String):Array<Token> {
		inline function isComment(c:Null<Int>):Bool
			return c == null ? false : c == ';'.code || c == '#'.code;

		final tokens:Array<Token> = new Array<Token>();
		final bytes:Bytes = Bytes.ofString(data);

		var pos:Int = 0;
		var lineNo:Int = 1;

		inline function readLine():Null<String> {
			if (pos >= bytes.length)
				return null;
			final start:Int = pos;
			while (pos < bytes.length && bytes.get(pos) != '\n'.code)
				pos++;
			final s:String = bytes.sub(start, pos - start).toString();
			if (pos < bytes.length && bytes.get(pos) == '\n'.code)
				pos++;
			lineNo++;
			return s;
		}

		var line:Null<String> = readLine();
		while (line != null) {
			final l:Null<String> = line;
			var start:Int = 0;
			var end:Int = l.length;

			while (start < end && ((l.charCodeAt(start) ?? -1) <= ' '.code))
				start++;
			while (end > start && ((l.charCodeAt(end - 1) ?? -1) <= ' '.code))
				end--;

			final trimmed:String = l.substring(start, end);

			if (trimmed == "") {
				tokens.push(Newline);
				line = readLine();
				continue;
			}

			final f:Null<Int> = trimmed.charCodeAt(0);
			if (f == null)
				continue;
			if (isComment(f)) {
				tokens.push(Comment(trimmed.substring(1).trim()));
				tokens.push(Newline);
				line = readLine();
				continue;
			}

			// Section
			if (f == '['.code) {
				final closeIndex:Int = trimmed.indexOf("]");
				if (closeIndex == -1)
					throw new Exception(EMalformedSection(trimmed), lineNo - 1);

				// inlined comments
				final t:String = trimmed.substring(closeIndex + 1).ltrim();
				if (t.length > 0 && !isComment(t.charCodeAt(0)))
					throw new Exception(EMalformedSection(trimmed), lineNo - 1);

				tokens.push(Section(trimmed.substring(1, closeIndex).trim()));
				if (t.length > 0)
					tokens.push(Comment(t.substring(1).trim()));
				tokens.push(Newline);

				line = readLine();
				continue;
			}

			// Key = Value
			final indexOf:Int = trimmed.indexOf("=");
			if (indexOf != -1) {
				final key:String = trimmed.substring(0, indexOf).rtrim();
				if (key == "" || key.length > 0 && isComment(key.charCodeAt(0)))
					throw new Exception(EUnknownLine, lineNo - 1);

				var value:String = trimmed.substring(indexOf + 1).ltrim();
				var comment:String = "";

				// comment detection...
				var commentPos:Int = -1;
				for (i in 0...value.length) {
					if (isComment(value.charCodeAt(i))) {
						commentPos = i;
						break;
					}
				}
				if (commentPos != -1) {
					comment = value.substring(commentPos + 1).rtrim();
					value = value.substring(0, commentPos).rtrim();
				}

				var buf:StringBuf = new StringBuf();
				buf.add(value);

				var isTripleQuoteThingy:Bool = value.startsWith('"""') || value.startsWith("'''");
				var tripleMarker:Null<Null<String>> = isTripleQuoteThingy ? value.substr(0, 3) : null;
				if (isTripleQuoteThingy) {
					buf = new StringBuf();
					buf.add(value.substring(3).rtrim());
				}

				while (true) {
					if (isTripleQuoteThingy && tripleMarker != null) {
						var nxtLine:Null<String> = readLine();
						if (nxtLine == null)
							throw new Exception(EUnterminatedMultilineValue(key), lineNo - 1);

						final idx:Int = nxtLine.indexOf(tripleMarker);
						if (idx != -1) {
							buf.add('\n${nxtLine.substring(0, idx)}');
							final t:String = nxtLine.substring(idx + 3).ltrim();
							if (t != "" && isComment(t.charCodeAt(0)))
								tokens.push(Comment(t.substring(1).trim()));
							break;
						}
						buf.add('\n$nxtLine');
						continue;
					}

					final s:String = buf.toString();
					if (!s.endsWith("\\"))
						break;

					buf = new StringBuf();
					buf.add(s.substring(0, s.length - 1).rtrim());

					final nxtLine:Null<String> = readLine();
					if (nxtLine == null)
						break;

					var st:Int = 0, en:Int = nxtLine.length;
					while (st < en && (nxtLine.charCodeAt(st) ?? -1) <= ' '.code) // i'm lazyy :( -orbl
						st++;
					while (en > st && (nxtLine.charCodeAt(en - 1) ?? -1) <= ' '.code)
						en--;

					buf.add("\n");
					buf.add(nxtLine.substring(st, en));
				}
				value = buf.toString();

				// removes surrounding quotes....
				// "hi" -> hi
				// 'hi' -> hi
				// "hi -> "hi
				// "\"hi"\" -> "hi"
				final vl:Int = value.length;
				if ((vl >= 2)
					&& ((value.charAt(0) == '"' && value.charAt(vl - 1) == '"')
						|| (value.charAt(0) == "'" && value.charAt(vl - 1) == "'")))
					value = value.substring(1, vl - 1);

				if (comment != "")
					tokens.push(Comment(comment.trim()));
				for (i in [Key(key), Equals, Value(value), Newline])
					tokens.push(i);

				line = readLine();
				continue;
			}

			throw new Exception(EUnknownLine, lineNo - 1);
		}

		tokens.push(Eof);
		return tokens;
	}
}
