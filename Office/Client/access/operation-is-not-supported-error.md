---
title: Operation is not supported error in Access and Excel
description: Describes the scenarios in which this error is displayed when working in Access and Excel, and provides multiple solutions to resolve the issue.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.reviewer: denniwil
ms.custom: 
  - CSSTroubleshoot
  - CI 9185
  - sap: Errors & Crashing
appliesto: 
  - Access for Microsoft 365
  - Access 2024
  - Access 2021
ms.date: 02/09/2026
---

# Operation is not supported error in Access and Excel

## Summary

This article discusses the cause of errors that you encounter when you take any of the following actions:

- Use a query in a Microsoft Access database

- Use an Open Database Connectivity (ODBC) connection that includes a remote table reference

- Use wizards to perform tasks in Access

The article provides multiple solutions to resolve the errors.

## Symptoms

When you work with Access or Microsoft Excel, you receive one of the following error messages in different scenarios:

`Operation is not supported for this type of object`

when:

- The Access database contains a query that includes a remote reference.

- You create or refresh an ODBC connection by using either an Access driver or an Excel driver within an Excel workbook.

`Invalid use of Null`

when you:

- Add a control or a command button to an Access form or report.

- Create a query, form, or report by using a wizard in Access.

## Cause

In 2021, the [**AllowQueryRemoteTables** registry key](https://support.microsoft.com/topic/kb5002984-configuring-jet-red-database-engine-and-access-connectivity-engine-to-block-access-to-remote-databases-56406821-30f3-475c-a492-208b9bd30544) was added to allow you to disable remote table references when you run a query. This feature helps to make your applications more secure.

Beginning in the Office updates that were released on December 9, 2025, the **AllowQueryRemoteTables** registry key provides the following values.

| **Key value** | **Definition**                  |
|---------------|---------------------------------|
| 0             | Allow only in trusted databases |
| 1             | Allow in all databases          |
| 2             | Disallow in all databases       |

The “Allow only in trusted databases” is the default value for this registry key.

### Check for a remote table reference

To identify a remote table reference, check the SQL syntax of a query or command text, as shown in the following example.

| **Local table** | SELECT \* FROM \`Orders Query\` |
|----|----|
| **Remote table** | SELECT \* FROM \`C:\temp\Database.accdb\`.\`Orders Query\` |

## Solutions

This issue has multiple solutions. Select the solution that’s appropriate for your scenario.

### Solutions when you work with Access

- Add a trusted folder location that includes the database location by using either the Trust Center in Access or via group policy.

- Don’t use wizards in Access. To avoid wizards, take the following actions instead:

  - When you use the **Create** tab, select an option such as **Table Design**, **Query Design**, **Form Design** or **Report Design** that doesn't use a wizard.

  - Disable Control wizards that you use for tasks such as adding a command button.  
    Expand the **Controls** group, and clear the **Use Control Wizards** checkbox.

  > :::image type="content" source="media/operation-is-not-supported-error/controls-group.png" alt-text="Screenshot of the Controls group in Access.":::

### Solutions when you work with apps other than Access

- Legacy ODBC connections in Excel are commonly constructed to include a remote table reference within the command text. The remote reference is used even if the table or query object that's referenced is local to the database or workbook that’s supplied in the connection string. In this scenario, remove the remote table reference from the command text in the query because it's unnecessary. See the following example.

| **Original Command Text** | **Updated Command Text** |
|----|----|
| :::image type="content" source="media/operation-is-not-supported-error/incorrect-remote-reference.png" alt-text="Screenshot of incorrect remote reference to local table."::: | :::image type="content" source="media/operation-is-not-supported-error/correct-reference-to-local-table.png" alt-text="Screenshot of correct reference to local table."::: |

- To update the remote table reference in the command text if the name of the file or table contains spaces, use the following syntax.

| **Original command text** | **Updated command text** |
|----|----|
| SELECT \* FROM \`C:\temp\Database.accdb\`.\`Orders Query\` \`Orders Query\` | SELECT \* FROM \`Orders Query\` |

>[!NOTE]

>- These solutions also apply to the Power BI desktop app and other apps that use ODBC connections.
>- Beginning in version 2601 of Microsoft 365 Apps, a remote table reference is treated as a local table reference during query execution if the database or workbook that’s supplied in the connection string matches the file that’s used in the remote table reference within the command text. Therefore, this error won’t occur.

### Solution that applies to all apps

1. Locate the **AllowQueryRemoteTables** registry key for your installation scenario by using the information in [KB 5002984](https://support.microsoft.com/topic/kb5002984-configuring-jet-red-database-engine-and-access-connectivity-engine-to-block-access-to-remote-databases-56406821-30f3-475c-a492-208b9bd30544).
1. Set the value for the key to **1** to allow remote table references during query execution.
