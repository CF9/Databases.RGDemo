CREATE TABLE [dbo].[Item]
(
[Item_ID] [bigint] NOT NULL IDENTITY(1, 1),
[Item_CD] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Item_Name] [varchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ItemType_ID] [bigint] NOT NULL,
[IsActive_FL] [bit] NOT NULL CONSTRAINT [DF_Item_IsActive_FL] DEFAULT ((1)),
[Create_DT] [datetime] NOT NULL CONSTRAINT [DF_Item_Create_DT] DEFAULT (getutcdate()),
[Update_DT] [datetime] NULL,
[Terminate_DT] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Item] ADD CONSTRAINT [PK_Item] PRIMARY KEY CLUSTERED  ([Item_ID]) ON [PRIMARY]
GO
