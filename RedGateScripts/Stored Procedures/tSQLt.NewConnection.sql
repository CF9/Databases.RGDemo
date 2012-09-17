CREATE PROCEDURE [tSQLt].[NewConnection] (@command [nvarchar] (max))
WITH EXECUTE AS CALLER
AS EXTERNAL NAME [tSQLtCLR].[tSQLtCLR.StoredProcedures].[NewConnection]
GO
