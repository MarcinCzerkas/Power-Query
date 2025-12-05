// Function: Convert UTC datetime -> Europe/Warsaw local (CET/CEST) with DST
// Usage: fxUtcToWarsaw([YourUtcColumn])
let
    fxUtcToWarsaw = (utc as nullable datetime) as nullable datetime =>
        let
            // Handle nulls
            _utc = utc, 
            result = 
                if _utc = null then
                    null
                else
                    let
                        y = Date.Year(DateTime.Date(_utc)), 
                        // Last Sunday of March
                        march31 = #date(y, 3, 31), 
                        lastSundayMarch = Date.AddDays(
                            march31, 
                            - Date.DayOfWeek(march31, Day.Sunday)
                        ), 
                        // Last Sunday of October
                        oct31 = #date(y, 10, 31), 
                        lastSundayOct = Date.AddDays(oct31, - Date.DayOfWeek(oct31, Day.Sunday)), 
                        // In Central Europe, DST changes happen at 01:00 UTC
                        dstStartUtc = #datetime(y, 3, Date.Day(lastSundayMarch), 1, 0, 0), 
                        dstEndUtc = #datetime(y, 10, Date.Day(lastSundayOct), 1, 0, 0), 
                        inDST = (_utc >= dstStartUtc) and (_utc < dstEndUtc), 
                        offsetHours = if inDST then 2 else 1, 
                        local = _utc + #duration(0, offsetHours, 0, 0)
                    in
                        local
        in
            result
in
    fxUtcToWarsaw
