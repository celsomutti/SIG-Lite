program SIGLite;

uses
  Vcl.Forms,
  View.Main in 'view\View.Main.pas' {view_Main},
  Vcl.Themes,
  Vcl.Styles,
  dm.SIGLite in 'data\dm.SIGLite.pas' {dm_SIGLite: TDataModule},
  Common.ENum in '..\SisGeF5\Common\Common.ENum.pas',
  Common.Utils in '..\SisGeF5\Common\Common.Utils.pas',
  Global.Parametros in '..\SisGeF5\Common\Global.Parametros.pas',
  View.Login in 'view\View.Login.pas' {view_login};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Windows10');
  Application.Title := 'SIG Lite';
  Application.CreateForm(Tview_Main, view_Main);
  Application.CreateForm(Tdm_SIGLite, dm_SIGLite);
  Application.Run;
end.
