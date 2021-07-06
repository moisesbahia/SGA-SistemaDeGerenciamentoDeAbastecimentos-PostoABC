unit BombaModel;

interface

type
  TBombaModel = class
  private
    FNomeTanque: string;
    FCodigo: Integer;
    FCodigoTanque: Integer;
    FNome: string;
    procedure SetCodigo(const Value: Integer);
    procedure SetCodigoTanque(const Value: Integer);
    procedure SetNome(const Value: string);
    procedure SetNomeTanque(const Value: string);
  public
    property Codigo: Integer read FCodigo write SetCodigo;
    property Nome: string read FNome write SetNome;
    property CodigoTanque: Integer read FCodigoTanque write SetCodigoTanque;
    property NomeTanque: string read FNomeTanque write SetNomeTanque;
  end;

implementation

{ TBombaModel }

procedure TBombaModel.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TBombaModel.SetCodigoTanque(const Value: Integer);
begin
  FCodigoTanque := Value;
end;

procedure TBombaModel.SetNome(const Value: string);
begin
  FNome := Value;
end;

procedure TBombaModel.SetNomeTanque(const Value: string);
begin
  FNomeTanque := Value;
end;

end.
