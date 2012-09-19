CREATE TABLE [dbo].[OrderDetail]
(
[OrderDetail_ID] [bigint] NOT NULL IDENTITY(10001, 1),
[Order_ID] [bigint] NOT NULL,
[Item_ID] [bigint] NOT NULL,
[Price_AT] [float] NOT NULL,
[IsActive_FL] [bit] NOT NULL CONSTRAINT [DF_OrderDetail_IsActive_FL] DEFAULT ((1)),
[Create_DT] [datetime] NOT NULL CONSTRAINT [DF_OrderDetail_Create_DT] DEFAULT (getutcdate()),
[Update_DT] [datetime] NULL,
[Terminate_DT] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OrderDetail] ADD CONSTRAINT [PK_OrderDetail] PRIMARY KEY CLUSTERED  ([OrderDetail_ID]) ON [PRIMARY]
GO
