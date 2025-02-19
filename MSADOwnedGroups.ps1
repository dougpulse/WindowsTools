"







------------------------
"
$functions = Join-Path $env:USERPROFILE "repos\CognosAdmin\RESTAPI\fn.ps1"
. $functions


$user = Read-Host "Group Owner"
$groups = Get-ADGroup -Filter '*' -Properties nTSecurityDescriptor

$l = $groups.Count
$objName = "group"
# $a = @()
$b = @()
$i = 0
Write-Host "$l groups in Active Directory"
$startTime = Get-Date
foreach ($g in $groups) {
    if ($g.nTSecurityDescriptor.Owner -eq $user) {
        # $a += $g
        $b += get-ADPath -DistinguishedName $g.DistinguishedName -BasePath "WSDOT.LOC" -BasePathLength 2
    }

    $i++
    $p = [int]($i * 100 / $l)
    
    $elapsed = ((Get-Date) - $startTime).TotalSeconds
    $remainingItems = $l - $i
    $averageItemTime = $elapsed / $i

    Write-Progress "Processing $l $($objName)s" `
			-Status "$i $($objName)s processed" `
			-PercentComplete $p `
			-SecondsRemaining ($remainingItems * $averageItemTime)
}

Write-Host "$($b.Length) groups owned by $user
"

foreach ($c in $b) {
    Write-Host $c
}

