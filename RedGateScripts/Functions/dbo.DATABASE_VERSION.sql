SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE
FUNCTION
	dbo.DATABASE_VERSION()
RETURNS VARCHAR(40)
AS
BEGIN

	RETURN		'0.0.0.0'

END
GO