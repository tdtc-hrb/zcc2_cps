unit data_abstracts;

interface

uses
  Windows, SysUtils, Classes, SvcMgr, DB, ADODB, Inifiles, ExtCtrls, UreadReg;

type
  Thread_t2d = class(TThread)
  private
    t1,t2,t3,t4,t5,t6:WideString;
    parade1:integer;
    { Private declarations }
  protected
    Function RegulateStr(aString:String;Sepchar:String):String;
    Function GetSubStr(var aString:String;SepChar:String):String;
    procedure Execute; override;
  public
    constructor Create(flag:Boolean;parade:integer);
  end;
  
type
  Tdata_abstract = class(TService)
    Timer1: TTimer;
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceContinue(Sender: TService; var Continued: Boolean);
    procedure ServicePause(Sender: TService; var Paused: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
    procedure Timer1Timer(Sender: TObject);
    procedure ServiceCreate(Sender: TObject);
    procedure ServiceDestroy(Sender: TObject);
  private
    ftxt2db1:Thread_t2d;
    ftxt2db2:Thread_t2d;
    ftxt2db3:Thread_t2d;
    ftxt2db4:Thread_t2d;
    ftxt2db5:Thread_t2d;
    ftxt2db6:Thread_t2d;
  public
    ADOConnectionX:TADOConnection;
    function GetServiceController: TServiceController; override;
  end;

type
  Tfun_con=function(DimRecord: Integer;filename1:WideString):WideString;stdcall;

var
  data_abstract: Tdata_abstract;

  connstring:Tfun_con;
  
implementation
  
{$R *.DFM}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  data_abstract.Controller(CtrlCode);
end;

function Tdata_abstract.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;


procedure Tdata_abstract.ServiceStart(Sender: TService; var Started: Boolean);
begin
  ftxt2db1:=Thread_t2d.Create(False,1);
  ftxt2db2:=Thread_t2d.Create(False,2);
  ftxt2db3:=Thread_t2d.Create(False,3);
  ftxt2db4:=Thread_t2d.Create(False,4);
  ftxt2db5:=Thread_t2d.Create(False,5);
  ftxt2db6:=Thread_t2d.Create(False,6);
  Started:=True;
end;

procedure Tdata_abstract.ServiceContinue(Sender: TService;
  var Continued: Boolean);
begin
  ftxt2db1:=Thread_t2d.Create(False,1);
  ftxt2db2:=Thread_t2d.Create(False,2);
  ftxt2db3:=Thread_t2d.Create(False,3);
  ftxt2db4:=Thread_t2d.Create(False,4);
  ftxt2db5:=Thread_t2d.Create(False,5);
  ftxt2db6:=Thread_t2d.Create(False,6);
  Continued:=True;
end;

procedure Tdata_abstract.ServicePause(Sender: TService; var Paused: Boolean);
begin
  ftxt2db1:=Thread_t2d.Create(False,1);
  ftxt2db2:=Thread_t2d.Create(False,2);
  ftxt2db3:=Thread_t2d.Create(False,3);
  ftxt2db4:=Thread_t2d.Create(False,4);
  ftxt2db5:=Thread_t2d.Create(False,5);
  ftxt2db6:=Thread_t2d.Create(False,6);
  Paused:=True;
end;

procedure Tdata_abstract.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  ftxt2db1:=Thread_t2d.Create(False,1);
  ftxt2db2:=Thread_t2d.Create(False,2);
  ftxt2db3:=Thread_t2d.Create(False,3);
  ftxt2db4:=Thread_t2d.Create(False,4);
  ftxt2db5:=Thread_t2d.Create(False,5);
  ftxt2db6:=Thread_t2d.Create(False,6);
  Stopped:=True;
end;

procedure Tdata_abstract.Timer1Timer(Sender: TObject);
begin
  ftxt2db1.Execute;
  ftxt2db2.Execute;
  ftxt2db3.Execute;
  ftxt2db4.Execute;
  ftxt2db5.Execute;
  ftxt2db6.Execute;
end;

procedure Tdata_abstract.ServiceCreate(Sender: TObject);
var
  xbffilepath:string;
  xbfini:TIniFile;
  xbfname:string;
  //h1:THandle;
begin
  //h1:=0;
  xbfini:=TIniFile.Create(ExtractFilePath(ParamStr(0))+'CPS_service.ini');
  xbfname:=xbfini.ReadString('file name','1','');
  xbffilepath:=ExtractFilePath(ParamStr(0))+xbfname;
  {try
    h1:=LoadLibrary('XBFGenerate.dll');
    
    if h1<>0 then
      @connstring:=GetprocAddress(h1,'readXBF');
    if (@connstring<>nil)then
      ADOConnection1.ConnectionString:=connstring(-1,xbffilepath);
   finally
     FreeLibrary(h1);
   end;}
  try
    ADOConnectionX:=TADOConnection.Create(nil);
    ADOConnectionX.LoginPrompt:=False;
    ADOConnectionX.Close;
    
    ADOConnectionX.ConnectionString:=readREG(xbffilepath)
  except

  end;

end;

////写线程执行
constructor Thread_t2d.create(flag:Boolean;parade:integer);
var
  xbfini:TIniFile;
  Err : DWord;
  timeformat1:PChar;
begin
  inherited Create(False);
  xbfini:=TIniFile.Create(ExtractFilePath(ParamStr(0))+'CPS_service.ini');
  t1:=xbfini.ReadString('file path','1','');
  t2:=xbfini.ReadString('file path','2','');
  t3:=xbfini.ReadString('file path','3','');
  t4:=xbfini.ReadString('file path','4','');
  t5:=xbfini.ReadString('file path','5','');
  t6:=xbfini.ReadString('file path','6','');
  parade1:=parade;
    //
  timeformat1:='yyyy-MM-dd';
  if SetLocaleInfo(LOCALE_USER_DEFAULT,LOCALE_SSHORTDATE,timeformat1) then
  begin
    //
  end
  else
  begin
    Err := GetLastError;
    //显示错误原因
    case Err of
      ERROR_INVALID_ACCESS : ;
      ERROR_INVALID_FLAGS  : ;
      ERROR_INVALID_PARAMETER : ;
    end;
  end;
  //free and nil
  FreeAndNil(xbfini);
end;
//
//
Function Thread_t2d.RegulateStr(aString:String;Sepchar:String):String;
var
  i,Num:Integer;
  Flag:Boolean;
  MyStr,TempStr:String;
begin
  Flag:=False;//进行标志，去除多余的分割符
  Num:=Length(aString);//计算aString串的长度
  for i:=1 to Num do
  begin
    TempStr:=Copy(aString,i,1);//取aString串中的一字符
    if TempStr<>SepChar then
    begin
      MyStr:=MyStr+TempStr;
      Flag:=True;
    end
    else
      if(Flag)then
      begin
        Mystr:=Mystr+TempStr;
        Flag:=False;
      end
      else
      begin
         Mystr:=Mystr+' '+TempStr;
         Flag:=False;
      end;
    end;
    if MyStr[Length(MyStr)]<>SepChar then
    MyStr:=MyStr+SepChar;
    RegulateStr:=MyStr;
end;

Function Thread_t2d.GetSubStr(var aString:String;SepChar:String):String;
var
  Mystr:WideString;
  //StrLen:Integer;
  SepCharPos:Integer;
begin
  //StrLen:=Length(aString);
  SepCharPos:=Pos(SepChar,aString);//计算分割符在子串中的位置
  MyStr:=Copy(aString,1,SepCharPos-1);//将分割符前所有字符放到mystr串中
  Delete(aString,1,SepCharPos);//除去分割符和分割符前的子串
  GetSubStr:=MyStr;//返回一个字段
end;




procedure Thread_t2d.Execute;
var
  richstring:TStringList;
  i,j:Integer;
  MyLine:String;
  //Space:String;
  //
  filename1:WideString;
  ADODataSetX:TADODataSet;
begin
  ADODataSetX:=TADODataSet.Create(nil);
  ADODataSetX.Connection:=data_abstract.ADOConnectionX;
  //
  case parade1 of

    1:
      begin
        filename1:=t1;
        ADODataSetX.Close;
        ADODataSetX.CommandText:='select * from sxj6566572';
      end;
    2:
      begin
        filename1:=t2;
        ADODataSetX.Close;
        ADODataSetX.CommandText:='select * from tbk6563921';
      end;
    3:
      begin
        filename1:=t3;
        ADODataSetX.Close;
        ADODataSetX.CommandText:='select * from ltk6565734';
      end;
    4:
      begin
        filename1:=t4;
        ADODataSetX.Close;
        ADODataSetX.CommandText:='select * from zlnr04';
      end;
    5:
      begin
        filename1:=t5;
        ADODataSetX.Close;
        ADODataSetX.CommandText:='select * from zlnr05';
      end;
    6:
      begin
        filename1:=t6;
        ADODataSetX.Close;
        ADODataSetX.CommandText:='select * from zlnr06';
      end;      

   end;

  richstring:=TStringList.Create;
  try
    richstring.LoadFromFile(filename1);
  except
    Exit;
  end;


  with ADODataSetX do
  begin
    Open;
    for i:=0 to richstring.Count-1 do
    begin
      MyLine:=RegulateStr(richstring.Strings[i],',');
      for j:=1 to 11 do//11列--根据数据列来定数
      begin
        Edit;
        Fields[j-1].Value:=GetSubStr(MyLine,',');
        post;
      end;//inner for
      Append;
    end;//outer for
    DeleteFile(filename1);
  end;//with end

  //free and nil
  FreeAndNil(ADODataSetX);
  FreeAndNil(richstring);
end;


procedure Tdata_abstract.ServiceDestroy(Sender: TObject);
begin
  FreeAndNil(ADOConnectionX);
end;

end.
 