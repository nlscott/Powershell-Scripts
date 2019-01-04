


# change_RDP_Port_8175.ps1 -------------------------------------------------------------------------
# 
# 2018.11.22
# changes the RDP port from the default 3389 to custom 8175 
# with access from only approved Remote Addresses
#

# chane the port to anything you want
$RDPPort = "8175"

# to add multiple IP addresses, seperate with a comma. IPs and CIDR's need to be in quotes, these IPs
# are just an example, please change them to something valid before testing
$remoteAddresses = "100.100.100.100","101.101.1.0/25"



# Edit the registry, change RDP Port, add a firewall rule to allow access from remote addresses only
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-TCP\" -Name PortNumber -Value $RDPPort
New-NetFirewallRule -DisplayName "Remote Desktop Custom Port" -Direction Inbound –LocalPort $RDPPort -Protocol TCP -Action Allow -RemoteAddress $remoteAddresses
