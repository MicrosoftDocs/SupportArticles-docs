---
title: Add new collations that comply with the GB18030-2022 standard
description: Describes the improvement that adds new collations that comply with the GB18030-2022 standard.
ms.date: 03/14/2024
ms.custom: KB5036707
ms.reviewer: alexek, umajay, shahmit, ravishetye, v-cuichen
appliesto:
- SQL Server 2022 on Windows
- SQL Server 2022 on Linux
---
# Improvement: Add new collations that comply with the GB18030-2022 standard

## Summary

Microsoft SQL Server 2022 currently complies with the GB18030-2005 standard. The GB18030-2022 standard is a revised version of the GB18030-2005 standard, which includes several updates and improvements. In order to comply with the GB18030-2022 standard, this improvement provides new collations that database applications can use to meet the standard requirements. For more information about the GB18030 standard, see [GB18030 support](/sql/relational-databases/collations/collation-and-unicode-support#GB18030).

This improvement adds a new `sp_db_gb18030_unicode_collations` system stored procedure that can be used to control the visibility of the new collations in a user database. Additionally, the stored procedure increases the database version of the internal user.

> [!NOTE]
> If a database has the new collation enabled, you won't be able to use the database together with a previous Cumulative Update (CU). For example, you can't downgrade the CU.

Here's an example of how to use the new collation:

```sql
USE master;
CREATE DATABASE gb1;
EXEC sp_db_gb18030_unicode_collations 'gb1', 'ON';
ALTER DATABASE gb1 COLLATE Chinese_Simplified_Pinyin_160_CS_AS_KS_WS_SC_UTF8;
```

To reset the database back to its state before you apply SQL Server 2022 CU12, all references to the new collation should be removed from the database, and the feature can be turned off. For example, you can run the following statements:

```sql
USE master;
ALTER DATABASE gb1 SET RECOVERY SIMPLE;
EXEC sp_db_gb18030_unicode_collations 'gb1', 'OFF';
```

## More information

This improvement is included in the following cumulative update for SQL Server:

[Cumulative Update 12 for SQL Server 2022](cumulativeupdate12.md)

## About cumulative updates for SQL Server

Each new cumulative update for SQL Server contains all the hotfixes and security fixes that were in the previous build. We recommend that you install the latest build for your version of SQL Server:

[Latest cumulative update for SQL Server 2022](build-versions.md)

## References

- [Language improvements](/sql/sql-server/what-s-new-in-sql-server-2022#language)
- [Collation and Unicode support](/sql/relational-databases/collations/collation-and-unicode-support)
- [sys.fn_helpcollations (Transact-SQL)](/sql/relational-databases/system-functions/sys-fn-helpcollations-transact-sql)
- [COLLATE (Transact-SQL)](/sql/t-sql/statements/collations)
- Learn about the [terminology](../../../windows-client/deployment/standard-terminology-software-updates.md) that Microsoft uses to describe software updates
