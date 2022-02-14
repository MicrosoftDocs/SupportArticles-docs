---
title: Decline superseded updates in Windows Server Update Services (WSUS)
description: Provides a PowerShell script to decline superseded updates in WSUS.
ms.date: 7/21/2021
ms.reviewer: jarrettr
author: simonxjx
ms.author: v-six
---
# PowerShell script to decline superseded updates in WSUS

If you are using standalone Windows Server Update Services (WSUS) servers or an older version of Configuration Manager, you can manually decline superseded updates by using the WSUS console. Or you can run the following PowerShell script. For common questions about WSUS maintenance for Configuration Manager environments, see [the complete guide to WSUS and Configuration Manager SUP maintenance](wsus-maintenance-guide.md).

```powershell
# ===============================================
# Script to decline superseded updates in WSUS.
# ===============================================
# We recommend that you run the script together with the -SkipDecline switch to see how many superseded updates are in WSUS. Also, you should MAKE A BACKUP OF THE SUSDB before you decline the updates.
# Parameters:

# $UpdateServer             = Specify WSUS server name.
# $UseSSL                   = Specify whether WSUS server is configured to use SSL.
# $Port                     = Specify WSUS server port.
# $SkipDecline              = Specify this to do a test run and get a summary of how many superseded updates we have.
# $DeclineLastLevelOnly     = Specify whether to decline all superseded updates or only last level superseded updates.
# $ExclusionPeriod          = Specify the number of days between today and the release date for which the superseded updates must not be declined. For example, if you want to keep superseded updates that were published within the last two months, specify a value of 60 (days).


# Supersedence chain could have multiple updates. 
# For example, Update1 supersedes Update2. Update2 supersedes Update3. In this scenario, the Last Level in the supersedence chain is Update3. 
# To decline only the last level updates in the supersedence chain, specify the -DeclineLastLevelOnly switch.

# Usage:
# =======

# To do a test run against WSUS Server without SSL
# Decline-SupersededUpdates.ps1 -UpdateServer SERVERNAME -Port 8530 -SkipDecline

# To do a test run against WSUS Server using SSL
# Decline-SupersededUpdates.ps1 -UpdateServer SERVERNAME -UseSSL -Port 8531 -SkipDecline

# To decline all superseded updates on the WSUS Server using SSL
# Decline-SupersededUpdates.ps1 -UpdateServer SERVERNAME -UseSSL -Port 8531

# To decline only Last Level superseded updates on the WSUS Server using SSL
# Decline-SupersededUpdates.ps1 -UpdateServer SERVERNAME -UseSSL -Port 8531 -DeclineLastLevelOnly

# To decline all superseded updates on the WSUS Server using SSL but keep superseded updates that were published within the last two months (60 days)
# Decline-SupersededUpdates.ps1 -UpdateServer SERVERNAME -UseSSL -Port 8531 -ExclusionPeriod 60


[CmdletBinding()]
Param(
    [Parameter(Mandatory=$True,Position=1)]
    [string] $UpdateServer,
    
    [Parameter(Mandatory=$False)]
    [switch] $UseSSL,
    
    [Parameter(Mandatory=$True, Position=2)]
    $Port,
    
    [switch] $SkipDecline,
    
    [switch] $DeclineLastLevelOnly,
    
    [Parameter(Mandatory=$False)]
    [int] $ExclusionPeriod = 0
)

Write-Host ""

if ($SkipDecline -and $DeclineLastLevelOnly) {
    Write-Host "Using SkipDecline and DeclineLastLevelOnly switches together is not allowed."
    Write-Host ""
    return
}

$outPath = Split-Path $script:MyInvocation.MyCommand.Path
$outSupersededList = Join-Path $outPath "SupersededUpdates.csv"
$outSupersededListBackup = Join-Path $outPath "SupersededUpdatesBackup.csv"
"UpdateID, RevisionNumber, Title, KBArticle, SecurityBulletin, LastLevel" | Out-File $outSupersededList

try {
    
    if ($UseSSL) {
        Write-Host "Connecting to WSUS server $UpdateServer on Port $Port using SSL... " -NoNewLine
    } Else {
        Write-Host "Connecting to WSUS server $UpdateServer on Port $Port... " -NoNewLine
    }
    
    [reflection.assembly]::LoadWithPartialName("Microsoft.UpdateServices.Administration") | out-null
    $wsus = [Microsoft.UpdateServices.Administration.AdminProxy]::GetUpdateServer($UpdateServer, $UseSSL, $Port);
}
catch [System.Exception] 
{
    Write-Host "Failed to connect."
    Write-Host "Error:" $_.Exception.Message
    Write-Host "Please make sure that WSUS Admin Console is installed on this machine"
    Write-Host ""
    $wsus = $null
}

if ($wsus -eq $null) { return } 

Write-Host "Connected."

$countAllUpdates = 0
$countSupersededAll = 0
$countSupersededLastLevel = 0
$countSupersededExclusionPeriod = 0
$countSupersededLastLevelExclusionPeriod = 0
$countDeclined = 0

Write-Host "Getting a list of all updates... " -NoNewLine

try {
    $allUpdates = $wsus.GetUpdates()
}

catch [System.Exception]
{
    Write-Host "Failed to get updates."
    Write-Host "Error:" $_.Exception.Message
    Write-Host "If this operation timed out, please decline the superseded updates from the WSUS Console manually."
    Write-Host ""
    return
}

Write-Host "Done"

Write-Host "Parsing the list of updates... " -NoNewLine
foreach($update in $allUpdates) {
    
    $countAllUpdates++
    
    if ($update.IsDeclined) {
        $countDeclined++
    }
    
    if (!$update.IsDeclined -and $update.IsSuperseded) {
        $countSupersededAll++
        
        if (!$update.HasSupersededUpdates) {
            $countSupersededLastLevel++
        }

        if ($update.CreationDate -lt (get-date).AddDays(-$ExclusionPeriod))  {
            $countSupersededExclusionPeriod++
            if (!$update.HasSupersededUpdates) {
                $countSupersededLastLevelExclusionPeriod++
            }
        }        
        
        "$($update.Id.UpdateId.Guid), $($update.Id.RevisionNumber), $($update.Title), $($update.KnowledgeBaseArticles), $($update.SecurityBulletins), $($update.HasSupersededUpdates)" | Out-File $outSupersededList -Append       
        
    }
}

Write-Host "Done."
Write-Host "List of superseded updates: $outSupersededList"

Write-Host ""
Write-Host "Summary:"
Write-Host "========"

Write-Host "All Updates =" $countAllUpdates
Write-Host "Any except Declined =" ($countAllUpdates - $countDeclined)
Write-Host "All Superseded Updates =" $countSupersededAll
Write-Host "    Superseded Updates (Intermediate) =" ($countSupersededAll - $countSupersededLastLevel)
Write-Host "    Superseded Updates (Last Level) =" $countSupersededLastLevel
Write-Host "    Superseded Updates (Older than $ExclusionPeriod days) =" $countSupersededExclusionPeriod
Write-Host "    Superseded Updates (Last Level Older than $ExclusionPeriod days) =" $countSupersededLastLevelExclusionPeriod
Write-Host ""

$i = 0
if (!$SkipDecline) {
    
    Write-Host "SkipDecline flag is set to $SkipDecline. Continuing with declining updates"
    $updatesDeclined = 0
    
    if ($DeclineLastLevelOnly) {
        Write-Host "  DeclineLastLevel is set to True. Only declining last level superseded updates." 
        
        foreach ($update in $allUpdates) {
            
            if (!$update.IsDeclined -and $update.IsSuperseded -and !$update.HasSupersededUpdates) {
              if ($update.CreationDate -lt (get-date).AddDays(-$ExclusionPeriod))  {
                $i++
                $percentComplete = "{0:N2}" -f (($updatesDeclined/$countSupersededLastLevelExclusionPeriod) * 100)
                Write-Progress -Activity "Declining Updates" -Status "Declining update #$i/$countSupersededLastLevelExclusionPeriod - $($update.Id.UpdateId.Guid)" -PercentComplete $percentComplete -CurrentOperation "$($percentComplete)% complete"
                
                try 
                {
                    $update.Decline()                    
                    $updatesDeclined++
                }
                catch [System.Exception]
                {
                    Write-Host "Failed to decline update $($update.Id.UpdateId.Guid). Error:" $_.Exception.Message
                } 
              }             
            }
        }        
    }
    else {
        Write-Host "  DeclineLastLevel is set to False. Declining all superseded updates."
        
        foreach ($update in $allUpdates) {
            
            if (!$update.IsDeclined -and $update.IsSuperseded) {
              if ($update.CreationDate -lt (get-date).AddDays(-$ExclusionPeriod))  {   
                  
                $i++
                $percentComplete = "{0:N2}" -f (($updatesDeclined/$countSupersededAll) * 100)
                Write-Progress -Activity "Declining Updates" -Status "Declining update #$i/$countSupersededAll - $($update.Id.UpdateId.Guid)" -PercentComplete $percentComplete -CurrentOperation "$($percentComplete)% complete"
                try 
                {
                    $update.Decline()
                    $updatesDeclined++
                }
                catch [System.Exception]
                {
                    Write-Host "Failed to decline update $($update.Id.UpdateId.Guid). Error:" $_.Exception.Message
                }
              }              
            }
        }   
        
    }
    
    Write-Host "  Declined $updatesDeclined updates."
    if ($updatesDeclined -ne 0) {
        Copy-Item -Path $outSupersededList -Destination $outSupersededListBackup -Force
        Write-Host "  Backed up list of superseded updates to $outSupersededListBackup"
    }
    
}
else {
    Write-Host "SkipDecline flag is set to $SkipDecline. Skipped declining updates"
}

Write-Host ""
Write-Host "Done"
Write-Host ""
```
