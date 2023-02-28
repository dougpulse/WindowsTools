param(
    [string]$computer,
    [string]$source
)

$s = New-PSSession -ComputerName $computer -Credential wsdot\pulsed
Invoke-Command -Session $s -ScriptBlock {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12}
Invoke-Command -Session $s -ScriptBlock {$src = $Using:source}
Invoke-Command -Session $s -ScriptBlock {$dest = Join-Path $env:USERPROFILE "Downloads"}
Invoke-Command -Session $s -ScriptBlock {Start-BitsTransfer -Source $src -Destination $dest}
