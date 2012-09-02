@echo off
REM for building on the commandline with ant
REM mainly created to build, test, debug CI scripts without installing hudson

set JOB_NAME=hello
REM note for hudson this is actually the name of the working copy directory which is regular
REM however users can name them whatever they want so in order to make this regular
REM workspace is one directory up from its definition in hudson (i.e. one directory up from here)
REM and then SCM_PATH_MODIFIER is one directory up from that
set WORKSPACE=%~dp0..

cmd /C "ant.bat -DSCM_PATH_MODIFIER=.. %* && exit %%ERRORLEVEL%%
pause
