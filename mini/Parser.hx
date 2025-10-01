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

using StringTools;

class Parser {
    public static function print(ini:Ini):String {
        return ini.toString();
    }

    // ugh these @:noCompletion metas look so weird.
    @:noCompletion static final regexSection:EReg = ~/^\[(.+)\]$/;
    @:noCompletion static final regexNode:EReg = ~/^([^#;][^=]+)=(.*)$/;
    @:noCompletion static final regexTripleQuote:EReg = ~/^"""\s*(.*)$/;
    @:noCompletion static final regexEndTripleQuote:EReg = ~/(.*?)"""\s*$/;
    @:noCompletion static final regexComment:EReg = ~/^([;#])(.*)$/;

    public static function parse(data:String):Ini {
        var __current:Null<Ini> = null;

        final doc:Ini = Ini.createDocument();
        final lines:Array<String> = data.split("\n");

        var i:Int = 0;
        while (i < lines.length) {
            var line = lines[i].trim(); i++;
            if (line == "" || line.length <= 0) continue;

			// comments
            if (regexComment.match(line)) {
                var content = regexComment.matched(2).trim();
                (__current == null ? doc : __current).addChild(new Ini(Comment, null, content));
                continue;
            }

			// sections
            if (regexSection.match(line)) {
                doc.addChild(__current = new Ini(Section, regexSection.matched(1).trim()));
                continue;
            } else if (line.startsWith("[") || line.endsWith("]")) {
                // malformed section exception
                throw new Exception(EMalformedSection(line), i);
            }

			// nodes
            if (regexNode.match(line)) {
                final key = regexNode.matched(1).trim();
                var value = regexNode.matched(2).trim();

				// \ lines nodes
                while (value.endsWith("\\")) {
                    value = StringTools.rtrim(value.substring(0, value.length - 1));
                    if (i < lines.length) {
                        value += "\n" + lines[i].trim();
                        i++;
                    } else {
                        break;
                    }
                }

				// """ """ nodes
                if (regexTripleQuote.match(value)) {
                    var _collected:String = regexTripleQuote.matched(1);
                    var __fEnd:Bool = false;

                    final __startingL:Int = i; 
                    while (i < lines.length) {
                        final _nextLine:String = lines[i++];
                        if (regexEndTripleQuote.match(_nextLine)) {
                            _collected += "\n" + regexEndTripleQuote.matched(1);
                            __fEnd = true; break;
                        } else {
                            _collected += "\n" + _nextLine;
                        }
                    }

                    if (!__fEnd) {
                        // should we throw or trace???
                        throw new Exception(EUnterminatedMultilineValue(key), __startingL);
                    }
                    value = _collected;
                }

                if ((value.startsWith('"') && value.endsWith('"')) || (value.startsWith("'") && value.endsWith("'"))) {
                    value = value.substring(1, value.length - 1);
                }

                (__current == null ? doc : __current).addChild(Ini.createKey(key, value));
			} else {
				// unknown line exception
				throw new Exception(EUnknownLine, i);
			}
		}


        return doc;
    }
}
