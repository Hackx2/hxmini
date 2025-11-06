package;

import tests.*;

class Main {
	static function main():Void {
		haxe.Log.trace = (str:Dynamic, ?_:haxe.PosInfos) -> { // remove posInfos formatting
			#if js
			if (js.Syntax.typeof(untyped console) != "undefined" && (untyped console).log != null)
				(untyped console).log(str);
			#elseif lua
			untyped __define_feature__("use._hx_print", _hx_print(str));
			#elseif sys
			Sys.println(str);
			#else
			throw new haxe.exceptions.NotImplementedException()
			#end
		}

		final time:Float = Sys.time();
		trace('<---------------------- Testing ---------------------->\n');

		(function(...rest) { // lol
			for (i in rest.toArray()) {
				trace([i]);
				trace('-----------------------------------');
				Type.createEmptyInstance(i).test();
				trace('-----------------------------------\n');
			}
		})(Normal, Long, Creation, Access, DangerouslyInject, Lexer, Miscellaneous);

		trace('Finished in ${Math.round((Sys.time() - time) * 1000.0) / 1000.0} seconds!\nAll tests passed!\n');
	}
}
