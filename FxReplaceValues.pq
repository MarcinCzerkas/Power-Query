// Function: fnReplaceValues
//
// Parameters:
//   Source        = table to modify
//   Replacements  = list of {old value, new value, columns} rules
//
// Example rule:
//   {"old value", "New Value", {"Column1"}}

(Source as table, Replacements as list) as table =>
let
    Result =
        List.Accumulate(
            Replacements,
            Source,
            (table, replacement) =>
                Table.ReplaceValue(
                    table,
                    replacement{0},
                    replacement{1},
                    Replacer.ReplaceText,
                    replacement{2}
                )
        )
in
    Result
