@echo off
cls
setlocal EnableDelayedExpansion
set script_home="%CD%"

echo.
echo +------------------------------------+
echo I       DeepTown ADB interface       I
echo I            - Mines -               I
echo +------------------------------------+

REM Extract information from parameter
FOR %%i IN (%1) do (  
  set minesLoc="%%~dpi%%~nxi"
  set mineLocNew="%%~dpi_%%~nxi"
  set mines_filename="%%~nxi"
)

call .\load_env.cmd
call :restore_home

if "%1" EQU "" (
  call :lng_missing_input_%dtadb_lang%
  PAUSE > nul
  EXIT /B
)

if NOT EXIST %minesLoc% (
  call :lng_input_not_found_%dtadb_lang%
  PAUSE > nul
  EXIT /B
)

echo.
call :lng_ready_%dtadb_lang%

REM delete the temp-file.
if EXIST %mineLocNew% (
  del %mineLocNew%
)

set curFloor=0

REM File-Structure
REM # = comment;Level/Type of mine;area of mine;new area of mine;ressource
REM ; = <TAB>

Rem Read through file and process every line.
for /f "usebackq tokens=1,2,3,4,5 delims=	" %%a in (%minesLoc%) do (
  if "%%a" NEQ "-" (
    echo %%a	%%b	%%c	%%d	%%e>> %mineLocNew%
  ) else (       
    set /A oldPos=%%c*-1
	set /A newPos=%%d*-1
	set ressource=%%e
	if "!oldPos!" EQU "!newPos!" (
	  REM echo Skip. Mine does not change position.
	) else (
	  call %script_home%\select_floor.cmd %funcRelocate% !curFloor! !oldPos!
	  call %script_home%\select_func.cmd %funcMove%
	  call %script_home%\select_floor.cmd %funcRelocate% !curFloor! !newPos!	  
	  call %script_home%\select_func.cmd %funcMove%
	)
	if "%%b" EQU "c" (
	  if "%%e" NEQ "" (
	    call %script_home%\select_floor.cmd %funcRelocate% !curFloor! !newPos!
	    call %script_home%\select_func.cmd %funcSearch%
	    call %script_home%\select_chem_search.cmd !ressource!
		set "ressource="
	  )
	)
	echo %%a	%%b	%%d	%%d	!ressource!>> %mineLocNew%
  )
)
if !curFloor! NEQ 0 (
  call %script_home%\select_floor.cmd %funcBase% !curFloor!
)

del %minesLoc%
ren %mineLocNew% %mines_filename%
call :lng_finished_%dtadb_lang%

PAUSE

goto :EOF
REM +==================================================+
REM I MESSAGES AND TRANSLATION
REM +==================================================+
:lng_ready_EN
  echo Position DeepTown on Area 0, then press any key to continue.
  echo.
  PAUSE > nul
  set funcRelocate=relocate
  set funcMove=move3
  set funcSearch=search
  set funcBase=base
goto :EOF
:lng_ready_DE
  echo Wahle Ebene 0 in DeepTown, wenn bereit beliebige Taste druecken.
  echo.
  PAUSE > nul
  set funcRelocate=verschieben
  set funcMove=bewegen3
  set funcSearch=suchen
  set funcBase=basis
goto :EOF
:lng_missing_input_EN
  echo Error: Please start the procedure in combination with a file.
goto :EOF
:lng_missing_input_DE
  echo Fehler: Bitte zum Starten der Prozedure eine Datei verwenden.
goto :EOF
:lng_input_not_found_EN
  echo Error: Could not open file "%minesLoc%"
goto :EOF
:lng_input_not_found_DE
  echo Fehler: Datei konnte nicht geoeffnet werden "%minesLoc%"
goto :EOF
:lng_finished_EN
  echo Done.
goto :EOF
:lng_finished_DE
  echo Fertig.
goto :EOF
:restore_home
  REM +=================================================+
  REM I  Restore the current working directory          I
  REM +=================================================+
  %script_home:~1,2%
  cd \
  cd %script_home%\
goto :EOF