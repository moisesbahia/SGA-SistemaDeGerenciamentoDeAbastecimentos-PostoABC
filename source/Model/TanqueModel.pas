unit TanqueModel;

interface

type
  TTanqueModel = class
  private
    FCodigo: Integer;
    FTipoCombustivel: string;
    FNome: string;
    procedure SetCodigo(const Value: Integer);
    procedure SetNome(const Value: string);
    procedure SetTipoCombustivel(const Value: string);
  public
    property Codigo: Integer read FCodigo write SetCodigo;
    property Nome: string read FNome write SetNome;
    property TipoCombustivel: string read FTipoCombustivel write SetTipoCombustivel;
  end;

implementation

{ TTanqueClass }

procedure TTanqueModel.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TTanqueModel.SetNome(const Value: string);
begin
  FNome := Value;
end;

procedure TTanqueModel.SetTipoCombustivel(const Value: string);
begin
  FTipoCombustivel := Value;
end;

end.
