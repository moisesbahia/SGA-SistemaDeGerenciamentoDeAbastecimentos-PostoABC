unit uCadTanque;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uBase, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.StdCtrls, StrUtils, System.UITypes;

type
  TfCadTanque = class(TfBase)
    lbCodigo: TLabel;
    edCodigo: TEdit;
    lbNome: TLabel;
    edNome: TEdit;
    rgTipoCombustivel: TRadioGroup;
    procedure sbGravarClick(Sender: TObject);
    procedure sbCancelarClick(Sender: TObject);
    procedure edCodigoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure sbPesquisarClick(Sender: TObject);
    procedure sbExcluirClick(Sender: TObject);
  private
    procedure AtivarDesativarCampos(inserir_editar: Boolean);
  public
    procedure VerificaDados; Override;
  end;

var
  fCadTanque: TfCadTanque;

implementation

{$R *.dfm}

uses TanqueController, TanqueModel, uPesquisarTanques, uConfiguracoes;

procedure TfCadTanque.AtivarDesativarCampos(inserir_editar: Boolean);
var
  codigo: string;
begin
  codigo := Trim(edCodigo.Text);

  sbGravar.Enabled := inserir_editar;
  sbCancelar.Enabled := inserir_editar;
  sbPesquisar.Enabled := not inserir_editar;
  sbExcluir.Enabled := inserir_editar and (codigo <> '');

  edCodigo.Enabled := not inserir_editar;
  edNome.Enabled := inserir_editar;
  rgTipoCombustivel.Enabled := inserir_editar;

  if inserir_editar then
    edNome.SetFocus
  else begin
    edCodigo.Clear;
    edNome.Clear;
    rgTipoCombustivel.ItemIndex := 0;
  end;
end;

procedure TfCadTanque.edCodigoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if key = VK_RETURN then begin
    if Trim(edCodigo.Text) <> '' then begin
      ShowMessage('Para consultar o registro, clique em pesquisar!');
      edCodigo.Clear;
      edCodigo.SetFocus;
    end
    else
      AtivarDesativarCampos(True);
  end;
end;

procedure TfCadTanque.FormShow(Sender: TObject);
begin
  inherited;
  edCodigo.SetFocus;
end;

procedure TfCadTanque.sbCancelarClick(Sender: TObject);
begin
  inherited;
  if MessageDlg('Deseja cancelar a edição do registro?', mtConfirmation, [mbYes, mbNo],0) = mrYes then begin
    AtivarDesativarCampos(False);
    edCodigo.SetFocus;
  end;
end;

procedure TfCadTanque.sbExcluirClick(Sender: TObject);
var
  TanqueController: TTanqueController;
  TanqueModel: TTanqueModel;
begin
  inherited;

  if edCodigo.Text = '' then begin
    ShowMessage('Necessário selecionar um registro válido para exclusão!');
    Exit;
  end;

  if MessageDlg('Deseja realmente excluir o registro?', mtConfirmation, [mbYes, mbNo],0) = mrNo then begin
    edNome.SetFocus;
    Exit;
  end;

  try
    TanqueModel := TTanqueModel.Create;
    TanqueModel.Codigo := StrToInt(edCodigo.Text);

    TanqueController := TTanqueController.Create;
    TanqueController.Excluir(TanqueModel);

    AtivarDesativarCampos(False);
  finally
    FreeAndNil(TanqueController);
    FreeAndNil(TanqueModel);
  end;
end;

procedure TfCadTanque.sbGravarClick(Sender: TObject);
var
  TanqueController: TTanqueController;
  TanqueModel: TTanqueModel;
  TipoRegistro: TTipoRegistro;
begin
  inherited;
  try
    TanqueModel := TTanqueModel.Create;

    if edCodigo.Text <> '' then begin
      TipoRegistro := Atualizar;
      TanqueModel.Codigo := StrToInt(edCodigo.Text);
    end
    else
      TipoRegistro := Inserir;

    TanqueModel.Nome := edNome.Text;
    TanqueModel.TipoCombustivel := ifThen(rgTipoCombustivel.ItemIndex = 0, 'G', 'D');

    TanqueController := TTanqueController.Create;
    TanqueController.Registrar(TanqueModel, TipoRegistro);

    AtivarDesativarCampos(False);
  finally
    FreeAndNil(TanqueController);
    FreeAndNil(TanqueModel);
  end;
end;

procedure TfCadTanque.sbPesquisarClick(Sender: TObject);
var
  retorno: TRetornoTanques;
begin
  inherited;
  retorno.xcodigo := 0;
  retorno := uPesquisarTanques.PesquisaTanques;

  if retorno.xcodigo > 0 then begin
    edCodigo.Text := IntToStr(retorno.xCodigo);
    edNome.Text := retorno.xNome;
    rgTipoCombustivel.ItemIndex := StrToInt(ifThen(retorno.xTipoCombustivel = 'G', '0', '1'));
    AtivarDesativarCampos(True);
  end;
end;

procedure TfCadTanque.VerificaDados;
begin
  inherited;
  edNome.Text := Trim(edNome.Text);
  if edNome.Text = '' then begin
    ShowMessage('É necessário informar o nome do tanque!');
    edNome.Clear;
    edNome.SetFocus;
    Abort;
  end;

  if rgTipoCombustivel.ItemIndex < 0 then begin
    ShowMessage('É necessário informar o tipo de combustível!');
    Abort;
  end;
end;

end.
