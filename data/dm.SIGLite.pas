unit dm.SIGLite;

interface

uses
  System.SysUtils, System.Classes, System.ImageList, Vcl.ImgList, Vcl.Controls, cxImageList, cxGraphics;

type
  Tdm_SIGLite = class(TDataModule)
    imageListMain: TcxImageList;
    imageList16_16: TcxImageList;
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

end.
