@echo off
REM for building on the commandline with ant
REM mainly created to build, test, debug CI scripts without installing hudson

set JOB_NAME=hello
set DEVENV=%VS80COMNTOOLS%..\IDE\devenv
REM note for hudson this is actually the name of the working copy directory which is regular
REM however users can name them whatever they want so in order to make this regular
REM workspace is one directory up from its definition in hudson (i.e. one directory up from here)
REM and then SCM_PATH_MODIFIER is one directory up from that
set WORKSPACE=%~dp0..
set PROGRAM_FILES_ROOT=C:\Program Files
set if exist "C:\Program Files (x86)" set PROGRAM_FILES_ROOT=%PROGRAM_FILES_ROOT% (x86)

cmd /C "ant.bat -DSCM_PATH_MODIFIER=.. -Dsolution_name=hello.sln %* && exit %%ERRORLEVEL%%
pause
