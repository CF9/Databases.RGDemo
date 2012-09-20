SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--  Comments here are associated with the test.
--  For test case examples, see: http://tsqlt.org/user-guide/tsqlt-tutorial/
CREATE
PROCEDURE
	[Test].[test TextIsNumeric should return 0 for space]
AS
/*

	EXEC
		[Test].[test TextIsNumeric should return 0 for space]

*/
BEGIN
	-- Assemble
	DECLARE
		@ActualValue		BIT
	,	@ExpectedValue		BIT		=	0
	,	@InputValue		VARCHAR(255)	=	' '

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
	,	@Message		=	'The value should be 0'

END
GO
