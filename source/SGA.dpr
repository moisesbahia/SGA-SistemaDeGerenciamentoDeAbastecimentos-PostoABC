program SGA;

uses
  Vcl.Forms,
  SysUtils,
  uMain in 'uMain.pas' {fMain},
  uConexao in 'uConexao.pas' {dmConexao: TDataModule},
  uConfiguracoes in 'uConfiguracoes.pas',
  uInicializacao in 'uInicializacao.pas' {fInicializacao},
  TanqueModel in 'Model\TanqueModel.pas',
  TanqueController in 'Controller\TanqueController.pas',
  uBase in 'uBase.pas' {fBase},
  uCadTanque in 'uCadTanque.pas' {fCadTanque},
  uPesquisarTanques in 'uPesquisarTanques.pas' {fPesquisarTanques},
  uCadBomba in 'uCadBomba.pas' {fCadBomba},
  BombaModel in 'Model\BombaModel.pas',
  BombaController in 'Controller\BombaController.pas',
  uPesquisarBombas in 'uPesquisarBombas.pas' {fPesquisarBombas},
  uCadComposicao in 'uCadComposicao.pas' {fCadComposicao},
  ComposicaoModel in 'Model\ComposicaoModel.pas',
  ComposicaoController in 'Controller\ComposicaoController.pas',
  AbastecimentoModel in 'Model\AbastecimentoModel.pas',
  AbastecimentoController in 'Controller\AbastecimentoController.pas',
  uAbastecimento in 'uAbastecimento.pas' {fAbastecimento},
  uRelatorio in 'uRelatorio.pas' {fRelatorio};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;

  fInicializacao := TfInicializacao.Create(Application);
  fInicializacao.Show;
  fInicializacao.Refresh;
  Sleep(2000);
  fInicializacao.Free;
  fInicializacao := nil;

  Application.CreateForm(TdmConexao, dmConexao);
  if dmConexao.RealizarConexaoBD then begin
    Application.CreateForm(TfMain, fMain);
    Application.CreateForm(TfRelatorio, fRelatorio);
    Application.Run;
  end;
end.
