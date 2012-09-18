@ECHO OFF
::
::	DeployDB.bat
::
::	Deploys a versioned database using MSBuild.exe.
::	The build script (MSBuild.xml) should contain a Deploy target
::	that can deploy a Red Gate scripted database.
::
::	Syntax:
::		DeployDB.bat PF.Databases.DATABASE_NAME ENVIRONMENT_NAME SVN_FOLDER_NAME
::		e.g. DeployDB.bat Databases.RGDemo localhost trunk
::
::	History:
::	2012-09-18		eh	Ported from PracticeFusion build server

PROMPT %DATE:~10,4%-%DATE:~4,2%-%DATE:~7,2% $t$g
@ECHO ON
C:\WINDOWS\Microsoft.NET\Framework64\v4.0.30319\MSBuild.exe C:\JenkinsPublisher\%2\%1\MSBuild.xml /t:DeployEnvironment /property:DestinationEnvironment="%2"
RMDIR C:\JenkinsPublisher\%2\%1 /s /q
@ECHO OFF
PROMPT $p$g
