---
title: Memory exceeds the configured limits specified by memory.memorylimitmb in SQL Server
description: Fixes an issue where memory exceeds the configured limits that are specified by memory.memorylimitmb in SQL Server.
ms.date: 07/25/2024
ms.update-cycle: 1095-days
ms.custom: sap:Installation, Patching, Upgrade, Uninstall, evergreen, KB5042369
ms.reviewer: rafidl, ericjulien, amitkh, v-cuichen
appliesto:
- SQL Server 2022 on Linux
- SQL Server 2019 on Linux
---
# FIX: Memory exceeds the configured limits that are specified by memory.memorylimitmb in SQL Server

## Symptoms

SQL Server on Linux might not comply with the memory boundaries that are set by the [memory.memorylimitmb](/sql/linux/sql-server-linux-configure-mssql-conf#memorylimit) configuration option, as evidenced by monitoring tools such as top and ps displaying memory usage that exceeds the configured limits.

For example, you notice that the memory reported by the Resident Memory Size (RES) or Resident Memory Usage (RSS) fields in the following commands is higher than the memory configured by `memory.memorylimitmb`.

```Bash
top -p $(pidof sqlservr | cut -d' ' -f1)

ps -p $(pidof sqlservr | cut -d' ' -f1) -u
```

## Resolution

This problem is fixed in the following cumulative updates for SQL Server:

- [Cumulative Update 14 for SQL Server 2022](cumulativeupdate14.md)
- [Cumulative Update 27 for SQL Server 2019](../sqlserver-2019/cumulativeupdate27.md)

> [!NOTE]
> After applying the fix, for servers that have Active Directory authentication configured, you might still see the issue or notice that the memory limits of `memory.memorylimitmb` are consumed quickly. In this scenario, you also need to update the version of Kerberos v5 (krb5) packages on Linux to 1.19.2 or later versions to resolve a `defcred` leak in `krb5_gss_inquire_cred()`. For more information, see [Fix defcred leak in krb5_gss_inquire_cred()](https://github.com/krb5/krb5/commit/098f874f3b50dd2c46c0a574677324b5f6f3a1a8).
> 
> For Red Hat Enterprise Linux (RHEL) 8, Ubuntu 20.04, or SUSE Linux Enterprise Server (SLES) 12 distributions, you might need to contact your Linux distribution vendor to request updated packages for krb5.
> 
> If you can't update the packages, you can still work around the leak in `krb5_gss_inquire_cred()` by using pooled connections in your application connection strings.

## Monitor memory usage in SQL Server on Linux

After installing SQL Server 2022 Cumulative Update 14 (CU14) or SQL Server 2019 CU27 or later versions, you'll be able to monitor system resource alerts by using the `system_low_memory_signal_state` and `system_high_memory_signal_state` columns in `sys.dm_os_sys_memory` dynamic management view (DMV). If `system_low_memory_signal_state` consistently shows `1`, consider increasing the memory allocation for SQL Server or review the queries that consume the most memory and then resolve their memory requirements.

## About cumulative updates for SQL Server

Each new cumulative update for SQL Server contains all the hotfixes and security fixes that were in the previous build. We recommend that you install the latest build for your version of SQL Server:

- [Latest cumulative update for SQL Server 2022](build-versions.md)
- [Latest cumulative update for SQL Server 2019](../sqlserver-2019/build-versions.md)

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.

## References

Learn about the [terminology](../../../windows-client/deployment/standard-terminology-software-updates.md) that Microsoft uses to describe software updates.

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-disclaimer.md)]
