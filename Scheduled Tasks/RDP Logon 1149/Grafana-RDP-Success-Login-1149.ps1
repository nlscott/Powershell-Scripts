## :: SUMMARY ::
## get a list or count of all scheduled tasks
## meant to be used as a baseline on a system so you can send results to grafana/influxdb


# Ignore check on self-signed cert -----------------------------------------------------------------
# need for "Invoke-WebRequest" because of the self-signed cert
[System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true} ;

# xxx
$computerName = $env:computername
$EventID = 1149
$output = Get-WinEvent `
    -FilterHashTable `
    @{LogName='Microsoft-Windows-TerminalServices-RemoteConnectionManager/Operational';ID='1149'} ` 
    -MaxEvents 1
$Username = ([xml]$output.ToXml()).Event.UserData.EventXML.Param1
$UserIP = ([xml]$output.ToXml()).Event.UserData.EventXML.Param3


## Send to Logfile on disk -------------------------------------------------------------------------
# Sample Log Line: SuccessLogon,Server=$Serve1 EventID=1149,Username="admin",UserIP="xx.xx.xx.xx"
"SuccessLogon,Server=$computerName EventID=$EventID,Username=`"$Username`",UserIP=`"$UserIP`"" `
    | Out-File `
    -Append `
    -filepath "F:\Logs\RDP-Success-Login-1149.txt" `
    -Encoding ASCII


## Send to InfluxDB as Line Protocol ---------------------------------------------------------------
# Data to write
$EventID1149 = "RDP-Login,Server=$computerName EventID=$EventID,Username=`"$Username`",UserIP=`"$UserIP`""

# Send reqeust
Invoke-WebRequest -Uri https://grafana.server.com:8086/write?db=databasename -Method POST -Body $EventID1149

