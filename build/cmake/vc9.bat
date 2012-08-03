@echo off

set PWD=%~dp0
set SRC_ROOT=%PWD%\..\..\
set BUILD_ROOT=%PWD%\build-vc9

mkdir %BUILD_ROOT%
cd %BUILD_ROOT%

cmake -G "Visual Studio 9 2008" %SRC_ROOT%


cd %PWD%