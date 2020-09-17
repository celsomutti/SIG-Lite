unit View.AcompanhamentoEntregas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  Tview_AcompanhamntoEntregas = class(TForm)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  view_AcompanhamntoEntregas: Tview_AcompanhamntoEntregas;

implementation

{$R *.dfm}

procedure Tview_AcompanhamntoEntregas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  view_AcompanhamntoEntregas := nil;
end;

end.
