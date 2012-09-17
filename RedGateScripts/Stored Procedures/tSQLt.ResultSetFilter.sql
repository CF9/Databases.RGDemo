CREATE PROCEDURE [tSQLt].[ResultSetFilter] (@ResultsetNo [int], @Command [nvarchar] (max))
WITH EXECUTE AS CALLER
AS EXTERNAL NAME [tSQLtCLR].[tSQLtCLR.StoredProcedures].[ResultSetFilter]
GO
