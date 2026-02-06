    // Define the list of replacement rules
    Replacements = {
        { "old value", "New Value", {"Column1"} },
        { " oLDvALUE", "New Value", {"Column2"} }
    },

    // Apply replacements iteratively using List.Accumulate
    ReplacedValues = List.Accumulate(
        Replacements, 
        PREVIOUS_STEP, 
        (table, replacement) => 
            Table.ReplaceValue(
                table, 
                replacement{0}, 
                replacement{1}, 
                Replacer.ReplaceText, 

                replacement{2}))

