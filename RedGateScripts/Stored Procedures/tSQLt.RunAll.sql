SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE tSQLt.RunAll
AS
BEGIN
  DECLARE @TestResultFormatter NVARCHAR(MAX);
  SELECT @TestResultFormatter = tSQLt.GetTestResultFormatter();
  
  EXEC tSQLt.Private_RunAll @TestResultFormatter;
END;
GO
