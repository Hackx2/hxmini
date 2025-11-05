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
