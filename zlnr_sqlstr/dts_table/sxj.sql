if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sxj6566572]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[sxj6566572]
GO

CREATE TABLE [dbo].[sxj6566572] (
	[Col001] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[Col002] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[Col003] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[Col004] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[Col005] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[Col006] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[Col007] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[Col008] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[Col009] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[Col010] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[Col011] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

