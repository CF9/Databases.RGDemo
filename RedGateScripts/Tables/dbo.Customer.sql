CREATE TABLE [dbo].[Customer]
(
[Customer_ID] [bigint] NOT NULL IDENTITY(1, 1),
[Customer_CD] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Customer_NM] [varchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Create_DT] [datetime] NOT NULL,
[IsActive_FL] [bit] NOT NULL,
[Update_DT] [datetime] NULL,
[Terminate_DT] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Customer] ADD CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED  ([Customer_ID]) ON [PRIMARY]
GO
