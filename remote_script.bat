@echo off

REM echo %~dp0
REM echo %CD%\modem_proc\build\ms\
if  %~dp0 == %CD%\modem_proc\build\ms\ (
GOTO Localbuild
) else (GOTO Remotebuild)

:Localbuild
    echo Local build
    cd %~dp0
    echo %CD%
    call build_cmd.bat
    
    for /r %~dp0 %%a in (*) do if "%%~nxa"=="radio.img" set p=%%~dpa
    if not defined p (echo File not found)  
    GOTO End 
    
:Remotebuild
    echo Remote build
    set remotefullpath=%~dp0%
    set remotecomname=%remotefullpath:~0,15%

    REM //set remote local path = "D:\"+
    set remotelocalpath=D:%remotefullpath:~15%

    echo Remote computer name: %remotecomname%
    echo Remote local path: %remotelocalpath%

    TITLE Connecting to Remote server %remotecomname%
    call psexec %remotecomname% -high %remotelocalpath%build_cmd.bat

    TITLE Finishing Building on %remotecomname%

    REM //find radio.img & open it
    for /r %remotefullpath%bin %%a in (*) do if "%%~nxa"=="radio.img" set p=%%~dpa
    if not defined p (echo File not found)
    GOTO End    
    
:End
    START explorer.exe %p%
    pause
