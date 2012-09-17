SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
---Build+
CREATE PROCEDURE tSQLt.TableToText
    @txt NVARCHAR(MAX) OUTPUT,
    @TableName NVARCHAR(MAX),
    @OrderBy NVARCHAR(MAX) = NULL
AS
BEGIN
    SET @txt = tSQLt.Private::TableToString(@TableName,@OrderBy);
END;
---Build-


GO
