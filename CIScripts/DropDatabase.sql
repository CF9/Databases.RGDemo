USE [master]
GO
/*
==================================================
Name:		DropDatabase.sql
Created:	2011.07.21
Author:		eh
Purpose:	Checks for the existence of a $(DATABASE_NAME) database
			and drops it if necessary.  This is performed after a 
			successful database build.

History:
2011.07.21	eh	Created
==================================================
*/

--:setvar DATABASE_NAME "PracticeFusion_CI"

-- Drop the database if it exists
IF DB_ID('$(DATABASE_NAME)') IS NOT NULL
BEGIN
	DROP DATABASE [$(DATABASE_NAME)]
END
GO