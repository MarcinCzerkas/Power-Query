// Function for normalization of flat tables (creates a dimension table based on selected columns).
(table_to_normalize as table, columns_to_normalize as list, optional index_name as text) as table =>
let
    Source = Table.SelectColumns(table_to_normalize, columns_to_normalize),
    Distinct = Table.Distinct(Source),
    AddIndex = Table.AddIndexColumn(Distinct, index_name, 1, 1, Int64.Type)
in
    AddIndex
