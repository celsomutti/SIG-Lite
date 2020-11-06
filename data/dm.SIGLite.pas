unit dm.SIGLite;

interface

uses
  System.SysUtils, System.Classes, System.ImageList, Vcl.ImgList, Vcl.Controls, cxImageList, cxGraphics, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, REST.Response.Adapter,
  cxClasses, VCL.Forms, cxLocalization;

type
  Tdm_SIGLite = class(TDataModule)
    imageListMain: TcxImageList;
    imageList16_16: TcxImageList;
    RESTClient: TRESTClient;
    RESTRequest: TRESTRequest;
    RESTResponse: TRESTResponse;
    RESTResponseDataSetAdapter: TRESTResponseDataSetAdapter;
    fdMemTabEntregas: TFDMemTable;
    fdMemTableExtrato: TFDMemTable;
    memTableExtrato: TFDMemTable;
    memTableExtravios: TFDMemTable;
    memTableLancamentos: TFDMemTable;
    cxLocalizer: TcxLocalizer;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm_SIGLite: Tdm_SIGLite;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure Tdm_SIGLite.DataModuleCreate(Sender: TObject);
begin
  if FileExists(ExtractFilePath(Application.ExeName)+'\devtrans.ini') then
  begin
    cxLocalizer.LoadFromFile(ExtractFilePath(Application.ExeName)+ '\devtrans.ini');
    cxLocalizer.LanguageIndex := 1; // MUDA DE LINGUAGEM
    cxLocalizer.Active := TRUE;     // ATIVA O COMPONENTE
  end;

end;

end.
