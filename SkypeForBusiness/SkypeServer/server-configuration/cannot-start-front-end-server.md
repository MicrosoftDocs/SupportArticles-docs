---
title: Can't start a front-end server
description: Fixes an issue in which you cannot start a front-end server of a server pool in a Lync Server 2013 environment. This issue occurs when the SQL Server transaction log reaches maximum capacity.
author: simonxjx
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-six
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: daveh
appliesto: 
  - Lync Server 2013
ms.date: 03/31/2022
---

# You cannot start a front-end server when a SQL Server transaction log reaches maximum capacity in a Lync Server 2013 environment

## Symptoms

Consider the following scenario:

- Many user activities occur in a server pool in a Microsoft Lync Server 2013 environment.   
- The back-end server of the front-end server pool is running Microsoft SQL Server.   
- The back-end server is in full recovery mode.   
- Database mirroring is enabled on the back-end server.   

In this situation, the transaction log for the user services database reaches maximum capacity. Therefore, you cannot start the front-end server, and the following is logged in an event log:

Also, you receive the following error:

```adoc
SQL_9002_severity_17                                           sql_err
# The log file for database '%.*ls' is full. Back up the
# transaction log for the database to free up some log space.
# as an HRESULT: Severity: SUCCESS (0), FACILITY_NULL (0x0), Code 0x232a
# for decimal 9002 / hex 0x232a
```

> [!NOTE]
> Run the DBCC SQLPERF (LOGSPACE) query to check the size and current capacity of all transaction logs on the back-end server.

## Workaround

To work around this issue, truncate the transaction logs that reach maximum capacity by performing a SQL Server backup on them. This reduces the file size of the transaction logs.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
