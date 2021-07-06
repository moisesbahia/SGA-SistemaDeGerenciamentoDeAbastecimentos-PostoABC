unit uBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons;

type
  TfBase = class(TForm)
    pBotoesPadrao: TPanel;
    sbGravar: TSpeedButton;
    sbCancelar: TSpeedButton;
    sbExcluir: TSpeedButton;
    sbPesquisar: TSpeedButton;
    sbFechar: TSpeedButton;
    procedure sbFecharClick(Sender: TObject);
    procedure sbGravarClick(Sender: TObject);
    procedure VerificaDados; Virtual;
  private
  public
  end;

var
  fBase: TfBase;

implementation

{$R *.dfm}

procedure TfBase.sbFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfBase.sbGravarClick(Sender: TObject);
begin
  VerificaDados;
end;

procedure TfBase.VerificaDados;
begin
  //
end;

end.
