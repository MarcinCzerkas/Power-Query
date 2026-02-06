// Replaces previously normalized attributes from the fact table with a foreign key
(PreviousStep as table, DimensionTable as table, JoinColumns as list, KeyColumn as text) as table =>
let
    MergeDimension = Table.NestedJoin(
        PreviousStep, JoinColumns,
        DimensionTable, JoinColumns,
        "DimensionTable",
        JoinKind.LeftOuter
    ),
    ExpandFK = Table.ExpandTableColumn(
        MergeDimension,
        "DimensionTable",
        {KeyColumn},
        {KeyColumn}
    ),
    RemoveAttributes = Table.RemoveColumns(
        ExpandFK,
        JoinColumns
    )
in
    RemoveAttributes
