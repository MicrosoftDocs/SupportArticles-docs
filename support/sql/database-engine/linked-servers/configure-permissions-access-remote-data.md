---
title: Configuring permissions to access remote data
description: This article describes how to disable ad hoc queries that use the OPENROWSET or the OPENDATASOURCE functionality in SQL Server.
ms.date: 10/01/2022
ms.custom: sap:Administration and Management
ms.reviewer: ericbu
---

# Configuring permissions to access remote data from an OLEDB datasource in SQL Server

This article describes how to disable ad hoc queries that use the `OPENROWSET` or the `OPENDATASOURCE` functionality in SQL Server.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 327489

## Summary

You can use `OPENROWSET` or `OPENDATASOURCE` statements in SQL Server as an ad hoc method to connect and access data from a remote OLEDB provider including a remote SQL Server instance. These statements can be used to access remote data from OLE DB data sources only when the **DisallowAdhocAccess** registry option is explicitly set to **0** for the specified provider, and the **Ad Hoc Distributed Queries** advanced configuration option is enabled. When these options aren't set, the default behavior doesn't allow for ad hoc access.

This article provides additional details on configuring **DisallowAdhocAccess** through SQL Server Management Studio and registry settings as well as the default behavior.

## Disabling ad hoc access using SQL Server Management Studio

Specify the `DisallowAdHocAccess` property for the provider in SQL Server Management Studio (SSMS)

1. Open SSMS and expand **Providers** under **Linked Servers**.

1. Click to select the OLE DB provider you want to use, and then select the **Provider Options** button.

1. Scroll down and select the **Disallow adhoc access** property checkbox and select **OK**.

## Disabling ad hoc access using registry editor

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/en-us/topic/how-to-back-up-and-restore-the-registry-in-windows-855140ad-e318-2a13-2829-d428a2ab0692).  

After a linked server is saved, the `DisallowAdHocAccess` property can be set only through a registry setting.

### Add the DisallowAdHocAccess value

To add the `DisallowAdHocAccess` value, follow these steps:

1. Start Registry Editor.
2. Locate and then select the key in the registry: **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSSQLServer\Providers\<ProviderName>**  

   Example:
   If you're trying to change this for Microsoft OLEDB Provider for ODBC Drivers, the key will be:

   `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSSQLServer\Providers\MSDASQL`

3. On the **Edit** menu, select **Add Value**, and then add this registry value:

    ```console
    Value name: DisallowAdHocAccess
    Data type: REG_DWORD
    Radix: Hex
    Value data: 1
    ```

4. Quit Registry Editor.

## Enable ad-hoc remote access

After ensuring that the **Ad Hoc Distributed Queries** advanced configuration option is enabled, you need to set the **DisallowAdhocAccess** registry option to **0** for the specified provider.

To modify an existing `DisallowAdHocAccess` value, follow these steps:

1. Start Registry Editor.
2. Locate and then select the `DisallowAdHocAccess` value under the key in the registry: **HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSSQLServer\Providers\<ProviderName>**  

   Example:
   `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSSQLServer\Providers\Microsoft.ACE.OLEDB.12.0`

3. On the **Edit** menu, select **DWORD**, type *1*, and then select **OK**.

4. Quit Registry Editor. For a named instance, the registry key is different:
`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server\<Instance Name>\Providers\<ProviderName>`

## Restart requirement

A change of the value of `DisallowAdHocAccess` from **1** to **0** wouldn't require a restart of the SQL Service, whereas a change from **0** to **1** would have to have a SQL Service restart for the change that was made to become effective.

## Default behavior

Ad hoc access of remote OLE BD data sources using `OPENROWSET` and `OPENDATASOURCE` is disabled by default and no additional configuration is necessary. You need to use the procedures discussed in the article only if this remote access has previously been explicitly enabled.  

> [!NOTE]
> With the default setting, if you try to call these functions in ad hoc queries, you receive an error message that resembles the following message:
> Server: Msg 7415, Level 16, State 1, Line 1 Ad hoc access to OLE DB provider 'Microsoft.Jet.OLEDB.4.0' has been denied. You must access this provider through a linked server.

In other words, with the `DisallowAdHocAccess` property set to **1** for a specific OLE DB provider, you must use a predefined linked server setup for the specific OLE DB provider. You can no longer pass in an ad hoc connection string that references that provider to the `OPENROWSET` or the `OPENDATASOURCE` function.

## See also

- [OPENDATASOURCE (Transact-SQL)](/sql/t-sql/functions/opendatasource-transact-sql)

- [OPENROWSET (Transact-SQL)](/sql/t-sql/functions/openrowset-transact-sql)

- [OleDbProviderSettings.DisallowAdHocAccess Property](/dotnet/api/microsoft.sqlserver.management.smo.oledbprovidersettings.disallowadhocaccess)
