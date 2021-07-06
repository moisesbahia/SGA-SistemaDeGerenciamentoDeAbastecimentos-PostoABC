unit ComposicaoModel;

interface

type
  TComposicaoModel = class
  private
    FVlr_Litro_Gasolina: Double;
    FVlr_Litro_Diesel: Double;
    FCodigo: Integer;
    FPercentual_Imposto: Double;
    procedure SetCodigo(const Value: Integer);
    procedure SetPercentual_Imposto(const Value: Double);
    procedure SetVlr_Litro_Diesel(const Value: Double);
    procedure SetVlr_Litro_Gasolina(const Value: Double);
    public
      property Codigo: Integer read FCodigo write SetCodigo;
      property Vlr_Litro_Gasolina: Double read FVlr_Litro_Gasolina write SetVlr_Litro_Gasolina;
      property Vlr_Litro_Diesel: Double read FVlr_Litro_Diesel write SetVlr_Litro_Diesel;
      property Percentual_Imposto: Double read FPercentual_Imposto write SetPercentual_Imposto;
  end;

implementation

{ TComposicaoModel }

procedure TComposicaoModel.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TComposicaoModel.SetPercentual_Imposto(const Value: Double);
begin
  FPercentual_Imposto := Value;
end;

procedure TComposicaoModel.SetVlr_Litro_Diesel(const Value: Double);
begin
  FVlr_Litro_Diesel := Value;
end;

procedure TComposicaoModel.SetVlr_Litro_Gasolina(const Value: Double);
begin
  FVlr_Litro_Gasolina := Value;
end;

end.
