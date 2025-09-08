---
title: Scripts to Check and Clean the AGPM Archive That Causes GPO Operation Issues
description: Introduces a script to check and clean up the AGPM archive that might lead to GPO operation issues.
ms.date: 04/25/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: garymu
ms.custom:
- sap:group policy\group policy management (gpmc or gpedit)
- pcy:WinComm Directory Services
---
# Scripts: Check and clean up the AGPM archive that might lead to GPO operation issues

_Applies to:_ &nbsp; Advanced Group Policy Manager 4.0 SP3

The sample script included in this article can assist with archive inconsistencies that lead to errors in managing Group Policy Objects (GPOs) within the tool.

Examples of errors that can occur if there's inconsistent information in the **gpostate.xml** file:

```output
Create GPO: Test...Failed.
[Error] The system cannot find the file specified. (Exception from HRESULT: 0x80070002)
--------------------------------------------------------------------------------------------------------
1 actions failed.
```

## Script

Here's what the script does:

1. Stops the Advanced Group Policy Management (AGPM) service.
2. Scans the **gpostate.xml** file and removes references (if any) to archive nonexistent or incomplete GUID folders.
3. Renames the **gpostate.xml** file with a timestamp if any changes are detected and saves a new **gpostate.xml** file.
4. Starts the AGPM service.

[!INCLUDE [Script disclaimer](../../includes/script-disclaimer.md)]

```powershell
Write-Host "Stopping AGPM Service"
Stop-Service "AGPM Service" -ErrorAction Stop
$AGPMArchivePath = Get-ItemPropertyValue -Path "HKLM:\SOFTWARE\Microsoft\AGPM" -Name "ArchivePath" -ErrorAction Stop
$AGPMFile =$AGPMArchivePath + "gpostate.xml"
[xml]$AGPMArchive = Get-Content -Path $AGPMFile -ErrorAction Stop
$bChangesMade = $false
foreach( $GPODomain in $AGPMArchive.Archive.GPODomain )
{
Write-Host "Processing archive information for domain: $($GPODomain.domain)"
$ArchiveGPO = if( $GPODomain.GPO -is [array] ){ $GPODomain.GPO[0] } else { $GPODomain.GPO }
While( $ArchiveGPO -ne $null )
{
$TempGPONext = $ArchiveGPO.NextSibling
Write-Host "Checking GPO $($ArchiveGPO.id)"
if( $ArchiveGPO.state.archiveId -ne $null ){
$TestArchivePath = $AGPMArchivePath + $ArchiveGPO.state.archiveId
if( -not (Test-Path $TestArchivePath ) )
{
Write-Host "$($ArchiveGPO.state.archiveId) is not in archive - Removing"
$ArchiveGPO.ParentNode.RemoveChild($ArchiveGPO) > $null
$bChangesMade = $true
}
}
else
{
$ArchiveGPOHistoryItem = $ArchiveGPO.History.FirstChild
While( $ArchiveGPOHistoryItem -ne $null )
{
$TempNext = $ArchiveGPOHistoryItem.NextSibling
$TestArchivePath = $AGPMArchivePath + $ArchiveGPOHistoryItem.archiveId
if( -not (Test-Path -Path $TestArchivePath) )
{
Write-Host "History '$($ArchiveGPOHistoryItem.archiveId)' for State '$($ArchiveGPOHistoryItem.state)' on '$($ArchiveGPOHistoryItem.time)' is not in archive - Removing"
$ArchiveGPOHistoryItem.ParentNode.RemoveChild($ArchiveGPOHistoryItem) > $null
$bChangesMade = $true
}
elseif( -not (Test-Path -Path ($TestArchivePath + "\bkupinfo.xml") ) )
{
Write-Host "'$($ArchiveGPOHistoryItem.archiveId)' does not have bkupinfo.xml - Removing"
$ArchiveGPOHistoryItem.ParentNode.RemoveChild($ArchiveGPOHistoryItem) > $null
$bChangesMade = $true
}
$ArchiveGPOHistoryItem = $TempNext
}
if( -not $ArchiveGPO.History.HasChildNodes )
{
Write-Host "GPO $($ArchiveGPO.id) has no History removing."
$ArchiveGPO.ParentNode.RemoveChild($ArchiveGPO) > $null
$bChangesMade = $true
}
}
$ArchiveGPO = $TempGPONext
}
}
if( $bChangesMade )
{
$BackupFileName = "gpostate\_bak\_$((Get-Date).ToString('yyyymmdd-hhmmss')).xml"
Write-Host "Backing up gpostate.xml file to $BackupFileName"
Move-Item -Path $AGPMFile -Destination ($AGPMArchivePath + $BackupFileName) -Force -ErrorAction Stop
Write-Host "Saving updates"
$AGPMArchive.Save($AGPMArchivePath + "gpostate.xml")
}
else
{
Write-Host "No Changes made."
}
Write-Host "Starting AGPM service."
Start-Service "AGPM Service"
```
