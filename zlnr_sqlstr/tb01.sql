if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[tb01]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[tb01]
GO

CREATE TABLE [dbo].[tb01] (
	[total_weight1] [numeric](9, 3) NULL ,
	[suttle1] [numeric](9, 3) NULL ,
	[car_marque] [varchar] (25) COLLATE Chinese_PRC_CI_AS NULL ,
	[car_number] [varchar] (25) COLLATE Chinese_PRC_CI_AS NULL ,
	[carry_weight1] [numeric](9, 3) NULL ,
	[self_weight1] [numeric](9, 3) NULL ,
	[yk_weight] [numeric](9, 3) NULL ,
	[breed] [varchar] (25) COLLATE Chinese_PRC_CI_AS NULL ,
	[Pstation] [varchar] (25) COLLATE Chinese_PRC_CI_AS NULL ,
	[past_date] [datetime] NULL ,
	[past_time] [varchar] (25) COLLATE Chinese_PRC_CI_AS NULL ,
	[consist] [bit] NULL ,
        [sn] [int] IDENTITY (1001, 1) NOT FOR REPLICATION  NOT NULL
) ON [PRIMARY]
GO

