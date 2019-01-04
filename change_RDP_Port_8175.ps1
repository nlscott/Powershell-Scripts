


# change_RDP_Port_8175.ps1 -------------------------------------------------------------------------
# 
# 2018.11.22
# changes the RDP port from the default 3389 to custom 8175 
# with access from only approved Remote Addresses
#
# Change RemoteAddress as needed, the IP here is just an example
#

$RDPPort = "8175"
$remoteAddresses = "100.100.100.100"


# Edit the registry, change RDP Port, add a firewall rule to allow access from remote addresses only
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-TCP\" -Name PortNumber -Value $RDPPort
New-NetFirewallRule -DisplayName "Remote Desktop Custom Port" -Direction Inbound –LocalPort $RDPPort -Protocol TCP -Action Allow -RemoteAddress $remoteAddresses
