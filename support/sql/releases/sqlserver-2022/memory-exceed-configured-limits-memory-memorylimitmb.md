---
title: Memory exceeds the configured limits specified by memory.memorylimitmb in SQL Server
description: Fixes an issue where memory exceeds the configured limits that are specified by memory.memorylimitmb in SQL Server.
ms.date: 07/23/2024
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen
ms.reviewer: rafidl, ericjulien, v-cuichen
appliesto:
- SQL Server 2022 on Linux
- SQL Server 2019 on Linux
---
# FIX: Memory exceeds the configured limits that are specified by memory.memorylimitmb in SQL Server

## Symptoms

SQL Server on Linux might not comply with the memory boundaries that are set by the `memory.memorylimitmb` configuration option, as evidenced by monitoring tools such as top and ps displaying memory usage that exceeding the configured limits.

## Resolution

This problem is fixed in the following cumulative updates for SQL Server:

- [Cumulative Update 14 for SQL Server 2022](cumulativeupdate14.md)
- [Cumulative Update 27 for SQL Server 2019](../sqlserver-2019/cumulativeupdate27.md)

> [!NOTE]
> If you use Active Directory Authentication together with SQL Server on Linux, you also need to update the version of Kerberos v5 (krb5) packages on Linux to 1.19 or later versions to resolve a `defcred` leak in `krb5 gss_inquire_cred()`.

## Monitor memory usage in SQL Server on Linux

After installing SQL Server 2022 Cumulative Update 14 (CU14) or SQL Server 2019 CU27 or later versions, you'll be able to monitor system resource alerts by using the `system_low_memory_signal_state` and `system_high_memory_signal_state` columns in `sys.dm_os_sys_memory` dynamic management view (DMV). If `system_low_memory_signal_state` always shows `1`, consider increasing the memory allocation for SQL Server or review the queries that consume the most memory and then resolve their memory requirements.

## About cumulative updates for SQL Server

Each new cumulative update for SQL Server contains all the hotfixes and security fixes that were in the previous build. We recommend that you install the latest build for your version of SQL Server:

- [Latest cumulative update for SQL Server 2022](build-versions.md)
- [Latest cumulative update for SQL Server 2019](../sqlserver-2019/build-versions.md)

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.

## References

Learn about the [terminology](../../../windows-client/deployment/standard-terminology-software-updates.md) that Microsoft uses to describe software updates.
