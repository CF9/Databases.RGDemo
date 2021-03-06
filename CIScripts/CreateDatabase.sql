USE [master]
GO
/*
==================================================
Name:		CreateDatabase.sql
Created:	2011.07.21
Author:		eh
Purpose:	Checks for the existence of the database
			and drops it if necessary, then recreates it from scratch.

Syntax:		sqlcmd.exe -i CreateDatabase.sql -S [SERVER_NAME] -U [USER_NAME] -P [PASSWORD] -d master -v DATABASE_NAME="[DATABASE_NAME]"
			
History:
2011.08.08	eh	Added DATABASE_NAME variable
				Added SQLSERVER_PATH variable
2011.07.21	eh	Created
==================================================
*/

--:setvar DATABASE_NAME "PracticeFusion_CI"
:setvar SQLSERVER_PATH "C:\\Program Files\\Microsoft SQL Server\\MSSQL10_50.MSSQLSERVER\\MSSQL\\DATA\\"
--:setvar SQLSERVER_PATH "C:\\Program Files\\Microsoft SQL Server\\MSSQL11.MSSQLSERVER\\MSSQL\\DATA\\"


-- Drop the database if it exists
IF DB_ID('$(DATABASE_NAME)') IS NOT NULL
BEGIN
	DROP DATABASE [$(DATABASE_NAME)]
END
GO

/****** Object:  Database [$(DATABASE_NAME)]    Script Date: 07/21/2011 17:12:30 ******/
CREATE DATABASE [$(DATABASE_NAME)] ON  PRIMARY 
( NAME = N'$(DATABASE_NAME)', FILENAME = N'$(SQLSERVER_PATH)$(DATABASE_NAME).mdf' , SIZE = 10000KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'$(DATABASE_NAME)_log', FILENAME = N'$(SQLSERVER_PATH)$(DATABASE_NAME).ldf' , SIZE = 5000KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO

ALTER DATABASE [$(DATABASE_NAME)] SET COMPATIBILITY_LEVEL = 90
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [$(DATABASE_NAME)].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [$(DATABASE_NAME)] SET ANSI_NULL_DEFAULT ON 
GO

ALTER DATABASE [$(DATABASE_NAME)] SET ANSI_NULLS ON 
GO

ALTER DATABASE [$(DATABASE_NAME)] SET ANSI_PADDING ON 
GO

ALTER DATABASE [$(DATABASE_NAME)] SET ANSI_WARNINGS ON 
GO

ALTER DATABASE [$(DATABASE_NAME)] SET ARITHABORT ON 
GO

ALTER DATABASE [$(DATABASE_NAME)] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [$(DATABASE_NAME)] SET AUTO_CREATE_STATISTICS ON 
GO

ALTER DATABASE [$(DATABASE_NAME)] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [$(DATABASE_NAME)] SET AUTO_UPDATE_STATISTICS OFF 
GO

ALTER DATABASE [$(DATABASE_NAME)] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [$(DATABASE_NAME)] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [$(DATABASE_NAME)] SET CONCAT_NULL_YIELDS_NULL ON 
GO

ALTER DATABASE [$(DATABASE_NAME)] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [$(DATABASE_NAME)] SET QUOTED_IDENTIFIER ON 
GO

ALTER DATABASE [$(DATABASE_NAME)] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [$(DATABASE_NAME)] SET ENABLE_BROKER WITH ROLLBACK IMMEDIATE
GO

ALTER DATABASE [$(DATABASE_NAME)] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [$(DATABASE_NAME)] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

-- This setting is needed for Assemblies to be created
ALTER DATABASE [$(DATABASE_NAME)] SET TRUSTWORTHY ON
GO

ALTER DATABASE [$(DATABASE_NAME)] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [$(DATABASE_NAME)] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [$(DATABASE_NAME)] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [$(DATABASE_NAME)] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [$(DATABASE_NAME)] SET  READ_WRITE 
GO

ALTER DATABASE [$(DATABASE_NAME)] SET RECOVERY FULL 
GO

ALTER DATABASE [$(DATABASE_NAME)] SET  MULTI_USER 
GO

ALTER DATABASE [$(DATABASE_NAME)] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [$(DATABASE_NAME)] SET DB_CHAINING OFF 
GO

-- Enables CLR execution
USE [$(DATABASE_NAME)]
GO
EXEC
sp_configure 'clr enabled', 1;
GO
RECONFIGURE;
GO
