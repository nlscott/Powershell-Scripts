## SUMMARY ---------------------------------------------------------------------
# simple functions that print the number of logs (error or warning) in the last
# 24 hours. Meant to be a simple metric to form a baseline of activity


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
