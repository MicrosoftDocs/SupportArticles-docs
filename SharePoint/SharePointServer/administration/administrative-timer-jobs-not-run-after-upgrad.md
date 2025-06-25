---
title: Administrative timer jobs fail after an upgrade
description: Fixes an issue in which administrative operations that depend on timer jobs to be completed aren't successful after an upgrade.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Administration\Timer Service and jobs
  - CSSTroubleshoot
ms.reviewer: tehnoonr
appliesto: 
  - SharePoint Server 2016
  - SharePoint Server 2019
  - SharePoint Server Subscription Edition
search.appverid: MET150
ms.date: 07/08/2024
---
# Administrative timer jobs don't run after an upgrade

_Original KB number:_ &nbsp; 2616609

## Symptoms

Every SharePoint server has one `SPTimerServiceInstance` object that represents the SPTimerV4 Windows Service. In certain circumstances (typically after an upgrade), you might discover that your timer service is running on the server but the `SPTimerSericeInstance` object is not online. In this case, any administrative operations that depend on one-time timer jobs to be completed (such as creating or deleting a Search Service Application, or deploying farm solutions) aren't successful.

## Cause

An unexpected event during the upgrade prevented the timer service instance object from being brought back online.

## Resolution

The following PowerShell script can be run on one of the SharePoint servers in the farm. The script detects timer service instances in the farm that aren't online, and it tries to bring them online. After you run the script, manually restart the SPTimerV4 Windows service (SharePoint Timer Service) on each server that's identified to have the issue.

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
