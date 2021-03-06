@echo off
setlocal EnableDelayedExpansion

set script_home=%1

set "device="
set devices_list=devices_list.log
set found_devices=0
set choosen_device=0

call .\load_env.cmd 

:detect_device
call :lng_scanning_devices_%dtadb_lang%
adb devices > %devices_list%

for /f "usebackq skip=1 eol=; delims=µ" %%a in (%devices_list%) do ( 
  set /A found_devices+=1
)

if %found_devices% EQU 0 (
  call :lng_no_devices_%dtadb_lang%
  timeout /t 10
  echo.
  goto :detect_device
) else (
  if %found_devices% EQU 1 (
    set choosen_device=1
  ) else (
    if %found_devices% GTR 1 (
	  call :lng_multiple_devices_%dtadb_lang%
      set found_devices=1
      for /f "usebackq skip=1 eol=; delims=µ" %%a in (%devices_list%) do (
	    echo !found_devices! : %%a
        set /A found_devices+=1
      )    
      call :lng_device_selection_%dtadb_lang%
    )
  )

  if "%choosen_device%" NEQ "" (
    set found_devices=1
    for /f "usebackq skip=1 eol=; delims=µ" %%a in (%devices_list%) do (
      if !found_devices! EQU !choosen_device! (
  	  for /f "tokens=1,2 delims=	" %%b in ("%%a") do (
  	    set device=%%b
        )
  	  )
      set /A found_devices+=1		
    )
	
	call %script_home%\update_env.cmd  %script_home%\load_env.cmd device !device!
  ) 	
)

endlocal & (
set "device=%device%"
)

goto :EOF
REM +==================================================+
REM I MESSAGES AND TRANSLATION
REM +==================================================+
REM    ....i....1....i....2....i....3....i....4....i....5....i....6....i....7....i....8
:lng_no_devices_EN
  echo No devices connected!
goto :EOF
:lng_no_devices_DE
  echo Keine Geraete verbunden!
goto :EOF
:lng_multiple_devices_EN
  echo Multiple Devices found: 
goto :EOF
:lng_multiple_devices_DE
  echo Mehrere Geraete erkannt: 
goto :EOF  
:lng_device_selection_EN
  set /P choosen_device=Which device you want to connect to:
goto :EOF
:lng_device_selection_DE
  set /P choosen_device=Zu welchem Geraet moechtest Du Dich verbinden:
goto :EOF
:lng_scanning_devices_EN
  echo Scanning for connected android devices...
goto :EOF
:lng_scanning_devices_DE
  echo Suche nach verbundenen Android Geraeten...
goto :EOF