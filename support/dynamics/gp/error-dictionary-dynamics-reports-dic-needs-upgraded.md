---
title: Error after you install the Payroll Year-End Update for Microsoft Dynamics GP 
description: Describes an error after you install the Payroll Year-End Update for Microsoft Dynamics GP - Dictionary C:\DYNAMICS\REPORTS.DIC needs to be upgraded.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# "Dictionary C:\DYNAMICS\REPORTS.DIC needs to be upgraded" error after you install the Payroll Year-End Update for Microsoft Dynamics GP

This article resolves an issue that occurs after you install the Payroll Year-End Update for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 855397

## Symptoms

After you install the Payroll Year-End Update for Micrsoft Dynamics GP, you receive the following error message:
> Dictionary C:\DYNAMICS\REPORTS.DIC needs to be upgraded. Use Dynamics Utilities to update your modified forms and reports

## Resolution

To resolve this problem, follow these steps:

1. Install the Payroll Year-End Update on all workstations where Microsoft Dynamics GP is installed.
1. Start Microsoft Dynamics GP. When you are prompted to include new code, click **Yes**. However, do not log onto Microsoft Dynamics GP.
1. Re-create the Reports.dic file.
    For more information about how to re-create the Reports.dic file, click the following article number to view the article in the Microsoft Knowledge Base:

    [850465](https://support.microsoft.com/help/850465) How to re-create the Reports.dic file in Microsoft Dynamics GP

[!INCLUDE [Publishing Disclaimer](../../includes/publishing-disclaimer.md)]
