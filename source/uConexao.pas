unit uConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Phys.IBBase,
  FireDAC.Comp.UI, System.RegularExpressions, uMain;

type
  TdmConexao = class(TDataModule)
    FDConnection: TFDConnection;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDQueryControllerTanque: TFDQuery;
    FDQueryControllerBomba: TFDQuery;
    FDQueryControllerComposicao: TFDQuery;
    FDQueryControllerAbastecimento: TFDQuery;
    FDQueryControllerAbastecimentoRel: TFDQuery;
    FDQueryControllerAbastecimentoRelCODIGO: TIntegerField;
    FDQueryControllerAbastecimentoRelQTDE_LITROS: TBCDField;
    FDQueryControllerAbastecimentoRelVLR_ABASTECIMENTO: TBCDField;
    FDQueryControllerAbastecimentoRelVLR_IMPOSTO: TBCDField;
    FDQueryControllerAbastecimentoRelDATA_CADASTRO: TDateField;
    FDQueryControllerAbastecimentoRelCODIGO_BOMBA: TIntegerField;
    FDQueryControllerAbastecimentoRelFORMA_PAGAMENTO: TStringField;
    procedure DataModuleDestroy(Sender: TObject);
  private
  public
    function RealizarConexaoBD: Boolean;
  end;

var
  dmConexao: TdmConexao;

implementation

uses uConfiguracoes, Vcl.Dialogs;

{$R *.dfm}

procedure TdmConexao.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(Self.FDQueryControllerTanque);
  FreeAndNil(Self.FDQueryControllerBomba);
  FreeAndNil(Self.FDQueryControllerComposicao);
  FreeAndNil(Self.FDQueryControllerAbastecimento);
  FreeAndNil(Self.FDQueryControllerAbastecimentoRel);
  FreeAndNil(Self.FDConnection);
end;

function TdmConexao.RealizarConexaoBD: Boolean;
var
  Msg: string;
begin
  Msg := TConfiguracoes.ValidarArquivoIniBD;
  if Msg <> EmptyStr then
    raise Exception.Create(Msg);

  try
    with Self.FDConnection do
      begin
        Params.Clear;
        Params.Values['DriverID']  := 'FB';
        Params.Values['Server'] := TConfiguracoes.LerIni('FIREBIRD','Server');
        Params.Values['Database'] := TConfiguracoes.LerIni('FIREBIRD','Database');
        Params.Values['User_name'] := TConfiguracoes.LerIni('FIREBIRD','User');
        Params.Values['Password'] := TConfiguracoes.LerIni('FIREBIRD','Password');
        Connected := True;
        Open;

        Result := True;
      end;
  except
    on E:Exception do
      raise Exception.Create(
        #13#10 + #13#10 + 'Ocorreu uma falha na conexão ao banco de dados!' +
        #13#10 + #13#10 + 'Verifique o arquivo de configuração.'
      );
  end;
end;

end.
