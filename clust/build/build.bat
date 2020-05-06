@echo off
echo.

:: Standalone build
curl -fsSL -o q.lib https://github.com/KxSystems/kdb/raw/master/w64/q.lib    || goto :error
curl -fsSL -o ../src/k.h   https://github.com/KxSystems/kdb/raw/master/c/c/k.h      || goto :error

::keep original PATH, PATH may get too long otherwise
set OP=%PATH%

set year=%1

if "%year%" == "2017" (
	set yearenv=2017\Community
) else if "%year%" == "2019" (
	set yearenv=2019\Buildtools
)

IF NOT "%VSDIR%" == "" (
	call %VSDIR%
) else if "%yearenv%" == "" (
	goto :error
)else (
      goto :VS
)      

:VS
call "C:\Program Files (x86)\Microsoft Visual Studio\%yearenv%\VC\Auxiliary\Build\vcvars64.bat"


cl /LD /DKXVER=3 ../src/kdnn.c q.lib
set PATH=%OP%

move *.dll %QHOME%\w64

del *.exp *.lib *.obj

exit /b 0
:error
exit /b %errorLevel%
