SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE tSQLt.Private_RunTest
   @TestName NVARCHAR(MAX),
   @SetUp NVARCHAR(MAX) = NULL
AS
BEGIN
    DECLARE @Msg NVARCHAR(MAX); SET @Msg = '';
    DECLARE @Msg2 NVARCHAR(MAX); SET @Msg2 = '';
    DECLARE @Cmd NVARCHAR(MAX); SET @Cmd = '';
    DECLARE @TestClassName NVARCHAR(MAX); SET @TestClassName = '';
    DECLARE @TestProcName NVARCHAR(MAX); SET @TestProcName = '';
    DECLARE @Result NVARCHAR(MAX); SET @Result = 'Success';
    DECLARE @TranName CHAR(32); EXEC tSQLt.GetNewTranName @TranName OUT;
    DECLARE @TestResultId INT;
    DECLARE @PreExecTrancount INT;
    
    TRUNCATE TABLE tSQLt.CaptureOutputLog;

    IF EXISTS (SELECT 1 FROM sys.extended_properties WHERE name = N'SetFakeViewOnTrigger')
    BEGIN
      RAISERROR('Test system is in an invalid state. SetFakeViewOff must be called if SetFakeViewOn was called. Call SetFakeViewOff after creating all test case procedures.', 16, 10) WITH NOWAIT;
      RETURN -1;
    END;

    SELECT @Cmd = 'EXEC ' + @TestName;
    
    SELECT @TestClassName = OBJECT_SCHEMA_NAME(OBJECT_ID(@TestName)), --tSQLt.Private_GetCleanSchemaName('', @TestName),
           @TestProcName = tSQLt.Private_GetCleanObjectName(@TestName);
           
    INSERT INTO tSQLt.TestResult(Class, TestCase, TranName, Result) 
        SELECT @TestClassName, @TestProcName, @TranName, 'A severe error happened during test execution. Test did not finish.'
        OPTION(MAXDOP 1);
    SELECT @TestResultId = SCOPE_IDENTITY();

    BEGIN TRAN;
    SAVE TRAN @TranName;

    SET @PreExecTrancount = @@TRANCOUNT;
    
    TRUNCATE TABLE tSQLt.TestMessage;

    BEGIN TRY
        IF (@SetUp IS NOT NULL) EXEC @SetUp;
        EXEC (@Cmd);
    END TRY
    BEGIN CATCH
        IF ERROR_MESSAGE() LIKE '%tSQLt.Failure%'
        BEGIN
            SELECT @Msg = Msg FROM tSQLt.TestMessage;
            SET @Result = 'Failure';
        END
        ELSE
        BEGIN
            SELECT @Msg = COALESCE(ERROR_MESSAGE(), '<ERROR_MESSAGE() is NULL>') + '{' + COALESCE(ERROR_PROCEDURE(), '<ERROR_PROCEDURE() is NULL>') + ',' + COALESCE(CAST(ERROR_LINE() AS NVARCHAR), '<ERROR_LINE() is NULL>') + '}';
            SET @Result = 'Error';
        END;
    END CATCH

    BEGIN TRY
        ROLLBACK TRAN @TranName;
    END TRY
    BEGIN CATCH
        SET @PreExecTrancount = @PreExecTrancount - @@TRANCOUNT;
        IF (@@TRANCOUNT > 0) ROLLBACK;
        BEGIN TRAN;
        IF(   @Result <> 'Success'
           OR @PreExecTrancount <> 0
          )
        BEGIN
          SELECT @Msg = COALESCE(@Msg, '<NULL>') + ' (There was also a ROLLBACK ERROR --> ' + COALESCE(ERROR_MESSAGE(), '<ERROR_MESSAGE() is NULL>') + '{' + COALESCE(ERROR_PROCEDURE(), '<ERROR_PROCEDURE() is NULL>') + ',' + COALESCE(CAST(ERROR_LINE() AS NVARCHAR), '<ERROR_LINE() is NULL>') + '})';
          SET @Result = 'Error';
        END
    END CATCH    

    If(@Result <> 'Success') 
    BEGIN
      SET @Msg2 = @TestName + ' failed: ' + @Msg;
      EXEC tSQLt.Private_Print @Message = @Msg2, @Severity = 0;
    END

    IF EXISTS(SELECT 1 FROM tSQLt.TestResult WHERE Id = @TestResultId)
    BEGIN
        UPDATE tSQLt.TestResult SET
            Result = @Result,
            Msg = @Msg
         WHERE Id = @TestResultId;
    END
    ELSE
    BEGIN
        INSERT tSQLt.TestResult(Class, TestCase, TranName, Result, Msg)
        SELECT @TestClassName, 
               @TestProcName,  
               '?', 
               'Error', 
               'TestResult entry is missing; Original outcome: ' + @Result + ', ' + @Msg;
    END    
      

    COMMIT;
END;
GO
