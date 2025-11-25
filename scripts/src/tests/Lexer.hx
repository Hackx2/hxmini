package tests;

import haxe.Resource;
import mini.Lexer as Lex;
import mini.Lexer.Token;

final class Lexer extends Test {
	@:noCompletion override function test():Null<Bool> {
		final time:Float = haxe.Timer.stamp();
		final tokens:Array<Token> = {
			var _ = Lex.tokenize(Resource.getString('testing_ini'));
			trace(_);
			_;
		}
		trace('\nLexer Tokenized ${(haxe.Timer.stamp() - time)*1000} ms!');

		return !super.test();
	}
}
