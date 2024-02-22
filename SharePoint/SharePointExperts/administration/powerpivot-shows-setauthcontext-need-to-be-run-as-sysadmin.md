---
title: 'SetAuthContext need to be run as sysadmin error in Power Pivot for SharePoint'
description: Fixes an error that occurs when interacting with a PowerPivot workbook in Microsoft SharePoint.
author: helenclu
ms.author: luche
ms.reviwer: zakirh
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: sap:spsexperts, CSSTroubleshoot
appliesto: 
  - Microsoft SharePoint
ms.date: 12/17/2023
---

# "SetAuthContext need to be run as sysadmin" error in PowerPivot

This article was written by [Zakir Haveliwala](https://social.technet.microsoft.com/profile/Zakir+H+-+MSFT), Senior Support Escalation Engineer.

## Symptoms

If you receive an error when you interact with a PowerPivot workbook in Microsoft SharePoint, you may see the following error from the PowerPivot Service in the SharePoint Unified Logging Service (ULS) log:

> EXCEPTION: System.ServiceModel.FaultException`1[System.ServiceModel.ExceptionDetail]: SetAuthContext need to be run as sysadmin.

This error refers to the Administrator permission on the PowerPivot Analysis Service instance.

## Resolution

To fix this issue, add the PowerPivot System Service account that's running the PowerPivot service application in SharePoint as an Administrator. To add the account, you can connect to the PowerPivot Analysis Services instance in SQL Server Management Studio.

1. Right-click the instance, and then select **Properties**.
1. In the **Analysis Server Properties** dialog box, select **Security**, and then select **Add** to add the user.

   :::image type="content" source="media/powerpivot-shows-setauthcontext-need-to-be-run-as-sysadmin/analysis-server-properties.png" alt-text="Screenshot of the Analysis Server Properties dialog box." border="false":::

1. Select **OK** to exit.
