@echo off
cls
setlocal EnableDelayedExpansion
set script_home="%CD%"

:start
  echo.
  echo +------------------------------------+
  echo I       DeepTown ADB interface       I
  echo +------------------------------------+  
  call %script_home%\detect_devices.cmd %script_home%
  call %script_home%\load_env.cmd 
  call :restore_home
:menu
  cls
  call :lng_main_menu_%dtadb_lang%
  call :choice%choice%
  if errorlevel 1 (
    echo.
    call :lng_wrong_input_%dtadb_lang%
    goto :menu
  )

goto :end

:choice1
  set choice=craft
  set duration=4h29m
  goto :task24h
  goto :EOF
:choice2
  set choice=smelt
  set duration=4h29m
  goto :task24h
  goto :EOF
:choice3
  set choice=garden
  set duration=4h29m
  goto :task24h
  goto :EOF
:choice4
  set choice=jewel
  set duration=2h59m
  goto :task24h
  goto :EOF
:choice5
  set duration=2h59m
  set choice=chemi
  goto :task24h
  goto :EOF
:choice6
  set duration=3h59m  
  goto :mine24h
  goto :EOF
:choice7
  call :ready7
  call %script_home%\arrange_mines.cmd %choosenFile%
  goto :menu
:choicee
  goto :end

goto :EOF
:calc_cycle
  for /f "tokens=1,2 delims=hm" %%a in ("%duration%") do (
    set hour=%%a
	set mins=%%b
  )
  set /A cycle=((((%hour%*60)+%mins%)*60)/900)
  for /f "tokens=1,2 delims=.," %%a  in ("%cycle%") do (
    set cycle=%%a
  )

goto :EOF
:ready
  echo.
  set files=load_env.cmd
  call :lng_ready_%dtadb_lang%
  PAUSE > nul

goto :EOF
:ready7
  echo.
  call :lng_select_mining_file_%dtadb_lang%
  set "choosenFile="
  set fileNo=1
  FOR /F "tokens=*" %%a IN ('dir /b %script_home%\mines*.txt') DO (  
    echo    [!fileNo!] : %%a 
	set /A fileNo+=1
  )
  set /P choosenNo= :
  set fileNo=1
  FOR /F "tokens=*" %%a IN ('dir /b %script_home%\mines*.txt') DO (
    if !fileNo! EQU %choosenNo% (
	  set choosenFile=%%a
	)
    set /A fileNo+=1
  )   
  set files=load_env.cmd, %choosenFile%
  echo.
  call :lng_ready_%dtadb_lang%
  PAUSE > nul
goto :EOF

:prep_commands
REM it would be not necessary to translate the commands.
REM but pre-prepared it looks unfinished if english words pop up in an DE environment.
  if "%dtadb_lang%" EQU "DE" (
    set water=wasser
	set claim=sammeln
	set underground=untergrund
	set oil=oel
	set dronebay=drohnenbucht
	set actions=aktionen
	set collect=sammeln
	set move3=bewegen3
	set base=basis
    set mine=abbauen
  ) else (
    set water=water
	set claim=claim
	set underground=underground
	set oil=oil
	set dronebay=dronebay
	set actions=actions
	set collect=collect
	set move3=move3
	set base=base
	set mine=mine	
  )

goto :EOF
:task24h  
  call :get_collect_bot
  call :prep_commands
  call :calc_cycle  
  call :ready
  echo.
:task24hloop  
  REM +=================================================+
  REM I  Claim Water and Oil and
  REM I  .. send bots to collect and craft
  REM I  .. then return to water collector and claim 4h
  REM I  .. return to base and restart.
  REM +=================================================+
  call %script_home%\select_floor.cmd %water% 0
  call %script_home%\select_func.cmd %claim%
  call %script_home%\select_floor.cmd %underground% %curFloor%
  call %script_home%\select_building.cmd %oil% 1
  call %script_home%\select_func.cmd %claim%
  call %script_home%\select_building.cmd %oil% 2
  call %script_home%\select_func.cmd %claim%
  call %script_home%\select_floor.cmd %dronebay% %curFloor%
  FOR /L %%b IN (1,1,8) DO (
    if %%b EQU %collecor_bot% (
      call %script_home%\select_bot.cmd %collecor_bot%
      call %script_home%\select_func.cmd %actions%
      call %script_home%\select_action.cmd %collect%  	
	) else (
      call %script_home%\select_bot.cmd %%b
      call %script_home%\select_func.cmd %actions%
      call %script_home%\select_action.cmd %choice%	
	)
  )
  call %script_home%\select_floor.cmd %water% %curFloor%
  call %script_home%\select_func.cmd %move3%
  FOR /L %%b IN (1,1,%cycle%) DO (
    call %script_home%\select_func.cmd %claim%
	set b=%%b
	call :lng_cycle_progress_%dtadb_lang%
    timeout /t 900
  )
  call %script_home%\select_floor.cmd %base% %curFloor%
  GOTO :task24hloop

goto :end
:mine24h
  call :get_collect_bot
  call %script_home%\get_input_ress.cmd %dtadb_lang%
  call :prep_commands
  call :calc_cycle
  call :ready
  echo.
:mine24hloop
  REM +=================================================+
  REM I  Claim Water and Oil and
  REM I  .. send bots to collect and mine
  REM I  .. then return to water collector and claim 3h
  REM I  .. return to base and restart.
  REM +=================================================+
  call %script_home%\select_floor.cmd %water% 0
  call %script_home%\select_func.cmd %claim%
  call %script_home%\select_floor.cmd %underground% %curFloor%
  call %script_home%\select_building.cmd %oil% 1
  call %script_home%\select_func.cmd %claim%
  call %script_home%\select_building.cmd %oil% 2
  call %script_home%\select_func.cmd %claim%
  call %script_home%\select_floor.cmd %dronebay% %curFloor%
  set "skipWord="
  FOR /L %%b IN (1,1,8) DO (
    if %%b EQU %collecor_bot% (
      call %script_home%\select_bot.cmd %collecor_bot%
      call %script_home%\select_func.cmd %actions%
      call %script_home%\select_action.cmd %collect%  	
	) else (
      call %script_home%\select_bot.cmd %%b
      call %script_home%\select_func.cmd %actions%
      call %script_home%\select_action.cmd %mine%
      call %script_home%\select_ress.cmd %input_ress% !skipWord!
	  set skipWord=skip	
	)
  )
  call %script_home%\select_floor.cmd water %curFloor%
  call %script_home%\select_func.cmd %move3%
  FOR /L %%b IN (1,1,%cycle%) DO (
    call %script_home%\select_func.cmd %claim%
	set b=%%b
	call :lng_cycle_progress_%dtadb_lang%
    timeout /t 900
  )
  call %script_home%\select_floor.cmd %base% %curFloor%
  GOTO :mine24hloop

goto :EOF
:get_collect_bot
  echo.
  call :lng_collecter_bot_%dtadb_lang%
  set /P collecor_bot=%lng_collector_bot_input%

goto :EOF
REM +==================================================+
REM I MESSAGES AND TRANSLATION
REM +==================================================+
REM    ....i....1....i....2....i....3....i....4....i....5....i....6....i....7....i....8
:lng_main_menu_EN
  echo +====================================+
  echo I       DeepTown ADB interface       I
  echo +------------------------------------+
  echo I       Select a program             I
  echo +====================================+
  echo.
  echo   [1]  boost crafting floor *1
  echo   [2]  boost smelthing floor *1
  echo   [3]  boost garden floor *1
  echo   [4]  boost jewel floor *1
  echo   [5]  boost chemical floor *1
  echo.
  echo   [6]  direct mine resource *1
  echo.
  echo   [7]  rearrange mines
  echo.
  echo   [e]  exit DTADBI
  echo.
  echo   *1: will claim water and oil (1st and 2nd entry), send 1st bot to collect
  echo       and the other bots to the specified task. will constantly claim water.
  echo.
  set /P choice=Choose your program:
goto :EOF
:lng_main_menu_DE
  echo.
  echo +====================================+
  echo I       DeepTown ADB interface       I
  echo +------------------------------------+
  echo I       Waehle ein Programm          I
  echo +====================================+
  echo.
  echo   [1]  Handwerk verbessern *1
  echo   [2]  Schmelzen verbessern *1
  echo   [3]  Gartenbau verbessern *1
  echo   [4]  Erhoeht die Juwelenproduk *1
  echo   [5]  Produktion der Chemieetage *1
  echo.
  echo   [6]  Rohstoffe abbauen *1
  echo.
  echo   [7]  Minen neu plazieren
  echo.
  echo   [e]  verlasse DTADBI
  echo.
  echo   *1: sammelt wasser and oel (1sten und 2ten Eintrag), sendet den 1sten Bot
  echo       zum sammeln und die restlichen erledigen die gewaehlte Aufgabe. Wasser
  echo       wird dauerhaft gesammelt.
  echo.
  set /P choice=Waehle ein Programm:
goto :EOF
:lng_wrong_input_EN
  echo Wrong input "%choice%", system restart.
goto :EOF
:lng_wrong_input_DE
  echo Falsche Eingabe "%choice%", neustart.
goto :EOF
:lng_ready_EN
  echo Please position the view on the main base in DeepTown (Area 0),
  echo additionaly the %files% must be up-to-date,
  echo continue by press any key.
goto :EOF
:lng_ready_DE
  echo Bitte die Ansicht auf Ebene 0, die Hauptbasis, in DeepTown einstellen,
  echo zusaetzlich muss die %files% aktualisiert sein,
  echo weiter mit beliebiger Taste.
goto :EOF
:lng_cycle_progress_EN
  echo Cycle !b! of %cycle%
goto :EOF
:lng_cycle_progress_DE
  echo Zyklus !b! von %cycle%
goto :EOF
:lng_collecter_bot_EN
  echo Which drone should be responsible for collecting ressources?
  echo Choose [0] if no drone should do it.
  set lng_collector_bot_input=Drone [0-8]:
goto :EOF
:lng_collecter_bot_DE
  echo Welche Drohne soll fuer das Sammeln von Reesourcen zustaendig sein?
  echo Falls es keine Drohne uebernhemen soll waehle [0].
  set lng_collector_bot_input=Drohne [0-8]:
goto :EOF
:lng_select_mining_file_EN
  echo Select a configuation file from %script_home%
goto :EOF
:lng_select_mining_file_DE
  echo Waehle die Konfigurationsdatei aus %script_home%
goto :EOF

REM +==================================================+
REM I MESSAGES AND TRANSLATION              - END -
REM +==================================================+

goto :EOF  
:restore_home
  REM +=================================================+
  REM I  Restore the current working directory          I
  REM +=================================================+
  %script_home:~1,2%
  cd \
  cd %script_home%\
goto :EOF
:end
  call :restore_home