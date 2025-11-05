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
