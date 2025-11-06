package tests;

final class Long extends Test {
	@:noCompletion override function test():Null<Bool> {
		final ini = Parser.parse(#if js Resource.getString("js_testing_long_ini") #else File.getContent('resources/testing_long.ini') #end);
		for (section in ini.elements()) {
			if (section.nodeType == Comment)
				continue;
			trace('[${section.nodeName}]');

			var i = 0;
			for (key in section.keys()){
				trace('${key.nodeName} = ${section.get(key.nodeName)}');
			i++;}

			
			if(i > 1)
				trace('');

			for (child in section.find(node -> node.nodeName == "welcome message")) {
				trace("FOUND IT: " + child.nodeValue);
			}
		}

		return !super.test();
	}
}
