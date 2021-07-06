unit uCadComposicao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uBase, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.StdCtrls, System.UITypes;

type
  TfCadComposicao = class(TfBase)
    lbCodigo: TLabel;
    edCodigo: TEdit;
    lbValorLitroGasolina: TLabel;
    edValorLitroGasolina: TEdit;
    lbValorDiesel: TLabel;
    edValorDiesel: TEdit;
    lbPercImposto: TLabel;
    edPercImposto: TEdit;
    procedure FormShow(Sender: TObject);
    procedure sbGravarClick(Sender: TObject);
    procedure edCodigoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormatoPadraoCampoNumero(Sender: TObject; var Key: Char);
    procedure sbCancelarClick(Sender: TObject);
  private
    procedure AtivarDesativarCampos(inserir_editar: Boolean);
    procedure ExibirDados;
  public
    procedure VerificaDados; Override;
  end;

var
  fCadComposicao: TfCadComposicao;

implementation

{$R *.dfm}

uses ComposicaoController, uConfiguracoes, ComposicaoModel;

procedure TfCadComposicao.AtivarDesativarCampos(inserir_editar: Boolean);
var
  codigo: string;
begin
  codigo := Trim(edCodigo.Text);

  sbGravar.Enabled := inserir_editar;
  sbCancelar.Enabled := inserir_editar;
  sbPesquisar.Enabled := not inserir_editar;
  sbExcluir.Enabled := inserir_editar and (codigo <> '');

  edCodigo.Enabled := not inserir_editar;
  edValorLitroGasolina.Enabled := inserir_editar;
  edValorDiesel.Enabled := inserir_editar;
  edPercImposto.Enabled := inserir_editar;

  if inserir_editar then
    edValorLitroGasolina.SetFocus
  else begin
    edCodigo.Clear;
    edValorLitroGasolina.Clear;
    edValorDiesel.Clear;
    edPercImposto.Clear;
  end;
end;

procedure TfCadComposicao.edCodigoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if key = VK_RETURN then begin
    if Trim(edCodigo.Text) <> '' then begin
      edCodigo.Clear;
      edCodigo.SetFocus;
    end
    else
      AtivarDesativarCampos(True);
  end;
end;

procedure TfCadComposicao.FormatoPadraoCampoNumero(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if not (CharInSet(Key, ['0'..'9', ',', #8])) then
    key := #0;
end;

procedure TfCadComposicao.ExibirDados;
var
  retorno: TRetornoComposicao;
  ComposicaoController: TComposicaoController;
begin
  inherited;
  try
    ComposicaoController := TComposicaoController.Create;

    retorno.xcodigo := 0;
    retorno := ComposicaoController.RetornarDadosComposicao;

    if retorno.xcodigo > 0 then begin
      edCodigo.Text := IntToStr(retorno.xCodigo);
      edValorLitroGasolina.Text := FloatToStr(retorno.xVlrLitroGasolina);
      edValorDiesel.Text := FloatToStr(retorno.xVlrLitroDiesel);
      edPercImposto.Text := FloatToStr(retorno.xPercImposto);

      AtivarDesativarCampos(True);
    end
    else
      edCodigo.SetFocus;
  finally
    FreeAndNil(ComposicaoController);
  end;
end;

procedure TfCadComposicao.FormShow(Sender: TObject);
begin
  inherited;
  ExibirDados;
end;

procedure TfCadComposicao.sbCancelarClick(Sender: TObject);
begin
  inherited;
  if MessageDlg('Deseja cancelar a edição do registro?', mtConfirmation, [mbYes, mbNo],0) = mrYes then begin
    AtivarDesativarCampos(False);
    ExibirDados;
  end;
end;

procedure TfCadComposicao.sbGravarClick(Sender: TObject);
var
  ComposicaoController: TComposicaoController;
  ComposicaoModel: TComposicaoModel;
  TipoRegistro: TTipoRegistro;
begin
  inherited;
  try
    ComposicaoModel := TComposicaoModel.Create;

    if edCodigo.Text <> '' then begin
      TipoRegistro := Atualizar;
      ComposicaoModel.Codigo := StrToInt(edCodigo.Text);
    end
    else
      TipoRegistro := Inserir;

    ComposicaoModel.Vlr_Litro_Gasolina := StrToFloat(edValorLitroGasolina.Text);
    ComposicaoModel.Vlr_Litro_Diesel := StrToFloat(edValorDiesel.Text);
    ComposicaoModel.Percentual_Imposto := StrToFloat(edPercImposto.Text);

    ComposicaoController := TComposicaoController.Create;
    ComposicaoController.Registrar(ComposicaoModel, TipoRegistro);

    AtivarDesativarCampos(False);
  finally
    FreeAndNil(ComposicaoController);
    FreeAndNil(ComposicaoModel);
  end;

  ExibirDados;
end;

procedure TfCadComposicao.VerificaDados;
begin
  inherited;

  if (edValorLitroGasolina.Text = '') or (StrToFloat(edValorLitroGasolina.Text) = 0) then begin
    ShowMessage('É necessário informar um valor válido do litro da gasolina!');
    edValorLitroGasolina.Clear;
    edValorLitroGasolina.SetFocus;
    Abort;
  end
  else
    edValorLitroGasolina.Text := FormatFloat('0.##', StrToFloat(edValorLitroGasolina.Text));

  if (edValorDiesel.Text = '') or (StrToFloat(edValorDiesel.Text) = 0) then begin
    ShowMessage('É necessário informar  um valor válido valor do litro do óleo diesel!');
    edValorDiesel.Clear;
    edValorDiesel.SetFocus;
    Abort;
  end
  else
    edValorDiesel.Text := FormatFloat('0.##', StrToFloat(edValorDiesel.Text));

  if (edPercImposto.Text = '') or (StrToFloat(edPercImposto.Text) = 0) then begin
    ShowMessage('É necessário informar o percentual de imposto!');
    edPercImposto.Clear;
    edPercImposto.SetFocus;
    Abort;
  end
  else
    edPercImposto.Text := FormatFloat('0.##', StrToFloat(edPercImposto.Text));
end;

end.
