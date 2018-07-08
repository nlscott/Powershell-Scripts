# setBranchLevel ----------------------------------------------------------------------
# created 2017.12.23 by Nic Scott
# tested on Windows 10 1709

# SUMMARY ------------------------------------------------------------------------------
# this script sets the Branch readyness level, defer feature udpates, and defer quality Updates
# settings found at: Settings > Updates & Secruity > Windows update > Advanced options

$BranchReadinessLevel_Path = "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings"
$BranchReadinessLevel_Name = "BranchReadinessLevel"
$BranchReadinessLevel_Level = "32"

$DeferFeatureUpdatesPeriodInDays_Path = "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings"
$DeferFeatureUpdatesPeriodInDays_Name = "DeferFeatureUpdatesPeriodInDays"
$DeferFeatureUpdatesPeriodInDays_Level = "90"

$DeferQualityUpdatesPeriodInDays_Path = "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings"
$DeferQualityUpdatesPeriodInDays_Name = "DeferQualityUpdatesPeriodInDays"
$DeferQualityUpdatesPeriodInDays_Level = "30"


# create and set Service Branch level --------------------------------------------------------------
if(!(Test-Path $BranchReadinessLevel_Path)){
    New-Item -Path $BranchReadinessLevel_Path -Force | Out-Null
    New-ItemProperty -Path $BranchReadinessLevel_Path `
    -Name $BranchReadinessLevel_Name `
    -Value $BranchReadinessLevel_Level `
    -PropertyType DWORD -Force | Out-Null
}
 else {
   New-ItemProperty -Path $BranchReadinessLevel_Path `
   -Name $BranchReadinessLevel_Name `
   -Value $BranchReadinessLevel_Level `
   -PropertyType DWORD -Force | Out-Null}

# create and set feature updates in days -----------------------------------------------------------
if(!(Test-Path $DeferFeatureUpdatesPeriodInDays_Path)){
    New-Item -Path $DeferFeatureUpdatesPeriodInDays_Path -Force | Out-Null
    New-ItemProperty -Path $DeferFeatureUpdatesPeriodInDays_Path `
    -Name $DeferFeatureUpdatesPeriodInDays_Name `
    -Value $DeferFeatureUpdatesPeriodInDays_Level `
    -PropertyType DWORD -Force | Out-Null
}
 else {
     New-ItemProperty -Path $DeferFeatureUpdatesPeriodInDays_Path `
    -Name $DeferFeatureUpdatesPeriodInDays_Name `
    -Value $DeferFeatureUpdatesPeriodInDays_Level `
    -PropertyType DWORD -Force | Out-Null
}

# set and create quality updates in days -----------------------------------------------------------
if(!(Test-Path $DeferQualityUpdatesPeriodInDays_Path)){
    New-Item -Path $DeferQualityUpdatesPeriodInDays_Path -Force | Out-Null
    New-ItemProperty -Path $DeferQualityUpdatesPeriodInDays_Path `
    -Name $DeferQualityUpdatesPeriodInDays_Name `
    -Value $DeferQualityUpdatesPeriodInDays_Level `
    -PropertyType DWORD -Force | Out-Null
}
 else {
     New-ItemProperty -Path $DeferQualityUpdatesPeriodInDays_Path `
    -Name $DeferQualityUpdatesPeriodInDays_Name `
    -Value $DeferQualityUpdatesPeriodInDays_Level `
    -PropertyType DWORD -Force | Out-Null
}
