unit Udispatch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, StrUtils, Grids, DBGrids, Menus, DB, ADODB,
  Mask, DBCtrls, UGeneralADO, Printers, IniFiles, ShellApi;

type
  Thread_update = class(TThread)
  private
    thread_flag1:integer;
    logpath2,reppath2:string;
    { Private declarations }
  protected
    procedure Execute; override;

  public
    constructor Create(thread_flag:integer;reppath1,Logpath1:string);
  end;

type
  Tfrm_main = class(TForm)
    Panel1: TPanel;
    StatusBar1: TStatusBar;
    Panel2: TPanel;
    Memo_04: TMemo;
    Memo_02: TMemo;
    Memo_07: TMemo;
    Panel3: TPanel;
    Panel4: TPanel;
    Splitter1: TSplitter;
    Panel5: TPanel;
    Label1: TLabel;
    cmbox_kb: TComboBox;
    DBGrid1: TDBGrid;
    Panel6: TPanel;
    DBGrid2: TDBGrid;
    btn_print: TButton;
    btn_csv: TButton;
    PopupMenu1: TPopupMenu;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    ADODataSet1: TADODataSet;
    ADOConnection1: TADOConnection;
    DataSource1: TDataSource;
    ADODataSet2: TADODataSet;
    N8: TMenuItem;
    dispatchTemplate: TADODataSet;
    DataSource2: TDataSource;
    Popup2: TPopupMenu;
    N1: TMenuItem;
    addDispatch: TADOQuery;
    delDispatch: TADOQuery;
    judgmentStation: TDBEdit;
    checkData1: TADOQuery;
    checkData2: TADOQuery;
    checkData3: TADOQuery;
    convertSP1: TADOStoredProc;
    convertSP2: TADOStoredProc;
    convertSP3: TADOStoredProc;
    add1del: TADOConnection;
    N2: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    ADODataSet2total_weight1: TBCDField;
    ADODataSet2suttle1: TBCDField;
    ADODataSet2car_marque: TStringField;
    ADODataSet2car_number: TStringField;
    ADODataSet2carry_weight1: TBCDField;
    ADODataSet2self_weight1: TBCDField;
    ADODataSet2yk_weight: TBCDField;
    ADODataSet2breed: TStringField;
    ADODataSet2Pstation: TStringField;
    ADODataSet2past_date: TDateTimeField;
    ADODataSet2past_time: TStringField;
    ADODataSet2sn: TAutoIncField;
    dispatchTemplatesn: TAutoIncField;
    dispatchTemplatetotal_weight1: TBCDField;
    dispatchTemplatesuttle1: TBCDField;
    dispatchTemplatecar_marque: TStringField;
    dispatchTemplatecar_number: TStringField;
    dispatchTemplatecarry_weight1: TBCDField;
    dispatchTemplateself_weight1: TBCDField;
    dispatchTemplateyk_weight: TBCDField;
    dispatchTemplatebreed: TStringField;
    dispatchTemplatePstation: TStringField;
    dispatchTemplatepast_date: TDateTimeField;
    dispatchTemplatepast_time: TStringField;
    dispatchTemplatestation: TStringField;
    init0adoquery: TADOQuery;
    init0: TTimer;
    clock: TTimer;
    N3: TMenuItem;
    N13: TMenuItem;
    Timer_update: TTimer;
    convertSP4: TADOStoredProc;
    checkData4: TADOQuery;
    checkData5: TADOQuery;
    checkData6: TADOQuery;
    convertSP5: TADOStoredProc;
    convertSP6: TADOStoredProc;
    Memo_13: TMemo;
    Memo_12: TMemo;
    Memo_11: TMemo;
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmbox_kbChange(Sender: TObject);
    procedure btn_csvClick(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure btn_printClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure init0Timer(Sender: TObject);
    procedure clockTimer(Sender: TObject);
    procedure N13Click(Sender: TObject);
    procedure Timer_updateTimer(Sender: TObject);
  private
    stationName:string;
    execpath:string;
    Logpath:string;
    reppath:string;
    csvPath:string;
    excpchar:pchar;
    stationcount,tempcount:integer;
    //
    h1:THandle;
    connectStr,colName1,tableName1,exportName1:WideString;
    colCount1:integer;
    { Private declarations }
  public
    tablename:string;
    stationINT:Integer;
    stationSTR1,stationSTR2,stationSTR3,stationSTR4,stationSTR5,stationSTR6:string;
    counINI:TIniFile;
    { Public declarations }
  end;

type
  Tpro_saveFCN=procedure(saveFile1,CheckFilePath:WideString);stdcall;

var
  frm_main: Tfrm_main;

  saveFCNA:Tpro_saveFCN;
  //
  handlers:string;
  xbf:string;//xbf path
  connstr:string;
  
implementation
uses
Ulogin,u_about,Udatatotal,Ustation;

function readXBF(DimRecord: Integer;filename1:WideString):WideString;stdcall;
                external 'XBFGenerate.dll';

{$R *.dfm}

procedure Tfrm_main.N4Click(Sender: TObject);
begin
  frm_about:=Tfrm_about.Create(Application);
  frm_about.Update;
  frm_about.ShowModal;
end;

procedure Tfrm_main.N5Click(Sender: TObject);
begin
  frm_sa:=Tfrm_sa.Create(Application);
  frm_sa.Update;
  frm_sa.ShowModal;
end;

procedure Tfrm_main.N7Click(Sender: TObject);
begin
  frm_station:=Tfrm_station.Create(Application);
  frm_station.Update;
  frm_station.ShowModal;
end;

procedure Tfrm_main.FormShow(Sender: TObject);
begin
  //
  ADODataSet1.Close;
  ADODataSet1.CommandText:='select OperName from operator where OperID='+opertor;
  ADODataSet1.Open;

  StatusBar1.Panels[3].Text:='调度员:'+ADODataSet1.Fields[0].AsString;
  StatusBar1.Panels[4].Text:='登录时间：'+RightStr(DateTimeToStr(Time),8);

  //
  dispatchTemplate.Close;
  dispatchTemplate.CommandText:='select sn,total_weight1,suttle1,car_marque,'
                +'car_number,carry_weight1,self_weight1,yk_weight,breed,'
                +'Pstation,past_date,past_time,station from dispatchTemplate';
  dispatchTemplate.Open;
  //
  stationINT:=counINI.ReadInteger('stationcount','1',6);
  case stationINT of

  1:
    begin
      stationSTR1:=counINI.ReadString('stationname','1','my1');
      cmbox_kb.Items.Add(stationSTR1);
    end;
  2:
    begin
      stationSTR1:=counINI.ReadString('stationname','1','my1');
      stationSTR2:=counINI.ReadString('stationname','2','my2');
      cmbox_kb.Items.Add(stationSTR1);
      cmbox_kb.Items.Add(stationSTR2);
    end;
  3:
    begin
      stationSTR1:=counINI.ReadString('stationname','1','my1');
      stationSTR2:=counINI.ReadString('stationname','2','my2');
      stationSTR3:=counINI.ReadString('stationname','3','my3');
      cmbox_kb.Items.Add(stationSTR1);
      cmbox_kb.Items.Add(stationSTR2);
      cmbox_kb.Items.Add(stationSTR3);
    end;
  4:
    begin
      stationSTR1:=counINI.ReadString('stationname','1','my1');
      stationSTR2:=counINI.ReadString('stationname','2','my2');
      stationSTR3:=counINI.ReadString('stationname','3','my3');
      stationSTR4:=counINI.ReadString('stationname','4','my4');
      cmbox_kb.Items.Add(stationSTR1);
      cmbox_kb.Items.Add(stationSTR2);
      cmbox_kb.Items.Add(stationSTR3);
      cmbox_kb.Items.Add(stationSTR4);
    end;
  5:
    begin
      stationSTR1:=counINI.ReadString('stationname','1','my1');
      stationSTR2:=counINI.ReadString('stationname','2','my2');
      stationSTR3:=counINI.ReadString('stationname','3','my3');
      stationSTR4:=counINI.ReadString('stationname','4','my4');
      stationSTR5:=counINI.ReadString('stationname','5','my5');
      cmbox_kb.Items.Add(stationSTR1);
      cmbox_kb.Items.Add(stationSTR2);
      cmbox_kb.Items.Add(stationSTR3);
      cmbox_kb.Items.Add(stationSTR4);
      cmbox_kb.Items.Add(stationSTR5);
    end;
  6:
    begin
      stationSTR1:=counINI.ReadString('stationname','1','my1');
      stationSTR2:=counINI.ReadString('stationname','2','my2');
      stationSTR3:=counINI.ReadString('stationname','3','my3');
      stationSTR4:=counINI.ReadString('stationname','4','my4');
      stationSTR5:=counINI.ReadString('stationname','5','my5');
      stationSTR6:=counINI.ReadString('stationname','6','my6');
      cmbox_kb.Items.Add(stationSTR1);
      cmbox_kb.Items.Add(stationSTR2);
      cmbox_kb.Items.Add(stationSTR3);
      cmbox_kb.Items.Add(stationSTR4);
      cmbox_kb.Items.Add(stationSTR5);
      cmbox_kb.Items.Add(stationSTR6);
    end;
  end;//case end;
end;

procedure Tfrm_main.FormCreate(Sender: TObject);
var
  configini:string;
begin
  configini:=ExtractFilePath(ParamStr(0))+'CPSconfig.ini';
  counINI:=TIniFile.Create(configini);

  try
    ADOConnection1.Close;
    //ADOConnection1.ConnectionString:=readXBF(-1,xbf);
    ADOConnection1.ConnectionString:=connstr;
    ADOConnection1.Open;
    add1del.Close;
    //add1del.ConnectionString:=readXBF(-1,xbf);
    add1del.ConnectionString:=connstr;
    add1del.Open;
   Except
     Application.MessageBox('数据库位置不对！','提示',MB_OK+MB_ICONINFORMATION);
     Exit;
   end;

   //
   execpath:=ExtractFilePath(ParamStr(0));
   excpchar:=pchar(execpath);
   Logpath:=execpath+'log\';
   reppath:=counINI.ReadString('filePath','2','D:\receive');
end;

procedure Tfrm_main.cmbox_kbChange(Sender: TObject);
var
  strlist:TStringList;
  sq:string;
begin
  ADODataSet1.Close;
  ADODataSet1.CommandText:='select ArriveStation from arrivestation';
  ADODataSet1.Open;
  strlist:=TStringList.Create;
  while not ADODataSet1.Eof do
  begin
    sq:=ADODataSet1.Fields[0].AsString;
    strlist.Add(sq);
    ADODataSet1.Next;
  end;
  DBGrid1.Columns[9].PickList:=strlist;
  //
  
  case cmbox_kb.ItemIndex of

  0:
    begin
      ADODataSet2.Close;
      ADODataSet2.CommandText:='select sn,total_weight1,suttle1,car_marque,'
                +'car_number,carry_weight1,self_weight1,yk_weight,breed,Pstation,'
                +'past_date,past_time from sx02';
      ADODataSet2.Open;
      tablename:='sx02';
      stationName:=trim(cmbox_kb.Text);
    end;
  1:
    begin
      ADODataSet2.Close;
      ADODataSet2.CommandText:='select sn,total_weight1,suttle1,car_marque,'
                +'car_number,carry_weight1,self_weight1,yk_weight,breed,Pstation,'
                +'past_date,past_time from tb01';
      ADODataSet2.Open;
      tablename:='tb01';
      stationName:=trim(cmbox_kb.Text);
    end;
  2:
    begin
      ADODataSet2.Close;
      ADODataSet2.CommandText:='select sn,total_weight1,suttle1,car_marque,'
                +'car_number,carry_weight1,self_weight1,yk_weight,breed,Pstation,'
                +'past_date,past_time from lt04';
      ADODataSet2.Open;
      tablename:='lt04';
      stationName:=trim(cmbox_kb.Text);
    end;
  3:
    begin
      ADODataSet2.Close;
      ADODataSet2.CommandText:='select sn,total_weight1,suttle1,car_marque,'
                +'car_number,carry_weight1,self_weight1,yk_weight,breed,Pstation,'
                +'past_date,past_time from tb01_2';
      ADODataSet2.Open;
      tablename:='tb01_2';
      stationName:=trim(cmbox_kb.Text);
    end;
  4:
    begin
      ADODataSet2.Close;
      ADODataSet2.CommandText:='select sn,total_weight1,suttle1,car_marque,'
                +'car_number,carry_weight1,self_weight1,yk_weight,breed,Pstation,'
                +'past_date,past_time from lt04_2';
      ADODataSet2.Open;
      tablename:='lt04_2';
      stationName:=trim(cmbox_kb.Text);
    end;
  5:
    begin
      ADODataSet2.Close;
      ADODataSet2.CommandText:='select sn,total_weight1,suttle1,car_marque,'
                +'car_number,carry_weight1,self_weight1,yk_weight,breed,Pstation,'
                +'past_date,past_time from sej_2';
      ADODataSet2.Open;
      tablename:='sej_2';
      stationName:=trim(cmbox_kb.Text);
    end;
  end;

  stationcount:=ADODataSet2.RecordCount;
  StatusBar1.Panels[0].Text:=stationName+'检斤站共有'+IntToStr(stationcount)+'辆车';
end;

procedure Tfrm_main.btn_csvClick(Sender: TObject);
var
 iFor: integer;
 TempStr: string;
 TempList: TStrings;
 //
 loop1:integer;
 ConsistCount,ConsistCount1:integer;
 sqlstr5,sqlstr6,sqlstr7,sqlstr8,sqlstr9:string;
begin
  csvPath:=counINI.ReadString('filePath','1','d:\send');
  //退出的几种情况
  if dispatchTemplate.RecordCount=0 then Exit;
  ConsistCount:=counINI.ReadInteger('cumulateConsist','2',2);
  ConsistCount1:=counINI.ReadInteger('cumulateConsist','3',2);
  if ConsistCount<>ConsistCount1 then Exit;

  //输出CSV文件
  connectStr:=ADOConnection1.ConnectionString;
  tableName1:='dispatchTemplate';
  colName1:='total_weight1,suttle1,car_marque,car_number,carry_weight1,'
        +'self_weight1,yk_weight,breed,station,Pstation,past_date,past_time';
  colCount1:=11;
  exportName1:=csvPath+'datasb.txt';
  if generalCSV(connectStr,colName1,tableName1,exportName1,colCount1)then
  begin
    h1:=0;
    try
    h1:=LoadLibrary('FCN.dll');

    if h1<>0 then
      @saveFCNA:=GetprocAddress(h1,'saveFCN');
    if (@saveFCNA<>nil)then
      saveFCNA(csvPath+'datasb.fcn',exportName1);
   finally
     FreeLibrary(h1);
   end;
  end
  else
  begin
    Exit;
  end;

  //Application.MessageBox('形成数据报文成功！', '提示', mb_ok + mb_iconinformation);
  //把dispatchTemplate表的数据添加到TotalTable表中

  for loop1:=0 to dispatchTemplate.RecordCount-1 do
  begin
    //

    sqlstr5:='insert into TotalTable';
    sqlstr6:=' (total_weight1,suttle1,car_marque, car_number,carry_weight1,'
                +'self_weight1,yk_weight,breed,Pstation,past_date,past_time,'
                +'cumulateConsist,station,OperID)';
    sqlstr7:=' values('+dispatchTemplatetotal_weight1.Text
                +','+dispatchTemplatesuttle1.Text
                +','+''''+dispatchTemplatecar_marque.Text+''''
                +','+''''+dispatchTemplatecar_number.Text+''''
                +','+dispatchTemplatecarry_weight1.Text
                +','+dispatchTemplateself_weight1.Text
                +','+dispatchTemplateyk_weight.Text; 
    sqlstr8:=','+''''+dispatchTemplatebreed.Text+''''
                +','+''''+dispatchTemplatePstation.Text+''''
                +','+''''+dispatchTemplatepast_date.Text+''''
                +','+''''+dispatchTemplatepast_time.Text+'''';
    sqlstr9:=','+IntToStr(ConsistCount)+','+''''+judgmentStation.Text+''''
                +','+''''+opertor+'''';
    //
    try
      add1del.BeginTrans;
      delDispatch.Close;
      delDispatch.SQL.Clear;
      delDispatch.SQL.Text:=sqlstr5+sqlstr6+sqlstr7+sqlstr8+sqlstr9+')';
      delDispatch.ExecSQL;
      add1del.CommitTrans;
      //dispatchTemplate.Delete;
      addDispatch.Close;
      addDispatch.SQL.Clear;
      addDispatch.SQL.Text:='delete from dispatchTemplate where sn='
                                +IntToStr(dispatchTemplatesn.Value);
      addDispatch.ExecSQL;

      dispatchTemplate.Close;
      dispatchTemplate.Open;
    except
      add1del.RollbackTrans;
      counINI.WriteString('RunTime','2',DateToStr(now));
      Application.MessageBox('数据上报失败！','提示',MB_OK);
      Exit;
    end;

  end;//for end;
  counINI.WriteInteger('cumulateConsist','2',ConsistCount+1);//增加计数
  counINI.WriteInteger('cumulateConsist','3',ConsistCount+1);
end;

procedure Tfrm_main.N8Click(Sender: TObject);
var
  sqlstr1,sqlstr2:string;
  carX,carN,breed2,dz,time2:string;
  TW:real;
begin
  //
  if DataSource1.DataSet.IsEmpty then Exit;
  carX:=ADODataSet2car_marque.Value;
  carN:=ADODataSet2car_number.Value;
  breed2:=ADODataSet2breed.Value;
  dz:=ADODataSet2Pstation.Value;
  time2:=ADODataSet2past_time.Value;
  //
  TW:=ADODataSet2total_weight1.Value;
  sqlstr1:='insert into dispatchTemplate (total_weight1,suttle1,car_marque,'
                +'car_number,carry_weight1,self_weight1,yk_weight,breed,Pstation,'
                +'past_date,past_time,station)';
  //sqlstr2:=' values('+DBEdit1.Text+','+DBEdit2.Text+','+''''+DBEdit3.Text+''''+','+''''+DBEdit4.Text+''''+','+DBEdit5.Text+','+DBEdit6.Text+','+DBEdit7.Text;
  //sqlstr1+sqlstr2+','+''''+DBEdit8.Text+''''+','+''''+DBEdit9.Text+''''+','+''''+DBEdit10.Text+''''+','+''''+DBEdit11.Text+''''+','+''''+stationName+''''+')';
  sqlstr2:=' values('+''+FloatToStr(TW)+''+','+FloatToStr(ADODataSet2suttle1.Value)
                +','+''''+carX+''''+','+''''+carN+''''
                +','+FloatToStr(ADODataSet2carry_weight1.Value)
                +','+FloatToStr(ADODataSet2self_weight1.Value)
                +','+''+FloatToStr(ADODataSet2yk_weight.Value)+''
                +','+''''+breed2+''''+','+''''+DZ+'''';
  try
    addDispatch.Close;
    addDispatch.SQL.Clear;
    addDispatch.SQL.Text:=sqlstr1+sqlstr2
                +','+''''+DateToStr(ADODataSet2past_date.Value)+''''
                +','+''''+time2+''''+','+''''+stationName+''''+')';
    addDispatch.ExecSQL;
    //ADODataSet2.Delete;//问题出现在这！！！
    delDispatch.Close;
    delDispatch.SQL.Clear;
    delDispatch.SQL.Text:='delete from '+tablename+' where sn='
                                        +IntToStr(ADODataSet2sn.Value);
    delDispatch.ExecSQL;

    dispatchTemplate.Close;
    dispatchTemplate.Open;
    //tempcount
    tempcount:=dispatchTemplate.RecordCount;
    StatusBar1.Panels[1].Text:='现在共有'+IntToStr(tempcount)+'辆车编入';
    ADODataSet2.Close;
    ADODataSet2.Open;
    //stationcount
    stationcount:=ADODataSet2.RecordCount;
    StatusBar1.Panels[0].Text:=stationName+'检斤站共有'
                                +IntToStr(stationcount)+'辆车';
  except
    Application.MessageBox('添加编车组失败！','提示',MB_OK);
    Exit;
  end;

end;

procedure Tfrm_main.btn_printClick(Sender: TObject);
const
  LeftBlank=1;
  RightBlank=1;
  TopBlank=1;
  BottomBlank=1;
var
  PointX,PointY:integer;
  PointScale,PrintStep:integer;
  s:string;
  x,y:integer;
  i:integer;
begin

  PointX:=Trunc(GetDeviceCaps(Printer.Handle,LOGPIXELSX)/2.54);
  PointY:=Trunc(GetDeviceCaps(Printer.Handle,LOGPIXELSY)/2.54);

  PointScale:=Trunc(GetDeviceCaps(Printer.Handle,LOGPIXELSY)/Screen.PixelsPerInch+0.5);
  printer.Orientation:=poPortrait;



  printer.Canvas.Font.Name:='宋体';
  printer.canvas.Font.Size:=10;

  s:='xiaobin';
  PrintStep:=printer.canvas.TextHeight(s)+16;

  x:=PointX*LeftBlank;
  y:=PointY*TopBlank;

  if ((DataSource2.DataSet).Active=true) and ((DataSource2.DataSet).RecordCount>0) then
  begin
    printer.BeginDoc;
    (DataSource2.DataSet).First;
    
    while not (DataSource2.DataSet).Eof do
    begin 
      for i:=0 to DBGrid2.FieldCount-1 do
      begin
    
        if (x+DBGrid2.Columns.Items[i].Width*PointScale)<=(Printer.PageWidth-PointX*RightBlank) then
        begin

          Printer.Canvas.Rectangle(x,y,x+DBGrid2.Columns.Items[i].Width*PointScale,y+PrintStep);
          if y=PointY*TopBlank then
            Printer.Canvas.TextOut(x+8,y+8,DBGrid2.Columns[i].Title.Caption)
          else
            Printer.Canvas.TextOut(x+8,y+8,DBGrid2.Fields[i].asString);
        end;
        x:=x+DBGrid2.Columns.Items[i].Width*PointScale;
      end;
      if not (y=PointY*TopBlank) then
        (DataSource2.DataSet).next;
        x:=PointX*LeftBlank;
        y:=y+PrintStep;
      if (y+PrintStep)>(Printer.PageHeight-PointY*BottomBlank) then
      begin
        Printer.NewPage;
        y:=PointY*TopBlank;
      end;
    end;//whil end

    printer.EndDoc;
    (DataSource2.DataSet).First;
    Application.MessageBox('打印完成','打印',32);

  end;//if end
end;

procedure Tfrm_main.N1Click(Sender: TObject);
var
  sqlstr3,sqlstr4,sqlstr5:string;
  carX,carN,breed2,dz,time2:string;
  TW:real;
begin
  //
  if dispatchTemplate.RecordCount=0 then Exit;

  if tablename='' then
  begin
    Exit;
  end;

  //
  carX:=dispatchTemplatecar_marque.Value;
  carN:=dispatchTemplatecar_number.Value;
  breed2:=dispatchTemplatebreed.Value;
  dz:=dispatchTemplatePstation.Value;
  time2:=dispatchTemplatepast_time.Value;
  //
  TW:=dispatchTemplatetotal_weight1.Value;

  sqlstr3:='insert into '+tablename;
  sqlstr4:=' (total_weight1,suttle1,car_marque, car_number,carry_weight1,'
        +'self_weight1,yk_weight,breed,Pstation,past_date,past_time)';
  //sqlstr5:=' values('+DBEdit_1.Text+','+DBEdit_2.Text+','+''''+DBEdit_3.Text+''''+','+''''+DBEdit_4.Text+''''+','+DBEdit_5.Text+','+DBEdit_6.Text+','+DBEdit_7.Text;
  sqlstr5:=' values('+''+FloatToStr(TW)+''
        +','+FloatToStr(dispatchTemplatesuttle1.Value)
        +','+''''+carX+''''+','+''''+carN+''''
        +','+FloatToStr(dispatchTemplatecarry_weight1.Value)
        +','+FloatToStr(dispatchTemplateself_weight1.Value)
        +','+''+FloatToStr(dispatchTemplateyk_weight.Value)+''
        +','+''''+breed2+''''+','+''''+DZ+'''';
  //判断站点是否是添加的站点
  if judgmentStation.Text<>stationName then
  begin
    Exit;
  end;
  //','+''+DateToStr(ADODataSet2past_date.Value)+''+','+''''+time2+''''+','+''''+stationName+''''+')'
  try
    addDispatch.Close;
    addDispatch.SQL.Clear;
    addDispatch.SQL.Text:=sqlstr3+sqlstr4+sqlstr5
                +','+''''+DateToStr(dispatchTemplatepast_date.Value)+''''
                +','+''''+time2+''''+')';
    addDispatch.ExecSQL;
    //dispatchTemplate.Delete;//问题出现在这！！！
    delDispatch.Close;
    delDispatch.SQL.Clear;
    delDispatch.SQL.Text:='delete from dispatchTemplate where sn='
                                +IntToStr(dispatchTemplatesn.Value);
    delDispatch.ExecSQL;

    dispatchTemplate.Close;
    dispatchTemplate.Open;
    //tempcount
    tempcount:=dispatchTemplate.RecordCount;
    StatusBar1.Panels[1].Text:='现在共有'+IntToStr(tempcount)+'辆车编入';
    
    ADODataSet2.Close;
    ADODataSet2.Open;
    //stationcount
    stationcount:=ADODataSet2.RecordCount;
    StatusBar1.Panels[0].Text:=stationName+'检斤站共有'
                                +IntToStr(stationcount)+'辆车';
    
    Exit;
  except
    Application.MessageBox('删除编车组失败！','提示',MB_OK);
    Exit;
  end;
end;

procedure Tfrm_main.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  counINI.Destroy;
  delDispatch.Close;
  delDispatch.SQL.Clear;
  delDispatch.SQL.Text:='update operator set preserve1=0 where OperID='+opertor;
  delDispatch.ExecSQL;
end;

//thread process
constructor Thread_update.create(thread_flag:integer;reppath1,Logpath1:string);
begin
  inherited Create(False);
  reppath2:=reppath1;
  logpath2:=Logpath1;
  thread_flag1:=thread_flag;
end;

procedure Thread_update.Execute;
begin
  //thread1
  if thread_flag1=1 then
  begin
    frm_main.checkData1.Close;
    frm_main.checkData1.SQL.Clear;
    frm_main.checkData1.SQL.Text:='select * from sxj6566572';
    frm_main.checkData1.Open;

    if frm_main.checkData1.RecordCount=0 then Exit;
    
    if FileExists(reppath2+'\sxj6566572.txt')then
    begin
      frm_main.Memo_02.Lines.LoadFromFile(reppath2+'\sxj6566572.txt');
    end;

    try
      frm_main.convertSP1.Close;
      frm_main.convertSP1.ProcedureName:='update_sxj';
      frm_main.convertSP1.ExecProc;
      //清空文本表12
      frm_main.checkData1.Close;
      frm_main.checkData1.SQL.Clear;
      frm_main.checkData1.SQL.Add('TRUNCATE TABLE sxj6566572');
      frm_main.checkData1.ExecSQL;
    except
      //清空文本表12
      frm_main.checkData1.Close;
      frm_main.checkData1.SQL.Clear;
      frm_main.checkData1.SQL.Add('TRUNCATE TABLE sxj6566572');
      frm_main.checkData1.ExecSQL;
      
      frm_main.Memo_02.Lines.SaveToFile(logpath2+DateToStr(Now)
                                +IntToStr(random(9994))+'sx2.log');
      Application.MessageBox('出现严重系统问题2，请检查报文:"sxj6566572.txt"！','系统退出提示',MB_OK);
      Exit;
    end;
      
  end;
  //thread2
  if thread_flag1=2 then
  begin
    frm_main.checkData2.Close;
    frm_main.checkData2.SQL.Clear;
    frm_main.checkData2.SQL.Text:='select * from ltk6565734';
    frm_main.checkData2.Open;

    if frm_main.checkData2.RecordCount=0 then Exit;
    if FileExists(reppath2+'\ltk6565734.txt')then
    begin
      frm_main.Memo_04.Lines.LoadFromFile(reppath2+'\ltk6565734.txt');
    end;
  
      try
        frm_main.convertSP2.Close;
        frm_main.convertSP2.ProcedureName:='update_ltk';
        frm_main.convertSP2.ExecProc;
        //清空文本表22
        frm_main.checkData2.Close;
        frm_main.checkData2.SQL.Clear;
        frm_main.checkData2.SQL.Add('TRUNCATE TABLE ltk6565734');
        frm_main.checkData2.ExecSQL;
      except
        //清空文本表22
        frm_main.checkData2.Close;
        frm_main.checkData2.SQL.Clear;
        frm_main.checkData2.SQL.Add('TRUNCATE TABLE ltk6565734');
        frm_main.checkData2.ExecSQL;

        frm_main.Memo_04.Lines.SaveToFile(logpath2+DateToStr(Now)
                                        +IntToStr(random(9996))+'lt2.log');
        Application.MessageBox('出现严重系统问题4，请检查报文:"ltk6565734.txt"！','系统退出提示',MB_OK);
        Exit;
      end;
  end;
  //thread3
  if thread_flag1=3 then
  begin
    frm_main.checkData3.Close;
    frm_main.checkData3.SQL.Clear;
    frm_main.checkData3.SQL.Text:='select * from tbk6563921';
    frm_main.checkData3.Open;

    if frm_main.checkData3.RecordCount=0 then Exit;
    if FileExists(reppath2+'\tbk6563921.txt')then
    begin
      frm_main.Memo_07.Lines.LoadFromFile(reppath2+'\tbk6563921.txt');
    end;

    try
      frm_main.convertSP3.Close;
      frm_main.convertSP3.ProcedureName:='update_tbk';
      frm_main.convertSP3.ExecProc;
      //清空文本表32
      frm_main.checkData3.Close;
      frm_main.checkData3.SQL.Clear;
      frm_main.checkData3.SQL.Add('TRUNCATE TABLE tbk6563921');
      frm_main.checkData3.ExecSQL;
    except
      //清空文本表32
      frm_main.checkData3.Close;
      frm_main.checkData3.SQL.Clear;
      frm_main.checkData3.SQL.Add('TRUNCATE TABLE tbk6563921');
      frm_main.checkData3.ExecSQL;

      frm_main.Memo_07.Lines.SaveToFile(logpath2+DateToStr(Now)
                                +IntToStr(random(9998))+'tb2.log');
      Application.MessageBox('出现严重系统问题6，请检查报文:"tbk6563921.txt"！','系统退出提示',MB_OK);
      Exit;
    end;

  end;

//第二次项目增加设备点（2006.8.14）
//铁北2为station04
//露天矿2为station05
//十二井为station06

  //thread4- station04
  if thread_flag1=4 then
  begin
    frm_main.checkData4.Close;
    frm_main.checkData4.SQL.Clear;
    frm_main.checkData4.SQL.Text:='select * from zlnr04';
    frm_main.checkData4.Open;

    if frm_main.checkData4.RecordCount=0 then Exit;
    if FileExists(reppath2+'\station04.txt')then
    begin
      frm_main.Memo_11.Lines.LoadFromFile(reppath2+'\station04.txt');
    end;

    try
      frm_main.convertSP4.Close;
      frm_main.convertSP4.ProcedureName:='update_station04';
      frm_main.convertSP4.ExecProc;
      //清空文本表42
      frm_main.checkData4.Close;
      frm_main.checkData4.SQL.Clear;
      frm_main.checkData4.SQL.Add('TRUNCATE TABLE zlnr04');
      frm_main.checkData4.ExecSQL;
    except
      //清空文本表42
      frm_main.checkData4.Close;
      frm_main.checkData4.SQL.Clear;
      frm_main.checkData4.SQL.Add('TRUNCATE TABLE zlnr04');
      frm_main.checkData4.ExecSQL;

      frm_main.Memo_11.Lines.SaveToFile(logpath2+DateToStr(Now)
                                        +IntToStr(random(9998))+'st4.log');
      Application.MessageBox('出现严重系统问题8，请检查报文:"station04.txt"！','系统退出提示',MB_OK);
      Exit;
    end;

  end;

 //thread5- station05
  if thread_flag1=5 then
  begin
    frm_main.checkData5.Close;
    frm_main.checkData5.SQL.Clear;
    frm_main.checkData5.SQL.Text:='select * from zlnr05';
    frm_main.checkData5.Open;

    if frm_main.checkData5.RecordCount=0 then Exit;
    if FileExists(reppath2+'\station05.txt')then
    begin
      frm_main.Memo_12.Lines.LoadFromFile(reppath2+'\station05.txt');
    end;

    try
      frm_main.convertSP5.Close;
      frm_main.convertSP5.ProcedureName:='update_station05';
      frm_main.convertSP5.ExecProc;
      //清空文本表52
      frm_main.checkData5.Close;
      frm_main.checkData5.SQL.Clear;
      frm_main.checkData5.SQL.Add('TRUNCATE TABLE zlnr05');
      frm_main.checkData5.ExecSQL;
    except
      //清空文本表52
      frm_main.checkData5.Close;
      frm_main.checkData5.SQL.Clear;
      frm_main.checkData5.SQL.Add('TRUNCATE TABLE zlnr05');
      frm_main.checkData5.ExecSQL;

      frm_main.Memo_12.Lines.SaveToFile(logpath2+DateToStr(Now)
                                +IntToStr(random(9998))+'st5.log');
      Application.MessageBox('出现严重系统问题10，请检查报文:"station05.txt"！','系统退出提示',MB_OK);
      Exit;
    end;

  end; 

  //thread6- station06
  if thread_flag1=6 then
  begin
    frm_main.checkData6.Close;
    frm_main.checkData6.SQL.Clear;
    frm_main.checkData6.SQL.Text:='select * from zlnr06';
    frm_main.checkData6.Open;

    if frm_main.checkData6.RecordCount=0 then Exit;
    if FileExists(reppath2+'\station06.txt')then
    begin
      frm_main.Memo_13.Lines.LoadFromFile(reppath2+'\station06.txt');
    end;

    try
      frm_main.convertSP6.Close;
      frm_main.convertSP6.ProcedureName:='update_station06';
      frm_main.convertSP6.ExecProc;
      //清空文本表62
      frm_main.checkData6.Close;
      frm_main.checkData6.SQL.Clear;
      frm_main.checkData6.SQL.Add('TRUNCATE TABLE zlnr06');
      frm_main.checkData6.ExecSQL;
    except
      //清空文本表62
      frm_main.checkData6.Close;
      frm_main.checkData6.SQL.Clear;
      frm_main.checkData6.SQL.Add('TRUNCATE TABLE zlnr06');
      frm_main.checkData6.ExecSQL;

      frm_main.Memo_13.Lines.SaveToFile(logpath2+DateToStr(Now)
                                +IntToStr(random(9998))+'st6.log');
      Application.MessageBox('出现严重系统问题12，请检查报文:"station06.txt"！','系统退出提示',MB_OK);
      Exit;
    end;

  end;

end;

//以下是2006.5.10添加
procedure Tfrm_main.init0Timer(Sender: TObject);
var
  sx02count,tb01count,lt04count:integer;
begin
//sx02
  ADODataSet1.Close;
  ADODataSet1.CommandText:='select * from sx02';
  ADODataSet1.Open;
  sx02count:=ADODataSet1.RecordCount;
  if sx02count=0 then
  begin
    init0adoquery.Close;
    init0adoquery.SQL.Clear;
    init0adoquery.SQL.Text:='truncate table sx02';
    init0adoquery.ExecSQL;
  end;
//tb01
  ADODataSet1.Close;
  ADODataSet1.CommandText:='select * from tb01';
  ADODataSet1.Open;
  tb01count:=ADODataSet1.RecordCount;
  if tb01count=0 then
  begin
    init0adoquery.Close;
    init0adoquery.SQL.Clear;
    init0adoquery.SQL.Text:='truncate table tb01';
    init0adoquery.ExecSQL;
  end;
//lt04
  ADODataSet1.Close;
  ADODataSet1.CommandText:='select * from lt04';
  ADODataSet1.Open;
  lt04count:=ADODataSet1.RecordCount;
  if lt04count=0 then
  begin
    init0adoquery.Close;
    init0adoquery.SQL.Clear;
    init0adoquery.SQL.Text:='truncate table lt04';
    init0adoquery.ExecSQL;
  end;
end;

procedure Tfrm_main.clockTimer(Sender: TObject);
begin
  StatusBar1.Panels[2].Text:='现在时间：'+RightStr(DateTimeToStr(Now),8);
end;

procedure Tfrm_main.N13Click(Sender: TObject);
var
  opertype:string;
  conentSTR:string;
begin
  opertype:='DEL OPER';
  conentSTR:=ADODataSet2total_weight1.AsString+','+ADODataSet2suttle1.AsString+','
             +ADODataSet2car_marque.AsString+','+ADODataSet2car_number.AsString+','
             +ADODataSet2carry_weight1.AsString+','+ADODataSet2self_weight1.AsString+','
             +ADODataSet2yk_weight.AsString+','+ADODataSet2breed.AsString+','
             +ADODataSet2past_date.AsString+','+ADODataSet2past_time.AsString;
  //把数据添加到日志表中
  addDispatch.Close;
  addDispatch.SQL.Clear;
  addDispatch.SQL.Text:='insert into zcc_log values('+''''+opertor+''''
                        +','+''''+DateTimeToStr(Now)+''''+','
                        +''''+conentSTR+''''+','+''''+opertype+''''+')';
  addDispatch.ExecSQL;
  //删除数据
  delDispatch.Close;
  delDispatch.SQL.Clear;
  delDispatch.SQL.Text:='delete from '+tablename+' where sn='
                                +IntToStr(ADODataSet2sn.Value);
  delDispatch.ExecSQL;

  ADODataSet2.Close;
  ADODataSet2.Open;
  stationcount:=ADODataSet2.RecordCount;
  StatusBar1.Panels[0].Text:=stationName+'检斤站共有'+IntToStr(stationcount)+'辆车';

end;


//thread processor
procedure Tfrm_main.Timer_updateTimer(Sender: TObject);
var
  spThread1,spThread2,spThread3,spThread4,spThread5,spThread6:Thread_update;
begin
  checkData1.Close;
  checkData1.SQL.Clear;
  checkData1.SQL.Text:='select * from sxj6566572';
  checkData1.Open;
  if checkData1.RecordCount<>0 then
  begin
    spThread1:=Thread_update.Create(1,reppath,Logpath);
  end;
  checkData2.Close;
  checkData2.SQL.Clear;
  checkData2.SQL.Text:='select * from ltk6565734';
  checkData2.Open;
  if checkData2.RecordCount<>0 then
  begin
    spThread2:=Thread_update.Create(2,reppath,Logpath);
  end;
  //tbk6563921
  checkData3.Close;
  checkData3.SQL.Clear;
  checkData3.SQL.Text:='select * from tbk6563921';
  checkData3.Open;
  if checkData3.RecordCount<>0 then
  begin
    spThread3:=Thread_update.Create(3,reppath,Logpath);
  end;
  //station04
  checkData4.Close;
  checkData4.SQL.Clear;
  checkData4.SQL.Text:='select * from zlnr04';
  checkData4.Open;
  if checkData4.RecordCount<>0 then
  begin
    spThread4:=Thread_update.Create(4,reppath,Logpath);
  end;
  //station05
  checkData5.Close;
  checkData5.SQL.Clear;
  checkData5.SQL.Text:='select * from zlnr05';
  checkData5.Open;
  if checkData5.RecordCount<>0 then
  begin
    spThread4:=Thread_update.Create(5,reppath,Logpath);
  end;
  //station06
  checkData6.Close;
  checkData6.SQL.Clear;
  checkData6.SQL.Text:='select * from zlnr06';
  checkData6.Open;
  if checkData6.RecordCount<>0 then
  begin
    spThread6:=Thread_update.Create(6,reppath,Logpath);
  end;
end;

end.
