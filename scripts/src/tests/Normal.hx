package tests;

final class Normal extends Test {
	override public function test():Null<Bool> {
		final ini:Ini = Parser.parse(#if js Resource.getString('js_testing_ini') #else File.getContent('resources/testing.ini') #end);

		final main:Ini = ini.elementsNamed("main.test").next();
		heading('Global Node');
		trace(main.get('name'));
		trace(main.get('cutie'));

		final general:Ini = ini.elementsNamed("General").next();
		heading('[General] Node');
		trace(general.get("version"));
		trace(general.get("theme"));

		#if sys Sys.println #else trace #end (#if sys "\n" + #end"All tests passed!\n");
		return !super.test();
	}
}
