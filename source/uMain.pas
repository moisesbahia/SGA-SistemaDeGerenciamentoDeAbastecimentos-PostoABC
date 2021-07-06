unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, System.Actions, Vcl.ActnList,
  System.ImageList, Vcl.ImgList, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  dxGDIPlusClasses;

type
  TfMain = class(TForm)
    Panel2: TPanel;
    Panel3: TPanel;
    PanelWorkArea: TPanel;
    btAbastecimento: TButton;
    btRelatórioGerencial: TButton;
    ActionList1: TActionList;
    ImageList1: TImageList;
    ActionAbastecimento: TAction;
    ActionRelGerencial: TAction;
    btCadComposicao: TButton;
    btCadTanque: TButton;
    ActionCadComposição: TAction;
    Panel4: TPanel;
    lbTitulo: TLabel;
    Timer1: TTimer;
    Panel1: TPanel;
    lbDataHora: TLabel;
    btCadBomba: TButton;
    ActionCadTanque: TAction;
    ActionCadBomba: TAction;
    procedure Timer1Timer(Sender: TObject);
    procedure ActionCadTanqueExecute(Sender: TObject);
    procedure ActionCadBombaExecute(Sender: TObject);
    procedure ActionCadComposiçãoExecute(Sender: TObject);
    procedure ActionAbastecimentoExecute(Sender: TObject);
    procedure ActionRelGerencialExecute(Sender: TObject);
  private
    FFormActive: TForm;
    procedure LoadForm(AClass: TFormClass);
  public
  end;

var
  fMain: TfMain;

implementation

{$R *.dfm}

uses
  uCadTanque, uCadBomba, uCadComposicao, uAbastecimento, uRelatorio;

procedure TfMain.ActionAbastecimentoExecute(Sender: TObject);
begin
  Self.LoadForm(TfAbastecimento);
end;

procedure TfMain.ActionCadBombaExecute(Sender: TObject);
begin
  Self.LoadForm(TfCadBomba);
end;

procedure TfMain.ActionCadComposiçãoExecute(Sender: TObject);
begin
  Self.LoadForm(TfCadComposicao);
end;

procedure TfMain.ActionCadTanqueExecute(Sender: TObject);
begin
  Self.LoadForm(TfCadTanque);
end;

procedure TfMain.ActionRelGerencialExecute(Sender: TObject);
begin
  fRelatorio.RLReport1.Preview();
end;

procedure TfMain.LoadForm(AClass: TFormClass);
begin
  if Assigned(Self.FFormActive) then
  begin
    Self.FFormActive.Close;
    Self.FFormActive.Free;
    Self.FFormActive := nil;
  end;

  Self.FFormActive             := AClass.Create(nil);
  Self.FFormActive.Parent      := Self.PanelWorkArea;
  Self.FFormActive.BorderStyle := TFormBorderStyle.bsNone;

  Self.FFormActive.Top   := 0;
  Self.FFormActive.Left  := 0;
  Self.FFormActive.Align := TAlign.alClient;

  Self.FFormActive.Show;
end;

procedure TfMain.Timer1Timer(Sender: TObject);
begin
  lbDataHora.Caption := DateTimeToStr(Now);
end;

end.
