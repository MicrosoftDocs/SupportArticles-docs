---
title: Transaction info not imported if SQL table used as Integration source
description: Describes how to get transaction line information to import when you use a Microsoft SQL Server table as your Integration source for Integration Manager for Microsoft Dynamics GP.
ms.reviewer: theley, v-anlang, dlanglie
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Developer - Customization and Integration Tools
---
# Transaction line information is not imported when you use a Microsoft SQL Server table as an Integration source in Integration Manager for Microsoft Dynamics GP

This article provides a resolution for the issue that the transaction line information isn't imported when you use a Microsoft SQL Server table as an Integration source in Integration Manager for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 970225

## Symptoms

In Integration Manager for Microsoft Dynamics GP, when you use a Microsoft SQL Server table as an Integration source, the transaction line information isn't imported, or it's only imported for some transactions.

## Cause

This issue occurs because the **Datatype** setting of a date column is set to **Date**. This setting should be set to **String**.

## Resolution

To resolve this issue, first verify that the **Options** tab is set to **Use Source Recordset** in the **Destination Mapping** window. If the line information is still not imported, follow these steps:

1. Right-click the Integration source that you are using, and then select **Preview**.
2. If the **Datatype** setting of a date column displays a date and time stamp, for example, **01/01/2009 12:00 AM**, change the **Datatype** setting of the column to a String data type.
3. For the Advanced ODBC source, follow these steps:

   1. Open the **Source Properties** window, and then select the **Columns** tab.
   2. Change the **Datatype** setting for the Date columns from **Date** to **String**.
   3. Make this change on all integration source files that have a date column that uses a date as the data type.
   4. If you are using a Simple ODBC source, change to an Advanced ODBC source, and then perform steps 3a to 3c.
