---
title: Troubleshoot MSDASQL linked server fails with error 7416
description: MSDASQL linked server queries fail and generate error 7416 after a SQL Server CU or GDR update. Apply these workarounds to restore access.
ms.date: 05/14/2026
ms.reviewer: jopilov, randolphwest, hugoqueiroz, jamesferebee, aartigoyle, v-shaywood
ms.custom: sap:Linked Server and distributed queries
---

# Linked server queries that use MSDASQL fail with error 7416

## Summary

This article describes a known issue in which linked server queries that use the `MSDASQL` (OLE DB Provider for ODBC Drivers) provider and specify a provider string fail and generate error 7416. The article also provides workarounds that restore linked server connectivity without rolling back the update.

This issue applies to the following SQL Server cumulative updates and security updates.

| Version | Update | KB | Released |
| --- | --- | --- | --- |
| SQL Server 2025 | CU5 | [KB5084896](../../releases/sqlserver-2025/cumulativeupdate5.md) | May 20, 2026 |
| SQL Server 2025 | CU4 + GDR | [KB5089899](https://support.microsoft.com/help/5089899) | May 12, 2026 |
| SQL Server 2025 | GDR | [KB5091223](https://support.microsoft.com/help/5091223) | May 12, 2026 |
| SQL Server 2025 | CU4 | [KB5081495](../../releases/sqlserver-2025/cumulativeupdate4.md) | April 16, 2026 |
| SQL Server 2025 | CU3 + GDR | [KB5083245](https://support.microsoft.com/help/5083245) | April 14, 2026 |
| SQL Server 2025 | GDR | [KB5084814](https://support.microsoft.com/help/5084814) | April 14, 2026 |
| SQL Server 2022 | CU25 | [KB5081477](../../releases/sqlserver-2022/cumulativeupdate25.md) | May 20, 2026 |
| SQL Server 2022 | CU24 + GDR | [KB5089900](https://support.microsoft.com/help/5089900) | May 12, 2026 |
| SQL Server 2022 | GDR | [KB5091158](https://support.microsoft.com/help/5091158) | May 12, 2026 |
| SQL Server 2022 | CU24 + GDR | [KB5083252](https://support.microsoft.com/help/5083252) | April 14, 2026 |
| SQL Server 2022 | GDR | [KB5084815](https://support.microsoft.com/help/5084815) | April 14, 2026 |
| SQL Server 2022 | CU24 | [KB5080999](../../releases/sqlserver-2022/cumulativeupdate24.md) | March 12, 2026 |
| SQL Server 2019 | CU32 + GDR | [KB5090407](https://support.microsoft.com/help/5090407) | May 12, 2026 |
| SQL Server 2019 | GDR | [KB5090408](https://support.microsoft.com/help/5090408) | May 12, 2026 |
| SQL Server 2019 | CU32 + GDR | [KB5084816](https://support.microsoft.com/help/5084816) | April 14, 2026 |
| SQL Server 2019 | GDR | [KB5084817](https://support.microsoft.com/help/5084817) | April 14, 2026 |
| SQL Server 2017 | CU31 + GDR | [KB5090354](https://support.microsoft.com/help/5090354) | May 12, 2026 |
| SQL Server 2017 | GDR | [KB5090347](https://support.microsoft.com/help/5090347) | May 12, 2026 |
| SQL Server 2017 | CU31 + GDR | [KB5084818](https://support.microsoft.com/help/5084818) | April 14, 2026 |
| SQL Server 2017 | GDR | [KB5084819](https://support.microsoft.com/help/5084819) | April 14, 2026 |
| SQL Server 2016 | Azure Connect Pack + GDR | [KB5089270](https://support.microsoft.com/help/5089270) | May 12, 2026 |
| SQL Server 2016 | SP3 + GDR | [KB5089271](https://support.microsoft.com/help/5089271) | May 12, 2026 |
| SQL Server 2016 | Azure Connect Pack + GDR | [KB5084820](https://support.microsoft.com/help/5084820) | April 14, 2026 |
| SQL Server 2016 | SP3 + GDR | [KB5084821](https://support.microsoft.com/help/5084821) | April 14, 2026 |

> [!NOTE]
> This issue also applies to Azure SQL Managed Instance.

## Symptoms

Linked server queries that use the `MSDASQL` provider and specify a provider string (`@provstr`) fail and return the following error message when a user that isn't a member of the **sysadmin** fixed server role runs the query:

> Msg 7416, Level 16  
> Access to the remote server is denied because no login-mapping exists.

The failure can occur even if the linked server and login mappings are configured correctly.

## Cause

A stricter connection validation check in the Database Engine can reject connections for certain linked server configurations that use the `MSDASQL` provider, even if earlier builds allowed those connections.

## Workaround

To work around this issue without rolling back the update, use one of the following methods:

- If your configuration doesn't require the provider string (`@provstr`), remove it from the linked server definition.
- Add a `User ID` entry to the provider string (`@provstr`). For example, set `User ID=<value>`. The provider string must still include `UID` as well.

You can also prevent the failure by granting **sysadmin** permissions to the affected user. However, we don't recommend that you use this method.

## Related content

- [Configuring permissions to access remote data](configure-permissions-access-remote-data.md)
- [Troubleshoot OLE DB provider errors for linked servers](ole-db-provider-errors.md)
- [Linked servers (Database Engine)](/sql/relational-databases/linked-servers/linked-servers-database-engine)
