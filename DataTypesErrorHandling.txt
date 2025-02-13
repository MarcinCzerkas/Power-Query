    // Error handling in case of wrong data types 
    TypePrep = Table.TransformColumns(
        RemovedBlankRows,
        {
            {"Column1", each try Number.From(_) otherwise null},
            {"Column2", each try Number.From(_) otherwise null}),
    ChangedType = Table.TransformColumnTypes(
        TypePrep,
        {
            {"Column1", type number},
            {"Column2", Int64.Type},
            {"Column3", type text}}),
