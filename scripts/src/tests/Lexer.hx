package tests;

import mini.Lexer as Lex;
import mini.Lexer.LToken;

final class Lexer extends Test {
	@:noCompletion override function test():Null<Bool> {
		final time:Float = Sys.time();
		final tokens:Array<LToken> = {
			var _ = Lex.tokenize(#if js Resource.getString('js_testing_ini') #else File.getContent('resources/testing.ini') #end);
			trace(_);
			_;
		}
		trace('\nLexer Tokenized ${(Sys.time() - time)*1000} ms!');

		return !super.test();
	}
}
