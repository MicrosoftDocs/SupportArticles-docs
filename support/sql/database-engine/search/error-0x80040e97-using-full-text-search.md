---
title: Error when you use integrated full-text search
description: This article provides a resolution for the problem that occurs when you index large documents by using integrated full-text search in SQL Server.
ms.date: 09/30/2022
ms.custom: sap:Administration and Management
ms.reviewer: jackli, rbeene
---
# Error 0x80040e97 occurs when you use integrated full-text search in SQL Server

This article helps you resolve the problem that occurs when you index large documents by using integrated full-text search in SQL Server.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 2270849

## Symptoms

When you index large or complex documents by using integrated full-text search in Microsoft SQL Server, you may receive time-out errors that resemble the following message:

> 2010-06-07 15:02:44.64 spid10s Error '0x80040e97' occurred during full-text index population for table or indexed view '[db1].[dbo].[Images]' (table or indexed view ID '622625261', database ID '171'), full-text key value '2375057'. Attempt will be made to reindex it.

Additionally, SQL Server may restart the *FDHOST.exe* process.

## Cause

This issue occurs if it takes longer than 60 seconds for the *FDHOST.exe* process to read and process the XML data.

## Resolution

To resolve this problem, increase the full-text indexing time-out value. To do this, call the `sp_fulltext_service` stored procedure that has the `'ft_timeout'` parameter. For example, the following code increases the full-text indexing time-out to 20 minutes for any document:

```sql
EXEC sp_fulltext_service 'ft_timeout', 1200000
```

> [!NOTE]
> The second parameter is full-indexing time-out in milliseconds.

> [!IMPORTANT]
> Restart your SQL Server for the new setting to take effect.

## More information

When SQL Server indexes data types such as **varbinary**, **varbinary (max)**, **image**, or **xml**, SQL Server sends data to the filter daemon process (*FDHOST.exe*). At any point during the indexing process, SQL Server will not wait for more than 60 seconds for the *FDHOST.exe* process to respond.

For large XML documents, the XML Filter that is hosted by the *FDHOST.exe* process reads in all the data from SQL Server and stores the data in a temporary file. Then *FDHOST.exe* processes the XML content for filtering and word-breaking. If this process takes more than 60 seconds, SQL Server stops the batch and retries the operation by using a smaller batch size. If an XML document is large, and the *FDHOST.exe* process takes more than 60 seconds to filter and break the words, then you can experience error that's mentioned in the [Symptoms](#symptoms) section.

> [!NOTE]
> The issue can occur with any iFilter that writes data to a temporary file.

Error 0x80040e97 can also be shown for other reasons. For example, you may see the same error code when SQL Server experiences issues loading an iFilter. Increasing the time-out value in these cases may mask the error and prevent effective troubleshooting. Therefore, we recommend that you verify the size of the document and confirm that the size of the failing document is exceptionally large before you increase the time-out value.
