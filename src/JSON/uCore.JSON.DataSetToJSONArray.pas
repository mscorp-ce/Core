unit uCore.JSON.DataSetToJSONArray;

interface

uses
  Data.DB, System.JSON;

type
  TDataSetToJSONArray = class
  public
    class function Execute(const ADataSet: TDataSet): TJSONArray;
  end;

implementation

uses
  System.SysUtils, System.DateUtils;

{ TDataSetToJSONArray }

class function TDataSetToJSONArray.Execute(const ADataSet: TDataSet): TJSONArray;
var
  LArray : TJSONArray;
  LObj   : TJSONObject;
  I      : Integer;
  Field  : TField;
begin
  LArray := TJSONArray.Create;
  try
    ADataSet.First;
    while not ADataSet.Eof do
      begin
        LObj := TJSONObject.Create;

        for I := 0 to ADataSet.FieldCount - 1 do
          begin
            Field := ADataSet.Fields[I];

            if Field.IsNull then
              begin
                LObj.AddPair(Field.FieldName, TJSONNull.Create);
                Continue;
              end;

            case Field.DataType of
              Data.DB.ftString,
              Data.DB.ftWideString,
              Data.DB.ftMemo,
              Data.DB.ftWideMemo,
              Data.DB.ftFmtMemo:
                LObj.AddPair(Field.FieldName, Field.AsString);

              Data.DB.ftSmallint,
              Data.DB.ftInteger,
              Data.DB.ftWord,
              Data.DB.ftAutoInc,
              Data.DB.ftLargeint,
              Data.DB.ftShortint,
              Data.DB.ftByte:
                LObj.AddPair(Field.FieldName, TJSONNumber.Create(Field.AsInteger));

              Data.DB.ftFloat,
              Data.DB.ftCurrency,
              Data.DB.ftBCD,
              Data.DB.ftFMTBcd:
                LObj.AddPair(Field.FieldName, TJSONNumber.Create(Field.AsFloat));

              Data.DB.ftBoolean:
                LObj.AddPair(Field.FieldName, TJSONBool.Create(Field.AsBoolean));

              Data.DB.ftDate,
              Data.DB.ftDateTime,
              Data.DB.ftTimeStamp:
                LObj.AddPair(
                  Field.FieldName,
                  DateToISO8601(Field.AsDateTime, False)
                );

              Data.DB.ftTime:
                LObj.AddPair(Field.FieldName, TimeToStr(Field.AsDateTime));

            else
              LObj.AddPair(Field.FieldName, Field.AsString);
            end;
          end;

        LArray.AddElement(LObj);
        ADataSet.Next;
      end;

    Result := LArray;

  except
    LArray.Free;
    raise;
  end;
end;

end.
