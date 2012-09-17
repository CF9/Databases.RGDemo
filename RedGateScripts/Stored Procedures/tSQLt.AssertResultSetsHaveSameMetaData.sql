CREATE PROCEDURE [tSQLt].[AssertResultSetsHaveSameMetaData] (@expectedCommand [nvarchar] (max), @actualCommand [nvarchar] (max))
WITH EXECUTE AS CALLER
AS EXTERNAL NAME [tSQLtCLR].[tSQLtCLR.StoredProcedures].[AssertResultSetsHaveSameMetaData]
GO
