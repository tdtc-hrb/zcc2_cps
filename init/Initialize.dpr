program Initialize;

uses
  Forms,
  init112 in 'init112.pas' {frm_init},
  UreadReg in '..\init2\UreadReg.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '��ʼ��';
  Application.CreateForm(Tfrm_init, frm_init);
  Application.Run;
end.
