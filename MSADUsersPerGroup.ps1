$groupName = Read-Host "group name"

$groupMembers = Get-ADGroupMember -Identity "$groupName" | Select-Object objectClass, name, SamAccountName

#$groupCSV = ($groupMembers | Select-Object objectClass, name, SamAccountName)

$gn = $groupName -replace " ", ""

$fn = $env:USERPROFILE + "\" + $gn + "Members.csv"

$groupMembers | Export-Csv -Path $fn -NoTypeInformation

Start-Process -FilePath $fn
