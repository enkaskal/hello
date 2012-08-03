@echo off

set PWD=%~dp0
set SRC_ROOT=%PWD%\..\..\
set BUILD_ROOT=%PWD%\build-vc8

mkdir %BUILD_ROOT%
cd %BUILD_ROOT%

cmake -G "Visual Studio 8 2005" %SRC_ROOT%


cd %PWD%