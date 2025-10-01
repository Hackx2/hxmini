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

import mini.Ini;
import mini.types.EntryType;

/**
 * Provides dot-access to `Ini` sections & keys, this class is inspired by [`haxe.xml.Access`](https://api.haxe.org/haxe/xml/Access.html).
 * 
 * This isn't required or really needed to access data stored in the Ini class.
 * I just want dot-access to be available to those who need/want it. ~orbl
 * 
 * @see https://api.haxe.org/haxe/xml/Access.html
 */
abstract Access(Ini) {
	public var ini(get, never):Ini;
	@:noCompletion inline function get_ini():Ini {
		return this;
	}

	/**
	 * Access to a named child **key**.
	 * 
	 * Throws an exception if the section doesn't exists.
	 * Make sure to use `has` to make sure the section exists before attempting to require.
	 * 
	 * ```haxe
	 * final ini = mini.Parser.parse('\n[General]\nversion=1.0\n\ntheme=dark');
	 * final access = new mini.Access(ini);
	 * final section = access.has.section.General ? access.section.General : null;
	 * if (section != null) {
	 * 		if(section.has.key.version) {
	 *			trace(section.key.version); // 1.0
	 *		}	
	 * }
	 * ```
	 */
	public var key(get, never):KeyAccess;
	@:noCompletion inline function get_key():KeyAccess {
		return this;
	}

	/**
	 * Access to a named child **section**.
	 * 
	 * Throws an exception if the section doesn't exists.
	 * Make sure to use `has` to make sure the section exists before attempting to require.
	 * 
	 * ```haxe
	 * final ini = mini.Parser.parse('\n[General]\nversion=1.0\n\ntheme=dark');
	 * final access = new mini.Access(ini);
	 * 
	 * trace(access.has.section.General); // true
	 * ```
	 */
	public var section(get, never):SectionAccess;
	@:noCompletion inline function get_section():SectionAccess {
		return this;
	}

	/**
	 * Check the existence of a section or key from the given name. 
	 */
	public var has(get, never):HasAccess;
	@:noCompletion inline function get_has():HasAccess {
		return this;
	}

	/**
	 * An `Iterable` of all sections.
	 */
	public var sections(get, never):Iterable<Access>;
	@:noCompletion inline function get_sections():Iterable<Access> {
		return Utils.iterableFromIterator(Utils.mapIterator(this.sections(), i -> new Access(i)));
	}

	/**
	 * An `Iterable` of all keys.
	 */
	public var keys(get, never):Iterable<Access>;
	@:noCompletion inline function get_keys():Iterable<Access> {
		return Utils.iterableFromIterator(Utils.mapIterator(this.keys(), i -> new Access(i)));
	}

	/**
	 * An `Iterable` of all comments.
	 */
	public var comments(get, never):Iterable<Access>;
	@:noCompletion inline function get_comments():Iterable<Access> {
		return Utils.iterableFromIterator(Utils.mapIterator(this.comments(), i -> new Access(i)));
	}

	/**
	 * Get the value of this node (used for KeyValue or Comment).
	 */
	public var value(get, never):Null<String>;
	@:noCompletion inline function get_value():Null<String> {
		return this.nodeValue;
	}

	/**
	 * Get the name of this node.
	 */
	public var name(get, never):Null<String>;
	@:noCompletion inline function get_name():Null<String> {
		return this.nodeName;
	}

	/**
	 * Get the type of this node.
	 */
	public var type(get,never):EntryType;
	@:noCompletion inline function get_type():EntryType {
		return this.nodeType;
	}

	public inline function new(i:Ini):Access {
		if (i == null)
			throw "Cannot wrap null Ini node.";
		this = i;
	}
}

abstract KeyAccess(Ini) from Ini to Ini {
	@:op(A.B)
	public function res(v:String):String {
		if (this.nodeType != EntryType.Section)
			throw 'Cannot get key "$v" from non section node: ${this.nodeType}';
		for (c in this.children) {
			if (c.nodeType == EntryType.KeyValue && c.nodeName == v)
				return c.nodeValue;
		}
		throw 'Key "$v" not found in section "${this.nodeName}"';
	}
}

abstract SectionAccess(Ini) from Ini to Ini {
	@:op(A.B)
	public function res(v:String):Access {
		if (this.nodeType != EntryType.Document && this.nodeType != EntryType.Section)
			throw 'Cannot get section "$v" from node type: ${this.nodeType}';
		for (c in this.children) {
			if (c.nodeType == EntryType.Section && c.nodeName == v)
				return new Access(c);
		}
		throw 'Section "$v" not found under "${this.nodeName}"';
	}
}

abstract HasAccess(Ini) from Ini {
	public var key(get, never):HasKeyAccess;
	@:noCompletion inline function get_key():HasKeyAccess return this;

	public var section(get, never):HasSectionAccess;
	@:noCompletion inline function get_section():HasSectionAccess return this;
}

abstract HasKeyAccess(Ini) from Ini {
	@:op(A.B)
	public function res(v:String):Bool {
		if (this.nodeType != EntryType.Section)
			throw 'Cannot check key "$v" on non section node: ${this.nodeType}';
		for (c in this.children) {
			if (c.nodeType == EntryType.KeyValue && c.nodeName == v)
				return true;
		}
		return false;
	}
}

abstract HasSectionAccess(Ini) from Ini {
	@:op(A.B)
	public function res(v:String):Bool {
		if (this.nodeType != EntryType.Section && this.nodeType != EntryType.Document)
			throw 'Cannot check section "$v" on node type: ${this.nodeType}';
		for (c in this.children) {
			if (c.nodeType == EntryType.Section && c.nodeName == v)
				return true;
		}
		return false;
	}
}
