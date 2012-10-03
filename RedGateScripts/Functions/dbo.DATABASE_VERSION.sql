
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE
FUNCTION
	[dbo].[DATABASE_VERSION]()
RETURNS VARCHAR(40)
AS
/*
--------------------------------------------------
Name:		dbo.DATABASE_VERSION()
Created:	2012.08.28
Author:		Ernest Hwang
--------------------------------------------------

	SELECT
		dbo.DATABASE_VERSION()


*/
BEGIN

	RETURN		'0.0.0.0'

END
GO
