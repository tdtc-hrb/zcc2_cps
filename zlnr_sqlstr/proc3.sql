CREATE PROCEDURE [dbo].[update_tbk] 
AS
       declare @Col001 varchar(30),@Col002 varchar(30),@Col003 varchar(30),@Col004 varchar(30),@Col005 varchar(30)
       declare @Col006 varchar(30),@Col007 varchar(30),@Col008 varchar(30),@Col009 varchar(50),@Col010 varchar(30),@Col011 varchar(30)

DECLARE c15 CURSOR FOR
SELECT Col001,Col002,Col003,Col004,Col005,Col006,Col007,Col008,Col009,Col010,Col011 FROM tbk6563921
OPEN c15 FETCH NEXT FROM c13 into @Col001,@Col002,@Col003,@Col004,@Col005,@Col006,@Col007,@Col008,@Col009,@Col010,@Col011

WHILE (@@FETCH_STATUS <>-1)
BEGIN
   INSERT INTO tb01(total_weight1,suttle1,car_marque,car_number,carry_weight1,self_weight1,yk_weight,breed,Pstation,past_date,past_time)
   VALUES(@Col001,@Col002,@Col003,@Col004,@Col005,@Col006,@Col007,@Col008,@Col009,@Col010,@Col011)
   
   FETCH NEXT FROM c15 into @Col001,@Col002,@Col003,@Col004,@Col005,@Col006,@Col007,@Col008,@Col009,@Col010,@Col011
END

CLOSE c15
DEALLOCATE c15