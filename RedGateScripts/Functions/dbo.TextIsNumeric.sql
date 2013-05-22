SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE
FUNCTION
	[dbo].[TextIsNumeric]
(
	@TextValue		VARCHAR(255)
)
RETURNS BIT
AS
BEGIN
/*
==================================================
Name:		dbo.[TextIsNumeric]
Created:	2012.09.19
Author:		Ernest Hwang
Purpose:	Better logic than the built in ISNUMERIC T-SQL function
		Code lifted from
		http://codecorner.galanter.net/2009/04/03/tsql-isnumeric-function-returns-false-positives/


History:
2012.09.19	eh	Created
==================================================


	SELECT
		dbo.[TextIsNumeric]('0')			AS	ShouldBe1
	,	dbo.[TextIsNumeric]('1234')			AS	ShouldBe1
	,	dbo.[TextIsNumeric]('1234.23')			AS	ShouldBe1
	,	dbo.[TextIsNumeric]('10.4E22')			AS	ShouldBe1

	,	dbo.[TextIsNumeric]('<1234.23')			AS	ShouldBe0
	,	dbo.[TextIsNumeric]('<1234')			AS	ShouldBe0
	,	dbo.[TextIsNumeric](NULL)			AS	ShouldBe0
	,	dbo.[TextIsNumeric]('.')			AS	ShouldBe0
	,	dbo.[TextIsNumeric](' ')			AS	ShouldBe0
	,	dbo.[TextIsNumeric]('ERNESTO IS 10.4E22')	AS	ShouldBe0

	Alternate (non working 

	--------------------------------------------------
	-- This is the version that works
	--------------------------------------------------

	DECLARE	@returnValue	INT
	
	IF CHARINDEX('E', UPPER(@TextValue))<> 0
	BEGIN
		-- if there is 'E' in the value - do a standard IsNumeric test
		SET @returnValue = IsNumeric(@TextValue)
	END
	ELSE
	BEGIN
		-- Otherwise do a modified IsNumeric test by adding 'E0' at the end
		SET @returnValue = IsNumeric(@TextValue + 'E0')
	END
	
	RETURN @returnValue

	--------------------------------------------------
	-- The built in ISNUMERIC function DOESN'T work
	--------------------------------------------------

	RETURN ISNUMERIC(@TextValue)

*/

	DECLARE	@returnValue	INT
	
	IF CHARINDEX('E', UPPER(@TextValue))<> 0
	BEGIN
		-- if there is 'E' in the value - do a standard IsNumeric test
		SET @returnValue = IsNumeric(@TextValue)
	END
	ELSE
	BEGIN
		-- Otherwise do a modified IsNumeric test by adding 'E0' at the end
		SET @returnValue = IsNumeric(@TextValue + 'E0')
	END
	
	RETURN @returnValue


END



GO
