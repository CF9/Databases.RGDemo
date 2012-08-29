CREATE TABLE [dbo].[ItemType]
(
[ItemType_ID] [bigint] NOT NULL IDENTITY(1, 1),
[ItemType_CD] [varchar] (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ItemType_NM] [varchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[IsActive_FL] [bit] NOT NULL CONSTRAINT [DF_ItemType_IsActive_FL] DEFAULT ((1)),
[Create_DT] [datetime] NOT NULL CONSTRAINT [DF_ItemType_Create_DT] DEFAULT (getutcdate()),
[Update_DT] [datetime] NULL,
[Terminate_DT] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ItemType] ADD CONSTRAINT [PK_ItemType] PRIMARY KEY CLUSTERED  ([ItemType_ID]) ON [PRIMARY]
GO
