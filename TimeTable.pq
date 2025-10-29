let
    // Define the granularity level: "Hour", "Minute" or "Second"
    Granularity = "Minute",

    // Based on the definition of granularity, calculate number of records (minus one because of 0-based list)
    RecordsCount =
        if Granularity = "Hour" then
            23
        else if Granularity = "Minute" then
            1439
        else if Granularity = "Second" then
            86399
        else
            0,

    // Create list of all hours, minutes or seconds in a day - based on the chosen granularity
    CreateList = {0 .. RecordsCount},
    ConvertToTable = Table.FromList(
        CreateList,
        Splitter.SplitByNothing(),
        null,
        null,
        ExtraValues.Error
    ),
    RenamedColumn = Table.RenameColumns(ConvertToTable, {{"Column1", "Index"}}),

    // Divide by the number of hours/minutes/seconds
    Division = Table.AddColumn(
        RenamedColumn,
        "Time", 
        each [Index] / (RecordsCount + 1),
        type number
    ),

    // Convert to time
    ChangedType = Table.TransformColumnTypes(Division, {{"Time", type time}}),

    // Extract hour as integer and add other columns (delete steps if not needed)
    Hour = Table.AddColumn(ChangedType, "Hour", each Time.Hour([Time]), Int64.Type),
    StartOfHour = Table.AddColumn(Hour, "Start of Hour", each Time.StartOfHour([Time]), type time),
    EndOfHour = Table.AddColumn(StartOfHour, "End of Hour", each Time.EndOfHour([Time]), type time),
    Minute = Table.AddColumn(EndOfHour, "Minute", each Time.Minute([Time]), Int64.Type),
    Second = Table.AddColumn(Minute, "Second", each Time.Second([Time]), type number),
    TimeOfDay = Table.AddColumn(
        Second,
        "Time of Day",
        each if [Hour] < 12 then "AM" else "PM",
        type text
    ), 
    PartOfDay = Table.AddColumn(
        TimeOfDay,
        "Part of Day",
        each 
            if [Hour] < 6 then
                "Night"
            else if [Hour] < 12 then
                "Morning"
            else if [Hour] < 18 then
                "Afternoon"
            else
                "Evening"
    ), 
    BusinessHours = Table.AddColumn(
        PartOfDay,
        "Business Hours Flag",
        each
            if [Hour] >= 8 and [Hour] < 18 then
                "Within Business Hours"
            else
                "Outside Business Hours"
    ),
    LunchBreak = Table.AddColumn(
        BusinessHours,
        "Lunch Break Flag",
        each if [Hour] >= 12 and [Hour] < 14 then "Lunch Break" else "Not Lunch Break"
    )
in
    LunchBreak