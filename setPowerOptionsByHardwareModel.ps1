

# setPowerOptionsByHardwareModel ------------------------------------------------------
# created 2017.12.21 by Nic Scott
# tested on Windows 10 1709

# SUMMARY ------------------------------------------------------------------------------
# This script sets require sign-in 'When PC wakes up from sleep'


# alternative method of pulling information
# $hardware_model=(Get-WmiObject -Class Win32_ComputerSystem | Select-Object -ExpandProperty PCSystemType)

# get class of computer, 2 is laptop, anything else is considerd desktop, server, etc
$hardware_model=(Get-WmiObject -Class Win32_ComputerSystem).PCSystemType

# sanity check
$hardware_model

if ($hardware_model -eq "2"){
  # setting power options for laptops
  #Write-Host "This is a Laptop" # sanity check
  # turn off the screen after x minutes
  powercfg -x monitor-timeout-ac 30
  powercfg -x monitor-timeout-dc 5

  # turn off hard disk after x minutes
  powercfg -x disk-timeout-ac 0
  powercfg -x disk-timeout-dc 15

  # put the computer to sleep time
  powercfg -x standby-timeout-ac 0
  powercfg -x standby-timeout-dc 10

  # hibernate after x minutes
  powercfg -x hibernate-timeout-ac 0
  powercfg -x hibernate-timeout-dc 30
}
else{
  # setting power options for desktops
  #Write-Host "This is a Desktop" #snaity check
  # turn off the screen after x minutes
  powercfg -x monitor-timeout-ac 10
  powercfg -x monitor-timeout-dc 10

  # turn off hard disk after x minutes
  powercfg -x disk-timeout-ac 0
  powercfg -x disk-timeout-dc 15

  # put the computer to sleep time
  powercfg -x standby-timeout-ac 0
  powercfg -x standby-timeout-dc 10

  # hibernate after x minutes
  powercfg -x hibernate-timeout-ac 0
  powercfg -x hibernate-timeout-dc 180
}
