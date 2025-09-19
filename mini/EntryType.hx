package mini;

enum abstract EntryType(Int) {
	final Document:EntryType = 0x00; // 0

	/**
	 * Section
	 * Example: [BlahBlahBlah]
	 */
	final Section:EntryType = 0x01; // 1

	/**
	 * Comment
	 * Example: ;BlahBlahBlah
	 */
	final Comment:EntryType = 0x02; // 2

	/**
	 * Key Value
	 * Example: BlahBlahBlah = WhatTheSigma
	 */
	final KeyValue:EntryType = 0x03; // 3

	/**
	 * [Description] Convert type to string.
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
	 * [Description] Converts a string to a type.
	 * @param str Option
	 * @return EntryType
	 */
	public function fromString(str:String):EntryType {
		return switch str {
			case "Document": Document;
			case "Section": Section;
			case "Comment": Comment;
			case "KeyValue": KeyValue;
			default: throw 'Unknown Type: $str';
		};
	}
}