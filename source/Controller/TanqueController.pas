unit TanqueController;

interface

uses TanqueModel, uConexao, Data.DB, SysUtils, FireDAC.Stan.Param, FireDAC.Comp.Client, uConfiguracoes;

type
  TRetornoTanques = record
    xCodigo: Integer;
    xNome: string;
    xTipoCombustivel: string;
  end;
  vetDadosTanques = array of TRetornoTanques;

  TTanqueController = class
  private
    procedure InicializarQuery;
  public
    function RetornarDadosTanque(campo_pesquisa, chave_pesquisa: string): vetDadosTanques;
    function RetornarNomeTanque(codigo: Integer): string;
    procedure Registrar(TanqueModel: TTanqueModel; TipoRegistro: TTipoRegistro);
    procedure Excluir(TanqueModel: TTanqueModel);
    function RetornarIDAbastecimento: Integer;
  end;

implementation

{ TTanqueBD }

function TTanqueController.RetornarDadosTanque(campo_pesquisa, chave_pesquisa: string): vetDadosTanques;
begin
  with DMConexao.FDQueryControllerTanque do begin
    try
      try
        InicializarQuery;
        SQL.Add('SELECT ');
        SQL.Add('  CODIGO, ');
        SQL.Add('  NOME, ');
        SQL.Add('  TIPO ');
        SQL.Add('FROM TANQUE ');

        if chave_pesquisa <> '' then begin
          SQL.Add(' WHERE ' + campo_pesquisa + ' like :FILTRO ');

          if campo_pesquisa = 'TIPO' then
            chave_pesquisa := Copy(chave_pesquisa, 1, 1);

          ParamByName('FILTRO').AsString := '%' + chave_pesquisa + '%';
        end;

        Open;
        while not Eof do begin
          SetLength(Result, Length(Result) + 1);

          Result[High(Result)].xCodigo := StrToInt(FieldByName('CODIGO').AsString);
          Result[High(Result)].xNome := FieldByName('NOME').AsString;
          Result[High(Result)].xTipoCombustivel := FieldByName('TIPO').AsString;

          Next;
        end;
      except
        on E: Exception do
          raise Exception.Create('Erro ao retornar dados dos tanque(s). Erro: ' + e.Message);
      end;
    finally
      Close;
    end;
  end;
end;

function TTanqueController.RetornarNomeTanque(codigo: Integer): string;
begin
  Result := '';
  with DMConexao.FDQueryControllerTanque do begin
    try
      try
        InicializarQuery;
        SQL.Add('SELECT ');
        SQL.Add('  NOME ');
        SQL.Add('FROM TANQUE ');
        SQL.Add('WHERE CODIGO = :CODIGO ');

        ParamByName('CODIGO').AsInteger := codigo;
        Open;

        Result := FieldByName('NOME').AsString;
      except
        on E: Exception do
          raise Exception.Create('Erro do retornar nome do tanque. Erro: ' + E.Message);
      end;
    finally
      Close;
    end;
  end;
end;

procedure TTanqueController.Excluir(TanqueModel: TTanqueModel);
begin
  with DMConexao.FDQueryControllerTanque do begin
    try
      try
        InicializarQuery;
        SQL.Add('DELETE FROM');
        SQL.Add('  TANQUE');
        SQL.Add('WHERE CODIGO = :CODIGO');

        ParamByName('CODIGO').AsInteger := TanqueModel.Codigo;
        ExecSQL;
      except
        on E: exception do
          raise Exception.Create('Erro do excluir tanque. Error: ' + E.Message);
      end;
    finally
      Close;
    end;
  end;
end;

procedure TTanqueController.InicializarQuery;
begin
  DMConexao.FDQueryControllerTanque.Close;
  DMConexao.FDQueryControllerTanque.SQL.Clear;
end;

procedure TTanqueController.Registrar(TanqueModel: TTanqueModel; TipoRegistro: TTipoRegistro);
begin
  with DMConexao.FDQueryControllerTanque do begin
    try
      try
        if TipoRegistro = inserir then begin
          TanqueModel.Codigo := RetornarIDAbastecimento;

          InicializarQuery;
          SQL.Add('INSERT INTO TANQUE( ');
          SQL.Add('  CODIGO, ');
          SQL.Add('  NOME, ');
          SQL.Add('  TIPO ');
          SQL.Add(') ');

          SQL.Add('VALUES( ');
          SQL.Add('  :CODIGO, ');
          SQL.Add('  :NOME, ');
          SQL.Add('  :TIPO ');
          SQL.Add(') ');
        end
        else begin
          InicializarQuery;
          SQL.Add('UPDATE TANQUE SET ');
          SQL.Add('  NOME = :NOME, ');
          SQL.Add('  TIPO = :TIPO ');
          SQL.Add('WHERE CODIGO = :CODIGO');
        end;

        ParamByName('CODIGO').AsInteger := TanqueModel.Codigo;
        ParamByName('NOME').AsString  := TanqueModel.Nome;
        ParamByName('TIPO').AsString := TanqueModel.TipoCombustivel;
        ExecSQL;
      except
        on E: Exception do
          raise Exception.Create('Erro ao registrar o tanque. Erro: ' + E.Message);
      end;
    finally
      Close;
    end;
  end;
end;

function TTanqueController.RetornarIDAbastecimento: Integer;
begin
  Result := 0;
  with DMConexao.FDQueryControllerTanque do begin
    try
      try
        InicializarQuery;
        SQL.Add('SELECT ');
        SQL.Add('  GEN_ID(GEN_TANQUE_ID, 1) ');
        SQL.Add('FROM RDB$DATABASE ');
        Open;

        Result := FieldByName('GEN_ID').AsInteger;
      except
        on E: Exception do
          raise Exception.Create('Erro ao retornar ID do estabelecimento. Erro: ' + E.Message);
      end;
    finally
      Close;
    end;
  end;
end;

end.
