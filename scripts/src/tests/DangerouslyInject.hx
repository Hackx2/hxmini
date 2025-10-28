package tests;

/**
 * I have no idea why one would want this, but you do you...
 * 
 * @since 1.0.2
 */
final class DangerouslyInject extends Test {
	override public function test():Null<Bool> {
		final ini:Ini = Parser.parse('[section_alt]\ntest1="i\'m sorry :("\n\n\n');
		ini.dangerouslyInject('[section]\nactual_test="yes, this is indeed a test..."');
		trace('dangerous section added: ' + Parser.parse(ini.toString()).elementsNamed('section').next().get('actual_test'));

		trace(ini.toString());
		return !super.test();
	}
}
