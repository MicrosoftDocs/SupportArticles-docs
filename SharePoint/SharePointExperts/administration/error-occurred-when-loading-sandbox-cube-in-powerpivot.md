---
title: 'An error occurred when loading the Sandbox cube error in PowerPivot for SharePoint'
description: Fixes an issue that occurs when run a scheduled data refresh of a PowerPivot workbook in Microsoft SharePoint.
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
  - sap:spsexperts
  - CSSTroubleshoot
appliesto: 
  - Microsoft SharePoint
ms.date: 12/17/2023
---

# "An error occurred when loading the Sandbox cube" error in PowerPivot

This article was written by [Zakir Haveliwala](https://social.technet.microsoft.com/profile/Zakir+H+-+MSFT), Senior Support Escalation Engineer.

## Symptoms

When you run a scheduled data refresh of a PowerPivot workbook in Microsoft SharePoint, you may receive an error message that resembles the following:

> The table with ID of '*TableID*', Name of '*TableName*' referenced by the 'Sandbox' cube, does not exist. An error occurred when loading the Sandbox cube, from the file, '\\?\C:\Program Files\Microsoft SQL Server\MSAS10_50.POWERPIVOT\OLAP\Backup\Sandboxes\PowerPivotServiceApplication\GUID.db\Sandbox.9825.cub.xml'.

This error may display in the scheduled data refresh results on the PowerPivot Data Refresh History page. This error may also display in Unified Logging Service (ULS) logs of the SharePoint server that's running the PowerPivot system service after matching the Correlation ID of a generic error that's received when you try to view the Manage Data Refresh page for the PowerPivot workbook.

## Cause

The error may be caused by a recent SharePoint update. The update causes the file store data cache for the PowerPivot cube data to become obsolete.

## Resolution

1. Stop **SQL Server Analysis Services (PowerPivot)** on the SharePoint server that's running the PowerPivot Analysis Services instance in Windows Services in **Control Panel** > **Administrative Tools** > **Services**.
1. Stop the **SQL Server PowerPivot System Service** on the SharePoint server that's running the PowerPivot service in **SharePoint Central Administration** > **System Settings** > **Manage Services on Server**.
1. Rename the **PowerPivotServiceApplication1** folder to **PowerPivotServiceApplication1.old** in **C:\Program Files\Microsoft SQL Server\MSAS10_50.POWERPIVOT\OLAP\Backup\Sandboxes**.
   > [!NOTE]
   > The path may be slightly different on your system, depending on the drive where PowerPivot was installed, the version of PowerPivot installed, and the name of the PowerPivot service application.
1. Start the **SQL Server PowerPivot System Service** in SharePoint Central Administration.
1. Start **SQL Server Analysis Services (PowerPivot)** on the PowerPivot Analysis Services server.
1. Retest the scheduled data refresh of the PowerPivot workbook. If the scheduled data refresh runs successfully, you can delete the **PowerPivotServiceApplication1.old** folder.
