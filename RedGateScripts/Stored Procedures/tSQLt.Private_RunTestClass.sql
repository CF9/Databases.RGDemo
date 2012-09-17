SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE tSQLt.Private_RunTestClass
  @TestClassName NVARCHAR(MAX)
AS
BEGIN
    DECLARE @TestCaseName NVARCHAR(MAX);
    DECLARE @SetUp NVARCHAR(MAX);SET @SetUp = NULL;

    SELECT @SetUp = tSQLt.Private_GetQuotedFullName(object_id)
      FROM sys.procedures
     WHERE schema_id = tSQLt.Private_GetSchemaId(@TestClassName)
       AND LOWER(name) = 'setup';

    DECLARE testCases CURSOR LOCAL FAST_FORWARD 
        FOR
     SELECT tSQLt.Private_GetQuotedFullName(object_id)
       FROM sys.procedures
      WHERE schema_id = tSQLt.Private_GetSchemaId(@TestClassName)
        AND LOWER(name) LIKE 'test%';

    OPEN testCases;
    
    FETCH NEXT FROM testCases INTO @TestCaseName;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        EXEC tSQLt.Private_RunTest @TestCaseName, @SetUp;

        FETCH NEXT FROM testCases INTO @TestCaseName;
    END;

    CLOSE testCases;
    DEALLOCATE testCases;
END;
GO
