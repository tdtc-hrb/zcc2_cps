declare @output11 varchar(30)
exec myproc11 @TableName1='pub_info',@sqlstr=@output11 output
print @output11
--exec(@output11)