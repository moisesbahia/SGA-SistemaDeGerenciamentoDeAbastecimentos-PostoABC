unit BombaController;

interface

uses uConexao, BombaModel, SysUtils, FireDac.Stan.Param, uConfiguracoes;

type
  TRetornoBombas = record
    xCodigo: Integer;
    xNome: string;
    xCodigoTanque: Integer;
    xNomeTanque: string;
  end;
  vetDadosBombas = array of TRetornoBombas;

  TBombaController = class
  private
    procedure InicializarQuery;
  public
    function RetornarDadosBomba(campo_pesquisa, chave_pesquisa: string): vetDadosBombas;
    procedure Registrar(BombaModel: TBombaModel; TipoRegistro: TTipoRegistro);
    procedure Excluir(BombaModel: TBombaModel);
    function RetornarIDBomba: Integer;
  end;

implementation

uses TanqueController;

function TBombaController.RetornarDadosBomba(campo_pesquisa, chave_pesquisa: string): vetDadosBombas;
var
  TanqueController: TTanqueController;
begin
  with DMConexao.FDQueryControllerBomba do begin
    try
      try
        InicializarQuery;
        SQL.Add('SELECT ');
        SQL.Add('  CODIGO, ');
        SQL.Add('  NOME, ');
        SQL.Add('  CODIGO_TANQUE ');
        SQL.Add('FROM BOMBA ');

        if chave_pesquisa <> '' then begin
          if campo_pesquisa = 'NOME' then
            SQL.Add(' WHERE ' + campo_pesquisa + ' like :FILTRO ')
          else begin
            SQL.Add(' WHERE ' + campo_pesquisa + ' in (');
            SQL.Add(' SELECT ');
            SQL.Add('   CODIGO ');
            SQL.Add(' FROM TANQUE ');
            SQL.Add(' WHERE NOME like :FILTRO) ');
          end;

          ParamByName('FILTRO').AsString := '%' + chave_pesquisa + '%';
        end;

        Open;
        TanqueController := TTanqueController.Create;
        while not Eof do begin
          SetLength(Result, Length(Result) + 1);

          Result[High(Result)].xCodigo := StrToInt(FieldByName('CODIGO').AsString);
          Result[High(Result)].xNome := FieldByName('NOME').AsString;
          Result[High(Result)].xCodigoTanque := StrToInt(FieldByName('CODIGO_TANQUE').AsString);
          Result[High(Result)].xNomeTanque := TanqueController.RetornarNomeTanque(StrToInt(FieldByName('CODIGO_TANQUE').AsString));

          Next;
        end;
      except
        on E: Exception do
          raise Exception.Create('Erro ao retonar os dados das bomba(s). Erro: ' + E.Message);
      end;
    finally
      Close;
      FreeAndNil(TanqueController);
    end;
  end;
end;

procedure TBombaController.Excluir(BombaModel: TBombaModel);
begin
  with DMConexao.FDQueryControllerBomba do begin
    try
      try
        InicializarQuery;
        SQL.Add('DELETE FROM');
        SQL.Add('  BOMBA');
        SQL.Add('WHERE CODIGO = :CODIGO');

        ParamByName('CODIGO').AsInteger := BombaModel.Codigo;
        ExecSQL;
      except
        on e: exception do
          raise Exception.Create('Erro do excluir bomba. Erro: ' + e.Message);
      end;
    finally
      Close;
    end;
  end;
end;

procedure TBombaController.InicializarQuery;
begin
  DMConexao.FDQueryControllerBomba.Close;
  DMConexao.FDQueryControllerBomba.SQL.Clear;
end;

procedure TBombaController.Registrar(BombaModel: TBombaModel; TipoRegistro: TTipoRegistro);
begin
  with DMConexao.FDQueryControllerBomba do begin
    try
      try
        if TipoRegistro = inserir then begin
          BombaModel.Codigo := RetornarIDBomba;

          InicializarQuery;
          SQL.Add('INSERT INTO BOMBA( ');
          SQL.Add('  CODIGO, ');
          SQL.Add('  NOME, ');
          SQL.Add('  CODIGO_TANQUE ');
          SQL.Add(') ');

          SQL.Add('VALUES( ');
          SQL.Add('  :CODIGO, ');
          SQL.Add('  :NOME, ');
          SQL.Add('  :CODIGO_TANQUE ');
          SQL.Add(') ');
        end
        else begin
          InicializarQuery;
          SQL.Add('UPDATE BOMBA SET ');
          SQL.Add('  NOME = :NOME, ');
          SQL.Add('  CODIGO_TANQUE = :CODIGO_TANQUE ');
          SQL.Add('WHERE CODIGO = :CODIGO');
        end;

        ParamByName('CODIGO').AsInteger := BombaModel.Codigo;
        ParamByName('NOME').AsString  := BombaModel.Nome;
        ParamByName('CODIGO_TANQUE').AsString := IntToStr(BombaModel.CodigoTanque);
        ExecSQL;
      except
        on E: Exception do
          raise Exception.Create('Erro ao registrar a bomba. Erro: ' + E.Message);
      end;
    finally
      Close;
    end;
  end;
end;

function TBombaController.RetornarIDBomba: Integer;
begin
  Result := 0;
  with DMConexao.FDQueryControllerBomba do begin
    try
      try
        InicializarQuery;
        SQL.Add('SELECT ');
        SQL.Add('  GEN_ID(GEN_BOMBA_ID, 1) ');
        SQL.Add('FROM RDB$DATABASE ');

        Open;
        Result := FieldByName('GEN_ID').AsInteger;
      except
        on E: Exception do
          raise Exception.Create('Erro ao retornar ID da bomba. Erro: ' + E.Message);
      end;
    finally
      Close;
    end;
  end;
end;

end.
