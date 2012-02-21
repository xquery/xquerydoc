# library module: xqdoc/xqdoc-display
 


Author:  Darin McBeath
Version:  1.3

## Table of Contents

* Variables: [$XQDOC_COLLECTION](#var_XQDOC_COLLECTION), [$XQDOC_URIS](#var_XQDOC_URIS)
* Functions: [print-intro\#1](#func_print-intro_1), [print-module-intro\#1](#func_print-module-intro_1), [print-modules\#1](#func_print-modules_1), [print-module-control\#2](#func_print-module-control_2), [print-module\#2](#func_print-module_2), [print-variables\#2](#func_print-variables_2), [print-imports\#2](#func_print-imports_2), [print-method-summary\#1](#func_print-method-summary_1), [print-method-detail\#2](#func_print-method-detail_2), [print-signature\#2](#func_print-signature_2), [print-comment\#3](#func_print-comment_3), [print-detail-comment\#3](#func_print-detail-comment_3), [print-comment-param\#1](#func_print-comment-param_1), [print-comment-see\#2](#func_print-comment-see_2), [print-external-functions-invoked\#2](#func_print-external-functions-invoked_2), [print-external-functions-invoked-by\#2](#func_print-external-functions-invoked-by_2), [print-internal-functions-invoked\#2](#func_print-internal-functions-invoked_2), [print-internal-functions-invoked-by\#2](#func_print-internal-functions-invoked-by_2), [print-external-variable-references\#2](#func_print-external-variable-references_2), [print-internal-variable-references\#2](#func_print-internal-variable-references_2), [print-external-variables-referenced\#2](#func_print-external-variables-referenced_2), [print-internal-variables-referenced\#2](#func_print-internal-variables-referenced_2), [decode-uri\#1](#func_decode-uri_1), [module-uri\#1](#func_module-uri_1), [print-footer\#1](#func_print-footer_1), [get-default-html\#1](#func_get-default-html_1), [get-module-html\#2](#func_get-module-html_2), [build-link\#4](#func_build-link_4), [get-module-uris\#0](#func_get-module-uris_0), [get-function-names\#1](#func_get-function-names_1), [get-code-html\#3](#func_get-code-html_3), [print-preserve-newlines\#1](#func_print-preserve-newlines_1), [get-stylesheet\#0](#func_get-stylesheet_0)


## Variables

### <a name="var_XQDOC_COLLECTION"/> $XQDOC_COLLECTION
```xquery
$XQDOC_COLLECTION as  xs:string
```
 


### <a name="var_XQDOC_URIS"/> $XQDOC_URIS
```xquery
$XQDOC_URIS as  xs:string\*
```
 




## Functions

### <a name="func_print-intro_1"/> print-intro\#1
```xquery
print-intro($local as xs:boolean
) as  element()+
```
 


#### Params

* local as  xs:boolean indicates whether to build static HTML link for offline viewing or dynamic linke for real-time viewing.


#### Returns
*  element()+: HTML.

### <a name="func_print-module-intro_1"/> print-module-intro\#1
```xquery
print-module-intro($local as xs:boolean
) as  element()
```



#### Params

* local as  xs:boolean indicates whether to build static HTML link for offline viewing or dynamic links for real-time viewing.


#### Returns
*  element(): HTML.

### <a name="func_print-modules_1"/> print-modules\#1
```xquery
print-modules($local as xs:boolean
) as  element()+
```



#### Params

* local as  xs:boolean indicates whether to build static HTML link for offline viewing or dynamic links for real-time viewing.


#### Returns
*  element()+: HTML.

### <a name="func_print-module-control_2"/> print-module-control\#2
```xquery
print-module-control($uri as xs:string, $local as xs:boolean
) as  item()+
```


*  Module introductory information
*  Global variables declared in this module
*  Modules imported by this module
*  Summary information for each function defined in the module
*  Detailed information for each function defined in the module


#### Params

* uri as  xs:string the URI for the module

* local as  xs:boolean indicates whether to build static HTML link for offline viewing or dynamic links for real-time viewing.


#### Returns
*  item()+: HTML.

### <a name="func_print-module_2"/> print-module\#2
```xquery
print-module($uri as xs:string, $local as xs:boolean
) as  element()*
```



#### Params

* uri as  xs:string the URI for the module

* local as  xs:boolean indicates whether to build static HTML link for offline viewing or dynamic links for real-time viewing.


#### Returns
*  element()\*: HTML.

### <a name="func_print-variables_2"/> print-variables\#2
```xquery
print-variables($uri as xs:string, $local as xs:boolean
) as  element()*
```


* Functions (contained in this module) that use this variable
* Functions (not contained in this module) that use this variable


#### Params

* uri as  xs:string the URI for the module

* local as  xs:boolean indicates whether to build static HTML link for offline viewing or dynamic links for real-time viewing.


#### Returns
*  element()\*: HTML.

### <a name="func_print-imports_2"/> print-imports\#2
```xquery
print-imports($uri as xs:string, $local as xs:boolean
) as  element()*
```



#### Params

* uri as  xs:string the URI for the module

* local as  xs:boolean indicates whether to build static HTML link for offline viewing or dynamic links for real-time viewing.


#### Returns
*  element()\*: HTML.

### <a name="func_print-method-summary_1"/> print-method-summary\#1
```xquery
print-method-summary($uri as xs:string
) as  element()*
```



#### Params

* uri as  xs:string the URI for the module


#### Returns
*  element()\*: HTML.

### <a name="func_print-method-detail_2"/> print-method-detail\#2
```xquery
print-method-detail($uri as xs:string, $local as xs:boolean
) as  item()*
```


* Functions (contained in this module) that are used by this function
* Functions (not contained in this module) that are used by this function
* Functions (contained in this module) that use this function
* Functions (not contained in this module) that use this function
* Variables (contained in this module) that are used by this function
* Variables (not contained in this module) that are used by this function


#### Params

* uri as  xs:string the URI for the module

* local as  xs:boolean indicates whether to build static HTML link for offline viewing or dynamic links for real-time viewing.


#### Returns
*  item()\*: HTML.

### <a name="func_print-signature_2"/> print-signature\#2
```xquery
print-signature($sigs as xs:string*, $local as xs:boolean
) as  item()*
```



#### Params

* sigs as  xs:string\* the signatures associated with the current function. Although only one signature is allowed for user-defined functions, more than one signature is required to support other 'modules' such as XPath F &amp; O.

* local as  xs:boolean indicates whether to build static HTML link for offline viewing or dynamic links for real-time viewing.


#### Returns
*  item()\*: String containing the marked up function signature.

### <a name="func_print-comment_3"/> print-comment\#3
```xquery
print-comment($comment as element()*, $name as xs:string?, $local as xs:boolean
) as  element()*
```


* author
* version
* param
* return
* error
* deprecated
* see
* since
* empty which indicates a description


#### Params

* comment as  element()\* the xqDoc comment element associated with a function

* name as  xs:string? the xqDoc comment name to process (i.e. author, version, etc.)

* local as  xs:boolean indicates whether to build static HTML link for offline viewing or dynamic links for real-time viewing.


#### Returns
*  element()\*: HTML

### <a name="func_print-detail-comment_3"/> print-detail-comment\#3
```xquery
print-detail-comment($comment as element()*, $name as xs:string?, $local as xs:boolean
) as  element()*
```


* author
* version
* param
* return
* error
* deprecated
* see
* since
* empty which indicates a description


#### Params

* comment as  element()\* the xqDoc comment element associated with a function

* name as  xs:string? the xqDoc comment name to process (i.e. author, version, etc.)

* local as  xs:boolean indicates whether to build static HTML link for offline viewing or dynamic links for real-time viewing.


#### Returns
*  element()\*: HTML

### <a name="func_print-comment-param_1"/> print-comment-param\#1
```xquery
print-comment-param($entry as element()
) as  item()*
```



#### Params

* entry as  element() the xqDoc param comment element associated with a function


#### Returns
*  item()\*: HTML

### <a name="func_print-comment-see_2"/> print-comment-see\#2
```xquery
print-comment-see($entry as element(), $local as xs:boolean
) as  item()*
```






#### Params

* entry as  element() the xqDoc param comment element associated with a function

* local as  xs:boolean indicates whether to build static HTML link for offline viewing or dynamic links for real-time viewing.


#### Returns
*  item()\*: HTML

### <a name="func_print-external-functions-invoked_2"/> print-external-functions-invoked\#2
```xquery
print-external-functions-invoked($function as element(), $local as xs:boolean
) as  element()*
```



#### Params

* function as  element() the current function

* local as  xs:boolean indicates whether to build static HTML link for offline viewing or dynamic links for real-time viewing.


#### Returns
*  element()\*: HTML

### <a name="func_print-external-functions-invoked-by_2"/> print-external-functions-invoked-by\#2
```xquery
print-external-functions-invoked-by($function as element(), $local as xs:boolean
) as  element()*
```



#### Params

* function as  element() the current function

* local as  xs:boolean indicates whether to build static HTML link for offline viewing or dynamic links for real-time viewing.


#### Returns
*  element()\*: HTML

### <a name="func_print-internal-functions-invoked_2"/> print-internal-functions-invoked\#2
```xquery
print-internal-functions-invoked($function as element(), $local as xs:boolean
) as  element()*
```



#### Params

* function as  element() the current function

* local as  xs:boolean indicates whether to build static HTML link for offline viewing or dynamic links for real-time viewing.


#### Returns
*  element()\*: HTML

### <a name="func_print-internal-functions-invoked-by_2"/> print-internal-functions-invoked-by\#2
```xquery
print-internal-functions-invoked-by($function as element(), $local as xs:boolean
) as  element()*
```



#### Params

* function as  element() the current function

* local as  xs:boolean indicates whether to build static HTML link for offline viewing or dynamic links for real-time viewing.


#### Returns
*  element()\*: HTML

### <a name="func_print-external-variable-references_2"/> print-external-variable-references\#2
```xquery
print-external-variable-references($variable as element(), $local as xs:boolean
) as  element()*
```



#### Params

* variable as  element() the current variable

* local as  xs:boolean indicates whether to build static HTML link for offline viewing or dynamic links for real-time viewing.


#### Returns
*  element()\*: HTML

### <a name="func_print-internal-variable-references_2"/> print-internal-variable-references\#2
```xquery
print-internal-variable-references($variable as element(), $local as xs:boolean
) as  element()*
```



#### Params

* variable as  element() the current variable

* local as  xs:boolean indicates whether to build static HTML link for offline viewing or dynamic links for real-time viewing.


#### Returns
*  element()\*: HTML

### <a name="func_print-external-variables-referenced_2"/> print-external-variables-referenced\#2
```xquery
print-external-variables-referenced($variable as element(), $local as xs:boolean
) as  element()*
```



#### Params

* variable as  element() the current variable

* local as  xs:boolean indicates whether to build static HTML link for offline viewing or dynamic links for real-time viewing.


#### Returns
*  element()\*: HTML

### <a name="func_print-internal-variables-referenced_2"/> print-internal-variables-referenced\#2
```xquery
print-internal-variables-referenced($variable as element(), $local as xs:boolean
) as  element()*
```



#### Params

* variable as  element() the current variable

* local as  xs:boolean indicates whether to build static HTML link for offline viewing or dynamic links for real-time viewing.


#### Returns
*  element()\*: HTML

### <a name="func_decode-uri_1"/> decode-uri\#1
```xquery
decode-uri($uri as xs:string
) as  xs:string
```



#### Params

* uri as  xs:string the string to be decoded


#### Returns
*  xs:string: the decoded string

### <a name="func_module-uri_1"/> module-uri\#1
```xquery
module-uri($e as element()
) as  xs:string
```



#### Params

* e as  element() the element (i.e. function or variable) that we want to find the module uri


#### Returns
*  xs:string: the module URI associated with the element

### <a name="func_print-footer_1"/> print-footer\#1
```xquery
print-footer($uri as xs:string
) as  element()*
```



#### Params

* uri as  xs:string the current module uri


#### Returns
*  element()\*: HTML

### <a name="func_get-default-html_1"/> get-default-html\#1
```xquery
get-default-html($local as xs:boolean
) as  element()
```



#### Params

* local as  xs:boolean indicates whether to build static HTML link for offline viewing or dynamic links for real-time viewing.


#### Returns
*  element(): HTML

### <a name="func_get-module-html_2"/> get-module-html\#2
```xquery
get-module-html($module as xs:string, $local as xs:boolean
) as  element()
```



#### Params

* module as  xs:string the module uri

* local as  xs:boolean indicates whether to build static HTML link for offline viewing or dynamic links for real-time viewing.


#### Returns
*  element(): HTML

### <a name="func_build-link_4"/> build-link\#4
```xquery
build-link($type as xs:string, $local as xs:boolean, $parms as xs:string*, $name as xs:string?
) as  element()?
```



#### Params

* type as  xs:string the type of link to construct. The link can be for the xqDoc home page, the module page for a particular module, or for the XQuery code for a specific function.

* local as  xs:boolean indicates whether to build static HTML link for offline viewing or dynamic links for real-time viewing.

* parms as  xs:string\* the parameters associated with the link $type

* name as  xs:string? the name to assign for the link


#### Returns
*  element()?: HTML

### <a name="func_get-module-uris_0"/> get-module-uris\#0
```xquery
get-module-uris(
) as  xs:string*
```



#### Returns
*  xs:string\*: List of module uris contained in xqDoc

### <a name="func_get-function-names_1"/> get-function-names\#1
```xquery
get-function-names($module as xs:string
) as  xs:string*
```



#### Params

* module as  xs:string the uri for the current module


#### Returns
*  xs:string\*: List of function names defined in the current module

### <a name="func_get-code-html_3"/> get-code-html\#3
```xquery
get-code-html($module as xs:string, $name as xs:string?, $local as xs:boolean
) as  element()
```



#### Params

* module as  xs:string the uri associated with the current module

* name as  xs:string? the name associated with the current function contained in the module

* local as  xs:boolean indicates whether to build static HTML link for offline viewing or dynamic links for real-time viewing.


#### Returns
*  element(): HTML ... the XQuery code for the function

### <a name="func_print-preserve-newlines_1"/> print-preserve-newlines\#1
```xquery
print-preserve-newlines($strin as xs:string?
) as  item()*
```



#### Params

* strin as  xs:string? the code associated with an XQuery function


#### Returns
*  item()\*: the presentation friendly version of the code

### <a name="func_get-stylesheet_0"/> get-stylesheet\#0
```xquery
get-stylesheet(
) as  element()
```



#### Returns
*  element(): the stylesheet





*Generated by [xquerydoc](https://github.com/xquery/xquerydoc)*