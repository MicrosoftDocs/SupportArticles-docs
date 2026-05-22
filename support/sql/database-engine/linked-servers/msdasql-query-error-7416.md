---
title: Troubleshoot MSDASQL linked server fails with error 7416
description: MSDASQL linked server queries fail and generate error 7416 after a SQL Server CU or GDR update. Apply these workarounds to restore access.
ms.date: 05/14/2026
ms.reviewer: jopilov, randolphwest, hugoqueiroz, jamesferebee, aartigoyle, v-shaywood
ms.custom: sap:Linked Server and distributed queries
appliesto:
- SQL Server 2022 CU and GDR updates since March 2026
- SQL Server 2025 CU and GDR updates since April 2026
- Azure SQL Managed Instance
---

# Linked server queries that use MSDASQL fail with error 7416

## Summary

This article describes a known issue in which linked server queries that use the `MSDASQL` (OLE DB Provider for ODBC Drivers) provider and specify a provider string fail and generate error 7416. The article also provides workarounds that restore linked server connectivity without rolling back the update.

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
