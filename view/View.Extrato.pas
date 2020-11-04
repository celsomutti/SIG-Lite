unit View.Extrato;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsCore,
  dxSkinsDefaultPainters, cxClasses, dxLayoutContainer, dxLayoutControl, cxContainer, cxEdit, dxLayoutcxEditAdapters, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, System.Actions, Vcl.ActnList, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  dxDateRanges, cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData, cxGridLevel, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, Controller.RESTPeriodos, System.DateUtils,
  dxLayoutControlAdapters, Vcl.Menus, Vcl.StdCtrls, cxButtons, Controller.RESTPreviaExtrato, cxLabel, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Controller.RESTExtratos, Controller.RESTExtravios, Controller.RESTLancamentos;

type
  Tview_Extrato = class(TForm)
    layoutControlPadraoGroup_Root: TdxLayoutGroup;
    layoutControlPadrao: TdxLayoutControl;
    layoutGroupHeader: TdxLayoutGroup;
    comboBoxTipo: TcxComboBox;
    layoutItemComboBoxTipo: TdxLayoutItem;
    comboBoxAno: TcxComboBox;
    layoutItemComboBoxAno: TdxLayoutItem;
    comboBoxMeses: TcxComboBox;
    layoutItemComboBoxMeses: TdxLayoutItem;
    comboBoxPeriodos: TcxComboBox;
    layoutItemComboBoxPeriodos: TdxLayoutItem;
    SaveDialog: TSaveDialog;
    actionListEntregas: TActionList;
    actionPesquisar: TAction;
    actionExportar: TAction;
    actionFechar: TAction;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    cxGrid: TcxGrid;
    layoutItemGrid: TdxLayoutItem;
    buttonPesquisar: TcxButton;
    layoutItemButtonPesquisar: TdxLayoutItem;
    buttonExportar: TcxButton;
    layoutItemButtonExportar: TdxLayoutItem;
    buttonFechar: TcxButton;
    layoutItemButtonFechar: TdxLayoutItem;
    dxLayoutAutoCreatedGroup1: TdxLayoutAutoCreatedGroup;
    labelPeriodo: TcxLabel;
    layoutItemLabelPeriodo: TdxLayoutItem;
    dsGrid: TDataSource;
    fdMemTablePrevia: TFDMemTable;
    fdMemTablePreviacod_entregador: TIntegerField;
    fdMemTablePrevianom_entregador: TStringField;
    fdMemTablePreviaval_verba: TFloatField;
    fdMemTablePreviaqtd_entrega: TIntegerField;
    fdMemTablePreviaval_producao: TFloatField;
    cxGridDBTableView1cod_entregador: TcxGridDBColumn;
    cxGridDBTableView1nom_entregador: TcxGridDBColumn;
    cxGridDBTableView1val_verba: TcxGridDBColumn;
    cxGridDBTableView1qtd_entrega: TcxGridDBColumn;
    cxGridDBTableView1val_producao: TcxGridDBColumn;
    fdMemTablePreviaval_creditos: TFloatField;
    fdMemTablePreviaval_debitos: TFloatField;
    fdMemTablePreviaval_extravios: TFloatField;
    fdMemTablePreviaval_total: TFloatField;
    cxGridDBTableView1val_creditos: TcxGridDBColumn;
    cxGridDBTableView1val_debitos: TcxGridDBColumn;
    cxGridDBTableView1val_extravios: TcxGridDBColumn;
    cxGridDBTableView1val_total: TcxGridDBColumn;
    cxGridExtraviosDBTableView1: TcxGridDBTableView;
    cxGridExtraviosLevel1: TcxGridLevel;
    cxGridExtravios: TcxGrid;
    layoutItemGridExtravios: TdxLayoutItem;
    cxGridLancamentosDBTableView1: TcxGridDBTableView;
    cxGridLancamentosLevel1: TcxGridLevel;
    cxGridLancamentos: TcxGrid;
    layoutItemGridLancamentos: TdxLayoutItem;
    dsExtravios: TDataSource;
    dxLayoutAutoCreatedGroup2: TdxLayoutAutoCreatedGroup;
    dsLancamentos: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actionPesquisarExecute(Sender: TObject);
    procedure actionExportarExecute(Sender: TObject);
    procedure actionFecharExecute(Sender: TObject);
  private
    function ValidaPesquisa(): Boolean;
    procedure PopulaPeriodos;
    procedure MontaPeriodo(iAno, iMes, iQuinzena: Integer);
    procedure SetupAno();
    procedure PesquisaPreviaExtrato();
    procedure PesquisaExtrato();
    procedure PesquisaExtravios(sExtratos: String);
    procedure PesquisaLancamentos(sExtratos: String);
    procedure ExportarDados;
    function PopulaPreviaExtrato(): Boolean;
    function PopulaExtrato(): Boolean;
  public
    { Public declarations }
  end;

var
  view_Extrato: Tview_Extrato;
  dtDataInicial, dtDataFinal: TDateTime;
  sExtratos : String;

implementation

{$R *.dfm}

uses Common.Params, Common.Utils, dm.SIGLite;

{ Tview_Extrato }

procedure Tview_Extrato.actionExportarExecute(Sender: TObject);
begin
  ExportarDados;
end;

procedure Tview_Extrato.actionFecharExecute(Sender: TObject);
begin
  Close;
end;

procedure Tview_Extrato.actionPesquisarExecute(Sender: TObject);
begin
  if not ValidaPesquisa() then
  begin
    Exit;
  end;

  case comboBoxTipo.ItemIndex of
    1 : PesquisaPreviaExtrato;
    2 : PesquisaExtrato;
  else
    Exit;
  end;

end;

procedure Tview_Extrato.ExportarDados;
begin
  SaveDialog.Filter := '';
  SaveDialog.Filter := 'Excel (*.xls) |*.xls|XML (*.xml) |*.xml|Arquivo Texto (*.txt) |*.txt|Página Web (*.html)|*.html|Arquivo separado por virgulas (*.csv)|*.csv';
  SaveDialog.Title := 'Exportar Dados';
  SaveDialog.DefaultExt := 'xls';
  if SaveDialog.Execute then
  begin
    TUtils.ExportarDados(cxGrid, SaveDialog.FileName);
  end;
end;

procedure Tview_Extrato.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if dm_SIGLite.fdMemTableExtrato.Active then dm_SIGLite.fdMemTableExtrato.Close;
  Action := caFree;
  view_Extrato := nil;
end;

procedure Tview_Extrato.FormShow(Sender: TObject);
begin
  SetupAno;
  PopulaPeriodos;
  if Common.Params.paramTipoUsuario = 'B' then
  begin
    layoutItemButtonExportar.Visible := True;
  end
  else
  begin
    layoutItemButtonExportar.Visible := False;
  end;

end;

procedure Tview_Extrato.MontaPeriodo(iAno, iMes, iQuinzena: Integer);
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

procedure Tview_Extrato.PesquisaExtrato;
var
  FExtrato: TRESTExtratosController;
  sTipo, scodigo, sAno, sMes, sQuinzena: String;
begin
  try
    FExtrato := TRESTExtratosController.Create;
    if dm_SIGLite.memTableExtrato.Active then
    begin
      dm_SIGLite.memTableExtrato.Close;
    end;
    labelPeriodo.Caption := '';
    if fdMemTablePrevia.Active then fdMemTablePrevia.Close;
    fdMemTablePrevia.Open;
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
      sAno := comboBoxAno.Text;
      sMes := comboBoxMeses.ItemIndex.ToString;
      sQuinzena := Copy(comboBoxPeriodos.Text,1,1);
    if not FExtrato.SearchExtrato(stipo, scodigo,sAno, sMes, sQuinzena) then
    begin
      Application.MessageBox('Período não encontrado!', 'Atenção!', MB_OK + MB_ICONEXCLAMATION);
    end
    else
    begin
      labelPeriodo.Caption := 'Extrato do período de ' + FormatDateTime('dd/mm/yyyy', dtDataInicial) + ' a ' +
                              FormatDateTime('dd/mm/yyyy', dtDataFinal);
      if PopulaExtrato() then
      begin
        PesquisaExtravios(sExtratos);
        PesquisaLancamentos(sExtratos);
        cxGrid.SetFocus;
      end
      else
      begin
        dm_SIGLite.memTableExtrato.Close;
      end;
    end;
  finally
    FExtrato.Free;
  end;
end;

procedure Tview_Extrato.PesquisaExtravios(sExtratos: String);
var
  FExtravio: TRESTExtraviossController;
begin
  try
    FExtravio := TRESTExtraviossController.Create;
    cxGridExtraviosDBTableView1.ClearItems;
    if dm_SIGLite.memTableExtravios.Active then
    begin
      dm_SIGLite.memTableExtravios.Close;
    end;
    if not FExtravio.SearchExtraviosExtrato(sExtratos) then
    begin
      if dm_SIGLite.memTableExtravios.Active then
      begin
        dm_SIGLite.memTableExtravios.Close;
      end;
      cxGridExtraviosDBTableView1.ClearItems;
    end
    else
    begin
      cxGridExtraviosDBTableView1.DataController.CreateAllItems();
    end;
  finally
    FExtravio.Free;
  end;
end;

procedure Tview_Extrato.PesquisaLancamentos(sExtratos: String);
var
  FLancamento: TRESTLancamentosController;
begin
  try
    FLancamento := TRESTLancamentosController.Create;
    cxGridLancamentosDBTableView1.ClearItems;
    if dm_SIGLite.memTableLancamentos.Active then
    begin
      dm_SIGLite.memTableLancamentos.Close;
    end;
    if not FLancamento.SearchLancamentosExtrato(sExtratos) then
    begin
      if dm_SIGLite.memTableLancamentos.Active then
      begin
        dm_SIGLite.memTableLancamentos.Close;
      end;
      cxGridLancamentosDBTableView1.ClearItems;
    end
    else
    begin
      cxGridLancamentosDBTableView1.DataController.CreateAllItems();
    end;
  finally
    FLancamento.Free;
  end;
end;

procedure Tview_Extrato.PesquisaPreviaExtrato;
var
  FEntregas: TRESTPreviaExtratoController;
  sTipo, scodigo, sdataini, sdatafim: String;
begin
  try
    FEntregas := TRESTPreviaExtratoController.Create;
    if dm_SIGLite.fdMemTableExtrato.Active then
    begin
      dm_SIGLite.fdMemTableExtrato.Close;
    end;
    labelPeriodo.Caption := '';
    if fdMemTablePrevia.Active then fdMemTablePrevia.Close;
    fdMemTablePrevia.Open;
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
      labelPeriodo.Caption := 'Prévia do período de ' + FormatDateTime('dd/mm/yyyy', dtDataInicial) + ' a ' +
                              FormatDateTime('dd/mm/yyyy', dtDataFinal);
      if PopulaPreviaExtrato() then
      begin
        cxGrid.SetFocus;
      end
      else
      begin
        dm_SIGLite.fdMemTableExtrato.Close;
      end;
    end;
  finally
    FEntregas.Free;
  end;
end;

function Tview_Extrato.PopulaPreviaExtrato: Boolean;
begin
  Result := False;
  if fdMemTablePrevia.Active then fdMemTablePrevia.Close;
  fdMemTablePrevia.Open;
  dm_SIGLite.fdMemTableExtrato.First;
  while not dm_SIGLite.fdMemTableExtrato.Eof do
  begin
    fdMemTablePrevia.Insert;
    fdMemTablePreviacod_entregador.AsInteger := dm_SIGLite.fdMemTableExtrato.Fields[0].AsInteger;
    fdMemTablePrevianom_entregador.AsString := dm_SIGLite.fdMemTableExtrato.Fields[1].AsString;
    fdMemTablePreviaval_verba.AsFloat := StrToFloatDef(StringReplace(dm_SIGLite.fdMemTableExtrato.Fields[2].AsString,'.',',',[rfReplaceAll]), 0);
    fdMemTablePreviaqtd_entrega.AsInteger := dm_SIGLite.fdMemTableExtrato.Fields[3].AsInteger;
    fdMemTablePreviaval_producao.AsFloat := StrToFloatDef(StringReplace(dm_SIGLite.fdMemTableExtrato.Fields[4].AsString,'.',',',[rfReplaceAll]), 0);
    fdMemTablePrevia.Post;
    dm_SIGLite.fdMemTableExtrato.Next;
  end;
  Result := True;
end;

function Tview_Extrato.PopulaExtrato: Boolean;
begin
  Result := False;
  if fdMemTablePrevia.Active then fdMemTablePrevia.Close;
  fdMemTablePrevia.Open;
  dm_SIGLite.memTableExtrato.First;
  sExtratos := '';
  while not dm_SIGLite.memTableExtrato.Eof do
  begin
    fdMemTablePrevia.Insert;
    fdMemTablePreviacod_entregador.AsInteger := dm_SIGLite.memTableExtrato.Fields[7].AsInteger;
    fdMemTablePrevianom_entregador.AsString := dm_SIGLite.memTableExtrato.Fields[8].AsString;
    fdMemTablePreviaval_verba.AsFloat := StrToFloatDef(StringReplace(dm_SIGLite.memTableExtrato.Fields[10].AsString,'.',',',[rfReplaceAll]), 0);
    fdMemTablePreviaqtd_entrega.AsInteger := dm_SIGLite.memTableExtrato.Fields[14].AsInteger;
    fdMemTablePreviaval_producao.AsFloat := StrToFloatDef(StringReplace(dm_SIGLite.memTableExtrato.Fields[17].AsString,'.',',',[rfReplaceAll]), 0);
    fdMemTablePreviaval_creditos.AsFloat := StrToFloatDef(StringReplace(dm_SIGLite.memTableExtrato.Fields[18].AsString,'.',',',[rfReplaceAll]), 0);
    fdMemTablePreviaval_debitos.AsFloat := StrToFloatDef(StringReplace(dm_SIGLite.memTableExtrato.Fields[19].AsString,'.',',',[rfReplaceAll]), 0);
    fdMemTablePreviaval_extravios.AsFloat := StrToFloatDef(StringReplace(dm_SIGLite.memTableExtrato.Fields[20].AsString,'.',',',[rfReplaceAll]), 0);
    fdMemTablePreviaval_total.AsFloat := StrToFloatDef(StringReplace(dm_SIGLite.memTableExtrato.Fields[21].AsString,'.',',',[rfReplaceAll]), 0);
    fdMemTablePrevia.Post;
    if sExtratos <> '' then
    begin
      sExtratos := sExtratos + ',';
    end;
    sExtratos := sExtratos + QuotedStr(dm_SIGLite.memTableExtrato.Fields[9].AsString);
    dm_SIGLite.memTableExtrato.Next;
  end;
  Result := True;
end;

procedure Tview_Extrato.PopulaPeriodos;
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

procedure Tview_Extrato.SetupAno;
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

function Tview_Extrato.ValidaPesquisa: Boolean;
begin
  Result := False;
  if comboBoxTipo.ItemIndex <= 0 then
  begin
    Application.MessageBox('Selecione o tipo de extrato.','Atenção!', MB_OK + MB_ICONEXCLAMATION);
    comboBoxTipo.SetFocus;
    Exit;
  end;
  if comboBoxAno.ItemIndex <= 0 then
  begin
    Application.MessageBox('Selecione o ano.','Atenção!', MB_OK + MB_ICONEXCLAMATION);
    comboBoxAno.SetFocus;
    Exit;
  end;
  if comboBoxMeses.ItemIndex <= 0 then
  begin
    Application.MessageBox('Selecione o mês.','Atenção!', MB_OK + MB_ICONEXCLAMATION);
    comboBoxMeses.SetFocus;
    Exit;
  end;
  if comboBoxPeriodos.ItemIndex <= 0 then
  begin
    Application.MessageBox('Selecione o período.','Atenção!', MB_OK + MB_ICONEXCLAMATION);
    comboBoxPeriodos.SetFocus;
    Exit;
  end;
  if comboBoxTipo.ItemIndex = 2 then
  begin
    cxGridDBTableView1val_creditos.Visible := True;
    cxGridDBTableView1val_debitos.Visible := True;
    cxGridDBTableView1val_extravios.Visible := True;
    cxGridDBTableView1val_total.Visible := True;
    layoutItemGridExtravios.Visible := True;
    layoutItemGridLancamentos.Visible := True;
  end
  else
  begin
    cxGridDBTableView1val_creditos.Visible := False;
    cxGridDBTableView1val_debitos.Visible := False;
    cxGridDBTableView1val_extravios.Visible := False;
    cxGridDBTableView1val_total.Visible := False;
    layoutItemGridExtravios.Visible := False;
    layoutItemGridLancamentos.Visible := False;
  end;
  Result := True;
end;

end.
