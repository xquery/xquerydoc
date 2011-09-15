import module namespace xqdoc="http://github.com/xquery/xquerydoc" at "xquerydoc.xq";
declare option xqilla:projection "false";
xqdoc:parse(unparsed-text("example_module.xq"))
