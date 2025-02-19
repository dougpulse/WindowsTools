function Get-GroupsForObject {
    [cmdletbinding()]
    param(
        [string]$Object = "", 
        [int]$Level = 0
    )
    
    $d = Get-ADObject -Identity $Object -Properties SamAccountName
 
    if ($d.ObjectClass -eq "user" -and $Level -eq 0) {
        $e = Get-ADUser -Identity $d.DistinguishedName -Properties MemberOf
    }
		elseif ($d.ObjectClass -eq "group") {
        $e = Get-ADGroup -Identity $d.DistinguishedName -Properties MemberOf
    }
 
    $e.MemberOf | Sort-Object | %{
        # prevent a loop if the group is a member of itself
        if ( $_ -ne $e.DistinguishedName ) {
            Get-GroupsForObject -Object $_  -Level($Level + 1)
        }
    }
    $e | select name | Sort-Object -Property name
}

function RemoveDups {
    [cmdletbinding()]
    param (
        [parameter(Mandatory=$true)]
        [System.Collections.ArrayList]$ArrayList
    )
    $last = ""
    $this = ""
    [System.Collections.ArrayList]$out = @()
    foreach ($a in $ArrayList) {
        if ($a -ne $last) {
            $null = $out.add($a)
        }
        $last = $a
    }
    $out
}

$userName = Read-Host "user name"
$un = $userName -replace " ", ""
$fn = (New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path + "\" + $un + "Groups.csv"

$Object = (Get-ADuser $userName).DistinguishedName


$g = Get-GroupsForObject -Object (Get-ADuser $userName).DistinguishedName | Sort-Object -Property name



[System.Collections.ArrayList]$gp = @()
foreach ($m in $g) {
    [void]$gp.Add($m.name)
}

$groups = RemoveDups -ArrayList $gp

#$groups | Export-Csv -Path $fn -NoTypeInformation

Set-Content $fn -Value $null

foreach ($e in $groups) {
    "`"$e`"" | Add-Content $fn
}

Start-Process -FilePath $fn
