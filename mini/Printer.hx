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

using StringTools;

class Printer {
	@:noUsing static public function stringify(doc:Ini):String {
		return serialize(doc);
	}
	
	@:noUsing static public function serialize(doc:Ini):String {
		//
		final stringBuffer:StringBuf = new StringBuf();

		for (c in doc.children) {
			switch (c.nodeType) {
				case Section:
					stringBuffer.add('[${c.nodeName}]');
					stringBuffer.add('\n');
					for (kv in c.children) {
						switch (kv.nodeType) {
							case KeyValue:
								stringBuffer.add(kv.nodeName + "=");
								stringBuffer.add(Utils.wrapMultiline(kv.nodeValue));
								stringBuffer.add("\n");
							case Comment:
								stringBuffer.add("; " + kv.nodeValue);
								stringBuffer.add("\n");
							default:
						}
					}
					stringBuffer.add("\n");
				case Comment:
					stringBuffer.add("; " + c.nodeValue);
					stringBuffer.add("\n");
				case KeyValue:
					stringBuffer.add(c.nodeName + "=");
					stringBuffer.add(Utils.wrapMultiline(c.nodeValue));
					stringBuffer.add("\n");
				case DangerousInner:
					stringBuffer.add(c.nodeValue);
					stringBuffer.add("\n");
				default: // theoretically, this not be possible so this is kinda useless...
			}
		}

		return stringBuffer.toString();
	}
}
