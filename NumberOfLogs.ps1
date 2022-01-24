


## FUNCTIONS -------------------------------------------------------------------
Function nmberOfErrorLogs {
    (Get-EventLog `
        -LogName System `
        -EntryType Error `
        -After (Get-Date).AddDays(-1)).count
}

Function nmberOfWarningLogs {
    (Get-EventLog `
        -LogName System `
        -EntryType Warning `
        -After (Get-Date).AddDays(-1)).count
}


## OUTPUT ----------------------------------------------------------------------
nmberOfErrorLogs
nmberOfWarningLogs
