@echo off
echo Installing the Maven-built Java application into the local Maven repository...
mvn jar:jar install:install help:evaluate -Dexpression=project.name

REM Extract project name from pom.xml
for /f "delims=" %%a in ('mvn help:evaluate -Dexpression=project.name ^| findstr /v /c:"["') do set NAME=%%a

REM Extract project version from pom.xml
for /f "delims=" %%a in ('mvn help:evaluate -Dexpression=project.version ^| findstr /v /c:"["') do set VERSION=%%a

REM Navigate to the target directory
cd /d %~dp0\..\..\target

echo Running the Java application...
java -jar %NAME%-%VERSION%.jar | tee output.log
type output.log
