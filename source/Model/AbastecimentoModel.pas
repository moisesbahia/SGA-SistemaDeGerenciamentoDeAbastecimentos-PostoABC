unit AbastecimentoModel;

interface

type
  TAbastecimentoModel = class
  private
    FCodigo_Bomba: Integer;
    FVlr_Imposto: Double;
    FData_Cadastro: TDate;
    FVlr_Abastecimento: Double;
    FCodigo: Integer;
    FForma_Pagamento: string;
    FQtde_Litros: Double;
    procedure SetCodigo(const Value: Integer);
    procedure SetCodigo_Bomba(const Value: Integer);
    procedure SetData_Cadastro(const Value: TDate);
    procedure SetForma_Pagamento(const Value: string);
    procedure SetQtde_Litros(const Value: Double);
    procedure SetVlr_Abastecimento(const Value: Double);
    procedure SetVlr_Imposto(const Value: Double);
  public
    property Codigo: Integer read FCodigo write SetCodigo;
    property Qtde_Litros: Double read FQtde_Litros write SetQtde_Litros;
    property Vlr_Abastecimento: Double read FVlr_Abastecimento write SetVlr_Abastecimento;
    property Vlr_Imposto: Double read FVlr_Imposto write SetVlr_Imposto;
    property Data_Cadastro: TDate read FData_Cadastro write SetData_Cadastro;
    property Codigo_Bomba: Integer read FCodigo_Bomba write SetCodigo_Bomba;
    property Forma_Pagamento: string read FForma_Pagamento write SetForma_Pagamento;
  end;

implementation

{ TAbastecimentoModel }

{ TAbastecimentoModel }

procedure TAbastecimentoModel.SetCodigo(const Value: Integer);
begin
  FCodigo := Value;
end;

procedure TAbastecimentoModel.SetCodigo_Bomba(const Value: Integer);
begin
  FCodigo_Bomba := Value;
end;

procedure TAbastecimentoModel.SetData_Cadastro(const Value: TDate);
begin
  FData_Cadastro := Value;
end;

procedure TAbastecimentoModel.SetForma_Pagamento(const Value: string);
begin
  FForma_Pagamento := Value;
end;

procedure TAbastecimentoModel.SetQtde_Litros(const Value: Double);
begin
  FQtde_Litros := Value;
end;

procedure TAbastecimentoModel.SetVlr_Abastecimento(const Value: Double);
begin
  FVlr_Abastecimento := Value;
end;

procedure TAbastecimentoModel.SetVlr_Imposto(const Value: Double);
begin
  FVlr_Imposto := Value;
end;

end.
