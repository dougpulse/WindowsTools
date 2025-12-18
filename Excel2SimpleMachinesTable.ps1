# In a shortcut, call like
# Target:  "C:\Program Files (x86)\PowerShell\7\pwsh.exe" .\Excel2SimpleMachinesTable.ps1
# Start In:  "%userprofile%\repos\WindowsTools"

# Excel to Simple Machines Table
# Write-Host "




# --------------------------------
# "

$sInput = Get-Clipboard -Raw
# Write-Host $sInput
# Write-Host ($sInput -split "`r`n")

$arrIn = $sInput -split "`r`n"
# Write-Host $arrIn
$sStartRow = "[tr][td]"
$sEndRow = "[/td][/tr]"
$sTab = "[/td][td]"
$arrOut = @()


for ($i = 0; $i -lt $arrIn.length; $i++) {
    $arrOut += "$sStartRow$($arrIn[$i].replace("`t", $sTab))$sEndRow"
    # Write-Host $arrOut[$i]
    if ($i -eq 0) {
        $arrOut[$i] = $arrOut[$i].replace("[td]", "[td][b]")
        $arrOut[$i] = $arrOut[$i].replace("[/td]", "[/b][/td]");
    }
}

$sOutput = "[table]`n$($arrOut -join "`n")`n[/table]"

# $sOutput
Set-Clipboard $sOutput

