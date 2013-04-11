
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE
PROCEDURE
	[dbo].[MyProcedure1]
AS
/*
--------------------------------------------------
Name:		[dbo].[MyProcedure1]
Created:	2012.09.24
Author:		Ernest Hwang
Purpose:	Just for kicks!
--------------------------------------------------

	EXEC
		dbo.MyProcedure1

*/
BEGIN
	PRINT 'Hello, San Francisco - You should all see the movie 42 coming out on Friday -- It''s really great!!'
END
GO
