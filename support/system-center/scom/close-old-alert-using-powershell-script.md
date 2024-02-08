---
title: Close old alerts using a PowerShell script
description: Describes a PowerShell script that can help clean up some Operations Manager environments with old alerts that are still active.
ms.date: 07/06/2020
ms.custom:
---
# PowerShell script to automatically close old alerts in System Center Operations Manager

The PowerShell script in this article can help clean up some System Center Operations Manager environments with old alerts that are still active.

_Original product version:_ &nbsp; System Center 2016 Operations Manager, System Center 2012 R2 Operations Manager  
_Original KB number:_ &nbsp; 4464212

## Script

The script can be used to automatically close old Operations Manager alerts. This script looks for active alerts along with the time when alert was created (alert age). If the alert age is greater than the specified number of days (`$alertsTobeClosedBefore`), the script will close the alert.

```powershell
$alertsTobeClosedBefore = 5
$currentDate = Get-Date
Get-SCOMAlert | Where-Object {(($_.ResolutionState -ne 255) -and (($currentDate - $_.TimeRaised).TotalDays -ge $alertsTobeClosedBefore))} |Resolve-SCOMAlert
```
