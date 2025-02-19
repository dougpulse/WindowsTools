if ($args.length -eq 0) {
    Write-Host "no path provided"
    exit
}

$MappedDrives = Get-CimInstance -ClassName Win32_MappedLogicalDisk | Select-Object -Property DeviceID, ProviderName
$out = @()
foreach ($p in $args) {
    if (Test-Path $p) {
        $thisPath = $p
        foreach ($drive in $MappedDrives) {
            if ($p.Substring(0,2) -eq $drive.DeviceID) {
                $thisPath = $p.Replace($drive.DeviceID, $drive.ProviderName)
            }
        }
        $out += $thisPath
    }
}

# $Out | clip.exe
Set-Clipboard -Value $Out
