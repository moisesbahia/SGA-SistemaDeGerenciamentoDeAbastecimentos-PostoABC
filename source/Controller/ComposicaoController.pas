unit ComposicaoController;

interface

uses uConexao, ComposicaoModel, SysUtils, FireDac.Stan.Param, uConfiguracoes, Data.DB;

type
  TRetornoComposicao = record
    xCodigo: Integer;
    xVlrLitroGasolina: Double;
    xVlrLitroDiesel: Double;
    xPercImposto: Double;
  end;

  TComposicaoController = class
  private
    procedure InicializarQuery;
  public
    function RetornarDadosComposicao: TRetornoComposicao;
    procedure Registrar(ComposicaoModel: TComposicaoModel; TipoRegistro: TTipoRegistro);
    function RetornarIDComposicao: Integer;
  end;

implementation

{ TComposicaoController }

procedure TComposicaoController.InicializarQuery;
begin
  DMConexao.FDQueryControllerComposicao.Close;
  DMConexao.FDQueryControllerComposicao.SQL.Clear;
end;

procedure TComposicaoController.Registrar(ComposicaoModel: TComposicaoModel;
  TipoRegistro: TTipoRegistro);
begin
  with DMConexao.FDQueryControllerComposicao do begin
    try
      try
        if TipoRegistro = inserir then begin
          ComposicaoModel.Codigo := RetornarIDComposicao;

          InicializarQuery;
          SQL.Add('INSERT INTO COMPOSICAO( ');
          SQL.Add('  CODIGO, ');
          SQL.Add('  VLR_LITRO_GASOLINA, ');
          SQL.Add('  VLR_LITRO_OLEO_DIESEL, ');
          SQL.Add('  PERC_IMPOSTO ');
          SQL.Add(') ');

          SQL.Add('VALUES( ');
          SQL.Add('  :CODIGO, ');
          SQL.Add('  :VLR_LITRO_GASOLINA, ');
          SQL.Add('  :VLR_LITRO_OLEO_DIESEL, ');
          SQL.Add('  :PERC_IMPOSTO ');
          SQL.Add(') ');
        end
        else begin
          InicializarQuery;
          SQL.Add('UPDATE COMPOSICAO SET ');
          SQL.Add('  VLR_LITRO_GASOLINA = :VLR_LITRO_GASOLINA, ');
          SQL.Add('  VLR_LITRO_OLEO_DIESEL = :VLR_LITRO_OLEO_DIESEL, ');
          SQL.Add('  PERC_IMPOSTO = :PERC_IMPOSTO ');
          SQL.Add('WHERE CODIGO = :CODIGO');
        end;

        ParamByName('CODIGO').AsInteger := ComposicaoModel.Codigo;
        ParamByName('VLR_LITRO_GASOLINA').AsFloat  := ComposicaoModel.Vlr_Litro_Gasolina;
        ParamByName('VLR_LITRO_OLEO_DIESEL').AsFloat := ComposicaoModel.Vlr_Litro_Diesel;
        ParamByName('PERC_IMPOSTO').AsFloat := ComposicaoModel.Percentual_Imposto;

        ExecSQL;
      except
        on E: Exception do
          raise Exception.Create('Erro ao registrar a composição. Erro: ' + E.Message);
      end;
    finally
      Close;
    end;
  end;
end;

function TComposicaoController.RetornarDadosComposicao: TRetornoComposicao;
begin
  with DMConexao.FDQueryControllerComposicao do begin
    try
      try
        InicializarQuery;
        SQL.Add('SELECT FIRST(1) ');
        SQL.Add('  CODIGO, ');
        SQL.Add('  VLR_LITRO_GASOLINA, ');
        SQL.Add('  VLR_LITRO_OLEO_DIESEL, ');
        SQL.Add('  PERC_IMPOSTO ');
        SQL.Add('FROM COMPOSICAO ');
        Open;

        if not IsEmpty then begin
          Result.xCodigo := StrToInt(FieldByName('CODIGO').AsString);
          Result.xVlrLitroGasolina := StrToFloat(FieldByName('VLR_LITRO_GASOLINA').AsString);
          Result.xVlrLitroDiesel := StrToFloat(FieldByName('VLR_LITRO_OLEO_DIESEL').AsString);
          Result.xPercImposto := StrToFloat(FieldByName('PERC_IMPOSTO').AsString);
        end;
      except
        on E: Exception do
          raise Exception.Create('Erro ao retornar composição. Erro: ' + E.Message);
      end;
    finally
      Close;
    end;
  end;
end;

function TComposicaoController.RetornarIDComposicao: Integer;
begin
  Result := 0;
  with DMConexao.FDQueryControllerComposicao do begin
    try
      try
        InicializarQuery;
        SQL.Add('SELECT ');
        SQL.Add('  GEN_ID(GEN_COMPOSICAO_ID, 1) ');
        SQL.Add('FROM RDB$DATABASE ');
        Open;

        Result := FieldByName('GEN_ID').AsInteger;
      except
        on E: Exception do
          raise Exception.Create('Erro ao retornar ID da composição. Erro: ' + E.Message);
      end;
    finally
      Close;
    end;
  end;
end;

end.
