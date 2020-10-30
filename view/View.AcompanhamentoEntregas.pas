unit View.AcompanhamentoEntregas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.WinXPanels, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  REST.Response.Adapter, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore, dxSkinsDefaultPainters,
  cxClasses, dxLayoutContainer, dxLayoutControl, cxContainer, cxEdit, dxLayoutcxEditAdapters, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  Controller.RESTPeriodos, dxLayoutControlAdapters, Vcl.Menus, Vcl.StdCtrls, cxButtons, System.Actions, Vcl.ActnList, System.DateUtils,
  Controller.RESTEntregas, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator, dxDateRanges,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData, cxGridLevel, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid;

type
  Tview_AcompanhamntoEntregas = class(TForm)
    layoutControlMainGroup_Root: TdxLayoutGroup;
    layoutControlMain: TdxLayoutControl;
    layoutGroupCriterios: TdxLayoutGroup;
    comboBoxMeses: TcxComboBox;
    bayoutItemComboBoxMeses: TdxLayoutItem;
    comboBoxPeriodos: TcxComboBox;
    layoutItemComboBoxPeriodos: TdxLayoutItem;
    buttonPesquisar: TcxButton;
    layoutItemButtonPesquisar: TdxLayoutItem;
    actionListEntregas: TActionList;
    actionPesquisar: TAction;
    comboBoxAno: TcxComboBox;
    layoutItemComboBoxAno: TdxLayoutItem;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    cxGrid: TcxGrid;
    layoutItemGrid: TdxLayoutItem;
    dsGrid: TDataSource;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure actionPesquisarExecute(Sender: TObject);
  private
    { Private declarations }
    procedure PopulaPeriodos;
    procedure MontaPeriodo(iAno, iMes, iQuinzena: Integer);
    procedure SetupAno();
    procedure PesquisaEntregas();
  public
    { Public declarations }
  end;

var
  view_AcompanhamntoEntregas: Tview_AcompanhamntoEntregas;
  dtDataInicial, dtDataFinal: TDateTime;

implementation

{$R *.dfm}

uses dm.SIGLite, Common.Params;

procedure Tview_AcompanhamntoEntregas.actionPesquisarExecute(Sender: TObject);
begin
  PesquisaEntregas;
end;

procedure Tview_AcompanhamntoEntregas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  view_AcompanhamntoEntregas := nil;
end;

procedure Tview_AcompanhamntoEntregas.FormShow(Sender: TObject);
begin
  SetupAno;
  PopulaPeriodos;
end;

procedure Tview_AcompanhamntoEntregas.PesquisaEntregas;
var
  FEntregas: TRESTEntregassController;
  sTipo, scodigo, sdataini, sdatafim: String;
begin
  try
    FEntregas := TRESTEntregassController.Create;
    stipo := Common.Params.paramTipoUsuario;
    MontaPeriodo(StrToInt(comboBoxAno.Text), comboBoxMeses.ItemIndex, StrToInt(Copy(comboBoxPeriodos.Text,0,1)));
    if sTipo = 'B' then
    begin
      scodigo := Common.Params.paramCodeDelivery.ToString;
    end
    else
    begin
      scodigo := Common.Params.paramCodigoEntregador.ToString;
    end;
    sdataini := FormatDateTime('yyyy-mm-dd', dtDataInicial);
    sdatafim := FormatDateTime('yyyy-mm-dd', dtDataFinal);
    if not FEntregas.SearchEntregas(stipo, scodigo,sdataini,sdatafim) then
    begin
      Application.MessageBox('Período não encontrado!', 'Atenção!', MB_OK + MB_ICONEXCLAMATION);
    end
    else
    begin

    end;
  finally
    FEntregas.Free;
  end;
end;

procedure Tview_AcompanhamntoEntregas.PopulaPeriodos;
var
  FPeriodos: TRESTPeriodosController;
  lLista: TStringList;
  i: Integer;
begin
  try
    FPeriodos := TRESTPeriodosController.Create;
    lLista := TStringList.Create;
    lLista := FPeriodos.RetornaPeriodos();
    for i := 0 to lLista.Count - 1 do
    begin
      comboBoxPeriodos.Properties.Items.Add(lLista[i]);
    end;
    comboBoxPeriodos.ItemIndex := 0;
  finally
    FPeriodos.Free;
  end;
end;

procedure Tview_AcompanhamntoEntregas.SetupAno;
var
  dtData: TDateTime;
  sAno: String;
  iMes: Integer;
begin
  dtData := IncDay(Now, -30);
  sAno := YearOf(dtData).ToString;
  iMes := MonthOf(dtData);
  comboBoxAno.Text := sAno;
  comboBoxMeses.ItemIndex := iMes;
end;

procedure Tview_AcompanhamntoEntregas.MontaPeriodo(iAno, iMes, iQuinzena: Integer);
var
  FPeriodos : TRESTPeriodosController;
  iDiaInicio, iDiaFinal, iMesData, iAnoData: Integer;
  sData: String;
  datData, datBase: TDate;

  lLista: TStringList;
begin
  try
    iAnoData := iAno;
    iMesData := iMes;
    iQuinzena := iQuinzena;
    FPeriodos := TRESTPeriodosController.Create;
    lLista := TStringList.Create;
    lLista := FPeriodos.RetornaDias(iQuinzena);
    if lLista.Count > 0 then
    begin
      iDiaInicio := StrToInt(lLista[0]);
      iDiaFinal := StrToInt(lLista[1]);
    end
    else
    begin
      if iQuinzena = 1 then
      begin
        iDiaInicio := 1;
        iDiaFinal := 15;
      end
      else
      begin
        iDiaInicio := 16;
        sData := '01/' + FormatFloat('00', iMes) + '/' + IntToStr(iAnoData);
        iDiaFinal := DaysInMonth(StrToDate(sData));
      end;
    end;
    if iDiaInicio > iDiaFinal then
    begin
      if iMes = 1 then
      begin
        iMesData := 12;
        iAnoData := iAnoData - 1;
        sData := FormatFloat('00', iDiaInicio) + '/' + FormatFloat('00', iMesData) + '/' + FormatFloat('0000', iAnoData);
      end
      else
      begin
        iMesData := iMes - 1;
        iAnoData := iAno;
        sData := FormatFloat('00', iDiaInicio) + '/' + FormatFloat('00', iMesData) + '/' + FormatFloat('0000', iAnoData);
      end;
      dtDataInicial := StrToDate(sData);
      iMesData := iMes;
      iAnoData := iAno;
      sData := FormatFloat('00', iDiaFinal) + '/' + FormatFloat('00', iMesData) + '/' + FormatFloat('0000', iAnoData);
      dtDataFinal := StrToDate(sData);
    end
    else
    begin
      iMesData := iMes;
      iAnoData := iAno;
      sData := FormatFloat('00', iDiaInicio) + '/' + FormatFloat('00', iMesData) + '/' + FormatFloat('0000', iAnoData);
      dtDataInicial := StrToDate(sData);
      iMesData := iMes;
      iAnoData := iAno;
      if iDiaFinal = 31 then
      begin
        iDiaFinal := DaysInMonth(StrToDate(sData));
      end;
      sData := FormatFloat('00', iDiaFinal) + '/' + FormatFloat('00', iMesData) + '/' + FormatFloat('0000', iAnoData);
      dtDataFinal := StrToDate(sData);
    end;
  finally
    FPeriodos.Free;
  end;
end;


end.
