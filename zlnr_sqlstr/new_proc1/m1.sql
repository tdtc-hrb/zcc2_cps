if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[myproc11]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[myproc11]
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

CREATE proc myproc11
            @TableName1 Varchar(30),---------input Parameter
            @sqlstr varchar(30) output-------output Parameter
as


declare @tn1 varchar(30),@tn2 varchar(30)

               
set @sqlstr='select * from '+@TableName1
set @tn1='select * from '+@TableName1
exec(@tn1)
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

