package;

import tests.*;

class Main {
	static function main():Void {
		//throw new mini.Exception("hi", 39);
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

		trace('<---------------------- Testing ---------------------->\n');

        (function(...rest) { // lol
            for(i in rest.toArray())
                Type.createEmptyInstance(i).test();
        })(Normal, Long, Creation);
        
		trace(mini.types.EntryType.fromString('Document'));
	}
}
