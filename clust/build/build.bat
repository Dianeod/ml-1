@echo off
echo.

:: Standalone build
curl -fsSL -o q.lib https://github.com/KxSystems/kdb/raw/master/w64/q.lib    || goto :error
curl -fsSL -o ../src/k.h   https://github.com/KxSystems/kdb/raw/master/c/c/k.h      || goto :error

::keep original PATH, PATH may get too long otherwise
set OP=%PATH%

set year = %1

IF NOT "%VSDIR%" == "" (
	call %VSDIR%
) else IF "year" == "" (
       goto :error
)else (
      goto :VS%year%
)      


cl /LD /DKXVER=3 ../src/kdnn.c q.lib
set PATH=%OP%

move *.dll %QHOME%\w64

del *.exp *.lib *.obj

exit /b 0
:error
exit /b %errorLevel%
