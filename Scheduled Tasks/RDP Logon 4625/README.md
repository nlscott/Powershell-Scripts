# Monitor Failed Logins To Windows VM



![Login-4625](support/Login-4625.png)

Monitor failed login attempts (including RDP logins) to a Windows Virtual Machine. Consist of two parts:

-   Scheduled Task that monitors Microsoft Event logs for Event ID: `4625`
-   A powershell script that gets triggered when the Event is found
    -   The script, writes a log file on disk
    -   Sends an `Invoke-WebRequest` to an Influxdb server (to be visualized with Grafana for setting alerts)