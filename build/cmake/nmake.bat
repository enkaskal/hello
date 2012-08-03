@echo off

set PWD=%~dp0
set SRC_ROOT=%PWD%\..\..\
set BUILD_ROOT=%PWD%\build-nmake

REM call vcvars32.bat

mkdir %BUILD_ROOT%
cd %BUILD_ROOT%

cmake -G "NMake Makefiles" -DCMAKE_BUILD_TYPE=Release %SRC_ROOT%

cd %PWD%