package mini.types;

enum ExceptionKind {
	EMalformedSection(key:String);
	EUnknownLine;
	EUnterminatedMultilineValue(key:String);
	ECustom(error:String);
}
