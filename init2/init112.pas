//****************************************************************************//
//****************************************************************************//
//**********This Unit For 2 Develop Use ZLNR**********************************//
//**********Date:2006.08.14***************************************************//
//**********Developer:XiaoBin*************************************************//
//**********Compant:Veic******************************************************//
//**********Purpose:New Table Create******************************************//
//****************************************************************************//



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
    edt_dbname: TEdit;
    edt_db: TEdit;
    edt_srv: TEdit;
    ADOCommand1: TADOCommand;
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
  //2006.8.17注释
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
  //2006.8.17注释
  try
    ADOConnection_init.Close;
    ADOConnection_init.ConnectionString:=readREG(xbf);
    ADOConnection_init.Open;
  except
    Application.MessageBox('配置错误，请重新填写各个值！','提示',MB_OK);
    Exit;
  end;

  //
  Gauge1.Visible:=True;
  try
    ADOCommand1.CommandText:='CREATE TABLE [dbo].[tb01_2] ('+#13+
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

        ADOCommand1.CommandText:='CREATE TABLE [dbo].[lt04_2] ('+#13+
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

        ADOCommand1.CommandText:='CREATE TABLE [dbo].[sej_2] ('+#13+
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
  //sp4-----------tb01_2(铁北2)
      ADOCommand1.CommandText:='CREATE PROCEDURE [dbo].[update_station04] AS '+#13+
                                'declare @Col001 varchar(30),@Col002 varchar(30),@Col003 varchar(30),@Col004 varchar(30),@Col005 varchar(30) '+#13+
                                'declare @Col006 varchar(30),@Col007 varchar(30),@Col008 varchar(30),@Col009 varchar(50),@Col010 varchar(30),@Col011 varchar(30) '+#13+
                                '    '+#13+
                                'DECLARE c17 CURSOR FOR '+#13+
                                'SELECT Col001,Col002,Col003,Col004,Col005,Col006,Col007,Col008,Col009,Col010,Col011 FROM zlnr04 '+#13+
                                'OPEN c17 FETCH NEXT FROM c17 into @Col001,@Col002,@Col003,@Col004,@Col005,@Col006,@Col007,@Col008,@Col009,@Col010,@Col011 '+#13+
                                '    '+#13+
                                'WHILE (@@FETCH_STATUS <>-1) '+#13+
                                'BEGIN '+#13+
                                '  INSERT INTO tb01_2(total_weight1,suttle1,car_marque,car_number,carry_weight1,self_weight1,yk_weight,breed,Pstation,past_date,past_time) '+#13+
                                '            VALUES(@Col001,@Col002,@Col003,@Col004,@Col005,@Col006,@Col007,@Col008,@Col009,@Col010,@Col011) '+#13+
                                '  FETCH NEXT FROM c17 into @Col001,@Col002,@Col003,@Col004,@Col005,@Col006,@Col007,@Col008,@Col009,@Col010,@Col011 '+#13+
                                'END '+#13+
                                '    '+#13+
                                'CLOSE c17 '+#13+
                                'DEALLOCATE c17 ';
      ADOCommand1.Execute;
      Gauge1.Progress:=68;
    //
  //sp5-----------lt04_2(露天2)

      ADOCommand1.CommandText:='CREATE PROCEDURE [dbo].[update_station05] AS'+#13+
                                'declare @Col001 varchar(30),@Col002 varchar(30),@Col003 varchar(30),@Col004 varchar(30),@Col005 varchar(30)'+#13+
                                'declare @Col006 varchar(30),@Col007 varchar(30),@Col008 varchar(30),@Col009 varchar(50),@Col010 varchar(30),@Col011 varchar(30)'+#13+
                                '    '+#13+
                                'DECLARE c19 CURSOR FOR'+#13+
                                'SELECT Col001,Col002,Col003,Col004,Col005,Col006,Col007,Col008,Col009,Col010,Col011 FROM zlnr05'+#13+
                                'OPEN c19 FETCH NEXT FROM c19 into @Col001,@Col002,@Col003,@Col004,@Col005,@Col006,@Col007,@Col008,@Col009,@Col010,@Col011'+#13+
                                '    '+#13+
                                'WHILE (@@FETCH_STATUS <>-1)'+#13+
                                'BEGIN'+#13+
                                '  INSERT INTO lt04_2(total_weight1,suttle1,car_marque,car_number,carry_weight1,self_weight1,yk_weight,breed,Pstation,past_date,past_time)'+#13+
                                '            VALUES(@Col001,@Col002,@Col003,@Col004,@Col005,@Col006,@Col007,@Col008,@Col009,@Col010,@Col011)'+#13+
                                '  FETCH NEXT FROM c19 into @Col001,@Col002,@Col003,@Col004,@Col005,@Col006,@Col007,@Col008,@Col009,@Col010,@Col011'+#13+
                                'END'+#13+
                                '    '+#13+
                                'CLOSE c19'+#13+
                                'DEALLOCATE c19';
      ADOCommand1.Execute;
      Gauge1.Progress:=85;
    //
  //sp6------------------------sej_2(十二井)

      ADOCommand1.CommandText:='CREATE PROCEDURE [dbo].[update_station06] AS'+#13+
                                'declare @Col001 varchar(30),@Col002 varchar(30),@Col003 varchar(30),@Col004 varchar(30),@Col005 varchar(30)'+#13+
                                'declare @Col006 varchar(30),@Col007 varchar(30),@Col008 varchar(30),@Col009 varchar(50),@Col010 varchar(30),@Col011 varchar(30)'+#13+
                                '    '+#13+
                                'DECLARE c21 CURSOR FOR'+#13+
                                'SELECT Col001,Col002,Col003,Col004,Col005,Col006,Col007,Col008,Col009,Col010,Col011 FROM zlnr06'+#13+
                                'OPEN c21 FETCH NEXT FROM c21 into @Col001,@Col002,@Col003,@Col004,@Col005,@Col006,@Col007,@Col008,@Col009,@Col010,@Col011'+#13+
                                '    '+#13+
                                'WHILE (@@FETCH_STATUS <>-1)'+#13+
                                'BEGIN'+#13+
                                '  INSERT INTO sej_2(total_weight1,suttle1,car_marque,car_number,carry_weight1,self_weight1,yk_weight,breed,Pstation,past_date,past_time)'+#13+
                                '            VALUES(@Col001,@Col002,@Col003,@Col004,@Col005,@Col006,@Col007,@Col008,@Col009,@Col010,@Col011)'+#13+
                                '  FETCH NEXT FROM c21 into @Col001,@Col002,@Col003,@Col004,@Col005,@Col006,@Col007,@Col008,@Col009,@Col010,@Col011'+#13+
                                'END'+#13+
                                '    '+#13+
                                'CLOSE c21'+#13+
                                'DEALLOCATE c21';
      ADOCommand1.Execute;
      Gauge1.Progress:=100;
    //
    Application.MessageBox('初始化完成！','提示',MB_OK);
    btn_stop.Enabled:=False;
  except

  end;
end;

procedure Tfrm_init.btn_stopClick(Sender: TObject);
//var
//  h1:THandle;
begin
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
  //
  try
    ADOConnection_init.Close;
    ADOConnection_init.ConnectionString:=readREG(xbf);
    ADOConnection_init.Open;
  except
    Application.MessageBox('配置错误，请重新填写各个值！','提示',MB_OK);
    Exit;
  end;

  //
  try
    ADOCommand1.CommandText:='drop table tb01_2';
    ADOCommand1.Execute;
    //
    ADOCommand1.CommandText:='drop table lt04_2';
    ADOCommand1.Execute;
      //
    ADOCommand1.CommandText:='drop table sej_2';
    ADOCommand1.Execute;
  except

  end;
  //
  try    
    ADOCommand1.CommandText:='drop procedure update_station04';
    ADOCommand1.Execute;
    //
    ADOCommand1.CommandText:='drop procedure update_station05';
    ADOCommand1.Execute;
    //
    ADOCommand1.CommandText:='drop procedure update_station06';
    ADOCommand1.Execute;
    //
  except

  end;
   btn_star.Enabled:=True;
  Application.MessageBox('预处理完成！','提示',MB_OK);
end;


end.
