---
title: Error when you click the Databases node
description: This article describes an error message that typically occurs in SSMS when there is a problem retrieving information about one or more databases of a SQL Server instance.
ms.date: 03/21/2025
ms.custom: sap:SQL Server Management, Query and Data Tools
---
# Error message when you click the Databases node in SQL Server Management Studio in SQL Server

This article describes an error message that typically occurs in SSMS when there is a problem retrieving information about one or more databases of a SQL Server instance.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 956179

## Symptoms

You might receive an error message similar to the following one when using SQL Server Management Studio (SSMS):

> Failed to retrieve data for this request (Microsoft.SqlServer.Management.sdk.sfc)

## Troubleshooting

There can be multiple symptoms that can contribute to this problem. The following items may help you understand and troubleshoot the issue:

- **Symptom 1**

  You might run into known issues in the following articles:

  - [SQL Server 2016 Agent fails to start or "Failed to retrieve data" error when you try to read error log from SSMS 2016](https://support.microsoft.com/help/3185365)

  - [KB4550657 - FIX: Error occurs when you interact with SQL Server Agent in SQL Server 2019](https://support.microsoft.com/help/4550657)

  **Resolution**

   To solve the known issues, see the resolutions documented in the corresponding articles listed earlier.

- **Symptom 2**

  You can run into this issue if using an older version of SSMS and when one of the following conditions is true:

  - SQL Server Management Studio can't correctly read one or more databases. Therefore, certain properties of a database can't be retrieved.

  - One or more databases is in an offline mode and you're using an older version of SSMS to connect to that SQL instance hosting this offline database.

  In these situations, the collection of objects doesn't appear in the **Object Explorer** pane or the **Object Explorer Details** pane. Therefore, certain properties of the database aren't computed as a group in the collection of objects.

  > [!NOTE]
  > This problem also occurs if you're not a member of the Sysadmins group.

  **Resolution**

  To work around this problem, follow these steps:

  1. Close the error message.

  2. Press **F7** to open the **Object Explorer Details** pane.

  3. Right-click the column headers, and make sure that only the following columns are selected:

       - Name

       - Date Created

       - Policy Health

       - Owner

  4. Right-click the **Databases** node, and then select **Refresh**.

  Alternatively, you can download and install SSMS from [Download SQL Server Management Studio (SSMS)](/sql/ssms/download-sql-server-management-studio-ssms) and see if the issue goes away. If the issue still occurs with the new version of SSMS, see [SQL Server help and feedback](/sql/sql-server/sql-server-get-help) for additional ways to get assistance with your issue.

