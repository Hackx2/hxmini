package;

#if !js
import sys.io.File;
#end
import mini.*;

class Main {
	static inline function separate(val:String):Void {
		return trace('-------- $val');
	}

	static function main():Void {
		trace('<---------------------- Testing ---------------------->\n');
		final ini:Ini = #if js Parser.parse('[main.test]
			name="hackx2"
			cutie="milo"

			[General]
			version=1.0
			theme=dark

			[User:General]
			username="Milo"
			role=Admin

			[User2:General]
			username="Orbl"
			role=User
			theme="Gold"') #else Parser.parse(File.getContent('resources/testing.ini')) #end;
		//
		// Normal .ini parsing test!
		//

		// NORMAL ELEMENT TESTING
		final main:Ini = ini.elementsNamed("main.test").next();
		separate('Global');
		trace(main.get('name'));
		trace(main.get('cutie'));

		// USER ELEMENT & INHERITED TESTING
		final general:Ini = ini.elementsNamed("General").next();
		separate('[General] normal');
		trace(general.get("version"));
		trace(general.get("theme"));

		// END TEST!
		trace("\nAll tests passed!\n");

		#if !js
		//
		// Long .ini file parsing test
		//
		if (sys.FileSystem.exists('resources/testing_long.ini')) {
			final ini:Ini = Parser.parse(File.getContent('resources/testing_long.ini'));
			for (section in ini.elements()) {
				if (section.nodeType == Comment)
					continue;
				separate('[' + section.nodeName + ']');
				for (key in section.keys())
					trace('${key.nodeName} = ${section.get(key.nodeName)}');
				trace('');

				for (child in section.find(node -> node.nodeName == "welcome message")) {
					trace("FOUND IT: " + child.nodeValue);
				}
			}
			trace("\nduh long file test!\n");
			separate('[Sending Full long.ini tostring]');
			trace(ini.toString());
		}
		#end

		//
		// Creating a .ini file using haxe
		//
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
