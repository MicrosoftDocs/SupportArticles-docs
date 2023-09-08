---
title: Log files are deleted when you use Performance Monitor in Windows Server
description: Discusses that log data is lost when you run Performance Monitor in Windows Server.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:performance-monitoring-tools, csstroubleshoot
ms.technology: windows-server-performance
---
# Log files are deleted when you use Performance Monitor in Windows Server

This article provides a solution to an error that occurs when you use Windows Performance Monitor to monitor system activity.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2916994

## Symptoms

Consider the following scenario:

- You use Windows Performance Monitor to monitor system activity in Windows Server.
- You do one of the following:
  - You use a template to create a Data Collector Set.
  - You configure the new Data Collector Set on the **Data Manager** tab by using the default properties or the same properties that are configured in a different Data Collector Set.
- The Performance Monitor log files that are generated are saved to the same folder as other Performance Monitor files.

In this scenario, all the Performance Monitor logs and all other files and folders that are in the same folder are deleted.

## Cause

This issue occurs because Performance Monitor cannot determine which files should be saved or deleted.

## Workaround

To work around this issue, do one of the following:

- Save the Performance Monitor log files to a different folder.
- Change the default settings when you configure a Data Collector Set on the **Data Manager** tab. For example, change the **Minimum free disk space** or **Maximum folders** setting.
- Do not use a template to create Data Collector Sets.

## References

- [Performance Monitoring Getting Started Guide](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd744567(v=ws.10))

- [Manage Data in Windows Performance Monitor](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc765998(v=ws.11))

- [IDataCollectorSet::RootPath property](/windows/win32/api/pla/nf-pla-idatacollectorset-get_rootpath)
