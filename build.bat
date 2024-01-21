@echo off
setlocal enabledelayedexpansion

javac --version 
IF errorlevel 1 goto :NoJavac

RMDIR /S /Q .\dist\QuizVineWebApplication\WEB-INF\classes\*
ROBOCOPY /E .\src\java .\dist\QuizVineWebApplication\WEB-INF\classes\
SET "javaPath=.\dist\QuizVineWebApplication\WEB-INF\classes\"
SET "javaFiles="
FOR /R "%javaPath%" %%i IN (*.java) do (
    SET "javaFiles=!javaFiles! %%i" 
)

javac -Xlint:none -cp ".\lib\*" -source 7 -target 7 %javaFiles%

goto :Done

:NoJavac
echo javac not found in path. 
goto :Done


:Done
echo Execution finished.
