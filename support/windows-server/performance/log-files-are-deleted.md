---
title: Log files are deleted
description: Discusses that log data is lost when you run Performance Monitor in Windows Server 2012, Windows Server 2008 R2, or Windows Server 2008.
ms.date: 09/17/2020
author: Deland-Han 
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Performance monitoring tools
ms.technology: Performance
---
# Log files are deleted when you use Performance Monitor in Windows Server

This article provides a solution to an error that occurs when you use Windows Performance Monitor to monitor system activity.

_Original product version:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2916994

## Symptoms

Consider the following scenario:

- You use Windows Performance Monitor to monitor system activity in Windows Server 2012, Windows Server 2008 R2, or Windows Server 2008.
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

For more information about Windows Performance Monitor, go to the following Microsoft TechNet website:

[Performance Monitoring Getting Started Guide](https://technet.microsoft.com/library/dd744567%28v=ws.10%29.aspx)

For information about how to manage data in Windows Performance Monitor, go to the following Microsoft TechNet website:

[Manage Data in Windows Performance Monitor](https://technet.microsoft.com/library/cc765998.aspx)

For information about the IDataCollectorSet::RootPath property, go to the following MSDN website:

[IDataCollectorSet::RootPath property](https://msdn.microsoft.com/library/windows/desktop/aa371978%28v=vs.85%29.aspx)
