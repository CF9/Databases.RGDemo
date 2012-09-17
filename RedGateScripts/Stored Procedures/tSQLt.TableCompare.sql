SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE tSQLt.TableCompare
       @Expected NVARCHAR(MAX),
       @Actual NVARCHAR(MAX),
       @Txt NVARCHAR(MAX) = NULL OUTPUT
AS
BEGIN
    DECLARE @Cmd NVARCHAR(MAX);
    DECLARE @R INT;
    DECLARE @En NVARCHAR(MAX);
    DECLARE @An NVARCHAR(MAX);
    DECLARE @Rn NVARCHAR(MAX);
    SELECT @En = QUOTENAME('#TSQLt_TempTable'+CAST(NEWID() AS NVARCHAR(100))),
           @An = QUOTENAME('#TSQLt_TempTable'+CAST(NEWID() AS NVARCHAR(100))),
           @Rn = QUOTENAME('#TSQLt_TempTable'+CAST(NEWID() AS NVARCHAR(100)));

    WITH TA AS (SELECT column_id,name,is_identity
                  FROM sys.columns 
                 WHERE object_id = OBJECT_ID(@Actual)
                 UNION ALL
                SELECT column_id,name,is_identity
                  FROM tempdb.sys.columns 
                 WHERE object_id = OBJECT_ID('tempdb..'+@Actual)
               ),
         TB AS (SELECT column_id,name,is_identity
                  FROM sys.columns 
                 WHERE object_id = OBJECT_ID(@Expected)
                 UNION ALL
                SELECT column_id,name,is_identity
                  FROM tempdb.sys.columns 
                 WHERE object_id = OBJECT_ID('tempdb..'+@Expected)
               ),
         T AS (SELECT TA.column_id,TA.name,
                      CASE WHEN TA.is_identity = 1 THEN 1
                           WHEN TB.is_identity = 1 THEN 1
                           ELSE 0
                      END is_identity
                 FROM TA
                 LEFT JOIN TB
                   ON TA.column_id = TB.column_id
              ),
         A AS (SELECT column_id,
                      P0 = ', '+QUOTENAME(name)+
                           CASE WHEN is_identity = 1
                                THEN '*1'
                                ELSE ''
                           END+
                         ' AS C'+CAST(column_id AS NVARCHAR),
                      P1 = CASE WHEN column_id = 1 THEN '' ELSE ' AND ' END+
                           '((A.C'+
                           CAST(column_id AS NVARCHAR)+
                           '=E.C'+
                           CAST(column_id AS NVARCHAR)+
                           ') OR (COALESCE(A.C'+ 
                           CAST(column_id AS NVARCHAR)+
                           ',E.C'+
                           CAST(column_id AS NVARCHAR)+
                           ') IS NULL))',
                      P2 = ', COALESCE(E.C'+
                           CAST(column_id AS NVARCHAR)+
                           ',A.C'+
                           CAST(column_id AS NVARCHAR)+
                           ') AS '+
                           QUOTENAME(name)
                 FROM T),
         B(m,p) AS (SELECT 0,0 UNION ALL 
                    SELECT 1,0 UNION ALL 
                    SELECT 2,1 UNION ALL 
                    SELECT 3,2),
         C(n,cmd) AS (SELECT 100+2000*B.m+column_id,
                             CASE B.p WHEN 0 THEN P0
                                      WHEN 1 THEN P1
                                      WHEN 2 THEN P2
                             END
                        FROM A
                       CROSS JOIN B),
         D(n,cmd) AS (SELECT * FROM C
                      UNION ALL
                      SELECT 1,'SELECT IDENTITY(int,1,1) no'
                      UNION ALL
                      SELECT 2001,' INTO '+@An+' FROM '+@Actual+';SELECT IDENTITY(int,1,1) no'
                      UNION ALL
                      SELECT 4001,' INTO '+@En+' FROM '+
                                  @Expected+';'+
                                  'WITH Match AS (SELECT A.no Ano, E.no Eno FROM '+@An+' A FULL OUTER JOIN '+@En+' E ON '
                      UNION ALL
                      SELECT 6001,'),MatchWithRowNo AS (SELECT Ano, Eno, r1=ROW_NUMBER() OVER(PARTITION BY Ano ORDER BY Eno), r2=ROW_NUMBER() OVER(PARTITION BY Eno ORDER BY Ano) FROM Match)'+
                                  ',CleanMatch AS (SELECT Ano,Eno FROM MatchWithRowNo WHERE r1 = r2)'+
                                  'SELECT CASE WHEN A.no IS NULL THEN ''<'' WHEN E.no IS NULL THEN ''>'' ELSE ''='' END AS _m_'
                      UNION ALL
                      SELECT 8001,' INTO '+@Rn+' FROM CleanMatch FULL JOIN '+@En+' E ON E.no = CleanMatch.Eno FULL JOIN '+@An+' A ON A.no = CleanMatch.Ano;'+
                                  ' SELECT @R = CASE WHEN EXISTS(SELECT 1 FROM '+@Rn+' WHERE _m_<>''='') THEN -1 ELSE 0 END;'+
--' SELECT * FROM '+@Rn+';'+
                                  ' EXEC tSQLt.TableToText @Txt OUTPUT,'''+@Rn+''',''_m_'';'+
--' PRINT @Txt;'+
                                  ' DROP TABLE '+@An+'; DROP TABLE '+@En+'; DROP TABLE '+@Rn+';'
                     ),
         E(xml) AS (SELECT cmd AS [data()]  FROM D ORDER BY n FOR XML PATH(''), TYPE)
    select @Cmd = xml.value( '/', 'NVARCHAR(max)' ) from E;

--    PRINT @Cmd;
    EXEC sp_executesql @Cmd, N'@R INT OUTPUT, @Txt NVARCHAR(MAX) OUTPUT', @R OUTPUT, @Txt OUTPUT;;

--    PRINT 'Outcome:'+CAST(@R AS NVARCHAR);
--    PRINT @Txt; 
    RETURN @R;
END;
GO
