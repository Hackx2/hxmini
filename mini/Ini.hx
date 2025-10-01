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

import mini.types.EntryType;

using StringTools;
using Lambda;

/**
 * Used for reading and writing INI files.
 * 
 * @see http://en.wikipedia.org/wiki/INI_file
 */
class Ini {
	public var parent:Null<Ini>;

	/**
	 * The node type.
	 */
	public var nodeType(default, null):Null<EntryType>;

	/**
	 * The node's name.
	 */
	public var nodeName:Null<String>;

	/**
	 * The node's value.
	 */
	public var nodeValue:Null<String>;

	/**
	 * Parse a string.
	 * @param str data
	 * @return Ini
	 */
	public static function parse(str:String):Ini {
		return Parser.parse(str);
	}

	/**
	 * This instances children.
	 */
	public var children:Array<Ini>;

	/**
	 * `mini.Ini`'s constructor
	 * @param type Note Type (Document, Section, Comment, KeyValue)
	 * @param name Name (Used for sections)
	 * @param value Value (Used for key values)
	 */
	public function new(type:EntryType, ?name:String, ?value:String):Void {
		this.nodeType = type;
		this.nodeName = name;
		this.nodeValue = value;
		this.children = new Array<Ini>();
		this.__disposed = false;
	}

	/**
	 * Create a document.
	 * @return Ini
	 */
	public static function createDocument():Ini {
		return new Ini(Document);
	}

	/**
	 * Create a section
	 * @param s The Section Name.
	 * @return Ini
	 */
	public static function createSection(s:String, ?parent:Ini):Ini {
		return new Ini(Section, s);
	}

	/**
	 * Create a key
	 * @param k The Key Name.
	 * @param v The Value.
	 * @return Ini
	 */
	public static function createKey(k:String, v:String):Ini {
		return new Ini(KeyValue, k, v);
	}

	@:dox(hide) var __disposed:Bool = false;

	/**
	 * Disposes this `Ini` node and all of its children.
	 */
	public function dispose():Void {
		if (__disposed)
			return;

		if (children != null && children.length > 0) {
			for (child in children) {
				if (child != null) {
					child.dispose();
				}
				children.remove(child);
			}
		}
		children.resize(0);

		parent = null;
		nodeName = null;
		nodeValue = null;
		nodeType = null;
		children = null;

		__disposed = true;
	}

	/**
	 * Adds/Pushes a child into the tree.
	 * @param x child
	 */
	public function addChild<T:Ini>(x:T):T {
		if(__disposed) return null;
		if (x.parent != null)
			x.parent.removeChild(x);
		children.push(x);
		x.parent = this;
		return x;
	}

	/**
	 * Removes a child from the children tree.
	 * @param x child
	 * @return Bool
	 */
	public function removeChild(x:Ini):Bool {
		if (!__disposed && children.remove(x)) {
			x.parent = null;
			return true;
		}
		return false;
	}

	/**
	 * Returns all elements.
	 * @return Iterator<Ini>
	 */
	public function elements():Iterator<Ini> {
		return children.iterator();
	}

	/**
	 * This gets all elements with the name v
	 * @param name the element name.
	 * @return Iterator<Ini>
	 */
	public function elementsNamed(name:String):Iterator<Ini> {
		return children.filter(c -> c.nodeName == name).iterator();
	}

	/**
	 * Get the value.
	 * @param name the value.
	 * @return String
	 */
	public function get(name:String):Null<String> {
		if (nodeType == Section) {
			for (c in children) {
				if (c != null && c.nodeType == KeyValue && c.nodeName == name) {
					return c.nodeValue;
				}
			}
		}
		return null;
	}

	/**
	 * Set a variable.
	 * @param name The name of the variable
	 * @param value The value.
	 */
	public function set(name:String, value:String):Void {
		if (nodeType == Section) {
			for (c in children) {
				if (c.nodeType == KeyValue && c.nodeName == name) {
					c.nodeValue = value;
					return;
				}
			}
			addChild(createKey(name, value));
		}
	}

	/**
	 * Create a comment.
	 * @param value 
	 */
	public function comment(value:String):Void {
		addChild(new Ini(Comment, null, value));
	}

	/**
	 * Converts a string into useable .ini data.
	 * This method is deprecated please use `mini.Parser.parse()` instead.
	 * @param data Data from an .ini file.
	 * @return Ini
	 */
	@:deprecated("This method is deprecated please use `mini.Parser.parse(v1)` instead,.")
	@:from public static function fromString(data:String):Ini {
		return Parser.parse(data);
	}

	/**
	 * Convert's this into a readable string.
	 * @return StringBuf
	 */
	@:to public function toString():String {
		return Printer.serialize(this);
	}

	/**
	 * Returns an iterator of all child sections.
	 */
	public function sections():Iterator<Ini> {
		return children.filter(c -> c.nodeType == Section).iterator();
	}

	/**
	 * Returns an iterator of all child key/value pairs.
	 */
	public function keys():Iterator<Ini> {
		return children.filter(c -> c.nodeType == KeyValue).iterator();
	}

	/**
	 * Returns an iterator of all child comments.
	 */
	public function comments():Iterator<Ini> {
		return children.filter(c -> c.nodeType == Comment).iterator();
	}

	/**
	 * Finds all children matching a predicate.
	 * @param predicate Function to test each node.
	 * @return Array<Ini> of matching nodes.
	 */
	public function find(predicate:Ini->Bool):Array<Ini> {
		return children.filter(predicate);
	}
}

@:deprecated("Use mini.EntryType instead")
typedef IniType = EntryType;
