let
    // --- Explicit list of fact & dimension queries to audit ---
    TablesToCheck =
        [
            Dim_Date        = Dim_Date,
            Dim_Customer    = Dim_Customer,
            Dim_Hotel       = Dim_Hotel,
            Fact_Bookings   = Fact_Bookings
        ],

    // --- Convert record of tables into audit rows ---
    AuditRows =
        List.Transform(
            Record.FieldNames(TablesToCheck),
            (tableName as text) =>
                let
                    tbl = Record.Field(TablesToCheck, tableName)
                in
                    [
                        TableName   = tableName,
                        TableType   = if Text.StartsWith(tableName, "Dim_") then "Dimension" else "Fact",
                        RowCount    = Table.RowCount(tbl),
                        RefreshTime = DateTime.LocalNow()
                    ]
        ),

    // --- Final audit table ---
    Result =
        Table.FromRecords(AuditRows)
in
    Result
