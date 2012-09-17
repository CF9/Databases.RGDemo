SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*******************************************************************************************/
/*******************************************************************************************/
/*******************************************************************************************/
CREATE PROCEDURE tSQLt.AssertEqualsTable
    @Expected NVARCHAR(MAX),
    @Actual NVARCHAR(MAX),
    @FailMsg NVARCHAR(MAX) = 'unexpected/missing resultset rows!'
AS
BEGIN
    DECLARE @TblMsg NVARCHAR(MAX);
    DECLARE @R INT;
    DECLARE @ErrorMessage NVARCHAR(MAX);
    DECLARE @FailureOccurred BIT;
    SET @FailureOccurred = 0;

    EXEC @FailureOccurred = tSQLt.AssertObjectExists @Actual;
    IF @FailureOccurred = 1 RETURN 1;
    EXEC @FailureOccurred = tSQLt.AssertObjectExists @Expected;
    IF @FailureOccurred = 1 RETURN 1;
        
    EXEC @R = tSQLt.TableCompare @Expected, @Actual, @TblMsg OUT;

    IF (@R <> 0)
    BEGIN
        IF ISNULL(@FailMsg,'')<>'' SET @FailMsg = @FailMsg + CHAR(13) + CHAR(10);
        EXEC tSQLt.Fail @FailMsg, @TblMsg;
    END;
    
END;
GO
