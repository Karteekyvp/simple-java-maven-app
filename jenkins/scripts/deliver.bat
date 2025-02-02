@echo off
echo Installing the Maven-built Java application into the local Maven repository...
mvn jar:jar install:install help:evaluate -Dexpression=project.name

REM Extract the project name from pom.xml
for /f "delims=" %%a in ('mvn help:evaluate -Dexpression=project.name ^| findstr /v /c:"["') do set NAME=%%a

REM Extract the project version from pom.xml
for /f "delims=" %%a in ('mvn help:evaluate -Dexpression=project.version ^| findstr /v /c:"["') do set VERSION=%%a

echo Running the Java application...
java -jar target\%NAME%-%VERSION%.jar >> output.log 2>&1
type output.log
