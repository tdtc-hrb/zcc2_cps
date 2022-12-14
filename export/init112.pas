unit init112;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, Gauges, UreadReg;

type
  TfrmExport = class(TForm)
    ADOConnection_init: TADOConnection;
    Gauge1: TGauge;
    btn_star: TButton;
    btn_stop: TButton;
    edtTxtPath: TEdit;
    Label1: TLabel;
    ADOQuery1: TADOQuery;
    procedure FormCreate(Sender: TObject);
    procedure btn_starClick(Sender: TObject);
    procedure btn_stopClick(Sender: TObject);
  private
    year,month,day,DOW:Word;
    { Private declarations }
  public
    xbf:WideString;
    csvPath,zcc_logTXT:string;
    { Public declarations }
  end;


var
  frmExport: TfrmExport;

implementation

{$R *.dfm}

function readXBF(DimRecord: Integer;filename1:WideString):WideString;stdcall;external 'XBFGenerate.dll';

procedure TfrmExport.FormCreate(Sender: TObject);
begin
  frmExport.Caption:='汇总数据导出程序';
  DecodeDateFully(Now,year,month,day,DOW);
  csvPath:='D:\ExprotTotal'+IntToStr(year)+IntToStr(month)+IntToStr(day)+'.log';
  zcc_logTXT:='D:\Export_log'+DateToStr(Now)+'.log';
  edtTxtPath.Text:=csvPath;

  xbf:=ExtractFilePath(ParamStr(0))+'zlnr1.xbf';
end;

procedure TfrmExport.btn_starClick(Sender: TObject);
var
  h1:THandle;
  iFor: integer;
  TempStr: string;
  TempList: TStrings;
begin
  if btn_stop.Enabled=false then
  begin
    Exit;
  end;
  try
    ADOConnection_init.ConnectionString:= readREG(xbf);
  except
    Application.MessageBox('配置错误，请重新填写各个值！','提示',MB_OK);
    Exit;
  end;
  Gauge1.Visible:=True;
  try
    //导出文本文件
    
    Gauge1.Progress:=17;

    //输出CSV文件
    ADOQuery1.Close;
    ADOQuery1.SQL.Text:='select * from TotalTable';
    ADOQuery1.Open;
    TempStr := '';
    TempList := TStringList.Create;
    ADOQuery1.First;
    while not ADOQuery1.Eof do
    begin
      TempStr := '';
      for iFor := 0 to 14-1 do//10 列
      begin
        if iFor=0 then
        begin
          TempStr := TempStr + ADOQuery1.Fields[iFor].AsString;
        end
        else
        begin
          TempStr := TempStr +','+ ADOQuery1.Fields[iFor].AsString;
        end;
      end;
      TempList.Append(TempStr);
      ADOQuery1.Next;
    end;
    TempList.SaveToFile(csvPath);
    FreeAndNil(TempList);

       
    Gauge1.Progress:=34;
    //
        //输出CSV文件
    ADOQuery1.Close;
    ADOQuery1.SQL.Text:='select * from zcc_log';
    ADOQuery1.Open;
    TempStr := '';
    TempList := TStringList.Create;
    ADOQuery1.First;
    while not ADOQuery1.Eof do
    begin
      TempStr := '';
      for iFor := 0 to 5-1 do//10 列
      begin
        if iFor=0 then
        begin
          TempStr := TempStr + ADOQuery1.Fields[iFor].AsString;
        end
        else
        begin
          TempStr := TempStr +','+ ADOQuery1.Fields[iFor].AsString;
        end;
      end;
      TempList.Append(TempStr);
      ADOQuery1.Next;
    end;
    TempList.SaveToFile(zcc_logTXT);
    FreeAndNil(TempList);

    Gauge1.Progress:=51;
  except
    Exit;
  end;


      Gauge1.Progress:=68;
    //
        //sp2


      Gauge1.Progress:=85;
    //
        //sp3

      
      Gauge1.Progress:=100;
    //
    Application.MessageBox('导出完成！','提示',MB_OK);
    btn_stop.Enabled:=False;

end;

procedure TfrmExport.btn_stopClick(Sender: TObject);
var
  h1:THandle;
begin
  try
    readREG(xbf);
  except
    Application.MessageBox('配置错误，请重新填写各个值！','提示',MB_OK);
    Exit;
  end;
  //
   btn_star.Enabled:=True;
   csvPath:=edtTxtPath.Text;
   Application.MessageBox('预处理完成！','提示',MB_OK);
end;


end.
