package mini;

import mini.Lexer;
import haxe.extern.EitherType;

using StringTools;

class Parser {
	@:deprecated public static function print(ini:Ini):String {
		return ini.toString();
	}

	/**
	 * Parses a string into a `Ini` class.
	 * @param string input string
	 * @return Returned a fully structured `Ini` class.
	 */
	public function parseString(string:String):Ini {
		return parse(Lexer.tokenize(string));
	}

	/**
	 * Parses a list of tokens or a string into a `Ini` class.
	 * @param tokens Either `String` or `Array<LToken>`
	 * @return Returned a fully structured `Ini` class.
	 */
	public static function parse(tokens:EitherType<String, Array<LToken>>):Ini {
		// !!! Support For previous versions of hxmini. !!!
		final lexTokens:Array<LToken> = tokens is String ? Lexer.tokenize(tokens) : cast tokens;

		final doc:Ini = Ini.createDocument();
		var currentSection:Ini = doc;

		var i:Int = 0;
		while (i < lexTokens.length) {
			switch (lexTokens[i]) {
				case Section(name):
					final section:Ini = new Ini(Section, name);
					doc.addChild(section);
					currentSection = section;
					i++;

				case Comment(comment):
					currentSection.addChild(new Ini(Comment, null, comment));
					i++;

				case Key(key):
					i++;
					if (i >= lexTokens.length || lexTokens[i] != Equals)
						throw new Exception(ECustom('Expected "="(equals) after key "$key"'));
					i++;
					if (i >= lexTokens.length)
						throw new Exception(ECustom('Expected value after key "$key"'));
					switch (lexTokens[i]) {
						case Value(value):
							currentSection.addChild(Ini.createKey(key, value));
							i++;
						default:
							throw new Exception(ECustom('Expected value after key "$key"'));
					}

				case Newline:
					i++;

				case Eof:
					return doc;

				default:
					throw new Exception(ECustom('Unexpected token at position $i: ' + lexTokens[i]));
			}
		}

		return doc;
	}
}
