SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE tSQLt.Private_Run
   @TestName NVARCHAR(MAX),
   @TestResultFormatter NVARCHAR(MAX)
AS
BEGIN
SET NOCOUNT ON;
    DECLARE @FullName NVARCHAR(MAX);
    DECLARE @SchemaId INT;
    DECLARE @IsTestClass BIT;
    DECLARE @IsTestCase BIT;
    DECLARE @IsSchema BIT;
    DECLARE @SetUp NVARCHAR(MAX);SET @SetUp = NULL;
    
    SELECT @TestName = tSQLt.Private_GetLastTestNameIfNotProvided(@TestName);
    EXEC tSQLt.Private_SaveTestNameForSession @TestName;
    
    SELECT @SchemaId = schemaId,
           @FullName = quotedFullName,
           @IsTestClass = isTestClass,
           @IsSchema = isSchema,
           @IsTestCase = isTestCase
      FROM tSQLt.Private_ResolveName(@TestName);
     
    EXEC tSQLt.Private_CleanTestResult;

    IF @IsSchema = 1
    BEGIN
        EXEC tSQLt.Private_RunTestClass @FullName;
    END
    
    IF @IsTestCase = 1
    BEGIN
      SELECT @SetUp = tSQLt.Private_GetQuotedFullName(object_id)
        FROM sys.procedures
       WHERE schema_id = @SchemaId
         AND name = 'SetUp';

      EXEC tSQLt.Private_RunTest @FullName, @SetUp;
    END;

    EXEC tSQLt.Private_OutputTestResults @TestResultFormatter;
END;
GO
