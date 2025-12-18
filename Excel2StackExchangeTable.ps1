# In a shortcut, call like
# Target:  "C:\Program Files (x86)\PowerShell\7\pwsh.exe" .\Excel2StackExchange.ps1
# Start In:  "%userprofile%\repos\WindowsTools"

# Excel to Stack Exchange Table
#   First row must not contain any cells with multiple lines.
# Write-Host "




# --------------------------------
# "

$sInput = Get-Clipboard -Raw

$arrIn = $sInput -split "`r`n"

# Get first (header) row
$header = $arrIn[0] -split "`t"
$arrOut = @()
$arrOut += "|$($header -join "|")|"

$s = "|"
for ($i = 0; $i -lt $header.length; $i++) {
    $s += "---|"
}
$arrOut += $s

# Get body rows
for ($i = 1; $i -lt $arrIn.length - 1; $i++) {
    $thisRow = $arrIn[$i] -split "`t"
    for ($j = 0; $j -lt $thisRow.length; $j++) {
        $thisRow[$j]
        $thisRow[$j] = $thisRow[$j].replace("`n","<br >")
        if ($thisRow[$j] -eq "") {
            $thisRow[$j] = " "
        }
    }
    $arrOut += "|$($thisRow -join "|")|"
}

$sOutput = $arrOut -join "`n"

Set-Clipboard $sOutput

