unit Udatatotal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, Grids, DBGrids, StdCtrls, DB, ADODB, Printers;

type
  Tfrm_sa = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    StatusBar1: TStatusBar;
    DBGrid1: TDBGrid;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    Label1: TLabel;
    cmbox_dz: TComboBox;
    Label2: TLabel;
    cmbox_mz: TComboBox;
    Label4: TLabel;
    cmbox_dd: TComboBox;
    DataSource1: TDataSource;
    totals1: TADODataSet;
    FindData: TADOQuery;
    pnl_btn: TPanel;
    btn_find: TButton;
    btn_print2: TButton;
    CheckBox1: TCheckBox;
    Label5: TLabel;
    edt_carnum: TEdit;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_print2Click(Sender: TObject);
    procedure btn_findClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_sa: Tfrm_sa;

implementation
uses
  Udispatch;

{$R *.dfm}

procedure Tfrm_sa.FormShow(Sender: TObject);
var
  PstationStr,breedStr,OperatorStr:string;
  gsStr:string;
begin
  totals1.Close;
  totals1.CommandText:='select total_weight1, suttle1, car_marque, car_number,'
                +' carry_weight1, self_weight1, yk_weight, breed, Pstation,'
                +' past_date, past_time,OperID from TotalTable';
  totals1.Open;
  //
  //到站添加
  FindData.Close;
  FindData.SQL.Clear;
  FindData.SQL.Text:='select DISTINCT  Pstation from TotalTable';
  FindData.Open;  
  while not FindData.Eof do
  begin
    PstationStr:=FindData.Fields[0].AsString;
    cmbox_dz.Items.Add(PstationStr);
    FindData.Next;
  end;
  //
  //煤种添加
  FindData.Close;
  FindData.SQL.Clear;
  FindData.SQL.Text:='select DISTINCT  breed from TotalTable';
  FindData.Open;  
  while not FindData.Eof do
  begin
    breedStr:=FindData.Fields[0].AsString;
    cmbox_mz.Items.Add(breedStr);
    FindData.Next;
  end;
  //
  //调度员添加
  FindData.Close;
  FindData.SQL.Clear;
  FindData.SQL.Text:='select DISTINCT  OperID from TotalTable';
  FindData.Open;  
  while not FindData.Eof do
  begin
    OperatorStr:=FindData.Fields[0].AsString;
    cmbox_dd.Items.Add(OperatorStr);
    FindData.Next;
  end;
  //
  {//钩数添加
  FindData.Close;
  FindData.SQL.Clear;
  FindData.SQL.Text:='select DISTINCT  cumulateConsist from TotalTable';
  FindData.Open;  
  while not FindData.Eof do
  begin
    gsStr:=FindData.Fields[0].AsString;
    cmb_gs.Items.Add(gsStr);
    FindData.Next;
  end;
  //}

end;

procedure Tfrm_sa.FormCreate(Sender: TObject);
begin
  //
  DateTimePicker1.Date:=Date-1;
  DateTimePicker2.Date:=Date;
end;

procedure Tfrm_sa.btn_print2Click(Sender: TObject);
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

  if ((DataSource1.DataSet).Active=true) and ((DataSource1.DataSet).RecordCount>0) then
  begin
    printer.BeginDoc;
    (DataSource1.DataSet).First;
    
    while not (DataSource1.DataSet).Eof do
    begin
      for i:=0 to DBGrid1.FieldCount-1 do
      begin
        if (x+DBGrid1.Columns.Items[i].Width*PointScale)<=(Printer.PageWidth-PointX*RightBlank) then
        begin
          Printer.Canvas.Rectangle(x,y,x+DBGrid1.Columns.Items[i].Width*PointScale,y+PrintStep);
          if y=PointY*TopBlank then
            Printer.Canvas.TextOut(x+8,y+8,DBGrid1.Columns[i].Title.Caption)
          else
            Printer.Canvas.TextOut(x+8,y+8,DBGrid1.Fields[i].asString);
        end;
        x:=x+DBGrid1.Columns.Items[i].Width*PointScale;
      end;
      if not (y=PointY*TopBlank) then
        (DataSource1.DataSet).next;
        x:=PointX*LeftBlank;
        y:=y+PrintStep;
      if (y+PrintStep)>(Printer.PageHeight-PointY*BottomBlank) then
      begin
        Printer.NewPage;
        y:=PointY*TopBlank;
      end;
    end;//whil end

    printer.EndDoc;
    (DataSource1.DataSet).First;
    Application.MessageBox('打印完成','打印',32);

  end;//if end
//
end;

procedure Tfrm_sa.btn_findClick(Sender: TObject);
var
  sqlstr11,sqlstr12,sqlstr13,sqlstr14,sqlstr15:string;
  datestr1,datestr2:string;
  //
  sqlCollocation:integer;
  cmb_dzINT,cmb_mzINT,cmb_ddINT:integer;
begin
  sqlstr11:='select total_weight1, suttle1, car_marque, car_number, carry_weight1,'
        +' self_weight1, yk_weight, breed, Pstation, past_date, past_time,OperID from TotalTable';
  //
  DataSource1.DataSet:=FindData;
  //
  datestr1:=DateToStr(DateTimePicker1.Date);
  datestr2:=DateToStr(DateTimePicker2.Date);

  sqlstr12:=' where past_date between '+''''+datestr1+''''+' and '+''''+datestr2+'''';
  sqlstr13:=' and Pstation='+''''+cmbox_dz.Text+'''';//到站
  sqlstr14:=' and breed='+''''+cmbox_mz.Text+'''';   //煤种
  sqlstr15:=' and OperID='+''''+cmbox_dd.Text+'''';  //调度员

  {//检查高级查询是否选中
  if CheckBox1.Checked then
  begin
    if cmb_gs.Text='' then
    begin
      Exit;
    end;
    FindData.Close;
    FindData.SQL.Clear;
    FindData.SQL.Text:=sqlstr11+' where cumulateConsist='+trim(cmb_gs.Text);
    FindData.Open;
    Exit;
  end;}
  if CheckBox1.Checked then
  begin
    if edt_carnum.Text='' then
    begin
      Exit;
    end;
    FindData.Close;
    FindData.SQL.Clear;
    FindData.SQL.Text:=sqlstr11+sqlstr12+' and car_number='+''''+trim(edt_carnum.Text)+'''';
    FindData.Open;
    Exit;
  end;
  //
  if cmbox_dz.Text='' then
  begin
    cmb_dzINT:=1;
  end
  else
  begin
    cmb_dzINT:=2;
  end;
  if cmbox_mz.Text='' then
  begin
    cmb_mzINT:=10;
  end
  else
  begin
    cmb_mzINT:=20;
  end;
  if cmbox_dd.Text='' then
  begin
    cmb_ddINT:=100;
  end
  else
  begin
    cmb_ddINT:=200;
  end;
  
  sqlCollocation:=cmb_dzINT+cmb_mzINT+cmb_ddINT;
  
  case sqlCollocation of
  //到站为空的
  111:
    begin
      FindData.Close;
      FindData.SQL.Clear;
      FindData.SQL.Text:=sqlstr11+sqlstr12;
      FindData.Open;
    end;
  211:
    begin
      FindData.Close;
      FindData.SQL.Clear;
      FindData.SQL.Text:=sqlstr11+sqlstr12+sqlstr15;
      FindData.Open;
    end;
  121:
     begin
      FindData.Close;
      FindData.SQL.Clear;
      FindData.SQL.Text:=sqlstr11+sqlstr12+sqlstr14;
      FindData.Open;
    end;
  221:
     begin
      FindData.Close;
      FindData.SQL.Clear;
      FindData.SQL.Text:=sqlstr11+sqlstr12+sqlstr14+sqlstr15;
      FindData.Open;
    end;
  //到站为非空的
  112:
    begin
      FindData.Close;
      FindData.SQL.Clear;
      FindData.SQL.Text:=sqlstr11+sqlstr12+sqlstr13;
      FindData.Open;
    end;
  212:
    begin
      FindData.Close;
      FindData.SQL.Clear;
      FindData.SQL.Text:=sqlstr11+sqlstr12+sqlstr13+sqlstr15;
      FindData.Open;
    end;
  122:
    begin
      FindData.Close;
      FindData.SQL.Clear;
      FindData.SQL.Text:=sqlstr11+sqlstr12+sqlstr13+sqlstr14;
      FindData.Open;
    end;
  222:
    begin
      FindData.Close;
      FindData.SQL.Clear;
      FindData.SQL.Text:=sqlstr11+sqlstr12+sqlstr13+sqlstr14+sqlstr15;
      FindData.Open;
    end;
  end;


end;

procedure Tfrm_sa.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked then
  begin
    Label1.Visible:=False;
    Label2.Visible:=False;
    Label4.Visible:=False;
    cmbox_dz.Visible:=False;
    cmbox_mz.Visible:=False;
    cmbox_dd.Visible:=False;
    //
    Label5.Visible:=True;
    edt_carnum.Visible:=True;
  end
  else
  begin
    Label1.Visible:=True;
    Label2.Visible:=True;
    Label4.Visible:=True;
    cmbox_dz.Visible:=True;
    cmbox_mz.Visible:=True;
    cmbox_dd.Visible:=True;
    //
    Label5.Visible:=False;
    edt_carnum.Visible:=False;
  end;
end;

end.
