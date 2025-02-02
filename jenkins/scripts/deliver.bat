@echo off
echo Installing the Maven-built Java application into the local Maven repository...
mvn jar:jar install:install help:evaluate -Dexpression=project.name

REM Extract project name from pom.xml
for /f "delims=" %%a in ('mvn help:evaluate -Dexpression=project.name ^| findstr /v /c:"["') do set NAME=%%a

REM Extract project version from pom.xml
for /f "delims=" %%a in ('mvn help:evaluate -Dexpression=project.version ^| findstr /v /c:"["') do set VERSION=%%a

REM Change to target directory before running Java
cd /d %~dp0\..\..\target

echo Running the Java application...
start /wait cmd /c "java -jar %NAME%-%VERSION%.jar"
