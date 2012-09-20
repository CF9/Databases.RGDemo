USE [master]
GO
/*
==================================================
Name:		RunTests.sql
Created:	2012.09.19
Author:		Ernest Hwang
Purpose:	Runs all tSQLt tests and saves results in an XML file

Syntax:		sqlcmd.exe -i RunTests.sql -S [SERVER_NAME] -d master -v DATABASE_NAME="[DATABASE_NAME]"
			
History:
2011.08.08	eh	Added DATABASE_NAME variable
				Added SQLSERVER_PATH variable
2011.07.21	eh	Created
==================================================
*/

--:setvar DATABASE_NAME "RGDemo_CI"
:setvar SQLSERVER_PATH "C:\\Program Files\\Microsoft SQL Server\\MSSQL10_50.MSSQLSERVER\\MSSQL\\DATA\\"

USE [$(DATABASE_NAME)]
GO

EXEC
	tSQLt.RunAll
