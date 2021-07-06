unit uPesquisarTanques;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Data.DB, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  TanqueController, StrUtils;

type
  TfPesquisarTanques = class(TForm)
    sgDadosTanques: TStringGrid;
    lbFiltro: TLabel;
    eChavePesquisa: TEdit;
    lbChavePesquisa: TLabel;
    cbFiltros: TComboBox;
    sbSelecionar: TSpeedButton;
    sbCancelar: TSpeedButton;
    pnBotoes: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure sgDadosTanquesDblClick(Sender: TObject);
    procedure sbCancelarClick(Sender: TObject);
    procedure eChavePesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure sgDadosTanquesEnter(Sender: TObject);
    procedure sbSelecionarClick(Sender: TObject);
  private
  end;
    function PesquisaTanques: TRetornoTanques;

implementation

uses uConexao;

const
  cCodigoTanque    = 0;
  cNomeTanque      = 1;
  cTipoCombustivel = 2;

{$R *.dfm}

procedure TfPesquisarTanques.eChavePesquisaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = VK_RETURN then
    sgDadosTanques.SetFocus
  else if key = VK_ESCAPE then
    ModalResult := mrCancel;
end;

procedure TfPesquisarTanques.FormCreate(Sender: TObject);
begin
  sgDadosTanques.Cells[cCodigoTanque, sgDadosTanques.FixedCols] := 'Código';
  sgDadosTanques.Cells[cNomeTanque, sgDadosTanques.FixedCols] := 'Nome';
  sgDadosTanques.Cells[cTipoCombustivel, sgDadosTanques.FixedCols] := 'Tipo Combustível';

  sgDadosTanques.ColWidths[cCodigoTanque] := 70;
  sgDadosTanques.ColWidths[cNomeTanque] := 200;
  sgDadosTanques.ColWidths[cTipoCombustivel] := 160;
end;

function PesquisaTanques: TRetornoTanques;
var
  form: TfPesquisarTanques;
begin
  form := TfPesquisarTanques.Create(Application);
  form.ShowModal;

  if form.ModalResult = mrOk then begin
    Result.xCodigo := StrToInt(form.sgDadosTanques.Cells[cCodigoTanque, form.sgDadosTanques.Row]);
    Result.xNome := form.sgDadosTanques.Cells[cNomeTanque, form.sgDadosTanques.Row];
    Result.xTipoCombustivel := form.sgDadosTanques.Cells[cTipoCombustivel, form.sgDadosTanques.Row];
  end;
end;

procedure TfPesquisarTanques.sbCancelarClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfPesquisarTanques.sbSelecionarClick(Sender: TObject);
begin
  if sgDadosTanques.Cells[cCodigoTanque, sgDadosTanques.FixedRows] <> '' then
    ModalResult := mrOk
  else begin
    ShowMessage('Nenhum dado foi selecionado!');
    eChavePesquisa.SetFocus;
  end;
end;

procedure TfPesquisarTanques.sgDadosTanquesDblClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TfPesquisarTanques.sgDadosTanquesEnter(Sender: TObject);
var
  i, j, linha: Integer;
  TanqueController: TTanqueController;
  vetTanquesAux: array of vetDadosTanques;
  chave_pesquisa, campo_pesquisa: string;
begin
  chave_pesquisa := Trim(eChavePesquisa.Text);
  if cbFiltros.ItemIndex = 0 then
    campo_pesquisa := 'NOME'
  else
    campo_pesquisa := 'TIPO';

  TanqueController := TTanqueController.Create;

  SetLength(vetTanquesAux, Length(vetTanquesAux) + 1);
  vetTanquesAux[High(vetTanquesAux)] := TanqueController.RetornarDadosTanque(campo_pesquisa, chave_pesquisa);

  with sgDadosTanques do begin
    linha := FixedRows;

    if Cells[cCodigoTanque, linha] <> '' then begin
      for linha := FixedRows to RowCount - 1 do begin
        Cells[cCodigoTanque, linha] := '';
        Cells[cNomeTanque, linha] := '';
        Cells[cTipoCombustivel, linha] := '';
      end;

      RowCount := 2;
      linha := FixedRows;
    end;

    for i := Low(vetTanquesAux) to High(vetTanquesAux) do begin
      for j := Low(vetTanquesAux[i]) to High(vetTanquesAux[i]) do begin
        Cells[cCodigoTanque, linha] := IntToStr(vetTanquesAux[i][j].xCodigo);
        Cells[cNomeTanque, linha] := vetTanquesAux[i][j].xNome;
        Cells[cTipoCombustivel, linha] := ifThen(vetTanquesAux[i][j].xTipoCombustivel = 'G', 'Gasolina', 'Óleo Diesel');

        Inc(linha);
      end;
    end;

    if linha > RowCount then
      RowCount := linha;
  end;
end;

end.
