<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step 
    xmlns:c="http://www.w3.org/ns/xproc-step"
    xmlns:p="http://www.w3.org/ns/xproc"
    xmlns:ml="http://xmlcalabash.com/ns/extensions/marklogic" 
    xmlns:test="http://www.marklogic.com/test"
    name="build"
    version="1.0"
    exclude-inline-prefixes="c ml p">
  
  <p:input port="source"/>
  <p:output port="result"/>


  <p:documentation>build xquerydoc</p:documentation>

  <p:www-form-urlencode match="/c:request/c:body/text()">
    <p:input port="source">
      <p:inline>
        <c:request method="POST"
                   href="http://www.bottlecaps.de/rex/">
          <c:body
              content-type="application/x-www-form-urlencoded"></c:body>
        </c:request>
      </p:inline>
    </p:input>
    <p:input port="parameters">
      <p:inline>
        <c:param-set>
          <c:param name="input" value="file:///Users/jfuller/Source/Webcomposite/xquerydoc/ebnf/XQDocComments.ebnf"/>
          <c:param name="target" value="-xquery"/>
          <c:param name="tree" value="true"/>
        </c:param-set>
      </p:inline>
    </p:input>
  </p:www-form-urlencode>

  <p:http-request name="parser-generator"/>

  <p:documentation>
    (:
    -- Local Variables:
    -- compile-command: "/usr/local/bin/calabash build.xpl"
    -- End:
    :)
  </p:documentation>

</p:declare-step>
