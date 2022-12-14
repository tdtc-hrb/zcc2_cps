unit UreadReg;

interface
uses
  Windows, SysUtils, Registry, Classes, Forms, StrUtils;

//
  type
  TreadXBF=function(DimRecord: Integer;filename1:WideString):WideString;stdcall;
  //


var
  myreg:TRegistry;
  childstr1,childstr6:string[1];
  childstr4,childstr5:string[2];
  childstr2,childstr3:string[4];
  installbool:Boolean;
  connstring:TreadXBF;

Function readREG(xbf:WideString):WideString;


implementation


Function readREG(xbf:WideString):WideString;
var
  XBFconnect:string;
  XBFconn1,REGconn2,XBFconn3:string;
  tempregbin:array [0..15]of char;
  XBFlen:integer;
  h1:THandle;
  //
  P : PChar;
  Err : DWord;
  ErrStr:string;
  year,month,day,DOW:Word;
  dayStr,monthStr:string;
  nowdate:string;
  installdate:string;
  TimeLag:integer;
  //2007.1.6定位密码位置
  pwdCoordinate:integer;
begin
  myreg:=TRegistry.Create;
  with myreg.Create do
  begin
    myreg.RootKey:=HKEY_LOCAL_MACHINE;

    if not OpenKey('SoftWare\veic\cps',False)then
    begin
      Application.MessageBox('操作系统出现问题或人为恶意改动！','OS ERROR',MB_OK);
      CloseKey;
      Application.Terminate;
    end;
    //内嵌过程start
    P := pchar('yyyy-MM-dd');
    if SetLocaleInfo(LOCALE_USER_DEFAULT,LOCALE_SSHORTDATE,P) then
    begin
      //
    end
    else
    begin
      Err := GetLastError;
      case Err of
        ERROR_INVALID_ACCESS : ErrStr:='INVALID_ACCESS';
        ERROR_INVALID_FLAGS  : ErrStr:='INVALID_FLAGS';
        ERROR_INVALID_PARAMETER : ErrStr:='INVALID_PARAMETER';
      end;
    end;
    DecodeDateFully(Now,year,month,day,DOW);
    if month<10 then
    begin
      monthStr:='0'+IntToStr(month);
    end else monthStr:=IntToStr(month);
    if day<10 then
    begin
      dayStr:='0'+IntToStr(day);
    end else dayStr:= IntToStr(day);
    nowdate:=IntToStr(year)+monthStr+dayStr;
    if ValueExists('InstallDate')then
    begin
      installdate:=myreg.ReadString('InstallDate');
      TimeLag:=StrToInt(nowdate)-StrToInt(installdate);
      DateTimeToFileDate(Now);
      //判断时间差(begin)
      if TimeLag>300000 then
      begin
        Application.MessageBox('Expired statute of limitations', 'Soft Information', MB_OK);
      end;
     //判断时间差(end)
    end
    else
    begin
      installbool:=True;
      Application.MessageBox('丢失安装信息，程序无法运行！','OS ERROR',MB_OK);
      Application.Terminate;
    end;

    //内嵌过程stop


    if ValueExists('support1')then
    begin
      myreg.ReadBinaryData('support1',tempregbin,4);
      childstr1:= tempregbin
    end
    else
    begin
      installbool:=True;
      exit;
    end;

    if ValueExists('support2')then
    begin
      myreg.ReadBinaryData('support2',tempregbin,16);
      childstr2:= tempregbin
     end
     else
     begin
       installbool:=True;
       exit;
     end;

     if ValueExists('support3')then
     begin
       myreg.ReadBinaryData('support3',tempregbin,16);
       childstr3:= tempregbin
     end
     else
     begin
       installbool:=True;
       exit;
     end;

     if ValueExists('support4')then
     begin
       myreg.ReadBinaryData('support4',tempregbin,8);
       childstr4:= tempregbin
     end
     else
     begin
       installbool:=True;
       exit;
     end;

     if ValueExists('support5')then
     begin
       myreg.ReadBinaryData('support5',tempregbin,8);
       childstr5:= tempregbin
     end
     else
     begin
       installbool:=True;
       exit;
     end;

     if ValueExists('support6')then
     begin
       myreg.ReadBinaryData('support6',tempregbin,4);
       childstr6:= tempregbin
     end
     else
     begin
       Application.MessageBox('丢失安装信息，程序无法运行！','OS ERROR',MB_OK);
       installbool:=True;
       exit;
     end;
  end;//withend
  REGconn2:=childstr2+childstr5+childstr6+childstr1+childstr3+childstr4;
  try
     h1:=0;
     try
      h1:=LoadLibrary('XBFGenerate.dll');

      if h1<>0 then
        @connstring:=GetprocAddress(h1,'readXBF');
      if (@connstring<>nil)then
          XBFconnect:=connstring(-1,xbf);
     finally
       FreeLibrary(h1);
     end;
  except
    Application.MessageBox('配置错误，请重新填写各个值！','提示',MB_OK);
    Exit;
  end;
  //XBFconnect:=readXBF(-1,xbf);
  XBFconn1:=LeftStr(XBFconnect,29);
  //2007.1.6定位密码位置
  pwdCoordinate:=pos(';Pe',XBFconnect);
  XBFlen:=length(XBFconnect);
  XBFconn3:=RightStr(XBFconnect,XBFlen-pwdCoordinate+1);

  Result:=XBFconn1+REGconn2+XBFconn3;

end;

end.
