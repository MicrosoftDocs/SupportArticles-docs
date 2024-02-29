---
title: Add Chinese collations that comply with the GB18030-2022 standard
description: Describes the improvement that adds Chinese collations that comply with the GB18030-2022 standard.
ms.date: 03/14/2024
ms.custom: KB5036707
ms.reviewer: alexek, umajay, shahmit, v-cuichen
appliesto:
- SQL Server 2022 on Windows
- SQL Server 2022 on Linux
---
# Improvement: Add Chinese collations that comply with the GB18030-2022 standard

## Summary

Microsoft SQL Server 2022 currently complies with the GB18030-2005 standard. The GB18030-2022 standard is a revised version of the GB18030-2005 standard, which includes several updates and improvements. In order to comply with the GB18030-2022 standard, this improvement provides new Chinese collations that database applications can use to meet the standard requirements. For more information about the GB18030 standard, see [GB18030 support](/sql/relational-databases/collations/collation-and-unicode-support#GB18030).

This improvement adds a new `sp_db_gb18030_unicode_collations` system stored procedure that can be used to control the visibility of the new Chinese collations in a user database. Additionally, the stored procedure increases the database version of the internal user.

> [!NOTE]
> If a database has the new Chinese collation enabled, you won't be able to use the database together with a previous Cumulative Update (CU), for example, you can't downgrade the CU.

## More information

This improvement is included in the following cumulative update for SQL Server:

[Cumulative Update 12 for SQL Server 2022](cumulativeupdate12.md)

## About cumulative updates for SQL Server

Each new cumulative update for SQL Server contains all the hotfixes and security fixes that were in the previous build. We recommend that you install the latest build for your version of SQL Server:

[Latest cumulative update for SQL Server 2022](build-versions.md)

## References

- [Collation and Unicode support](/sql/relational-databases/collations/collation-and-unicode-support)
- [sys.fn_helpcollations (Transact-SQL)](/sql/relational-databases/system-functions/sys-fn-helpcollations-transact-sql)
- [COLLATE (Transact-SQL)](/sql/t-sql/statements/collations)
- Learn about the [terminology](../../../windows-client/deployment/standard-terminology-software-updates.md) that Microsoft uses to describe software updates
