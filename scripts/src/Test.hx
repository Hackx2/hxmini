package;

abstract class Test { // TODO: use an interface instead
	public function new():Void {}

	public function test():Null<Bool> {
		return false;
	}

	function heading(val:String):Void {
		#if sys Sys.println(''); #end
		trace('-------- $val\n');
	}
}
