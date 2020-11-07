@echo off
cls
setlocal EnableDelayedExpansion
set script_home="%CD%"

:start
  echo.
  echo +------------------------------------+
  echo I       DeepTown ADB interface       I
  echo I         - Script Builder -         I
  echo +------------------------------------+
  call %script_home%\load_env.cmd
  call :restore_home

  set "curFloor=%%curFloor%%"
  set "CD1=%%cd%%"
  set "scripthome1=%%script_home%%"
  set "drive=%%script_home:~1,2%%"

  set /P batchName=Name of the new batch file (without extension):
  set batchName=usr_%batchName%.cmd

  echo @echo off > %batchName%
  echo cls>> %batchName%
  echo setlocal EnableDelayedExpansion>> %batchName%
  echo set script_home="%CD1%">> %batchName%
  echo echo.>> %batchName%
  echo echo +----------------------------------------+>> %batchName%
  echo echo I       DeepTown ADB Custom Script       I>> %batchName%
  echo echo +----------------------------------------+>> %batchName%
  echo call %scripthome1%\detect_devices.cmd %scripthome1%>> %batchName%
  echo call %scripthome1%\load_env.cmd>> %batchName%
  echo %drive%>> %batchName%
  echo cd \>> %batchName%
  echo cd %scripthome1%\>> %batchName%
  echo echo.>> %batchName%

  set files=load_env.cmd
  call :lng_ready_%dtadb_lang%

  set /P choice=Collect water once at beginning [y]es/[n]o:
  if "%choice%" EQU "y" (
    echo call %scripthome1%\select_floor.cmd water 0 >> %batchName%
    echo call %scripthome1%\select_func.cmd claim>> %batchName%
    echo call %scripthome1%\select_floor.cmd base %curFloor%>> %batchName%
  ) else (
    echo set curFloor=0>> %batchName%
  )

  echo :mainloop>> %batchName%
  set /P choice=Collect oil stations; 0 = none [0-5]:
  if %choice% GTR 0 (
    if %choice% LSS 6 (
	  echo call %scripthome1%\select_floor.cmd underground %curFloor%>> %batchName%
	  FOR /L %%a IN (1,1,%choice%) DO (
	    echo call %scripthome1%\select_building.cmd oil %%a>> %batchName%
        echo call %scripthome1%\select_func.cmd claim>> %batchName%
	  )
	)
  )

  set "oldRess="
  echo call %scripthome1%\select_floor.cmd dronebay %curFloor%>> %batchName%
  FOR /L %%a IN (1,1,%maxDrones%) DO (
    echo :taskBot%%a>> %batchName%
	echo.
    set /P choice=Assign a task to drone #%%a [y]es/[n]o:
	if "!choice!" EQU "y" (
	  echo Available task:  [1]collect [2]smelt [3]craft [4]garden [5]water [6]oil [7]mine [8]jewel [9]chemi
	  set /P choiceTask=Task to perform:
	  set curDrone=%%a
	  if "!choiceTask!" EQU "1" call :bot_collect
	  if "!choiceTask!" EQU "2" call :bot_smelt
	  if "!choiceTask!" EQU "3" call :bot_craft
	  if "!choiceTask!" EQU "4" call :bot_garden
	  if "!choiceTask!" EQU "5" call :bot_water
	  if "!choiceTask!" EQU "6" call :bot_oil
	  if "!choiceTask!" EQU "7" call :bot_mine
	  if "!choiceTask!" EQU "8" call :bot_jewel
	  if "!choiceTask!" EQU "9" call :bot_chemi
	)
  )

  set "b=%%%%b"
  echo :WaterClaim>> %batchName%
  echo call %scripthome1%\select_floor.cmd water %curFloor%>> %batchName%
  echo call %scripthome1%\select_func.cmd move3>> %batchName%
  echo FOR /L %b% IN (1,1,12) DO (>> %batchName%
  echo   call %scripthome1%\select_func.cmd claim>> %batchName%
  echo   set b=%b%>> %batchName%
  echo   timeout /t 900>> %batchName%
  echo )>> %batchName%
  echo call %scripthome1%\select_floor.cmd base %curFloor%>> %batchName%
  echo GOTO :mainloop>> %batchName%

  echo.
  echo Script "%batchName%" created.
  PAUSE

goto :EOF
:bot_collect
  echo call %scripthome1%\select_bot.cmd %curDrone% >> %batchName%
  echo call %scripthome1%\select_func.cmd actions>> %batchName%
  echo call %scripthome1%\select_action.cmd collect>> %batchName%
goto :EOF
:bot_smelt
  echo call %scripthome1%\select_bot.cmd %curDrone% >> %batchName%
  echo call %scripthome1%\select_func.cmd actions>> %batchName%
  echo call %scripthome1%\select_action.cmd smelt>> %batchName%
goto :EOF
:bot_craft
  echo call %scripthome1%\select_bot.cmd %curDrone% >> %batchName%
  echo call %scripthome1%\select_func.cmd actions>> %batchName%
  echo call %scripthome1%\select_action.cmd craft>> %batchName%
goto :EOF
:bot_garden
  echo call %scripthome1%\select_bot.cmd %curDrone% >> %batchName%
  echo call %scripthome1%\select_func.cmd actions>> %batchName%
  echo call %scripthome1%\select_action.cmd garden>> %batchName%
goto :EOF
:bot_water
  echo call %scripthome1%\select_bot.cmd %curDrone% >> %batchName%
  echo call %scripthome1%\select_func.cmd actions>> %batchName%
  echo call %scripthome1%\select_action.cmd water>> %batchName%
goto :EOF
:bot_oil
  echo call %scripthome1%\select_bot.cmd %curDrone% >> %batchName%
  echo call %scripthome1%\select_func.cmd actions>> %batchName%
  echo call %scripthome1%\select_action.cmd oil>> %batchName%
goto :EOF
:bot_jewel
  echo call %scripthome1%\select_bot.cmd %curDrone% >> %batchName%
  echo call %scripthome1%\select_func.cmd actions>> %batchName%
  echo call %scripthome1%\select_action.cmd jewel>> %batchName%
goto :EOF
:bot_chemi
  echo call %scripthome1%\select_bot.cmd %curDrone% >> %batchName%
  echo call %scripthome1%\select_func.cmd actions>> %batchName%
  echo call %scripthome1%\select_action.cmd chemi>> %batchName%
goto :EOF
:bot_mine
  call %script_home%\get_input_ress.cmd %dtadb_lang%
  echo call %scripthome1%\select_bot.cmd %curDrone% >> %batchName%
  echo call %scripthome1%\select_func.cmd actions>> %batchName%
  echo call %scripthome1%\select_action.cmd mine>> %batchName%
  if "%oldRess%" EQU "%input_ress%" (
    set skipWord=skip
  ) else (
    set oldRess=%input_ress%
    set "skipWord="
  )
  echo call %scripthome1%\select_ress.cmd %input_ress% %skipWord%>> %batchName%
goto :EOF
:lng_ready_EN
  echo echo Please position the view on the main base in DeepTown (Area 0),>> %batchName%
  echo echo additionaly the %files% must be up-to-date,>> %batchName%
  echo echo continue by press any key.>> %batchName%
  echo pause>> %batchName%
goto :EOF
:lng_ready_DE
  echo echo Bitte die Ansicht auf Ebene 0, die Hauptbasis, in DeepTown einstellen,>> %batchName%
  echo echo zusaetzlich muss die %files% aktualisiert sein,>> %batchName%
  echo echo weiter mit beliebiger Taste.>> %batchName%
  echo pause>> %batchName%
goto :EOF
:restore_home
  REM +=================================================+
  REM I  Restore the current working directory          I
  REM +=================================================+
  %script_home:~1,2%
  cd \
  cd %script_home%\
goto :EOF