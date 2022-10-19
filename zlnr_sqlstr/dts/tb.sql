if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tbk]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tbk]
GO

CREATE TABLE [dbo].[tbk] (
	[totalWeight] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[suttle1] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[carMarque] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[carNumber] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[carryWeight] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[selfWeight1] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[ykWeight] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[breed] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[Pstation] [varchar] (50) COLLATE Chinese_PRC_CI_AS NULL ,
	[pastDate] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL ,
	[pastTime] [varchar] (30) COLLATE Chinese_PRC_CI_AS NULL 
) ON [PRIMARY]
GO