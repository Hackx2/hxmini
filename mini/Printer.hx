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
