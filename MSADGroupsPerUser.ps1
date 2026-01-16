function Get-GroupsForObject {
    [cmdletbinding()]
    param(
        [string]$Object = "", 
        [int]$Level = 0,
        [int]$i,
        [string]$Parent
    )
    
    $d = Get-ADObject -Identity $Object -Properties SamAccountName
 
    if ($d.ObjectClass -eq "user" -and $Level -eq 0) {
        $e = Get-ADUser -Identity $d.DistinguishedName -Properties MemberOf
    }
		elseif ($d.ObjectClass -eq "group") {
        $e = Get-ADGroup -Identity $d.DistinguishedName -Properties MemberOf
    }
    # Stop looping if this group is already in the path
    if ($Parent -like "*/$($e.Name)/*") {
        return
    }
    $e.MemberOf | Sort-Object | ForEach-Object{
        # prevent a loop if the group is a member of itself
        if ( $_ -ne $e.DistinguishedName ) {
            $me = "$parent/$((Get-ADObject -Identity $_).Name)"
            Get-GroupsForObject -Object $_ -Parent $me -i $i -Level($Level + 1)
        }
    }
    $e | Select-Object name | Sort-Object -Property name
}

function RemoveDups {
    [cmdletbinding()]
    param (
        [parameter(Mandatory=$true)]
        [System.Collections.ArrayList]$ArrayList
    )
    $last = ""
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


$g = Get-GroupsForObject -Object (Get-ADuser $userName).DistinguishedName -Parent (Get-ADuser $userName).Name -i 0 | Sort-Object -Property name



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
