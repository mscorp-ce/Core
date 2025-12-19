# Core Package – Delphi Utilities

📦 **Core** é um *package Delphi* criado para centralizar utilitários e classes estáticas reutilizáveis, facilitando o compartilhamento de código entre diferentes projetos Delphi.

O objetivo deste repositório é manter funcionalidades **genéricas**, **independentes de regra de negócio** e de **uso recorrente**, promovendo reutilização, padronização e redução de código duplicado.

---

## 📂 Estrutura do Projeto

```
Core
├── src
│   └── JSON
│       └── uCore.JSON.DataSetToJSONArray.pas
├── Core.dpk
└── README.md
```

---

## 🚀 Funcionalidades Disponíveis

### 🔹 `TDataSetToJSONArray`

Classe utilitária responsável por converter um `TDataSet` em um `TJSONArray`, respeitando os tipos de dados de cada campo.

📍 **Unit:**  
`uCore.JSON.DataSetToJSONArray`

📌 **Assinatura:**
```delphi
class function Execute(const ADataSet: TDataSet): TJSONArray;
```

---

### 🧠 Regras de Conversão

| Tipo do Campo (`TFieldType`) | Conversão JSON |
|------------------------------|----------------|
| String / Memo                | String         |
| Integer / SmallInt / etc     | Number (int)   |
| Float / Currency / BCD       | Number (float) |
| Boolean                      | Boolean        |
| Date / DateTime / Timestamp | ISO-8601       |
| Null                         | `null`         |
| Outros                       | String         |

- Datas são convertidas para **ISO-8601**
- Campos nulos são representados como `JSON null`
- Cada registro do `DataSet` gera um `JSONObject` dentro do `JSONArray`

---

## 🧪 Exemplo de Uso

```delphi
uses
  uCore.JSON.DataSetToJSONArray,
  System.JSON;

var
  JSONArray: TJSONArray;
begin
  JSONArray := TDataSetToJSONArray.Execute(MyDataSet);
  try
    ShowMessage(JSONArray.ToString);
  finally
    JSONArray.Free;
  end;
end;
```

---

## 📦 Dependências

- RTL
- DBRTL
- Units:
  - `Data.DB`
  - `System.JSON`
  - `System.SysUtils`
  - `System.DateUtils`

---

## 🎯 Objetivos do Package

- Centralizar utilitários comuns
- Evitar duplicação de código entre projetos
- Facilitar manutenção e evolução
- Incentivar código limpo e reutilizável

---

## 🛠️ Próximos Passos (ideias)

- Conversão `JSONArray` → `TDataSet`
- Helpers para JSON
- Utilitários de Data/Hora
- Helpers para validação
- Classes utilitárias para strings, números e enums

---

## 📄 Licença

Defina aqui a licença do projeto (ex: MIT, Apache 2.0, Proprietária).

