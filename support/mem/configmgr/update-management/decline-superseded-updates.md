---
title: Decline superseded updates in Windows Server Update Services (WSUS)
description: Provides a PowerShell script to decline superseded updates in WSUS.
ms.date: 12/05/2023
ms.reviewer: kaushika, jarrettr, v-six
ms.custom: sap:Software Update Management (SUM)\WSUS Database Maintenance
---
# PowerShell script to decline superseded updates in WSUS

If you are using standalone Windows Server Update Services (WSUS) servers or an older version of Configuration Manager, you can manually decline superseded updates by using the WSUS console. Or you can run the following PowerShell script. For common questions about WSUS maintenance for Configuration Manager environments, see [the complete guide to WSUS and Configuration Manager SUP maintenance](wsus-maintenance-guide.md).

```powershell
<#
    .SYNOPSIS
        Script to decline superseeded updates in WSUS. It's recommended to run the script with the -SkipDecline switch to see how many superseded updates 
        are in WSUS and to TAKE A BACKUP OF THE SUSDB before declining the updates.

    .PARAMETER UpdateServer
        Specify WSUS Server Name

    .PARAMETER Port
        WSUS Server Port

    .PARAMETER UseSSL
        Specifies whether WSUS Server is configured to use SSL

    .PARAMETER SkipDecline
        Runs decline script in audit mode

    .PARAMETER DeclineLastLevelOnly
        Whether to decline all superseded updates or only last level superseded updates

        Supersedence chain could have multiple updates. For example, Update1 supersedes Update2. Update2 supersedes Update3. In this scenario,
        the Last Level in the supersedence chain is Update3. To decline only the last level updates in the supersedence chain, specify the DeclineLastLevelOnly switch

    .PARAMETER ExclusionPeriod
        The number of days between today and the release date for which the superseded updates must not be declined.

    .EXAMPLE
        # To do a test run against WSUS Server without SSL
        Decline-SupersededUpdates.ps1 -UpdateServer SERVERNAME -Port 8530 -SkipDecline

    .EXAMPLE
        # To do a test run against WSUS Server using SSL
        Decline-SupersededUpdates.ps1 -UpdateServer SERVERNAME -UseSSL -Port 8531 -SkipDecline

    .EXAMPLE
        # To decline all superseded updates on the WSUS Server using SSL
        Decline-SupersededUpdates.ps1 -UpdateServer SERVERNAME -UseSSL -Port 8531

    .EXAMPLE
        # To decline only Last Level superseded updates on the WSUS Server using SSL
        Decline-SupersededUpdates.ps1 -UpdateServer SERVERNAME -UseSSL -Port 8531 -DeclineLastLevelOnly

    .EXAMPLE
        # To decline all superseded updates on the WSUS Server using SSL but keep superseded updates published within the last 2 months (60 days)
        Decline-SupersededUpdates.ps1 -UpdateServer SERVERNAME -UseSSL -Port 8531 -ExclusionPeriod 60
#>
[CmdletBinding()]
param
(
    [Parameter(Mandatory = $true, Position = 1)]
    [string]
    $UpdateServer,

    [Parameter(Mandatory = $true, Position = 2)]
    [int]
    $Port,

    [Parameter()]
    [switch]
    $UseSSL,

    [Parameter()]
    [switch]
    $SkipDecline,

    [Parameter()]
    [switch]
    $DeclineLastLevelOnly,

    [Parameter()]
    [int]
    $ExclusionPeriod = 0
)

if (-not (Test-Path -Path "$PSScriptRoot\WsusDeclineLogs"))
{
    New-Item -Path $PSScriptRoot -Name 'WsusDeclineLogs' -ItemType Directory -Force
}

$file = "$PSScriptRoot\WsusDeclineLogs\WSUS_Decline_Superseded_{0:MMddyyyy_HHmm}.log" -f (Get-Date) 

Start-Transcript -Path $file

if ($SkipDecline -and $DeclineLastLevelOnly)
{
    Write-Output -InputObject 'Using SkipDecline and DeclineLastLevelOnly switches together is not allowed.'
    Write-Output -InputObject ''
    return
}

$outSupersededList = Join-Path -Path "$PSScriptRoot\WsusDeclineLogs" -ChildPath 'SupersededUpdates.csv'
$outSupersededListBackup = Join-Path -Path "$PSScriptRoot\WsusDeclineLogs" -ChildPath 'SupersededUpdatesBackup.csv'

Set-Content -Value 'UpdateID, RevisionNumber, Title, KBArticle, SecurityBulletin, LastLevel' -Path $outSupersededList

try
{
    if ($UseSSL)
    {
        Write-Output -InputObject "Connecting to WSUS server $UpdateServer on Port $Port using SSL... "
    }
    else
    {
        Write-Output -InputObject "Connecting to WSUS server $UpdateServer on Port $Port... "
    }
    
    [reflection.assembly]::LoadWithPartialName('Microsoft.UpdateServices.Administration') | Out-Null
    $wsus = [Microsoft.UpdateServices.Administration.AdminProxy]::GetUpdateServer($UpdateServer, $UseSSL, $Port);
}
catch [System.Exception] 
{
    Write-Output -InputObject 'Failed to connect.'
    Write-Output -InputObject "Error: $($_.Exception.Message)"
    Write-Output -InputObject 'Please make sure that WSUS Admin Console is installed on this machine'
    Write-Output -InputObject ''
    $wsus = $null
}

if ($null -eq $wsus)
{
    return
}

Write-Output -InputObject 'Connected.'

$UpdateScope = New-Object Microsoft.UpdateServices.Administration.UpdateScope

(Get-Date).AddMonths(-6)
$UpdateScope.FromArrivalDate = (Get-Date).AddMonths(-6)
$UpdateScope.ToArrivalDate = (Get-Date)

$countAllUpdates = 0
$countSupersededAll = 0
$countSupersededLastLevel = 0
$countSupersededExclusionPeriod = 0
$countSupersededLastLevelExclusionPeriod = 0
$countDeclined = 0

Write-Output -InputObject 'Getting a list of all updates... '

try
{
    $allUpdates = $wsus.GetUpdates($UpdateScope)
}
catch [System.Exception]
{
    Write-Output -InputObject 'Failed to get updates.'
    Write-Output -InputObject "Error: $($_.Exception.Message)"
    Write-Output -InputObject 'If this operation timed out, please decline the superseded updates from the WSUS Console manually.'
    Write-Output -InputObject ''
    return
}

Write-Output -InputObject 'Done'

Write-Output -InputObject 'Parsing the list of updates... '
foreach ($update in $allUpdates)
{
    $countAllUpdates++

    if ($update.IsDeclined)
    {
        $countDeclined++
    }

    if (-not $update.IsDeclined -and $update.IsSuperseded)
    {
        $countSupersededAll++
    
        if (-not $update.HasSupersededUpdates)
        {
            $countSupersededLastLevel++
        }

        if ($update.CreationDate -lt (Get-Date).AddDays(-$ExclusionPeriod))
        {
            $countSupersededExclusionPeriod++
            if (-not $update.HasSupersededUpdates)
            {
                $countSupersededLastLevelExclusionPeriod++
            }
        }

        "$($update.Id.UpdateId.Guid), $($update.Id.RevisionNumber), $($update.Title), $($update.KnowledgeBaseArticles), $($update.SecurityBulletins), $($update.HasSupersededUpdates)" | Out-File $outSupersededList -Append
    }
}

Write-Output -InputObject 'Done.'
Write-Output -InputObject "List of superseded updates: $outSupersededList"

Write-Output -InputObject ''
Write-Output -InputObject 'Summary:'
Write-Output -InputObject '========'

Write-Output -InputObject "All Updates = $countAllUpdates"
$AnyExceptDeclined = $countAllUpdates - $countDeclined
Write-Output -InputObject "Any except Declined = $AnyExceptDeclined"
Write-Output -InputObject "All Superseded Updates = $countSupersededAll"
$SuperseededAllOutput = $countSupersededAll - $countSupersededLastLevel
Write-Output -InputObject "    Superseded Updates (Intermediate) = $SuperseededAllOutput"
Write-Output -InputObject "    Superseded Updates (Last Level) = $countSupersededLastLevel"
Write-Output -InputObject "    Superseded Updates (Older than $ExclusionPeriod days) = $countSupersededExclusionPeriod"
Write-Output -InputObject "    Superseded Updates (Last Level Older than $ExclusionPeriod days) = $countSupersededLastLevelExclusionPeriod"

$i = 0
if (-not $SkipDecline)
{
    
    Write-Output -InputObject "SkipDecline flag is set to $SkipDecline. Continuing with declining updates"
    $updatesDeclined = 0
    
    if ($DeclineLastLevelOnly)
    {
        Write-Output -InputObject '  DeclineLastLevel is set to True. Only declining last level superseded updates.' 
        
        foreach ($update in $allUpdates)
        {
            
            if (-not $update.IsDeclined -and $update.IsSuperseded -and -not $update.HasSupersededUpdates)
            {
                if ($update.CreationDate -lt (Get-Date).AddDays(-$ExclusionPeriod))
                {
                    $i++
                    $percentComplete = "{0:N2}" -f (($updatesDeclined / $countSupersededLastLevelExclusionPeriod) * 100)
                    Write-Progress -Activity "Declining Updates" -Status "Declining update #$i/$countSupersededLastLevelExclusionPeriod - $($update.Id.UpdateId.Guid)" -PercentComplete $percentComplete -CurrentOperation "$($percentComplete)% complete"

                    try
                    {
                        $update.Decline()
                        $updatesDeclined++
                    }
                    catch [System.Exception]
                    {
                        Write-Output -InputObject "Failed to decline update $($update.Id.UpdateId.Guid). Error:" $_.Exception.Message
                    }
                }
            }
        }
    }
    else
    {
        Write-Output -InputObject '  DeclineLastLevel is set to False. Declining all superseded updates.'

        foreach ($update in $allUpdates)
        {
            
            if (-not $update.IsDeclined -and $update.IsSuperseded)
            {
                if ($update.CreationDate -lt (Get-Date).AddDays(-$ExclusionPeriod))
                {
                  
                    $i++
                    $percentComplete = "{0:N2}" -f (($updatesDeclined / $countSupersededAll) * 100)
                    Write-Progress -Activity "Declining Updates" -Status "Declining update #$i/$countSupersededAll - $($update.Id.UpdateId.Guid)" -PercentComplete $percentComplete -CurrentOperation "$($percentComplete)% complete"
                    try
                    {
                        $update.Decline()
                        $updatesDeclined++
                    }
                    catch [System.Exception]
                    {
                        Write-Output -InputObject "Failed to decline update $($update.Id.UpdateId.Guid). Error:" $_.Exception.Message
                    }
                }
            }
        }
    }

    Write-Output -InputObject "  Declined $updatesDeclined updates."

    if ($updatesDeclined -ne 0)
    {
        Copy-Item -Path $outSupersededList -Destination $outSupersededListBackup -Force
        Write-Output -InputObject "  Backed up list of superseded updates to $outSupersededListBackup"
    }
}
else
{
    Write-Output -InputObject "SkipDecline flag is set to $SkipDecline. Skipped declining updates"
}

Write-Output -InputObject ''
Write-Output -InputObject 'Done'
Write-Output -InputObject ''

Stop-Transcript

```
