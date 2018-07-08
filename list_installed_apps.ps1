
#create new array
$base_apps = @('Microsoft DCF MUI (English) 2016', 'Microsoft Office Professional Plus 2016',
'Microsoft OneNote MUI (English) 2016', 'Microsoft Office OSM MUI (English) 2016',
'Microsoft Office OSM UX MUI (English) 2016', 'Microsoft InfoPath MUI (English) 2016',
'Microsoft Access MUI (English) 2016', 'Microsoft Office Shared Setup Metadata MUI (English) 2016',
'Microsoft Excel MUI (English) 2016', 'Microsoft Office Shared 64-bit Setup Metadata MUI (English) 2016',
'Microsoft Access Setup Metadata MUI (English) 2016', 'Microsoft PowerPoint MUI (English) 2016',
'Microsoft Outlook MUI (English) 2016', 'Microsoft Office 64-bit Components 2016',
'Microsoft Office Shared 64-bit MUI (English) 2016', 'Microsoft Groove MUI (English) 2016',
'Microsoft Word MUI (English) 2016', 'Microsoft Skype for Business MUI (English) 2016',
'Microsoft Office Proofing (English) 2016', 'Microsoft Office Shared MUI (English) 2016',
'Microsoft Office Proofing Tools 2016 - English', 'Microsoft Publisher MUI (English) 2016',
'Microsoft Visual C++ 2010  x64 Redistributable - 10.0.40219', 'Microsoft Visual C++ 2010  x86 Redistributable - 10.0.40219',
'Microsoft Visual C++ 2008 Redistributable - x64 9.0.30729.6161', 'Microsoft Visual C++ 2008 Redistributable - x86 9.0.30729.6161')

$installed_apps = @()
$userInstalledApps = @()


#=======================================================================================
# query for all installed apps 

$all_installed_apps = {Get-WmiObject -Class Win32_Product | Select-Object -ExpandProperty Name}

foreach ($app in &$all_installed_apps){
    $installed_apps += $app.trim()
}

#=======================================================================================
#remove foregin langues names that contain special characters
$installed_apps = $installed_apps | where {$_ -notmatch '^Herr*'}
$installed_apps = $installed_apps | where {$_ -notmatch '^Outils*'}

#=======================================================================================
#filter out apps that are listed in baseapps
foreach ($item in $installed_apps){
    if ($base_apps -notcontains $item) {
        $userInstalledApps += $item
    }
}

#=======================================================================================
#show results
$numberofinstalledapps=$userInstalledApps.count
Write-Host "Total number of installed apps: $numberofinstalledapps"
Write-Host "======================================="
$userInstalledApps