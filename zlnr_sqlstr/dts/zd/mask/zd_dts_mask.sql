— 2006-10-27/16:11 上生成的脚本
— 由: ZLNR2SERVER\Administrator
— 服务器: ZLNR2SERVER

BEGIN TRANSACTION            
  DECLARE @JobID BINARY(16)  
  DECLARE @ReturnCode INT    
  SELECT @ReturnCode = 0     
IF (SELECT COUNT(*) FROM msdb.dbo.syscategories WHERE name = N'[Uncategorized (Local)]') < 1 
  EXECUTE msdb.dbo.sp_add_category @name = N'[Uncategorized (Local)]'

  — 删除同名的警报（如果有的话）。
  SELECT @JobID = job_id     
  FROM   msdb.dbo.sysjobs    
  WHERE (name = N'zd_dts')       
  IF (@JobID IS NOT NULL)    
  BEGIN  
  -- 检查此作业是否为多重服务器作业  
  IF (EXISTS (SELECT  * 
              FROM    msdb.dbo.sysjobservers 
              WHERE   (job_id = @JobID) AND (server_id <> 0))) 
  BEGIN 
    -- 已经存在，因而终止脚本 
    RAISERROR (N'无法导入作业“zd_dts”，因为已经有相同名称的多重服务器作业。', 16, 1) 
    GOTO QuitWithRollback  
  END 
  ELSE 
    -- 删除［本地］作业 
    EXECUTE msdb.dbo.sp_delete_job @job_name = N'zd_dts' 
    SELECT @JobID = NULL
  END 

BEGIN 

  — 添加作业
  EXECUTE @ReturnCode = msdb.dbo.sp_add_job @job_id = @JobID OUTPUT , @job_name = N'zd_dts', @owner_login_name = N'ZLNR2SERVER\Administrator', @description = N'执行包: zd_dts', @category_name = N'[Uncategorized (Local)]', @enabled = 1, @notify_level_email = 0, @notify_level_page = 0, @notify_level_netsend = 0, @notify_level_eventlog = 2, @delete_level= 0
  IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 

  — 添加作业步骤
  EXECUTE @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 1, @step_name = N'zd_dts', @command = N'DTSRun /~Z0xF0F8C6428272A41368C3F08B28CB261A1684526AE834279276FE4F2C274DB9A608BB6F6949C10B9A4BD154EFCEB6A25DDC112855E1B01D548407B16AFA6CCB237A00F6742EB0F26E79C14850BE1DBF8A3CDF7A503E9DF4F2F2BAEA ', @database_name = N'', @server = N'', @database_user_name = N'', @subsystem = N'CmdExec', @cmdexec_success_code = 0, @flags = 0, @retry_attempts = 0, @retry_interval = 0, @output_file_name = N'', @on_success_step_id = 0, @on_success_action = 1, @on_fail_step_id = 0, @on_fail_action = 2
  IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 
  EXECUTE @ReturnCode = msdb.dbo.sp_update_job @job_id = @JobID, @start_step_id = 1 

  IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 

  — 添加作业调度
  EXECUTE @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @JobID, @name = N'zd_dts', @enabled = 1, @freq_type = 4, @active_start_date = 20061027, @active_start_time = 0, @freq_interval = 1, @freq_subday_type = 4, @freq_subday_interval = 3, @freq_relative_interval = 1, @freq_recurrence_factor = 0, @active_end_date = 99991231, @active_end_time = 235959
  IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 

  — 添加目标服务器
  EXECUTE @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @JobID, @server_name = N'(local)' 
  IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 

END
COMMIT TRANSACTION          
GOTO   EndSave              
QuitWithRollback:
  IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION 
EndSave: 


