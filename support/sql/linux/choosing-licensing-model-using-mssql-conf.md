---
title: Choosing a licensing model by using mssql-conf
description: This article describes how to choose a licensing model for SQL Server on Linux.
ms.date: 11/02/2020
ms.custom: sap:SQL Server on Linux
ms.topic: how-to
---
# Choose a licensing model for SQL Server on Linux

This article describes how to choose a licensing model for SQL Server on Linux.

_Original product version:_ &nbsp; SQL Server 2017 on Linux (all editions)  
_Original KB number:_ &nbsp; 4475751

## Summary

If you install Microsoft SQL Server on Linux by using the mssql-conf Setup tool, and if you purchased the appropriate license through the Volume Licensing Service Center (VLSC), you can select one of the appropriate PAID options from among the following SQL Server editions:

- Evaluation (free, no production use rights, 180-day limit)
- Developer (free, no production use rights)
- Express (free)
- Web (PAID)
- Standard (PAID)
- Enterprise (PAID)
- Enterprise Core (PAID)
- "I bought a license through a retail sales channel and have a product key to enter."

## More information

For more information, see the following sections from [SQL Server on Linux Frequently Asked Questions (FAQ)](/sql/linux/sql-server-linux-faq).

**How does licensing work on Linux?**  

SQL Server is licensed the same way for both Windows and Linux. You select the platform of your choice during the licensing process. For more information, see [How to license SQL Server](https://www.microsoft.com/sql-server/sql-server-2017?rtc=1).

**Which edition of SQL Server should I choose if I have already purchased it?**  

When you run mssql-conf Setup, you are provided the following installation options:

Choose an edition of SQL Server:

- Evaluation (free, no production use rights, 180-day limit)

- Developer (free, no production use rights)

- Express (free)  

- Web (PAID)

- Standard (PAID)

- Enterprise (PAID)

- Enterprise Core (PAID)

- I bought a license through a retail sales channel and have a product key to enter.

If you obtained your license through Volume Licensing as part of an Enterprise Agreement or through your MSDN subscription, you must select from among options 4 through 7.
If you purchased a Standard edition through a retail channel, you must select option 8.
