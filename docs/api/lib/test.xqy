xquery version "1.0";
                                              
(: Simple XQuery Unit Test Library - Jim Fuller 05/11/10 :)

module namespace test = "http://www.marklogic.com/test";


(: --------------------------------------------------------------------------------------------------- :)
(:                                                                                              Tests  :)
(: --------------------------------------------------------------------------------------------------- :)
declare function test:assertExists($a as item()*) as xs:boolean {
    fn:exists($a)
};
	
(: --------------------------------------------------------------------------------------------------- :)
(:                                                                                          XML Tests  :)
(: --------------------------------------------------------------------------------------------------- :)
declare function test:assertXMLEqual($a as item()*, $b as item()*) as xs:boolean {
    fn:deep-equal($a,$b)
};
declare function test:assertXMLNotEqual($a as item()*, $b as item()*) as xs:boolean {
    fn:not(test:assertXMLEqual($a,$b))
};

(: --------------------------------------------------------------------------------------------------- :)
(:                                                                                       String Tests  :)
(: --------------------------------------------------------------------------------------------------- :)
declare function test:assertStringEqual($a as xs:string, $b as xs:string) as xs:boolean {  
 fn:not(fn:boolean(fn:compare($a, $b)))
};
declare function test:assertStringNotEqual($a as xs:string, $b as xs:string) as xs:boolean {  
 fn:boolean(fn:compare($a, $b))
};
declare function test:assertStringContain($a as xs:string, $b as xs:string) as xs:boolean {
    fn:contains($a, $b)
};
declare function test:assertStringNotContain($a as xs:string, $b as xs:string) as xs:boolean {
    fn:not(fn:contains($a, $b))
};

(: --------------------------------------------------------------------------------------------------- :)
(:                                                                                      Integer Tests  :)
(: --------------------------------------------------------------------------------------------------- :)
declare function test:assertIntegerEqual($a as xs:integer, $b as xs:integer) as xs:boolean {  
  fn:boolean($a=$b) 
};
declare function test:assertIntegerNotEqual($a as xs:integer, $b as xs:integer) as xs:boolean {  
  fn:not(fn:boolean($a=$b)) 
};


(: --------------------------------------------------------------------------------------------------- :)
(:                                                                                   	 Test Wrapper  :)
(: --------------------------------------------------------------------------------------------------- :)
declare function test:test($message as xs:string?, $result as xs:boolean)
		as xs:string
{
	if ($result) then
		fn:concat('Passed - ', $message, '&#10;')
	else
		fn:error(xs:QName('ERROR'), 'Failed')
};

