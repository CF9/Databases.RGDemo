
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE
VIEW
	dbo.OrderSummary
AS
/*
--------------------------------------------------
Name:		dbo.OrderSummary
Created:	2012.09.27
Author:		Ernest Hwang
--------------------------------------------------


	--------------------------------------------------
	-- Get a few rows from the view
	--------------------------------------------------
	SELECT
		TOP 100
		*
	FROM
		dbo.OrderSummary	os
	ORDER BY
		os.Order_ID		DESC



*/
	SELECT
		c.Customer_ID
	,	c.Customer_CD
	,	c.Customer_NM
	,	o.Order_ID
	,	o.Order_CD
	,	COUNT(1)		AS	TotalLineItems_NB
	,	SUM(od.Unit_AT)
					AS	TotalUnits_AT
	,	SUM(od.Unit_AT * od.UnitPrice_AT)
					AS	TotalPrice_AT
	FROM	dbo.Customer		c
	JOIN	dbo.[Order]		o
	ON	c.Customer_ID		=	o.Customer_ID
	JOIN	dbo.OrderDetail		od
	ON	o.Order_ID		=	od.Order_ID
	GROUP BY
		c.Customer_ID
	,	c.Customer_CD
	,	c.Customer_NM
	,	o.Order_ID
	,	o.Order_CD
	
GO
