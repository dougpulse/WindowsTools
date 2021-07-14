$userName = Read-Host "user name"

$groups = Get-ADPrincipalGroupMembership "$userName" | select name | Sort-Object -Property name

$un = $userName -replace " ", ""

$fn = $env:USERPROFILE + "\" + $un + "Groups.csv"

$groups | Export-Csv -Path $fn -NoTypeInformation

Start-Process -FilePath $fn
