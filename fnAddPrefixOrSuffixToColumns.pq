// This function can be used to dynamically add a suffix or a prefix to all column names in a given table

(
    inputTable as table, 
    textToAdd as text, 
    mode as number
) 
as table =>

let
    // Validate mode parameter
    _validateMode = 
        if not List.Contains({0,1}, mode) then
            error "Mode must be 0 (prefix) or 1 (suffix)."
        else
            mode,

    // Get column names
    ColumnNames = Table.ColumnNames(inputTable),

    // Create rename pairs {OldName, NewName}
    RenamePairs =
        List.Transform(
            ColumnNames,
            each {
                _, 
                if mode = 0 
                    then textToAdd & _
                    else _ & textToAdd
            }
        ),

    // Apply renaming
    Result = Table.RenameColumns(inputTable, RenamePairs)

in
    Result
