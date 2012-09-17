CREATE PROCEDURE [tSQLt].[SuppressOutput] (@command [nvarchar] (max))
WITH EXECUTE AS CALLER
AS EXTERNAL NAME [tSQLtCLR].[tSQLtCLR.StoredProcedures].[SuppressOutput]
GO
