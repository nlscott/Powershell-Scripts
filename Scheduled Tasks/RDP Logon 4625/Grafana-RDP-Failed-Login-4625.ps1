## :: SUMMARY ::
## Used with a Scheduled task that moitors logs for event ID 4625, then executes this script that 
## writes a log file on disk, and sends an Invoke-WebRequest to a influxdb server


# Ignore check on self-signed cert ----------------------------------------------
# need for "Invoke-WebRequest" because of the self-signed cert
[System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true} ;


$computerName = $env:computername
$EventID = 4625
$id4625 = Get-WinEvent -Max 1 @{logname='Security'; id=4625}
$xml = [xml]$id4625.ToXml()
$xml.event.EventData.data | out-null
$Username = $id4625.properties[5].Value
$LogonType = $id4625.properties[10].Value
$UserIP = $id4625.properties[19].Value


## Send to Logfile ---------------------------------------------------------------------------------
# Sample Log Line: Failed-Logon,Server=Server1 EventID=4625,Username="admin",UserIP="xx.xx.xx.xx",LogonType=3"
# LogonType 3 = Network Logon. For more logon types see the link below.
# See https://docs.microsoft.com/en-us/windows/security/threat-protection/auditing/event-4625

"Failed-Logon,Server=$computerName EventID=$EventID,Username=`"$Username`",UserIP=`"$UserIP`",LogonType=$LogonType" `
    | Out-File `
    -Append `
    -filepath "F:\Logs\RDP-Failed-Login-4625.txt" `
    -Encoding ASCII

## Send to InfluxDB as Line Protocol ---------------------------------------------------------------
# Data to write
$EventID4625 = "Failed-Logon,Server=$computerName EventID=$EventID,Username=`"$Username`",UserIP=`"$UserIP`",LogonType=$LogonType"

# Send reqeust
Invoke-WebRequest -Uri https://grafana.server.com:8086/write?db=databasename -Method POST -Body $EventID4625

