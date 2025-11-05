package tests;

import mini.Lexer;

final class LexerTest extends Test {
	override public function test():Null<Bool> {
		final time:Float = Sys.time();
		trace(Lexer.tokenize(#if js Resource.getString('js_testing_ini') #else File.getContent('resources/testing.ini') #end));
		final end:Float = Sys.time();
		trace('Lexer Tokenize ${(end - time)*1000} ms!');

		return !super.test();
	}
}
