---
title: PowerPivot Performance Counter errors
description: Fixes the PowerPivot Performance errors on a PowerPivot workbook in Microsoft SharePoint.
author: helenclu
ms.author: luche
ms.reviwer: zakirh
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Administration\Service Applications (except Search)
  - CSSTroubleshoot
appliesto: 
  - Microsoft SharePoint
ms.date: 12/17/2023
---

# PowerPivot Performance Counter errors

This article was written by [Zakir Haveliwala](https://social.technet.microsoft.com/profile/Zakir+H+-+MSFT), Senior Support Escalation Engineer.

## Symptoms

You may encounter a data refresh error on a PowerPivot workbook in Microsoft SharePoint due to issues with Performance Counters on the PowerPivot Analysis Services server. You may receive the following error in the Universal Logging System (ULS) log:
```
EXCEPTION: System.ComponentModel.Win32Exception (0x80004005): Access is denied at System.Diagnostics.PerformanceMonitor.Init()
```
This may indicate that the PowerPivot System Service doesn't have permissions to the Performance Counters on the server that's running PowerPivot Analysis Services.

## Resolution

To fix the error, add the account that's running the PowerPivot System Service application pool to the **Performance Log Users** and **Performance Monitor Users** groups by going to **Computer Management** > **Local Users and Groups** > **Groups**.

:::image type="content" source="media/powerpivot-performance-counter-errors/computer-management.png" alt-text="Screenshot of the Computer Management dialog box, adding the account that's running the PowerPivot System Service application pool to the Performance Log Users and Performance Monitor Users groups.":::

## More information

You may receive the following error in the ULS log:
```
The '\MSOLAP$POWERPIVOT:Memory\Memory Limit High KB' performance counter could not be found.
```
This means that the Performance Counters for PowerPivot haven't been loaded. Check the following registry key:

**HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\MSOLAP$POWERPIVOT\Performance\Disable Performance Counters**

If it is set to **1**, the Performance Counters for PowerPivot Analysis Services are disabled. To fix this error, set the value of this registry key to **2** to enable the Performance Counters.

:::image type="content" source="media/powerpivot-performance-counter-errors/registry-editor.png" alt-text="Screenshot of the Registry Editor dialog box, setting the value of Disable Performance Counters to 2 to enable the Performance Counters.":::

If that method does not fix the error, you may have to run the following commands at a command prompt to re-create the Performance Counters:
   - unlodctr msolap$pwerpivot
   - lodctr perf-MSOLAP$POWERPIVOTmsmdctr.ini
