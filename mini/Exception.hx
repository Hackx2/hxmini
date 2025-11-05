/*
 * MIT License
 *
 * Copyright (c) 2025 Hackx2
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
 * Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
 * AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH
 * THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

package mini;

import haxe.Exception;
import mini.types.ExceptionKind;

class Exception extends haxe.Exception {
	public var line:Int;
	public var kind:ExceptionKind;

	// MINI EXCEPTION seems so cringe
	public function new(kind:ExceptionKind, ?line:Int) {
		super('[hxmini] : [EXCEPTION]:${line != null ? '$line:' : ''} ' + to(kind));
		this.kind = kind;
		this.line = line ?? 0;
	}

	static function to(kind:ExceptionKind):String {
		return switch (kind) {
			case EMalformedSection(key): 'Malformed section header "$key"';
			case EUnknownLine: 'Unrecognized line format';
			case EUnterminatedMultilineValue(key): 'Unterminated multiline value for key "$key"';
			case ECustom(e): '$e';
		}
	}
}
