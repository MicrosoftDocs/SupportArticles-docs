---
title: Error when you click the Databases node
description: This article describes an error message that typically occurs in SSMS when there is a problem retrieving information about one or more databases of a SQL Server instance.
ms.date: 11/19/2020
ms.custom: sap:Management Studio
---
# Error message when you click the Databases node in SQL Server Management Studio in SQL Server

This article describes an error message that typically occurs in SSMS when there is a problem retrieving information about one or more databases of a SQL Server instance.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 956179

## Symptoms

You may receive an error message similar to the following when using SQL Server Management Studio (SSMS)

> Failed to retrieve data for this request (Microsoft.SqlServer.Management.sdk.sfc)

## Troubleshooting

There can be multiple causes that can contribute to this problem. The following items may help you understand and troubleshoot the issue:

- Check if you are running into any known issues listed below and use the resolutions documented in the corresponding articles:

  - [SQL Server 2016 Agent fails to start or “Failed to retrieve data” error when you try to read error log from SSMS 2016](https://support.microsoft.com/help/3185365)

  - [KB4550657 - FIX: Error occurs when you interact with SQL Server Agent in SQL Server 2019](https://support.microsoft.com/help/4550657)

- You can run into this issue if are using an older version of SSMS and when one of the following conditions is true:

  - SQL Server Management Studio cannot correctly read one or more databases. Therefore, certain properties of a database cannot be retrieved.

  - One or more databases is in an offline mode and you are using an older version of SSMS to connect to that SQL instance hosting this offline database.

  In these situations, the collection of objects does not appear in the **Object Explorer** pane or in the **Object Explorer Details** pane. Therefore, certain properties of the database are not computed as a group in the collection of objects.

   > [!NOTE]
   > This problem also occurs if you are not a member of the Sysadmins group.

   To work around this problem, using the older version of SSMS follow these steps:

    1. Close the error message.

    2. Press **F7** to open the Object Explorer Details pane.

    3. Right-click the column headers, and make sure that only the following columns are selected:

       - Name

       - Date Created

       - Policy Health

       - Owner

    4. Right-click the Databases node, and then click Refresh.

    Alternatively, you can download and install SSMS from [Download SQL Server Management Studio (SSMS)](/sql/ssms/download-sql-server-management-studio-ssms) and see if the issue goes away. If the issue still occurs with new version of SSMS, see [SQL Server help and feedback](/sql/sql-server/sql-server-get-help) for additional ways to get assistance with your issue.

- You are connecting to a SQL Server 2008 R2 or an earlier version of SQL Server and when guest user is disabled in the msdb database. For additional information review [You should not disable the guest user in the msdb database in SQL Server](https://support.microsoft.com/help/2539091)
