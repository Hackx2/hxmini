package tests;

final class Long extends Test {
	override public function test():Null<Bool> {
		final ini = Parser.parse(#if js Resource.getString("js_testing_long_ini") #else File.getContent('resources/testing_long.ini') #end);
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

		return !super.test();
	}
}
