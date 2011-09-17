xquery version "1.0-ml" encoding "UTF-8";

(: Copyright 2006-2010 Mark Logic Corporation. :)

(:
 : Licensed under the Apache License, Version 2.0 (the "License");
 : you may not use this file except in compliance with the License.
 : You may obtain a copy of the License at
 :
 :     http://www.apache.org/licenses/LICENSE-2.0
 :
 : Unless required by applicable law or agreed to in writing, software
 : distributed under the License is distributed on an "AS IS" BASIS,
 : WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 : See the License for the specific language governing permissions and
 : limitations under the License.
 :)

module namespace json = "http://marklogic.com/json";
declare default function namespace "http://www.w3.org/2005/xpath-functions";


(: Need to backslash escape any double quotes backslashes, newlines and tabs :)
declare function json:escape($s as xs:string) as xs:string {
  let $s := replace($s, "(\\|"")", "\\$1")
  let $s := replace($s, $new-line-regex, "\\n")
  let $s := replace($s, codepoints-to-string(9), "\\t")
  return $s
};
