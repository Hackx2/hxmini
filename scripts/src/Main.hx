package;

import mini.Ini;
import mini.Parser;

#if js
import haxe.http.HttpJs;
#else
import sys.io.File;
#end

class Main {
    static inline function heading(val:String):Void {
        trace('-------- $val');
    }

    static function main():Void {
        trace('<---------------------- Testing ---------------------->\n');
        testNormalIniParsing();
        testLongIniParsing();
        testIniCreation();

		trace(mini.EntryType.fromString('Document'));
    }

    static function testNormalIniParsing():Void {
        final ini:Ini = Parser.parse(
            #if js
            HttpJs.requestUrl('resources/testing.ini')
            #else
            File.getContent('resources/testing.ini')
            #end
        );

        final main:Ini = ini.elementsNamed("main.test").next();
        heading('Global');
        trace(main.get('name'));
        trace(main.get('cutie'));

        final general:Ini = ini.elementsNamed("General").next();
        heading('[General] normal');
        trace(general.get("version"));
        trace(general.get("theme"));

        trace("\nAll tests passed!\n");
    }

    static function testLongIniParsing():Void {
        #if js
        final cc = HttpJs.requestUrl("resources/testing_long.ini");
        if (cc != null) {
            parseAndTraceLongIni(Parser.parse(cc));
        }
        #else
        if (sys.FileSystem.exists('resources/testing_long.ini')) {
            parseAndTraceLongIni(Parser.parse(File.getContent('resources/testing_long.ini')));
        }
        #end
    }

    static function parseAndTraceLongIni(ini:Ini):Void {
        for (section in ini.elements()) {
            if (section.nodeType == Comment)
                continue;
            heading('[' + section.nodeName + ']');
            for (key in section.keys())
                trace('${key.nodeName} = ${section.get(key.nodeName)}');
            trace('');

            for (child in section.find(node -> node.nodeName == "welcome message")) {
                trace("FOUND IT: " + child.nodeValue);
            }
        }
        trace("\nduh long file test!\n");
        heading('[Sending Full long.ini tostring]');
        trace(ini.toString());
    }

    static function testIniCreation():Void {
        final ini:Ini = Ini.createDocument();

        final general:Ini = Ini.createSection("General");
        general.set("name", "MyApp");
        general.set("version", "1.0");
        general.comment("This is gay");
        ini.addChild(general);

        final user:Ini = Ini.createSection("User");
        user.set("username", "Milo");
        user.set("role", "Admin");
        ini.addChild(user);

        final net:Ini = Ini.createSection("Network");
        net.set("ip", "192.168.0.5");
        net.set("port", "8080");
        ini.addChild(net);

        final miloNetworkInherit:Ini = Ini.createSection("Milo:Network", ini);
        miloNetworkInherit.set("hi", "heyo!!!");
        ini.addChild(miloNetworkInherit);

        trace(ini.toString());
    }
}