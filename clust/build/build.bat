@echo off
echo.

:: Standalone build
curl -fsSL -o q.lib https://github.com/KxSystems/kdb/raw/master/w64/q.lib    || goto :error
curl -fsSL -o ../src/k.h   https://github.com/KxSystems/kdb/raw/master/c/c/k.h      || goto :error

::keep original PATH, PATH may get too long otherwise
set OP=%PATH%


:: if %1==[] ECHO VISUAL STUDIO year missing

if %1==2017 (%DIR% = "Community"
) elif %1==2019 (%DIR% = "Buildtools"
)


call "C:\Program Files (x86)\Microsoft Visual Studio\%VS%\%DIR%\Auxiliary\Build\vcvars64.bat"

:: if EXIST "\Program Files (x86)\Microsoft Visual Studio\2018\Community\VC\Auxiliary\Build\vcvars64.bat" (
::	call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\VC\Auxiliary\Build\vcvars64.bat"
::) else (	
 :: call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Buildtools\VC\Auxiliary\Build\vcvars64.bat"
::)

cl /LD /DKXVER=3 ../src/kdnn.c q.lib
set PATH=%OP%

move *.dll %QHOME%\w64

del *.exp *.lib *.obj

exit /b 0
:error
exit /b %errorLevel%
