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
		final __strBuf:StringBuf = new StringBuf();

		for (c in doc.children) {
			switch (c.nodeType) {
				case Section:
					__strBuf.add('[${c.nodeName}]\n');
					for (kv in c.children) {
						switch (kv.nodeType) {
							case KeyValue:
								__strBuf.add(kv.nodeName + "=");
								__strBuf.add(Utils.wrapMultiline(kv.nodeValue));
								__strBuf.add("\n");
							case Comment:
								__strBuf.add("; " + kv.nodeValue + "\n");
							default:
								#if MINI_PUSH_ARTIFACTS __strBuf.add("; [ARTIFACT]: " + kv.nodeName + " | " + kv.nodeValue + " | " + kv.nodeType + "\n"); #end
						}
					}
					__strBuf.add("\n");
				case Comment:
					__strBuf.add("; " + c.nodeValue + "\n");
				case KeyValue:
					__strBuf.add(c.nodeName + "=");
					__strBuf.add(Utils.wrapMultiline(c.nodeValue));
					__strBuf.add("\n");
				default:
					#if MINI_PUSH_ARTIFACTS __strBuf.add("; [ARTIFACT]: " + c.nodeName + " | " + c.nodeValue + " | " + c.nodeType + "\n"); #end
			}
		}

		return __strBuf.toString();
	}
}
