package mini;

using StringTools;

enum LToken {
	Section(section:String); // [ blah ]
	Key(key:String); // what =
	Value(value:String); // = muhehehe
	Comment(comment:String); // ; hi
	Equals; // =
	Newline; // \n
	Eof; // end of file
}

// make into an instance, or?
class Lexer {
	static final regexSection:EReg = ~/^\[(.+)\]$/;
	static final regexNode:EReg = ~/^([^#;][^=]+)=(.*)$/;
	static final regexTripleQuote:EReg = ~/^"""\s*(.*)$/;
	static final regexEndTripleQuote:EReg = ~/(.*?)"""\s*$/;
	static final regexComment:EReg = ~/^([;#])(.*)$/;

	/**
	 * Turns the inputted string into a list of tokens.
	 * @param input input string
	 * @return Outputs Array<LToken>
	 */
	public static function tokenize(data:String):Array<LToken> {
		final tokens:Array<LToken> = new Array<LToken>();
		final lines:Array<String> = data.split("\n");

		var i:Int = 0;
		while (i < lines.length) {
			final line:String = lines[i].trim();
			i++;

			if (line == "" || line.length == 0) {
				tokens.push(Newline);
				continue;
			}

			// comment
			if (regexComment.match(line)) {
				tokens.push(Comment(regexComment.matched(2).trim()));
				tokens.push(Newline);
				continue;
			}

			// section
			if (regexSection.match(line)) {
				tokens.push(Section(regexSection.matched(1).trim()));
				tokens.push(Newline);
				continue;
			} else if (line.startsWith("[") || line.endsWith("]")) {
				// malformed section exception
				throw new Exception(EMalformedSection(line), i);
			}

			// Key = Value
			if (regexNode.match(line)) {
				final key:String = regexNode.matched(1).trim();
				var value:String = regexNode.matched(2).trim();

				while (value.endsWith("\\")) {
					value = StringTools.rtrim(value.substring(0, value.length - 1));
					if (i < lines.length) {
						value += "\n" + lines[i].trim();
						i++;
					} else
						break;
				}

				// """ """ nodes
				if (regexTripleQuote.match(value)) {
					var collected:String = regexTripleQuote.matched(1);
					var closed:Bool = false;
					final starting:Int = i;
					while (i < lines.length) {
						final next:String = lines[i++];
						if (regexEndTripleQuote.match(next)) {
							collected += "\n" + regexEndTripleQuote.matched(1);
							closed = true;
							break;
						} else {
							collected += "\n" + next;
						}
					}
					if (!closed) {
						// should we throw or trace???
						throw new Exception(EUnterminatedMultilineValue(key), starting);
					}
					value = collected;
				}

				if ((value.startsWith('"') && value.endsWith('"')) || (value.startsWith("'") && value.endsWith("'")))
					value = value.substring(1, value.length - 1);

				tokens.push(Key(key));
				tokens.push(Equals);
				tokens.push(Value(value));
				tokens.push(Newline);
				continue;
			}

			throw new Exception(EUnknownLine, i);
		}

		tokens.push(Eof);
		return tokens;
	}
}
