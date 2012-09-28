SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE
VIEW
	dbo.OrderSummary
AS
	SELECT
		c.Customer_ID
	,	c.Customer_CD
	,	c.Customer_NM
	,	o.Order_ID
	,	o.Order_CD
	,	COUNT(1)		AS	TotalLineItems_NB
	,	SUM(od.Units_AT)	AS	TotalUnits_AT
	,	SUM(od.Units_AT * od.UnitPrice_AT)
					AS	TotalPrice_AT
	FROM	dbo.Customer		c	WITH (NOLOCK)
	JOIN	dbo.[Order]		o	WITH (NOLOCK)
	ON	c.Customer_ID		=	o.Customer_ID
	JOIN	dbo.OrderDetail		od	WITH (NOLOCK)
	ON	o.Order_ID		=	od.Order_ID
	GROUP BY
		c.Customer_ID
	,	c.Customer_CD
	,	c.Customer_NM
	,	o.Order_ID
	,	o.Order_CD
	
GO
