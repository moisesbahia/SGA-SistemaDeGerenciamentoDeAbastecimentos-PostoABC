unit AbastecimentoController;

interface

uses uConexao, AbastecimentoModel, SysUtils, FireDac.Stan.Param, uConfiguracoes;

type
  TAbastecimentoController = class
  private
    procedure InicializarQuery;
  public
    function RetornarIDAbastecimento: Integer;
    function Registrar(AbastecimentoModel: TAbastecimentoModel): string;
  end;

implementation

uses TanqueController;

function TAbastecimentoController.Registrar(AbastecimentoModel: TAbastecimentoModel): string;
begin
  Result := '';
  AbastecimentoModel.Codigo := RetornarIDAbastecimento;

  with DMConexao.FDQueryControllerAbastecimento do begin
    try
      try
        InicializarQuery;
        SQL.Add('INSERT INTO ABASTECIMENTO ( ');
        SQL.Add('  Codigo, ');
        SQL.Add('  QTDE_LITROS, ');
        SQL.Add('  VLR_ABASTECIMENTO, ');
        SQL.Add('  VLR_IMPOSTO, ');
        SQL.Add('  DATA_CADASTRO, ');
        SQL.Add('  CODIGO_BOMBA, ');
        SQL.Add('  FORMA_PAGAMENTO ');
        SQL.Add(') ');

        SQL.Add('VALUES( ');
        SQL.Add('  :CODIGO, ');
        SQL.Add('  :QTDE_LITROS, ');
        SQL.Add('  :VLR_ABASTECIMENTO, ');
        SQL.Add('  :VLR_IMPOSTO, ');
        SQL.Add('  CURRENT_DATE, ');
        SQL.Add('  :CODIGO_BOMBA, ');
        SQL.Add('  :FORMA_PAGAMENTO ');
        SQL.Add(') ');

        ParamByName('CODIGO').AsInteger := AbastecimentoModel.Codigo;
        ParamByName('QTDE_LITROS').AsFloat  := AbastecimentoModel.Qtde_Litros;
        ParamByName('VLR_ABASTECIMENTO').AsFloat  := AbastecimentoModel.Vlr_Abastecimento;
        ParamByName('VLR_IMPOSTO').AsFloat  := AbastecimentoModel.Vlr_Imposto;
        ParamByName('CODIGO_BOMBA').AsInteger  := AbastecimentoModel.Codigo_Bomba;
        ParamByName('FORMA_PAGAMENTO').AsString  := AbastecimentoModel.Forma_Pagamento;

        ExecSQL;
        Result := 'Abastecimento Realizado com Sucesso!';
      except
        on E: Exception do
          raise Exception.Create('Erro ao inserir novo abastecimento. Erro: ' + E.Message);
      end;
    finally
      Close;
    end;
  end;
end;

function TAbastecimentoController.RetornarIDAbastecimento: Integer;
begin
  Result := 0;
  with DMConexao.FDQueryControllerAbastecimento do begin
    try
      try
        InicializarQuery;

        SQL.Add('SELECT ');
        SQL.Add('  GEN_ID(GEN_ABASTECIMENTO_ID, 1) ');
        SQL.Add('FROM RDB$DATABASE ');

        Open;
        Result := FieldByName('GEN_ID').AsInteger;
      except
        on E: Exception do
          raise Exception.Create('Erro ao retornar ID do abastecimento. Erro: ' + E.Message);
      end;
    finally
      Close;
    end;
  end;
end;

procedure TAbastecimentoController.InicializarQuery;
begin
  DMConexao.FDQueryControllerAbastecimento.Close;
  DMConexao.FDQueryControllerAbastecimento.SQL.Clear;
end;

end.
