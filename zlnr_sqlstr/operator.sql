if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[operator]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[operator]
GO

CREATE TABLE [dbo].[operator] (
	[OperID] [int] IDENTITY (1001, 1) NOT NULL ,
	[OperName] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[OperPassWord] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[preserve1] [bit] DEFAULT (0) NOT NULL ,
	[OperMemo] [varchar] (50) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO
