Rem Copyright (c) 2011-2012 Jim Fuller, John Snelson  
Rem Licensed under the Apache License, Version 2.0 (the "License");
Rem you may not use this file except in compliance with the License.
Rem You may obtain a copy of the License at

Rem http://www.apache.org/licenses/LICENSE-2.0
  
Rem Unless required by applicable law or agreed to in writing, software
Rem distributed under the License is distributed on an "AS IS" BASIS,
Rem WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
Rem See the License for the specific language governing permissions and
Rem limitations under the License.

Rem xquerydoc 0.1, generates xquery api documentation
Rem 
Rem see https://github.com/xquery/xquerydoc
Rem 
Rem usage: xquerydoc [-x xquery directory] [-o output directory ] [-f output format ]
Rem 

Rem need help with creating and testing windows version

@echo on

CURRENTDIR=`pwd`

XQUERY=$CURRENTDIR
OUTPUT=$CURRENTDIR/xqdoc
XQUERY=$CURRENTDIR
FORMAT=html

:GETOPTS
 if /I %1 == -h goto usage
 if /I %1 == -x set XQUERY=%2& shift
 if /I %1 == -o set OUTPUT=%2& shift
 if /I %1 == -f set FORMAT=%2& shift

 shift
if not (%1)==() goto GETOPTS
	 
	 
function usage(){
    echo "xquerydoc 0.1, generates xquery api documentation"
    echo "Copyright (c) 2011, 2012 Jim Fuller, John Snelson"
    echo "see https://github.com/xquery/xquerydoc"
    echo ""
    echo "usage: xquerydoc [-x xquery directory] [-o output directory ] [-f output format ]"
    echo ""

    exit 1
}


echo "xquerydoc 0.1, generates xquery api documentation"
echo "Copyright (c) 2011, 2012 Jim Fuller, John Snelson"
echo "see https://github.com/xquery/xquerydoc"
echo ""
echo "xquery dir: $XQUERY"
echo "output dir: $OUTPUT"
echo "    format: $FORMAT"
echo ""
echo "generating documentation ..."

# run xproc pipeline
$XQUERYDOC_DIR/deps/xmlcalabash/calabash -oresult=$OUTPUT/index.html $XQUERYDOC_DIR/xquerydoc.xpl xquery=$XQUERY output=$OUTPUT currentdir=$CURRENTDIR format=$FORMAT 

# copy lib resources
mkdir -p $OUTPUT/lib
cp $XQUERYDOC_DIR/src/lib/prettify.js $OUTPUT/lib/prettify.js
cp $XQUERYDOC_DIR/src/lib/prettify.css $OUTPUT/lib/prettify.css
cp $XQUERYDOC_DIR/src/lib/lang-xq.js $OUTPUT/lib/lang-xq.js

echo "xquerydoc processing is done."

