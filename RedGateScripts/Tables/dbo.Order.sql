CREATE TABLE [dbo].[Order]
(
[Order_ID] [bigint] NOT NULL IDENTITY(1, 1),
[Order_CD] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Customer_ID] [bigint] NOT NULL,
[Create_DT] [datetime] NOT NULL,
[IsActive_FL] [bit] NOT NULL CONSTRAINT [DF_Order_IsActive_FL] DEFAULT ((1)),
[Update_DT] [datetime] NULL,
[Terminate_DT] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Order] ADD CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED  ([Order_ID]) ON [PRIMARY]
GO
