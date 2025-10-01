package tests;

import mini.Access as MAccess;

final class Access extends Test {
	override public function test():Null<Bool> {
		final ini:Ini = Parser.parse(#if js Resource.getString('js_testing_ini') #else File.getContent('resources/testing.ini') #end);
		final access:MAccess = new MAccess(ini);

		if (access.has.section.General) {
			trace('has General section');
			if (access.section.General.has.key.version) {
				trace('has General.version key');
			}
			trace(access.section.General.key.version);
		}

		for (s in access.sections) {
			trace(s.name);
		}

		for (s in access.keys) {
			trace('${s.name} = ${s.value}');
		}

		for (s in access.comments) {
			trace('Comment: ${s.value}');
		}

		return !super.test();
	}
}
