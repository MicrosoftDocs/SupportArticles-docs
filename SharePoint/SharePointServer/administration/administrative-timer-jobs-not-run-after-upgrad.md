---
title: Administrative timer jobs fail after an upgrade
description: Fixes an issue in which administrative operations that depend on timer jobs to be completed aren't successful after an upgrade.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: tehnoonr
appliesto: 
  - SharePoint Server 2010
  - Microsoft SharePoint Foundation 2010
search.appverid: MET150
ms.date: 12/17/2023
---
# Administrative timer jobs aren't running after an upgrade

_Original KB number:_ &nbsp; 2616609

## Symptoms

Every SharePoint server has one `SPTimerServiceInstance` object that represents the SPTimerV4 Windows Service. In certain circumstances (typically after an upgrade), you could end up in a situation where your timer service is running on the server but the `SPTimerSericeInstance` object is not online. In this case, any administrative operations that depend on timer jobs to be completed (such as starting the User Profile Synchronization Service) will not be successful.

## Cause

An unexpected event during the upgrade prevented the timer service instance object to be brought back online.

## Resolution

The following PowerShell script can be run on one of the SharePoint servers in the farm. The script detects timer service instances in the farm that are not online and attempts to bring them online. After running the script, manually restart the SPTimerV4 Windows Service (SharePoint 2010 Timer) on each server that is identified to have the problem.

```powershell
$farm = Get-SPFarm
$disabledTimers = $farm.TimerService.Instances | where {$_.Status -ne "Online"}
if ($disabledTimers -ne $null)
{
foreach ($timer in $disabledTimers)
{
Write-Host "Timer service instance on server " $timer.Server.Name " is not Online. Current status:" $timer.Status
Write-Host "Attempting to set the status of the service instance to online"
$timer.Status = [Microsoft.SharePoint.Administration.SPObjectStatus]::Online
$timer.Update()
}
}
else
{
Write-Host "All Timer Service Instances in the farm are online! No problems found"
}
```
