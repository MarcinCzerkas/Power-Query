    // Define the list of replacement rules
    Replacements = {
        { "old value", "", {"New Value"} },
        { " oLDvALUE", "", {"New Value"} }
    },

    // Apply replacements iteratively using List.Accumulate
    ReplacedValues = List.Accumulate(
        Replacements, 
        CombinedData, 
        (table, replacement) => 
            Table.ReplaceValue(
                table, 
                replacement{0}, 
                replacement{1}, 
                Replacer.ReplaceText, 

                replacement{2}))
