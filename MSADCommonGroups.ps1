<#
.SYNOPSIS
Find all of the Active Directory groups of which all users are a member.

.DESCRIPTION

.PARAMETER users
An array of the names of the users to compare.

.EXAMPLE
$users = @()
$users += "Gates, Bill"
$users += "Jobs, Steve"
$users += "Wozniak, Steve"
.\MSADCommonGroups $users
#>

[CmdletBinding()]
param( 
    [parameter(position=0, mandatory=$true)]
    [string[]]$users
)

$thisFolder = (Split-Path $MyInvocation.MyCommand.Source)
Set-Location $thisFolder
. ".\fn.ps1"


$userGroups = @()
$groupNames = @()
$i = 0
foreach ($u in $users) {
    $groupNames = @()
    $groups = (Get-ADUser -filter "Name -eq '$u'" -Properties MemberOf).MemberOf
    foreach ($g in $groups) {
        $groupNames += (Get-ADGroup $g).Name
    }
    if ($i -eq 0) {
        $userGroups = $groupNames
    }
    else {
        $userGroups = arrayAnd $userGroups $groupNames
    }
    if ($userGroups.Length -eq 0) {
        "No matches"
    }
    $i++
}

"$($userGroups.Length) groups in common:"
$userGroups | Sort-Object
