package mini;

using StringTools;

class Parser {
    public static function print(ini:Ini):String {
        return ini.toString();
    }

    // ugh these @:noCompletion metas look so weird.
    @:noCompletion static final regexSection:EReg = ~/^\[(.+)\]/;
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
                        throw 'Unterminated multiline value for key "$key"';
                    }
                    value = _collected;
                }

                if ((value.startsWith('"') && value.endsWith('"')) || (value.startsWith("'") && value.endsWith("'"))) {
                    value = value.substring(1, value.length - 1);
                }

                (__current == null ? doc : __current).addChild(Ini.createKey(key, value));
            }
        }

        return doc;
    }
}
