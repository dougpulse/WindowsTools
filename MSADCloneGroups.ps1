<#
.SYNOPSIS
Clone AD groups.

.DESCRIPTION
For all groups whose names begin with a specific sequence, clone those groups to groups named with a different prefix.

.PARAMETER oldNamePrefix

.PARAMETER oldNamePrefix

.EXAMPLE
# I want the same groups with access to my SSRS reports to have similar 
# permissions in Power BI, but I may want some differences in the future, and 
# I will want to retire SSRS and the associated groups at some point.
# And I want to put those groups in MyCompany.Com/Groups/ReportingSystem.
.\CopyADGroups.ps1 "SSRS" "PowerBI" "OU=ReportingSystem,OU=Groups,DC=MyCompany,DC=Com
#>
[CmdletBinding()]
param( 
    [parameter(position=0, mandatory=$true)]
    [string[]]$oldNamePrefix
    [parameter(position=1, mandatory=$true)]
    [string[]]$newNamePrefix
    [parameter(position=2, mandatory=$true)]
    [string[]]$destinationPath
)

$thisFolder = (Split-Path $MyInvocation.MyCommand.Source)
Set-Location $thisFolder
. ".\fn.ps1"

$searchPattern = "`"$oldNamePrefix*`""
$aGroups = Get-ADGroup -Filter "SamAccountName -like $searchPattern" -Properties *
$bGroups = Get-ADGroup -Filter "Name -like $searchPattern" -Properties *
$oldGroups = $aGroups + $bGroups | Select-Object -Unique

$l = $oldGroups.Count
$i = 0
$startTime = Get-Date
$newGroups = @()

foreach ($g in $oldGroups) {
    $Path = $destinationPath    # $g.LastKnownParent
    $Name = $g.Name.Replace($oldNamePrefix, $newNamePrefix)
    $GroupCategory = $g.GroupCategory
    $GroupScope = $g.GroupScope
    $Description = $g.Description
    $DisplayName = $g.DisplayName ? $g.DisplayName.Replace($oldNamePrefix, $newNamePrefix) : $null
    $SamAccountName = $g.SamAccountName.Replace($oldNamePrefix, $newNamePrefix)
    $members = $g.Members | ForEach-Object{Get-ADObject $_ -Properties *}
    $memberOf = $g.MemberOf | ForEach-Object{Get-ADObject $_ -Properties *}

    try {
        $newGroup = New-ADGroup -Path $Path `
                                -Name $Name `
                                -GroupCategory $GroupCategory `
                                -GroupScope $GroupScope `
                                -Description $Description `
                                -DisplayName $DisplayName `
                                -SamAccountName $SamAccountName
        # Add the members
        foreach ($m in $members) {
            # We're adding the old members, even if they are in the old pattern.
            # We'll fix this later.
            Add-ADGroupMember -Identity $SamAccountName -Members $m
        }
        
        # Add the parents
        foreach ($p in $memberOf) {
            Add-ADGroupMember -Identity $p.sAMAccountName -Members $newGroup
        }
        $newGroups += $newGroup
    }
    catch {
        
    }  

    $i++
    $p = [int]($i * 100 / $l)
    
    $elapsed = ((Get-Date) - $startTime).TotalSeconds
    $remainingItems = $l - $i
    $averageItemTime = $elapsed / $i

    Write-Progress "Processing $l groups" -Status "$i groups processed" `
        -PercentComplete $p `
        -SecondsRemaining ($remainingItems * $averageItemTime)
}

$searchPattern = "`"$newNamePrefix*`""
$aGroups = Get-ADGroup -Filter "SamAccountName -like $searchPattern" -Properties *
$bGroups = Get-ADGroup -Filter "Name -like $searchPattern" -Properties *
$newGroups = $aGroups + $bGroups | Select-Object -Unique

$l = $newGroups.Count
$i = 0
$startTime = Get-Date

foreach ($g in $newGroups) {
    # $Path = $destinationPath    # $g.LastKnownParent
    $Name = $g.Name     # .Replace($oldNamePrefix, $newNamePrefix)
    $GroupCategory = $g.GroupCategory
    $GroupScope = $g.GroupScope
    $Description = $g.Description
    $DisplayName = $g.DisplayName ? $g.DisplayName <#.Replace($oldNamePrefix, $newNamePrefix)#> : $null
    $SamAccountName = $g.SamAccountName     # .Replace($oldNamePrefix, $newNamePrefix)

    # If we added member groups that have the old prefix, switch each to the group with the new prefix.
    $members = $g.Members | ForEach-Object{Get-ADObject $_}
    foreach ($m in $members) {
        if ($m.Name -like "$oldNamePrefix*") {
            Add-ADGroupMember -Identity $g.SamAccountName -Members $m.Name.Replace($oldNamePrefix, $newNamePrefix)
            Remove-ADGroupMember -Identity $g.SamAccountName -Members $m.Name
        }
    }

    # If we added parents that have the old prefix, switch each to the group with the new prefix.
    $memberOf = $g.MemberOf | ForEach-Object{Get-ADObject $_}
    foreach ($p in $memberOf) {
        if ($p.Name -like "$oldNamePrefix*") {
            Add-ADGroupMember -Identity $p.SamAccountName.Replace($oldNamePrefix, $newNamePrefix) -Members $g
            Remove-ADGroupMember -Identity $p.SamAccountName -Members $g
        }
    }

    $i++
    $p = [int]($i * 100 / $l)
    
    $elapsed = ((Get-Date) - $startTime).TotalSeconds
    $remainingItems = $l - $i
    $averageItemTime = $elapsed / $i

    Write-Progress "Processing $l groups" -Status "$i groups processed" `
        -PercentComplete $p `
        -SecondsRemaining ($remainingItems * $averageItemTime)
}
