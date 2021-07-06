unit uInicializacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TfInicializacao = class(TForm)
    lbTitulo: TLabel;
  private
  public
  end;

var
  fInicializacao: TfInicializacao;

implementation

{$R *.dfm}

end.
