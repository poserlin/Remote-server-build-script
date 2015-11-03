@echo off

cd /D %~dp0
REM //set build cmd here
set Build_cmd=8996.gen.prod_htc_debug_UMTS.cmd

TITLE Building this codebase on Remote Server

REM //find build cmd & run it
for /r %~dp0 %%a in (*) do if "%%~nxa"=="%Build_cmd%" set p=%%~dpa
if not defined p (
echo Build cmd not found
) else (
echo %p%
)

call %p%wsd_server.bat /WAIT
call %p%%Build_cmd% /WAIT
