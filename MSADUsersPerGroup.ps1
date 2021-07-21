function Get-UsersInGroup {
    [cmdletbinding()]
    param (
        [parameter(Mandatory=$true)]
        [string]$Object
    )
    
    [System.Collections.ArrayList]$Users = @()
 
    $x = Get-ADObject -Identity $Object -Properties SamAccountName
 
    if ($x.ObjectClass -eq "group") {
        $y = Get-ADGroup -Identity $Object -Properties Members
 
        $y.Members | %{
            $o = Get-ADObject -Identity $_ -Properties SamAccountName
 
            if ($o.ObjectClass -eq "user") {
                $null = $Users.Add($o)
            }
            elseif ($o.ObjectClass -eq "group") {
                Get-UsersInGroup -Object $o.DistinguishedName
            }
        }
    } else {
        Write-Warning "$($Object) is not a group, it is a $($x.ObjectClass)"
    }
    $Users | select name | Sort-Object -Property name
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

$groupName = Read-Host "group name"
$gn = $groupName -replace " ", ""
$fn = (New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path + "\" + $gn + "Members.csv"
$gm = Get-UsersInGroup -Object (Get-ADGroup "$groupName").DistinguishedName | Sort-Object -Property name

[System.Collections.ArrayList]$gpMem = @()
foreach ($m in $gm) {
    [void]$gpMem.Add($m.name)
}

$gpMembers = RemoveDups -ArrayList $gpMem

Set-Content $fn -Value $null

foreach ($e in $gpMembers) {
    "`"$e`"" | Add-Content $fn
}

Start-Process -FilePath $fn
