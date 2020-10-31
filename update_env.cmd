@echo off
setlocal EnableDelayedExpansion
set script_home="%CD%"

set "config=%1"
set "choice=%2"
set "newValue=%3"

if %choice% EQU "" (
  echo missing 2nd paramter "setting"
  pause
  EXIT /B
)

if %newValue% EQU "" (
  echo missing 3rd parameter "new value"
  pause
  EXIT /B  
)

set update=false

FOR %%i IN (%config%) do (
  set config_LocOld="%%~dpi%%~nxi"
  set config_LocNew="%%~dpi_%%~nxi"
  set config_filename=%%~nxi
)

if NOT EXIST %config_LocOld% (
  echo config file %config_LocOld% could not be found.
  pause
  EXIT /B  
)

if EXIST %config_LocNew% (
  del %config_LocNew%
)

REM Read through the file
for /f "usebackq eol=; delims=µ" %%a in (%config_LocOld%) do ( 
REM analyze each line
 set update=false
 for %%b in (%%a) do (
REM search foo a keyword   
   if "%%b" EQU "%choice%" (
     set update=true
   )
 )
REM if keyword was found alter write process
 if "!update!" EQU "true" (
   echo set %choice%=^%newValue%>> %config_LocNew%
 ) else (
   echo %%a>> %config_LocNew%
 )
)

del %config%
ren %config_LocNew% %config_filename%