unit uCadBomba;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uBase, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.StdCtrls, StrUtils, System.UITypes;

type
  TfCadBomba = class(TfBase)
    lbCodigo: TLabel;
    edCodigo: TEdit;
    lbNome: TLabel;
    edNome: TEdit;
    lbCodigoTanque: TLabel;
    edCodigoTanque: TEdit;
    lbNomeTanque: TLabel;
    edNomeTanque: TEdit;
    procedure sbGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edCodigoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure sbCancelarClick(Sender: TObject);
    procedure sbExcluirClick(Sender: TObject);
    procedure sbPesquisarClick(Sender: TObject);
    procedure edCodigoTanqueKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edCodigoTanqueExit(Sender: TObject);
  private
    procedure AtivarDesativarCampos(inserir_editar: Boolean);
  public
    procedure VerificaDados; Override;
  end;

var
  fCadBomba: TfCadBomba;

implementation

{$R *.dfm}

uses BombaController, BombaModel, uPesquisarBombas, TanqueController,
  uConfiguracoes;

procedure TfCadBomba.AtivarDesativarCampos(inserir_editar: Boolean);
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
  edCodigoTanque.Enabled := inserir_editar;

  if inserir_editar then
    edNome.SetFocus
  else begin
    edCodigo.Clear;
    edNome.Clear;
    edCodigoTanque.Clear;
    edNomeTanque.Clear;
  end;
end;

procedure TfCadBomba.edCodigoKeyDown(Sender: TObject; var Key: Word;
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

procedure TfCadBomba.edCodigoTanqueExit(Sender: TObject);
var
  TanqueController: TTanqueController;
begin
  inherited;
  edCodigoTanque.Text := Trim(edCodigoTanque.Text);
  if edCodigoTanque.Text <> '' then begin
    try
      TanqueController := TTanqueController.Create;
      edNomeTanque.Text := TanqueController.RetornarNomeTanque(StrToInt(edCodigoTanque.Text));
    finally
      FreeAndNil(TanqueController);
    end;
  end;
end;

procedure TfCadBomba.edCodigoTanqueKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  TanqueController: TTanqueController;
begin
  inherited;
  if key = VK_RETURN then begin
    edCodigoTanque.Text := Trim(edCodigoTanque.Text);
    if edCodigoTanque.Text <> '' then begin
      try
        TanqueController := TTanqueController.Create;
        edNomeTanque.Text := TanqueController.RetornarNomeTanque(StrToInt(edCodigoTanque.Text));
      finally
        FreeAndNil(TanqueController);
      end;
    end
  end;
end;

procedure TfCadBomba.FormShow(Sender: TObject);
begin
  inherited;
  edCodigo.SetFocus;
end;

procedure TfCadBomba.sbCancelarClick(Sender: TObject);
begin
  inherited;
  if MessageDlg('Deseja cancelar a edição do registro?', mtConfirmation, [mbYes, mbNo],0) = mrYes then begin
    AtivarDesativarCampos(False);
    edCodigo.SetFocus;
  end;
end;

procedure TfCadBomba.sbExcluirClick(Sender: TObject);
var
  BombaController: TBombaController;
  BombaModel: TBombaModel;
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
    BombaModel := TBombaModel.Create;
    BombaModel.Codigo := StrToInt(edCodigo.Text);

    BombaController := TBombaController.Create;
    BombaController.Excluir(BombaModel);

    AtivarDesativarCampos(False);
  finally
    FreeAndNil(BombaController);
    FreeAndNil(BombaModel);
  end;
end;

procedure TfCadBomba.sbGravarClick(Sender: TObject);
var
  BombaController: TBombaController;
  BombaModel: TBombaModel;
  TipoRegistro: TTipoRegistro;
begin
  inherited;
  try
    BombaModel := TBombaModel.Create;

    if edCodigo.Text <> '' then begin
      TipoRegistro := Atualizar;
      BombaModel.Codigo := StrToInt(edCodigo.Text);
    end
    else
      TipoRegistro := Inserir;

    BombaModel.Nome := edNome.Text;
    BombaModel.CodigoTanque := StrToInt(edCodigoTanque.Text);
    BombaModel.NomeTanque := edNomeTanque.Text;

    BombaController := TBombaController.Create;
    BombaController.Registrar(BombaModel, TipoRegistro);

    AtivarDesativarCampos(False);
  finally
    FreeAndNil(BombaController);
    FreeAndNil(BombaModel);
  end;
end;

procedure TfCadBomba.sbPesquisarClick(Sender: TObject);
var
  retorno: TRetornoBombas;
begin
  inherited;
  retorno.xcodigo := 0;
  retorno := uPesquisarBombas.PesquisaBombas;

  if retorno.xcodigo > 0 then begin
    edCodigo.Text := IntToStr(retorno.xCodigo);
    edNome.Text := retorno.xNome;
    edCodigoTanque.Text := IntToStr(retorno.xCodigoTanque);
    edNomeTanque.Text := retorno.xNomeTanque;
    AtivarDesativarCampos(True);
  end;
end;

procedure TfCadBomba.VerificaDados;
begin
  inherited;
  edNome.Text := Trim(edNome.Text);
  if edNome.Text = '' then begin
    ShowMessage('É necessário informar o nome do bomba!');
    edNome.Clear;
    edNome.SetFocus;
    Abort;
  end;

  edCodigoTanque.Text := Trim(edCodigoTanque.Text);
  edNomeTanque.Text := Trim(edNomeTanque.Text);
  if (edCodigoTanque.Text = '') or (edNomeTanque.Text = '') then begin
    ShowMessage('É necessário vincular ao tanque!');
    edCodigoTanque.Clear;
    edCodigoTanque.SetFocus;
    Abort;
  end;
end;

end.
