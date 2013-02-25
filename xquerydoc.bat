@echo off
:: usage: xquerydoc [-x xquery directory] [-o output directory ] [-f output format ]
:: formats: raw,(raw2), xqdoc, html, markdown
:: absolute paths for x and o should be prefixed by / e.g /c:/...
setlocal enableDelayedExpansion

Set CURRENTDIR=%CD%
set BATPATH=%~dp0
set "options=-x:"%CURRENTDIR%" -o:"%CURRENTDIR%\xqdoc" -f:html"

:: based on http://stackoverflow.com/questions/3973824/windows-bat-file-optional-argument-parsing
:: Set the default option values
for %%O in (%options%) do for /f "tokens=1,* delims=:" %%A in ("%%O") do set "%%A=%%~B"
:loop

if not "%~1"=="" (
  set "test=!options:*%~1:=! "
  if "!test!"=="!options! " (
    echo Error: Invalid option %~1
  ) else if "!test:~0,1!"==" " (
    set "%~1=1"
  ) else (
    set "%~1=%~2"
    shift /1
  )
  shift /1
  goto :loop
)

:: add leading slash if drive for calabash
set "OUTPUT=%-o%"
if "%OUTPUT:~1,1%"==":" (
   set "OUTPUT=/%OUTPUT%"
) 
set "XQUERY=%-x%"
if "%XQUERY:~1,1%"==":" (
   set "XQUERY=/%XQUERY%"
) 
echo xquerydoc [-x xquery directory] [-o output directory ] [-f output format ]
echo xquerydoc 0.1, generates xquery api documentation
echo Copyright (c) 2011, 2012 Jim Fuller, John Snelson
echo see https://github.com/xquery/xquerydoc
set -
echo generating documentation ...

java -Xmx1024m -jar "%BATPATH%deps\xmlcalabash\calabash.jar" -oresult="%-o%/index.html" "%BATPATH%probe.xpl" "xquery=%XQUERY%" "currentdir=/%CURRENTDIR%" "output=%OUTPUT%" "format=%-f%"

:: IF NOT EXIST "%-o%\lib" GOTO notestdir
:: GOTO endif2
:notestdir
echo Creating lib directory at "%-o%" ...
mkdir "%-o%\lib"
copy "%BATPATH%\src\lib\prettify.js" "%-o%\lib\prettify.js"
copy "%BATPATH%\src\lib\prettify.css" "%-o%\lib\prettify.css"
copy "%BATPATH%\src\lib\lang-xq.js" "%-o%\lib\lang-xq.js"
echo.
:endif2
