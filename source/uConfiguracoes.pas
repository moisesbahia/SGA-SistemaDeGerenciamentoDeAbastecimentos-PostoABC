unit uConfiguracoes;

interface

uses IniFiles, IWSystem, SysUtils, Vcl.Dialogs;

type
  TTipoRegistro = (Inserir, Atualizar);
  TConfiguracoes = class
  public
    class function ValidarArquivoIniBD: string; static;
    class function LerIni(Chave1, Chave2: string; ValorPadrao: string = ''): string; static;
  end;

implementation

{ TConfiguracoes }

class function TConfiguracoes.LerIni(Chave1, Chave2,
  ValorPadrao: string): string;
var
  FileIni: TIniFile;
  Arquivo: String;
begin
  Arquivo := gsAppPath + gsAppName + '.ini';
  result := ValorPadrao;
  try
    FileIni := TIniFile.Create(Arquivo);
    if FileExists(Arquivo) then
      result := FileIni.ReadString(Chave1, Chave2, ValorPadrao);
  finally
    FreeAndNil(FileIni)
  end;
end;

class function TConfiguracoes.ValidarArquivoIniBD: string;
var
  Arquivo: String;
begin
  Result := '';
  Arquivo := gsAppPath + gsAppName + '.ini';

  if not FileExists(Arquivo) then begin
    Result := #13#10 + #13#10 +
      'Arquivo: ' + gsAppName + '.ini' + ' para configura��o do banco de dados n�o encontrado!' + #13#10 + #13#10 +
      'Obrigat�ria cria��o do arquivo na pasta execut�vel.' + #13#10 + #13#10 +
      'Necess�ria configura��o do arquivo antes da inicializa��o do sistema!'
  end;
end;

end.
