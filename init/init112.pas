unit init112;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, Gauges, UreadReg;

type
  Tfrm_init = class(TForm)
    ADOConnection_init: TADOConnection;
    Gauge1: TGauge;
    btn_star: TButton;
    btn_stop: TButton;
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edt_dbpass: TEdit;
    edt_dbusername: TEdit;
    edt_db: TEdit;
    edt_srv: TEdit;
    ADOCommand1: TADOCommand;
    ADOStoredProc1: TADOStoredProc;
    procedure FormCreate(Sender: TObject);
    procedure btn_starClick(Sender: TObject);
    procedure btn_stopClick(Sender: TObject);
  private
    { Private declarations }
  public
    xbf:WideString;
    { Public declarations }
  end;

//
  type
  TreadXBF=function(DimRecord: Integer;filename1:WideString):WideString;stdcall;
  //

var
  frm_init: Tfrm_init;
  connstring:TreadXBF;
implementation

{$R *.dfm}

function readXBF(DimRecord: Integer;filename1:WideString):WideString;stdcall;external 'XBFGenerate.dll';

procedure Tfrm_init.FormCreate(Sender: TObject);
begin
  frm_init.Caption:='初始化程序';
  xbf:=ExtractFilePath(ParamStr(0))+'zlnr1.xbf';
end;

procedure Tfrm_init.btn_starClick(Sender: TObject);
//var
//  h1:THandle;
begin
  if btn_stop.Enabled=false then
  begin
    Exit;
  end;
  {try
     h1:=0;
     try
      h1:=LoadLibrary('XBFGenerate.dll');

      if h1<>0 then
        @connstring:=GetprocAddress(h1,'readXBF');
      if (@connstring<>nil)then
          ADOConnection_init.Close;
          ADOConnection_init.ConnectionString:=connstring(-1,xbf);
          ADOConnection_init.Open;
     finally
       FreeLibrary(h1);
     end;
  except
    Application.MessageBox('配置错误，请重新填写各个值！','提示',MB_OK);
    Exit;
  end;}
  //2006.8.17使用注册表密码
  try
    ADOConnection_init.Close;
    ADOConnection_init.ConnectionString:=readREG(xbf);
    ADOConnection_init.Open;
  except
    Application.MessageBox('配置错误，请重新填写各个值！','提示',MB_OK);
    Exit;
  end;


  Gauge1.Visible:=True;
  try
    ADOCommand1.CommandText:='CREATE TABLE [dbo].[sx02] ('+#13+
                            '[total_weight1] [numeric](9, 3) NOT NULL ,'+#13+
                            '[suttle1] [numeric](9, 3) NULL ,'+#13+
                            '[car_marque] [varchar] (25) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                            '[car_number] [varchar] (25) COLLATE Chinese_PRC_CI_AS NOT NULL ,'+#13+
                            '[carry_weight1] [numeric](9, 3) NULL ,'+#13+
                            '[self_weight1] [numeric](9, 3) NULL ,'+#13+
                            '[yk_weight] [numeric](9, 3) NULL ,'+#13+
                            '[breed] [varchar] (25) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                            '[Pstation] [varchar] (25) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                            '[past_date] [datetime] NULL ,'+#13+
                            '[past_time] [varchar] (25) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                            '[consist] [bit] NULL ,'+#13+
                            '[sn] [int] IDENTITY (1001, 1) NOT FOR REPLICATION  NOT NULL'+#13+
                            ') ON [PRIMARY]';
                            //'constraint PK_sx02'+#13+//联合主键
                            //'primary key(total_weight1, car_number)) ON [PRIMARY]';
                            
    ADOCommand1.Execute;
    Gauge1.Progress:=17;
    //

        ADOCommand1.CommandText:='CREATE TABLE [dbo].[lt04] ('+#13+
                              '[total_weight1] [numeric](9, 3) NOT NULL ,'+#13+
                              '[suttle1] [numeric](9, 3) NULL ,'+#13+
                              '[car_marque] [varchar] (25) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                              '[car_number] [varchar] (25) COLLATE Chinese_PRC_CI_AS NOT NULL ,'+#13+
                              '[carry_weight1] [numeric](9, 3) NULL ,'+#13+
                              '[self_weight1] [numeric](9, 3) NULL ,'+#13+
                              '[yk_weight] [numeric](9, 3) NULL ,'+#13+
                              '[breed] [varchar] (25) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                              '[Pstation] [varchar] (25) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                              '[past_date] [datetime] NULL ,'+#13+
                              '[past_time] [varchar] (25) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                              '[consist] [bit] NULL ,'+#13+
                              '[sn] [int] IDENTITY (1001, 1) NOT FOR REPLICATION  NOT NULL'+#13+
                              ') ON [PRIMARY]';
                               //'constraint PK_lt04'+#13+//联合主键
                               //'primary key(total_weight1, car_number)) ON [PRIMARY]';
    ADOCommand1.Execute;
    Gauge1.Progress:=34;
    //

        ADOCommand1.CommandText:='CREATE TABLE [dbo].[tb01] ('+#13+
                              '[total_weight1] [numeric](9, 3) NOT NULL ,'+#13+
                              '[suttle1] [numeric](9, 3) NULL ,'+#13+
                              '[car_marque] [varchar] (25) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                              '[car_number] [varchar] (25) COLLATE Chinese_PRC_CI_AS NOT NULL ,'+#13+
                              '[carry_weight1] [numeric](9, 3) NULL ,'+#13+
                              '[self_weight1] [numeric](9, 3) NULL ,'+#13+
                              '[yk_weight] [numeric](9, 3) NULL ,'+#13+
                              '[breed] [varchar] (25) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                              '[Pstation] [varchar] (25) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                              '[past_date] [datetime] NULL ,'+#13+
                              '[past_time] [varchar] (25) COLLATE Chinese_PRC_CI_AS NULL ,'+#13+
                              '[consist] [bit] NULL ,'+#13+
                              '[sn] [int] IDENTITY (1001, 1) NOT FOR REPLICATION  NOT NULL'+#13+
                              ') ON [PRIMARY]';
                              //'constraint PK_tb01'+#13+//联合主键
                              //'primary key(total_weight1, car_number)) ON [PRIMARY]';
    ADOCommand1.Execute;
    Gauge1.Progress:=51;
  except

  end;

  try
  //sp1
      ADOCommand1.CommandText:='CREATE PROCEDURE [dbo].[update_sxj] AS '+#13+
                                'declare @Col001 varchar(30),@Col002 varchar(30),@Col003 varchar(30),@Col004 varchar(30),@Col005 varchar(30) '+#13+
                                'declare @Col006 varchar(30),@Col007 varchar(30),@Col008 varchar(30),@Col009 varchar(50),@Col010 varchar(30),@Col011 varchar(30) '+#13+
                                '    '+#13+
                                'DECLARE c11 CURSOR FOR '+#13+
                                'SELECT Col001,Col002,Col003,Col004,Col005,Col006,Col007,Col008,Col009,Col010,Col011 FROM sxj6566572 '+#13+
                                'OPEN c11 FETCH NEXT FROM c11 into @Col001,@Col002,@Col003,@Col004,@Col005,@Col006,@Col007,@Col008,@Col009,@Col010,@Col011 '+#13+
                                '    '+#13+
                                'WHILE (@@FETCH_STATUS <>-1) '+#13+
                                'BEGIN '+#13+
                                '  INSERT INTO sx02(total_weight1,suttle1,car_marque,car_number,carry_weight1,self_weight1,yk_weight,breed,Pstation,past_date,past_time) '+#13+
                                '            VALUES(@Col001,@Col002,@Col003,@Col004,@Col005,@Col006,@Col007,@Col008,@Col009,@Col010,@Col011) '+#13+
                                '  FETCH NEXT FROM c11 into @Col001,@Col002,@Col003,@Col004,@Col005,@Col006,@Col007,@Col008,@Col009,@Col010,@Col011 '+#13+
                                'END '+#13+
                                '    '+#13+
                                'CLOSE c11 '+#13+
                                'DEALLOCATE c11 ';
      ADOCommand1.Execute;
      Gauge1.Progress:=68;
    //
        //sp2

      ADOCommand1.CommandText:='CREATE PROCEDURE [dbo].[update_ltk] AS'+#13+
                                'declare @Col001 varchar(30),@Col002 varchar(30),@Col003 varchar(30),@Col004 varchar(30),@Col005 varchar(30)'+#13+
                                'declare @Col006 varchar(30),@Col007 varchar(30),@Col008 varchar(30),@Col009 varchar(50),@Col010 varchar(30),@Col011 varchar(30)'+#13+
                                '    '+#13+
                                'DECLARE c13 CURSOR FOR'+#13+
                                'SELECT Col001,Col002,Col003,Col004,Col005,Col006,Col007,Col008,Col009,Col010,Col011 FROM ltk6565734'+#13+
                                'OPEN c13 FETCH NEXT FROM c13 into @Col001,@Col002,@Col003,@Col004,@Col005,@Col006,@Col007,@Col008,@Col009,@Col010,@Col011'+#13+
                                '    '+#13+
                                'WHILE (@@FETCH_STATUS <>-1)'+#13+
                                'BEGIN'+#13+
                                '  INSERT INTO lt04(total_weight1,suttle1,car_marque,car_number,carry_weight1,self_weight1,yk_weight,breed,Pstation,past_date,past_time)'+#13+
                                '            VALUES(@Col001,@Col002,@Col003,@Col004,@Col005,@Col006,@Col007,@Col008,@Col009,@Col010,@Col011)'+#13+
                                '  FETCH NEXT FROM c13 into @Col001,@Col002,@Col003,@Col004,@Col005,@Col006,@Col007,@Col008,@Col009,@Col010,@Col011'+#13+
                                'END'+#13+
                                '    '+#13+
                                'CLOSE c13'+#13+
                                'DEALLOCATE c13';
      ADOCommand1.Execute;
      Gauge1.Progress:=85;
    //
        //sp3

      ADOCommand1.CommandText:='CREATE PROCEDURE [dbo].[update_tbk] AS'+#13+
                                'declare @Col001 varchar(30),@Col002 varchar(30),@Col003 varchar(30),@Col004 varchar(30),@Col005 varchar(30)'+#13+
                                'declare @Col006 varchar(30),@Col007 varchar(30),@Col008 varchar(30),@Col009 varchar(50),@Col010 varchar(30),@Col011 varchar(30)'+#13+
                                '    '+#13+
                                'DECLARE c15 CURSOR FOR'+#13+
                                'SELECT Col001,Col002,Col003,Col004,Col005,Col006,Col007,Col008,Col009,Col010,Col011 FROM tbk6563921'+#13+
                                'OPEN c15 FETCH NEXT FROM c15 into @Col001,@Col002,@Col003,@Col004,@Col005,@Col006,@Col007,@Col008,@Col009,@Col010,@Col011'+#13+
                                '    '+#13+
                                'WHILE (@@FETCH_STATUS <>-1)'+#13+
                                'BEGIN'+#13+
                                '  INSERT INTO tb01(total_weight1,suttle1,car_marque,car_number,carry_weight1,self_weight1,yk_weight,breed,Pstation,past_date,past_time)'+#13+
                                '            VALUES(@Col001,@Col002,@Col003,@Col004,@Col005,@Col006,@Col007,@Col008,@Col009,@Col010,@Col011)'+#13+
                                '  FETCH NEXT FROM c15 into @Col001,@Col002,@Col003,@Col004,@Col005,@Col006,@Col007,@Col008,@Col009,@Col010,@Col011'+#13+
                                'END'+#13+
                                '    '+#13+
                                'CLOSE c15'+#13+
                                'DEALLOCATE c15';
      ADOCommand1.Execute;
      Gauge1.Progress:=100;
    //
    Application.MessageBox('初始化完成！','提示',MB_OK);
    btn_stop.Enabled:=False;
  except

  end;
end;

procedure Tfrm_init.btn_stopClick(Sender: TObject);
var
  customDS,customUserID,customPWD:WideString;
  lenOldPWD,lenNewPWD,lenUserName:Integer;
  regInfoPWD:WideString;
  XBFuserID:WideString;
  XBFuIDlen:integer;
  XBFinfo:WideString;
  //定位字符串中user ID的位置
  leftLen,rightLen:Integer;
begin
  //2007.1.5对SQL2000进行权限操作
  customPWD:=trim(edt_dbpass.Text);
  customDS:=Trim(edt_srv.Text);
  customUserID:=Trim(edt_dbusername.Text);
  XBFinfo:=readREG(xbf);
  regInfoPWD:=childstr2+childstr5+childstr6+childstr1+childstr3+childstr4;

  lenOldPWD:=length(customPWD);
  lenNewPWD:=length(regInfoPWD);
  lenUserName:=length(customUserID);
  try
    ADOConnection_init.Close;
    ADOConnection_init.ConnectionString:='Provider=SQLOLEDB.1'
                                        +';Password='+customPWD
                                        +';Persist Security Info=True'
                                        +';User ID='+customUserID
                                        +';Initial Catalog=pubs'
                                        +';Data Source='+customDS;
    ADOConnection_init.Open;
    //更改sa密码。(新密码为注册表密码)
    ADOStoredProc1.Close;
    ADOStoredProc1.ProcedureName:='sp_password';
    ADOStoredProc1.Parameters.Clear;
    ADOStoredProc1.Parameters.CreateParameter('@old',ftWideString,pdInput,lenOldPWD,customPWD);
    ADOStoredProc1.Parameters.CreateParameter('@new',ftWideString,pdInput,lenNewPWD,regInfoPWD);
    ADOStoredProc1.Parameters.CreateParameter('@loginame',ftWideString,pdInput,lenUserName,customUserID);

    ADOStoredProc1.ExecProc;
  except
    Application.MessageBox('管理员密码错误，请重新填写密码！','提示',MB_OK);
    Exit;
  end;
  //2006.1.6建立新用户和新密码（为注册表密码）
  //xbf文件中的用户即为新用户
  leftLen:=pos('ID=',XBFinfo);
  rightLen:=pos(';I',XBFinfo);

  XBFuserID:=copy(XBFinfo,leftLen+3,rightLen-leftLen-3);
  XBFuIDlen:=length(XBFuserID);
  //删除用户  
  try
    ADOStoredProc1.Close;
    ADOStoredProc1.ProcedureName:='sp_droplogin';
    ADOStoredProc1.Parameters.Clear;
    ADOStoredProc1.Parameters.CreateParameter('@loginame',ftWideString,pdInput,XBFuIDlen,XBFuserID);
    ADOStoredProc1.ExecProc;
  except

  end;
  //建立新用户
  try
    ADOStoredProc1.Close;
    ADOStoredProc1.ProcedureName:='sp_addlogin';
    ADOStoredProc1.Parameters.Clear;
    ADOStoredProc1.Parameters.CreateParameter('@loginame',ftWideString,pdInput,XBFuIDlen,XBFuserID);
    ADOStoredProc1.Parameters.CreateParameter('@passwd',ftWideString,pdInput,lenNewPWD,regInfoPWD);
    ADOStoredProc1.ExecProc;
  except
    Application.MessageBox('配置数据库错误，请中止相关管理员操作！','提示',MB_OK);
    Exit;
  end;
  //赋予新用户权限(默认权限为sa)
  try
    //服务器角色授权
    ADOStoredProc1.Close;
    ADOStoredProc1.ProcedureName:='sp_addsrvrolemember';
    ADOStoredProc1.Parameters.CreateParameter('@loginame',ftWideString,pdInput,XBFuIDlen,XBFuserID);
    ADOStoredProc1.Parameters.CreateParameter('@rolename',ftWideString,pdInput,8,'sysadmin');
    ADOStoredProc1.ExecProc;
    //数据库访问授权1步
    //(此时拥有"public"数据库角色)
    ADOStoredProc1.Close;
    ADOStoredProc1.ProcedureName:='sp_grantdbaccess';
    ADOStoredProc1.Parameters.CreateParameter('@loginame',ftWideString,pdInput,XBFuIDlen,XBFuserID);
    ADOStoredProc1.Parameters.CreateParameter('@name_in_db',ftWideString,pdInput,XBFuIDlen,XBFuserID);
    ADOStoredProc1.ExecProc;
    //数据库访问授权2步
    //(此时拥有"public"和"db_owner"两个数据库角色)
    ADOStoredProc1.Close;
    ADOStoredProc1.ProcedureName:='sp_addrolemember';
    ADOStoredProc1.Parameters.CreateParameter('@rolename',ftWideString,pdInput,8,'db_owner');
    ADOStoredProc1.Parameters.CreateParameter('@membername',ftWideString,pdInput,XBFuIDlen,XBFuserID);
    ADOStoredProc1.ExecProc;
  except

  end;


  //拒绝windows组对SQL的访问
  try
    ADOStoredProc1.Close;
    ADOStoredProc1.ProcedureName:='sp_denylogin';
    ADOStoredProc1.Parameters.Clear;
    ADOStoredProc1.Parameters.CreateParameter('@loginame',ftWideString,pdInput,22,'BUILTIN\Administrators');
    ADOStoredProc1.ExecProc;
  except

  end;


  //2006.8.17使用注册表密码
  try
    ADOConnection_init.Close;
    ADOConnection_init.ConnectionString:=readREG(xbf);
    ADOConnection_init.Open;
  except
    Application.MessageBox('连接数据库错误，请重新填写各个值！','提示',MB_OK);
    Exit;
  end;
  try
    ADOCommand1.CommandText:='drop table sx02';
    ADOCommand1.Execute;
    //
    ADOCommand1.CommandText:='drop table lt04';
    ADOCommand1.Execute;
      //
    ADOCommand1.CommandText:='drop table tb01';
    ADOCommand1.Execute;
  except

  end;
  //
  try    
    ADOCommand1.CommandText:='drop procedure update_sxj';
    ADOCommand1.Execute;
    //
    ADOCommand1.CommandText:='drop procedure update_ltk';
    ADOCommand1.Execute;
    //
    ADOCommand1.CommandText:='drop procedure update_tbk';
    ADOCommand1.Execute;
    //
    ADOCommand1.CommandText:='drop procedure update_sxj1';
    ADOCommand1.Execute;
    //
    ADOCommand1.CommandText:='drop procedure update_ltk1';
    ADOCommand1.Execute;
    //
    ADOCommand1.CommandText:='drop procedure update_tbk1';
    ADOCommand1.Execute;
    //
  except

  end;
   btn_star.Enabled:=True;
  Application.MessageBox('预处理完成！','提示',MB_OK);
end;


end.
