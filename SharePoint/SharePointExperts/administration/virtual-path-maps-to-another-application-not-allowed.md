---
title: 'The virtual path maps to another application, which is not allowed. error when you run a scheduled data refresh'
description: Fixes an issue that occurs when you run a scheduled data refresh on a PowerPivot workbook in Microsoft SharePoint Server 2016.
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
  - sap:Administration\Farm Administration
  - CSSTroubleshoot
appliesto: 
  - SharePoint Server 2016
ms.date: 12/17/2023
---

# "The virtual path maps to another application, which is not allowed." error when you run a scheduled data refresh

This article was written by [Zakir Haveliwala](https://social.technet.microsoft.com/profile/Zakir+H+-+MSFT), Senior Support Escalation Engineer.

## Symptoms

When you run a scheduled data refresh on a PowerPivot workbook in Microsoft SharePoint Server 2016, you may receive the following error:

> The virtual path '/……xlsx' maps to another application, which is not allowed.

:::image type="content" source="media/virtual-path-maps-to-another-application-not-allowed/virtual-path-error.png" alt-text="Screenshot of the virtual path error dialog box." border="false":::

After this error occurs, the schedule data refresh gets disabled and the schedule settings are deleted. The schedule keeps getting disabled even if the subsequent scheduled refreshes run successfully.

## Resolution

This error is caused by a bug in PowerPivot. To fix this issue, install the **sppowerpivot16.msi** file that's available in the [SQL Server 2016 Service Pack 2 Feature Pack](https://www.microsoft.com/en-us/download/details.aspx?id=56833).
