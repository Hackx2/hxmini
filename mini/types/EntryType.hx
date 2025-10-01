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

package mini.types;

enum abstract EntryType(Int) {
	final Document:EntryType = 0x00; // 0

	/**
	 * Section
	 * Example: [BlahBlahBlah]
	 */
	final Section:EntryType = 0x01; // 1

	/**
	 * Comment
	 * Example: `; BlahBlahBlah` or `# BlahBlahBlah`.
	 */
	final Comment:EntryType = 0x02; // 2

	/**
	 * Key Value
	 * Example: BlahBlahBlah = WhatTheSigma
	 */
	final KeyValue:EntryType = 0x03; // 3

	/**
	 * Convert type to string.
	 * @return String
	 */
	@:to public function toString():String {
		return switch (cast this : EntryType) {
			case Document: "Document";
			case Section: "Section";
			case Comment: "Comment";
			case KeyValue: "KeyValue";
		};
	}

	/**
	 * Converts a string to a type.
	 * @param str Option
	 * @return EntryType
	 */
	@:from public static function fromString(str:String):EntryType {
		return switch str.toLowerCase() {
			case "document": Document;
			case "section": Section;
			case "comment": Comment;
			case "keyvalue": KeyValue;
			default: throw 'Unknown Type: $str';
		};
	}
}