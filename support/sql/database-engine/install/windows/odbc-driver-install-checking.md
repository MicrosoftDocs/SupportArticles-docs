---
title: ODBC driver installation check
description: Helps you verify the successful installation of your ODBC drivers and ensure they're correctly configured to facilitate smooth data access and management.
ms.date: 12/19/2023
ms.custom: sap:Installation, Patching and Upgrade
ms.reviewer: mastewa, jopilov, prmadhes, v-sidong
---

# ODBC driver installation check

Ensuring the correct installation and functionality of ODBC drivers is pivotal for seamless database connectivity across various applications and systems. This article assists you in verifying the successful installation of your ODBC drivers and ensuring they're correctly configured to facilitate smooth data access and management.

## ODBC Data Source Administrator and sample ODBC connection strings

There are two copies of the ODBC Data Source Administrator on 64-bit systems:

- For 64-bit applications, select <kbd>Windows</kbd>+<kbd>R</kbd> and type *ODBCAD32.EXE* or *C:\WINDOWS\SYSTEM32\ODBCAD32.EXE*.

- For 32-bit applications, select <kbd>Windows</kbd>+<kbd>R</kbd> and type *C:\WINDOWS\SYSWOW64\ODBCAD32.EXE*.

ODBC connections can use Data Source Names (DSNs) or can be DSN-less, for example:

- `driver={sql server};server=sqlprod01;database=northwind;trusted_connection=yes`
- `dsn=userdsn1`
- `dsn=test;uid=sa;pwd=<Password>`

The first connection string explicitly specifies the driver name, server name, database name, and whether to use integrated security (`trusted_connection`). It's a DSN-less connection.

The second and third connection strings use a DSN, which is an encapsulation of these items that are stored in the registry. The username and password can't be stored in the DSN and must be specified explicitly.

A DSN is a shortcut for applications to load the driver, providing a level of indirection. By using a DSN, you can change the server, database, and even the database type the application connects to without changing the application.

## ODBC Data Source Administrator drivers and registry

The best test is to see if the driver shows up in the ODBC Data Source Administrator. Here are some 64-bit and 32-bit drivers:

:::image type="content" source="media/odbc-driver-install-checking/64-bit-driver.png" alt-text="Screenshot shows a 64-bit driver.":::

:::image type="content" source="media/odbc-driver-install-checking/32-bit-driver.png" alt-text="Screenshot shows a 32-bit driver.":::

Driver and DSN information is stored in the registry:

:::image type="content" source="media/odbc-driver-install-checking/driver-dsn-registry.png" alt-text="Screenshot shows the driver and DSN information in the registry.":::

On 64-bit machines, the `Wow6432Node` registry entry is used to store 32-bit DSN and driver information. System DSNs are stored under `HKEY_LOCAL_MACHINE`, and User DSNs are stored under `HKEY_CURRENT_USER`. For example:

- `HKEY_LOCAL_MACHINE\SOFTWARE\ODBC`
- `HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\ODBC`
- `HKEY_CURRENT_USER\Software\ODBC`
- `HKEY_CURRENT_USER\Software\Wow6432Node\ODBC`

The `ODBC.INI` subkey contains a list of all the DSNs and the subkeys for each DSN. The `ODBCINST.INI` subkey lists all the drivers.

:::image type="content" source="media/odbc-driver-install-checking/odbc-odbcinst-subkeys.png" alt-text="Screenshot shows the ODBC.INI and ODBCINST.INI subkeys.":::

If there's a problem loading a driver via the DSN, check the `ODBC.INI` subkey to find out which driver the DSN is using.

:::image type="content" source="media/odbc-driver-install-checking/odbc-subkey.png" alt-text="Screenshot shows how to find out which driver the DSN is using.":::

> [!NOTE]
> The **LastUser** entry doesn't affect the connection string. It's only used when testing the DSN in the ODBC Data Source Administrator.

Validate the server name, database name, and whether the driver is installed. If the driver can't be loaded, you receive the following error message:

> ERROR [IM002] [Microsoft][ODBC Driver Manager] Data source name not found and no default driver specified.

Even if the driver path in the DSN is incorrect, the driver manager can still locate it in the `ODBCINST.INI` subkey from the driver name listed in the ODBC Data Sources registry key.

## Support for third-party driver installation

For third-party ODBC drivers, Microsoft support is limited to:

- Check if the driver registry keys are present. If not, reinstall or consult the vendor.
- Check if the paths point to an actual existing DLL. If not, reinstall or consult the vendor.
- Create a test DSN and perform a connection test.
- Help capture a PROCMON trace that the vendor can analyze.

## More information

- [.NET driver installation check](net-driver-install-check.md)
- [OLE DB driver installation check](oledb-driver-install-check.md)
- [Driver installation check](driver-install-checking.md)