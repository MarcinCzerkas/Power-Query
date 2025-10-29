let
    Source = Excel.CurrentWorkbook(){[Name="Headers"]}[Content],
    Transposed = Table.Transpose(Table.DemoteHeaders(Source)),
    Reordered = Table.Transpose(Transposed),
    CreateList = Table.ToColumns(Reordered)
in
    CreateList
