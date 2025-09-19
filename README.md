<br>
<br>
<div align="center">
<img src=".resources/logo-noir-ini.png" alt="Matter" width="60%" />
<p>
<strong>Matter.ini 🌌</strong> is a lightweight and easy-to-use library for parsing <code>.ini</code> files. <br>It provides a straightforward way to read, modify, and create your own <code>.ini</code> files.

</p>
</div>



<hr>

<h2>Features :p</h2>
<ul>
<li><strong>Comment Support:</strong> Ignores nodes starting with a semicolon(<code>;</code>) or an hashtag (<code>#</code>).</li>
<li><strong>Multi-line support:</strong> Allows you to define a node using triple quotation marks (<code>""" """</code>, <code>Multiline Test=\ possible\ hehe</code> )</li>
<li><strong>File Creation & Editing:</strong> Lets you create and edit .ini files</li>
</ul>

<hr>

<h2>Installation</h2>
<p>You can install the library directly using <code>haxelib</code>.</p>
<pre><code>haxelib install mini</code></pre>
<p>Or you could install using <code>git</code>.</p>
<pre><code>haxelib git mini https://github.com/hackx2/hxmini</code></pre>
<hr>

<h2>Usage</h2>

<details>
  <summary>Parse & Access <code>.ini</code> data</summary>
    <p>Here is a simple example of how to use the parser in your Haxe project.</p>
    <p>First, let's assume you have a file named <strong><code>config.ini</code></strong> with the following contents:</p>

  ```ini
  [main.test]
  name="hackx2"
  cutie="milo"
  ```

  
<p>Now, you can parse this file and access its data:</p>

```haxe
import mini.Parser as INIParser;


// Get `testing.ini`'s file content.
final content : String = sys.io.File.getContent('testing.ini');

// Parse the content.
final ini:Ini = INIParser.parse(content);

// ------ NORMAL ELEMENT TESTING

// Get the element.
final main:Ini = ini.elementsNamed("main.test").next();

// Get and print data.
Sys.println(main.get('name')); // Returns "hackx2"
Sys.println(main.get('cutie')); // Returns "milo"

// -----------------------------
```

</details> 

<details>
  <summary>Create your own <code>.ini</code> files</summary>

  <p>Heres how you can create a .ini file:</p>

```haxe
// Create the document.
final ini:Ini = Ini.createDocument();

// Create a Section
final user:Ini = Ini.createSection("User");
user.set("username", "Milo");
user.set("role", "Admin");
user.set("progress", "78%");
ini.addChild(user);

user.get('progress'); // Returns: "78%"

ini.toString(); // Returns the serialized .ini document
```
</details>


<hr>

## Contribution (yippie)
Contributions are welcome!!! 💖 If you have suggestions or find a bug, please open an [issue](https://github.com/hackx2/hxmini/issues).

<hr>

<h2>License</h2>
<p>This project is licensed under the MIT License.</p>