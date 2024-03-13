---
title: Error when you print the Historical Aged Trial Balance report in Microsoft Dynamics GP
description: Describes an error message that occurs when you try to print the Historical Aged Trial Balance report in Microsoft Dynamics GP.
ms.reviewer:
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "Unable to close table; DBMS: 208, dynamics: 0" error when you try to print the Historical Aged Trial Balance report in Microsoft Dynamics GP

The article solves an issue where you can't print the Historical Aged Trial Balance report in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 850017

## Symptoms

When you try to print the Historical Aged Trial Balance report in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains, you receive the following error message:
> Unable to close table; DBMS: 208, Dynamics: 0

This problem occurs even after you re-create the reports dictionary (reports.dic) and delete the DEX_LOCK table and the DEX_SESSION table from the tempdb database in SQL Query Analyzer.

Additionally, the following error message may be logged in the Dexsql.log file:
> You cannot run SELECT INTO in this database. The DBO would have to run sb_dboption to enable this options.

## Cause

This problem occurs if the options for the tempdb database properties are set incorrectly.

## Resolution

To resolve this problem, modify the tempdb database properties by following these steps:

1. Start SQL Enterprise Manager. To do this, click **Start**, point to **All Programs** > **Microsoft SQL Server**, and then click **Enterprise Manager**.
1. Expand the server that's running Microsoft SQL Server, expand **Databases**, right-click the tempdb database, and then click **Properties**.
1. Click the **Options** tab.
1. Follow the appropriate step
    - In Microsoft SQL Server 7.0, make sure that the **Select Into/Bulk Copy** check box is selected, and then click **OK**.
    - In Microsoft SQL Server 2000, make sure that **Simple** is selected in the **Model** list in the **Recovery** area. Then, click **OK**.
1. Print the Historical Aged Trial Balance report.

[!INCLUDE [Publishing Disclaimer](../../includes/publishing-disclaimer.md)]
