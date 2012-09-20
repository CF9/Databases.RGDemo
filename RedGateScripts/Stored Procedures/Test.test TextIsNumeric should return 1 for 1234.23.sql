SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--  Comments here are associated with the test.
--  For test case examples, see: http://tsqlt.org/user-guide/tsqlt-tutorial/
CREATE
PROCEDURE
	[Test].[test TextIsNumeric should return 1 for 1234.23]
AS
/*

	EXEC
		[Test].[test TextIsNumeric should return 1 for 1234.23]

*/
BEGIN
	-- Assemble
	DECLARE
		@ActualValue		BIT
	,	@ExpectedValue		BIT		=	1
	,	@InputValue		VARCHAR(255)	=	'1234.23'

	-- Act
	SELECT
		@ActualValue		=	dbo.[TextIsNumeric](@InputValue)

	-- Assert
	PRINT 'Expected result: ' + CAST(@ExpectedValue AS VARCHAR)
	PRINT 'Actual result: ' + CAST(@ActualValue AS VARCHAR)

	EXEC
		tSQLt.AssertEquals
		@Expected		=	@ExpectedValue
	,	@Actual			=	@ActualValue
	,	@Message		=	'The value should be 1'

END
GO
