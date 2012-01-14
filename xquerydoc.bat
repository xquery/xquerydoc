echo off
set CURRENTDIR=D:\test\xquerydoc-0.1

set XQUERY=%CURRENTDIR%\src\xquery
set OUTPUT=%CURRENTDIR%\xqdoc
set FORMAT=html

echo xquerydoc 0.1, generates xquery api documentation
echo Copyright (c) 2011, 2012 Jim Fuller, John Snelson
echo see https://github.com/xquery/xquerydoc
echo 
echo xquery dir: %XQUERY%
echo output dir: %OUTPUT%
echo     format: %FORMAT%
echo 
echo generating documentation ...

java -Xmx1024m -jar "deps\xmlcalabash\calabash.jar" -D xquerydoc.xpl "xquery=%XQUERY%" "currentdir=%CURRENTDIR%" "output=%OUTPUT%" "format=%FORMAT%"

IF NOT EXIST "%OUTPUT%" GOTO notestdir
GOTO endif2
:notestdir
echo Creating directory at "%OUTPUT%" ...
mkdir %OUTPUT%
mkdir %OUTPUT%\lib

echo.
:endif2
