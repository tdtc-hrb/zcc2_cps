---sxj6566572.txt
---ltk6565734.txt
---tbk6563921.txt
/*
  新的存储过程 2006.3.27
*/
CREATE PROCEDURE [dbo].[update_ltk]
@TableName1 Varchar(30)
--,@TableName2 Varchar(30)

AS

declare @SQLstr1 Varchar(255),@SQLstr2 Varchar(255)

declare @Col001 varchar(30),@Col002 varchar(30),@Col003 varchar(30),@Col004 varchar(30),@Col005 varchar(30)
declare @Col006 varchar(30),@Col007 varchar(30),@Col008 varchar(30),@Col009 varchar(50),@Col010 varchar(30),@Col011 varchar(30)
----

--set @SQLstr1='SELECT * FROM '+@TableName2
set @SQLstr2='INSERT INTO '+@TableName1+'(total_weight1,suttle1,car_marque,car_number,carry_weight1,self_weight1,yk_weight,breed,Pstation,past_date,past_time) 
                 VALUES(@Col001,@Col002,@Col003,@Col004,@Col005,@Col006,@Col007,@Col008,@Col009,@Col010,@Col011)'

DECLARE c11 CURSOR FOR
  SELECT * FROM ltk6565734 
  --exec(@SQLstr1)--//运行不过去???很可能与游标有关!!!

  OPEN c11 FETCH NEXT FROM c11 into @Col001,@Col002,@Col003,@Col004,@Col005,@Col006,@Col007,@Col008,@Col009,@Col010,@Col011
  WHILE (@@FETCH_STATUS <> -1)
  BEGIN
    exec(@SQLstr2)
    FETCH NEXT FROM c11 into @Col001,@Col002,@Col003,@Col004,@Col005,@Col006,@Col007,@Col008,@Col009,@Col010,@Col011
  END

  CLOSE c11
  DEALLOCATE c11

exec('truncate table ltk6565734')