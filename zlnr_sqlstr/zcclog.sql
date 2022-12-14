if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[zcc_log]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[zcc_log]
GO

CREATE TABLE [dbo].[zcc_log] (
	[id] [int] IDENTITY (1, 1) NOT NULL ,
	[operID] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[datetime1] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[content1] [varchar] (249) COLLATE Chinese_PRC_CI_AS NULL ,
	[memo] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO

