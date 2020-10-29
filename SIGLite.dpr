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
  View.Login in 'view\View.Login.pas' {view_login},
  Model.RESTLogin in 'model\Model.RESTLogin.pas',
  Common.Params in 'common\Common.Params.pas',
  Controller.RESTLogin in 'controller\Controller.RESTLogin.pas',
  Model.RESTLoginAgente in 'model\Model.RESTLoginAgente.pas',
  Controller.RESTLoginAgente in 'controller\Controller.RESTLoginAgente.pas',
  Model.RESTBases in 'model\Model.RESTBases.pas',
  Controller.RESTBases in 'controller\Controller.RESTBases.pas',
  View.AcompanhamentoEntregas in 'view\View.AcompanhamentoEntregas.pas' {view_AcompanhamntoEntregas},
  Model.RESTEntregadores in 'model\Model.RESTEntregadores.pas',
  Controller.RESTEntregadores in 'controller\Controller.RESTEntregadores.pas';

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
