## :: SUMMARY ::
## get a list or count of all scheduled tasks
## meant to be used as a baseline on a system so you can send results to grafana
## then set alerts if a new schedule task is created

#ignore check on self-signed cert
[System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true} ;


$computerName = $env:computername
$script:arrayOfExistingTasks = @()

#My List of approved scheduled Tasks.
$ApprovedScheduledTasks = @(
    "AutoUpdateAgent Status Check",
    "AutoUpdateAgent Poll",
    "GoogleUpdateTaskMachineCore",
    "Azure Nightly Backup Files",
    "Microsoft-OnlineBackup",
    "Microsoft-OnlineBackup-RetryFailedJobs",
    "GoogleUpdateTaskMachineUA",
    "Grafana Scheduled Tasks",
    "Grafana RDP Successful Login",
    "Grafana RDP Failed Login",
    "Grafana Azure Stats"
 )
$script:BlackListTasks = @()

## FUNCTIONS ---------------------------------------------------------------------------------------
## total number of scheduled tasks
Function numberOfScheduledTasksTotal{
    (Get-ScheduledTask `
    | Get-ScheduledTaskInfo `
    | Measure-Object).Count
}

## Verbose list of non-microsoft scheduled tasks
Function numberOfNonMicrosoftScheduledTasks {
    (Get-ScheduledTask `
    | Get-ScheduledTaskInfo `
    | Where-Object {$_.TaskPath -NotLike '\Microsoft\Windows\*'} `
    | Measure-Object).Count
}


## Verbose list of non-microsoft scheduled tasks
Function listScheduledTasksVerbose {
    (Get-ScheduledTask `
    | Get-ScheduledTaskInfo `
    | Where-Object {$_.TaskPath -NotLike '\Microsoft\Windows\*'})
}

# List of non-microsoft scheduled tasks names
Function listScheduledTaskNames {
    (Get-ScheduledTask `
    | Get-ScheduledTaskInfo `
    | Where-Object {$_.TaskPath -NotLike '\Microsoft\Windows\*'} `
    | Select-Object TaskName)
}

## Converts tasknames of existing scheduled tasks into an array
Function GetArrayOfExisitingTaskNames {
    $results = listScheduledTaskNames
    foreach($x in $results){
        $script:arrayOfExistingTasks += $x.Taskname
    }
}

## compares Whitelisted tasks with exisiting tasks
Function CheckForUnapprovedScheduledTasks {
    foreach($task in $script:arrayOfExistingTasks){
        if($ApprovedScheduledTasks -contains $task){
            # Write-Output "$task is Approved"}
            continue}
        else {
            # Write-Output "$task is NOT Approved"}
            $script:BlackListTasks += $task}
    }
}

Function BlackListStatus {
    if ($script:BlackListTasks.count -eq 0){
        # Write-Output "Status: All Approved"}
        $script:TaskStatus = 0}
    elseif ($script:BlackListTasks.count -ge 1){
        # Write-Output "Status: Unapproved Tasks"}
        $script:TaskStatus = 1}
    else {
        # Write-Output "Status: Something Went Wrong"}
        $script:TaskStatus = 2}
}

Function BlackListTaskName {
    if ($script:BlackListTasks.count -eq 0){
        # Write-Output "Status: All Approved"}
        $script:TaskStatusName = "none"}
    elseif ($script:BlackListTasks.count -ge 1){
        # Write-Output "Status: Unapproved Tasks"}
        $script:TaskStatusName = $script:BlackListTasks[0]}
    else {
        # Write-Output "Status: Something Went Wrong"}
        $script:TaskStatusName = "something went wrong"}
}

## Output ------------------------------------------------------------------------------------------
$TotalscheduledTasks = numberOfScheduledTasksTotal
$TotalnonMicrosoftscheduledTasks = numberOfNonMicrosoftScheduledTasks
#$TaskStatusName = $script:TaskStatusName
#listScheduledTasksVerbose
#listScheduledTaskNames
GetArrayOfExisitingTaskNames
CheckForUnapprovedScheduledTasks
BlackListStatus
BlackListTaskName
# $script:BlackListTasks.count
# $script:TaskStatus 


## Send to Logfile ---------------------------------------------------------------------------------
"ScheduledTasks,Server=$computerName TotalscheduledTasks=$TotalscheduledTasks,TotalnonMicrosoftscheduledTasks=$TotalnonMicrosoftscheduledTasks,TaskStatus=$script:TaskStatus,TaskStatusName=$script:TaskStatusName" `
    | Out-File `
    -Append `
    -filepath "F:\Logs\ScheduledTasks.txt" `
    -Encoding ASCII


## Send to Grafana ---------------------------------------------------------------------------------
$Taskstats = "ScheduledTasks,Server=$computerName TotalscheduledTasks=$TotalscheduledTasks,TotalnonMicrosoftscheduledTasks=$TotalnonMicrosoftscheduledTasks,TaskStatus=$script:TaskStatus,TaskStatusName=`"$script:TaskStatusName`""

Invoke-WebRequest -Uri https://grafana.server.com:8086/write?db=mydatabase -Method POST -Body $Taskstats


