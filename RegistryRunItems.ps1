## SUMMARY ---------------------------------------------------------------------
# Read entries in $registryKey and adds each name to an array, then checks to
# see if the names are in the Approved list ($ApprovedRegistryRunItems)


## VARIABLES -------------------------------------------------------------------
$registryKey = "Registry::HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run"
$script:arrayofRunEntries = @()
$ApprovedRegistryRunItems = @(
    "SecurityHealth"
)

## FUNCTIONS -------------------------------------------------------------------
Function getRegistryRunItems {
    Get-Item `
        -Path $registryKey `
        | Select-Object -ExpandProperty Property
}

Function addtoarrayofRunEntries {
    $results = getRegistryRunItems
    foreach($x in $results){
        # Write-Output $x
        $script:arrayofRunEntries += $x
    }
}

Function numberofRegistryRunEntries {
    addtoarrayofRunEntries
    $count = ($script:arrayofRunEntries).count
    $count
}

Function CheckForUnapprovedRegistryRunItems {
    addtoarrayofRunEntries
    foreach($item in $script:arrayofRunEntries){
        if($ApprovedRegistryRunItems -contains $item){
            Write-Output "$item`: Approved"}
            else {Write-Output "$item`: NOT Approved"}
    }
}


## OUTPUT ----------------------------------------------------------------------

getRegistryRunItems
numberofRegistryRunEntries
CheckForUnapprovedRegistryRunItems