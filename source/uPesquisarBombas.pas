unit uPesquisarBombas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Data.DB, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  BombaController, StrUtils;

type
  TfPesquisarBombas = class(TForm)
    sgDadosBombas: TStringGrid;
    lbFiltro: TLabel;
    eChavePesquisa: TEdit;
    lbChavePesquisa: TLabel;
    cbFiltros: TComboBox;
    sbSelecionar: TSpeedButton;
    sbCancelar: TSpeedButton;
    pnBotoes: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure sgDadosBombasDblClick(Sender: TObject);
    procedure sbCancelarClick(Sender: TObject);
    procedure eChavePesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure sgDadosBombasEnter(Sender: TObject);
    procedure sbSelecionarClick(Sender: TObject);
  private
  end;
    function PesquisaBombas: TRetornoBombas;

implementation

uses uConexao;

const
  cCodigoBomba  = 0;
  cNomeBomba    = 1;
  cCodigoTanque = 2;
  cNomeTanque   = 3;

{$R *.dfm}

procedure TfPesquisarBombas.eChavePesquisaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = VK_RETURN then
    sgDadosBombas.SetFocus
  else if key = VK_ESCAPE then
    ModalResult := mrCancel;
end;

procedure TfPesquisarBombas.FormCreate(Sender: TObject);
begin
  sgDadosBombas.Cells[cCodigoBomba, sgDadosBombas.FixedCols] := 'Código';
  sgDadosBombas.Cells[cNomeBomba, sgDadosBombas.FixedCols] := 'Nome';
  sgDadosBombas.Cells[cCodigoTanque, sgDadosBombas.FixedCols] := 'Código Tanque';
  sgDadosBombas.Cells[cNomeTanque, sgDadosBombas.FixedCols] := 'Nome Tanque';

  sgDadosBombas.ColWidths[cCodigoBomba] := 70;
  sgDadosBombas.ColWidths[cNomeBomba] := 200;
  sgDadosBombas.ColWidths[cCodigoTanque] := 80;
  sgDadosBombas.ColWidths[cNomeTanque] := 200;
end;

function PesquisaBombas: TRetornoBombas;
var
  form: TfPesquisarBombas;
begin
  form := TfPesquisarBombas.Create(Application);
  form.ShowModal;

  if form.ModalResult = mrOk then begin
    Result.xCodigo := StrToInt(form.sgDadosBombas.Cells[cCodigoBomba, form.sgDadosBombas.Row]);
    Result.xNome := form.sgDadosBombas.Cells[cNomeBomba, form.sgDadosBombas.Row];
    Result.xCodigoTanque := StrToInt(form.sgDadosBombas.Cells[cCodigoTanque, form.sgDadosBombas.Row]);
    Result.xNomeTanque := form.sgDadosBombas.Cells[cNomeTanque, form.sgDadosBombas.Row];
  end;
end;

procedure TfPesquisarBombas.sbCancelarClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfPesquisarBombas.sbSelecionarClick(Sender: TObject);
begin
  if sgDadosBombas.Cells[cCodigoBomba, sgDadosBombas.FixedRows] <> '' then
    ModalResult := mrOk
  else begin
    ShowMessage('Nenhum dado foi selecionado!');
    eChavePesquisa.SetFocus;
  end;
end;

procedure TfPesquisarBombas.sgDadosBombasDblClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TfPesquisarBombas.sgDadosBombasEnter(Sender: TObject);
var
  i, j, linha: Integer;
  BombaController: TBombaController;
  vetBombasAux: array of vetDadosBombas;
  chave_pesquisa, campo_pesquisa: string;
begin
  chave_pesquisa := Trim(eChavePesquisa.Text);
  if cbFiltros.ItemIndex = 0 then
    campo_pesquisa := 'NOME'
  else
    campo_pesquisa := 'CODIGO_TANQUE';

  try
    BombaController := TBombaController.Create;

    SetLength(vetBombasAux, Length(vetBombasAux) + 1);
    vetBombasAux[High(vetBombasAux)] := BombaController.RetornarDadosBomba(campo_pesquisa, chave_pesquisa);

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

end.
