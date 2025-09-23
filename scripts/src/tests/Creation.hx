package tests;

final class Creation extends Test {
	override public function test():Null<Bool> {
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

		return !super.test();
	}
}
