unit uAbastecimento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Grids, System.UITypes;

type
  TfAbastecimento = class(TForm)
    pnPrincipal: TPanel;
    btAtendimento: TButton;
    sgDadosBombas: TStringGrid;
    edValorParaAbastecimento: TEdit;
    cbCondicaoPagamento: TComboBox;
    lbValorAbastecimento: TLabel;
    Label1: TLabel;
    btConcluirAbastecimento: TButton;
    lbQtdeLitrosAbastecimento: TLabel;
    edQtdeLitrosAbastecimento: TEdit;
    Panel1: TPanel;
    btFecharTela: TButton;
    pnRodape: TPanel;
    procedure btAtendimentoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btConcluirAbastecimentoClick(Sender: TObject);
    procedure edValorParaAbastecimentoChange(Sender: TObject);
    procedure sgDadosBombasClick(Sender: TObject);
    procedure edValorParaAbastecimentoKeyPress(Sender: TObject; var Key: Char);
    procedure btFecharTelaClick(Sender: TObject);
  private
    FVlr_Litro_Gasolina: Double;
    FVlr_Litro_Diesel: Double;
    FPerc_Imposto: Double;
    FValor_Litro: Double;
    FBomba_Selecionada: Boolean;
    FComposicaoCompleta: Boolean;

    procedure ValidarCampos;
    procedure CalcularAbastecimento(vlr_pagamento: string);
    procedure ExibirBombasAbastecimento;
    procedure CarregarDadosAbastecimento;
    procedure InicializacaoAbastecimento(iniciar_abastecimento: Boolean);
  public
  end;

var
  fAbastecimento: TfAbastecimento;

implementation

uses BombaController, uConfiguracoes, AbastecimentoModel,
  AbastecimentoController, ComposicaoController;

const
  cSelecao      = 0;
  cCodigoBomba  = 1;
  cNomeBomba    = 2;
  cCodigoTanque = 3;
  cNomeTanque   = 4;

{$R *.dfm}

procedure TfAbastecimento.btAtendimentoClick(Sender: TObject);
begin
  if not FComposicaoCompleta then begin  
    ShowMessage(
      'Obrigatória configuração completa da composição dos valores!' + #13#10 + #13#10 +
      'Não será possível iniciar o abastecimento antes de definir a composição!'
    ); 
    Exit;
  end;

  if btAtendimento.Caption = 'INICIAR ABASTECIMENTO' then
    InicializacaoAbastecimento(True)
  else
    InicializacaoAbastecimento(False);
end;

procedure TfAbastecimento.btConcluirAbastecimentoClick(Sender: TObject);
var
  retornoAbastecimento: string;
  AbastecimentoController: TAbastecimentoController;
  AbastecimentoModel: TAbastecimentoModel;
begin
  inherited;
  ValidarCampos;

  try
    AbastecimentoModel := TAbastecimentoModel.Create;

    AbastecimentoModel.Qtde_Litros := StrToFloat(edQtdeLitrosAbastecimento.Text);
    AbastecimentoModel.Vlr_Abastecimento := StrToFloat(edValorParaAbastecimento.Text);
    AbastecimentoModel.Vlr_Imposto := ((AbastecimentoModel.Vlr_Abastecimento * FPerc_Imposto) / 100);
    AbastecimentoModel.Codigo_Bomba := StrToInt(sgDadosBombas.Cells[cCodigoBomba, sgDadosBombas.Row]);
    AbastecimentoModel.Forma_Pagamento := cbCondicaoPagamento.Text;

    AbastecimentoController := TAbastecimentoController.Create;
    retornoAbastecimento := AbastecimentoController.Registrar(AbastecimentoModel);

    if retornoAbastecimento <> '' then begin
      ShowMessage(retornoAbastecimento);
      InicializacaoAbastecimento(False);
    end
    else
      Close;
  finally
    FreeAndNil(AbastecimentoController);
    FreeAndNil(AbastecimentoModel);
  end;
end;

procedure TfAbastecimento.btFecharTelaClick(Sender: TObject);
begin
  Close;
end;

procedure TfAbastecimento.CalcularAbastecimento(vlr_pagamento: string);
var
  vlr_pagamento_formatado: string;
begin
  ValidarCampos;

  vlr_pagamento_formatado := FormatFloat('0.##', StrToFloat(vlr_pagamento));
  edQtdeLitrosAbastecimento.Text := FormatFloat('0.##', (StrToFloat(vlr_pagamento_formatado) / FValor_Litro));
end;

procedure TfAbastecimento.CarregarDadosAbastecimento;
var
  retorno: TRetornoComposicao;
  ComposicaoController: TComposicaoController;
begin
  try
    ComposicaoController := TComposicaoController.Create;

    retorno.xCodigo := 0;
    retorno := ComposicaoController.RetornarDadosComposicao;

    if retorno.xCodigo > 0 then begin
      FVlr_Litro_Gasolina := retorno.xVlrLitroGasolina;
      FVlr_Litro_Diesel := retorno.xVlrLitroDiesel;
      FPerc_Imposto := retorno.xPercImposto;
      FComposicaoCompleta := True;
    end;

    if (retorno.xCodigo = 0) or (FVlr_Litro_Gasolina = 0) or
      (FVlr_Litro_Diesel = 0) or (FPerc_Imposto = 0)
    then begin
      FComposicaoCompleta := False;
      raise Exception.Create('Obrigatória configuração completa da composição dos valores!');
    end;
  finally
    FreeAndNil(ComposicaoController);
  end;
end;

procedure TfAbastecimento.edValorParaAbastecimentoChange(Sender: TObject);
begin
  if edValorParaAbastecimento.Text <> '' then
    CalcularAbastecimento(edValorParaAbastecimento.Text);
end;

procedure TfAbastecimento.edValorParaAbastecimentoKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (CharInSet(Key, ['0'..'9', ',', #8])) then
    key := #0;
end;

procedure TfAbastecimento.ExibirBombasAbastecimento;
var
  i, j, linha: Integer;
  BombaController: TBombaController;
  vetBombasAux: array of vetDadosBombas;
begin
  try
    BombaController := TBombaController.Create;

    SetLength(vetBombasAux, Length(vetBombasAux) + 1);
    vetBombasAux[High(vetBombasAux)] := BombaController.RetornarDadosBomba('', '');

    with sgDadosBombas do begin
      linha := FixedRows;

      if Cells[cCodigoBomba, linha] <> '' then begin
        for linha := FixedRows to RowCount - 1 do begin
          Cells[cCodigoBomba, linha] := '';
          Cells[cNomeBomba, linha] := '';
          Cells[cCodigoTanque, linha] := '';
          Cells[cNomeTanque, linha] := '';
        end;

        RowCount := 2;
        linha := FixedRows;
      end;

      for i := Low(vetBombasAux) to High(vetBombasAux) do begin
        for j := Low(vetBombasAux[i]) to High(vetBombasAux[i]) do begin
          Cells[cCodigoBomba, linha] := IntToStr(vetBombasAux[i][j].xCodigo);
          Cells[cNomeBomba, linha] := vetBombasAux[i][j].xNome;
          Cells[cCodigoTanque, linha] := IntToStr(vetBombasAux[i][j].xCodigoTanque);
          Cells[cNomeTanque, linha] := vetBombasAux[i][j].xNomeTanque;

          Inc(linha);
        end;
      end;

      if linha > RowCount then
        RowCount := linha;
    end;
  finally
    FreeAndNil(BombaController);
  end;
end;

procedure TfAbastecimento.FormCreate(Sender: TObject);
begin
  sgDadosBombas.Cells[cSelecao, sgDadosBombas.FixedCols] := 'Bomba Selecionada';
  sgDadosBombas.Cells[cCodigoBomba, sgDadosBombas.FixedCols] := 'Código';
  sgDadosBombas.Cells[cNomeBomba, sgDadosBombas.FixedCols] := 'Nome';
  sgDadosBombas.Cells[cCodigoTanque, sgDadosBombas.FixedCols] := 'Código Tanque';
  sgDadosBombas.Cells[cNomeTanque, sgDadosBombas.FixedCols] := 'Nome Tanque';

  sgDadosBombas.ColWidths[cSelecao] := 100;
  sgDadosBombas.ColWidths[cCodigoBomba] := 100;
  sgDadosBombas.ColWidths[cNomeBomba] := 250;
  sgDadosBombas.ColWidths[cCodigoTanque] := 100;
  sgDadosBombas.ColWidths[cNomeTanque] := 250;

  ExibirBombasAbastecimento;
  CarregarDadosAbastecimento
end;

procedure TfAbastecimento.InicializacaoAbastecimento(iniciar_abastecimento: Boolean);
begin
  if iniciar_abastecimento then begin
    btAtendimento.Caption := 'CANCELAR ABASTECIMENTO';
    pnPrincipal.Enabled := iniciar_abastecimento;
    sgDadosBombas.Enabled := True;
    FBomba_Selecionada := False;
  end
  else if MessageDlg('Deseja iniciar um novo abastecimento?', mtConfirmation, [mbYes, mbNo],0) = mrYes then begin
    btAtendimento.Caption := 'INICIAR ABASTECIMENTO';
    pnPrincipal.Enabled := iniciar_abastecimento;

    edValorParaAbastecimento.Text := '';
    edQtdeLitrosAbastecimento.Text := '';
    cbCondicaoPagamento.ItemIndex := 0;

    if FBomba_Selecionada then
      sgDadosBombas.Cells[cSelecao, sgDadosBombas.Row] := '';
  end
  else
    Close;
end;

procedure TfAbastecimento.sgDadosBombasClick(Sender: TObject);
begin
  if MessageDlg('Confirma a seleção da bomba: ' + sgDadosBombas.Cells[cNomeBomba, sgDadosBombas.Row], mtConfirmation, [mbYes, mbNo],0) = mrYes then begin
    FBomba_Selecionada := True;
    sgDadosBombas.Enabled := False;
    sgDadosBombas.Cells[cSelecao, sgDadosBombas.Row] := 'X';

    if sgDadosBombas.Cells[cNomeTanque, sgDadosBombas.Row] = 'Gasolina' then
      FValor_Litro := FVlr_Litro_Gasolina
    else
      FValor_Litro := FVlr_Litro_Diesel;
  end;
end;

procedure TfAbastecimento.ValidarCampos;
begin
  if not FBomba_Selecionada then begin
    ShowMessage(
      'Nenhum bomba selecionada! ' + #13#10 + #13#10 +
      'Obrigatória seleção antes de iniciar o abastecimento!'
    );
    edValorParaAbastecimento.Clear;
    Abort;
  end;

  if (edValorParaAbastecimento.Text = '') or (StrToFloat(edValorParaAbastecimento.Text) = 0) then begin
    ShowMessage('É necessário informar o valor de abastecimento!');
    edValorParaAbastecimento.Clear;
    edValorParaAbastecimento.SetFocus;
    Abort;
  end;
end;

end.
