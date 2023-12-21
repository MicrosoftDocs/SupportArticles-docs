---
title: ODBC Driver Install Checking
description: This article assist you in verifying the successful installation of your ODBC drivers and ensuring they're correctly configured to facilitate smooth data access and management.
ms.date: 12/19/2023
ms.custom: sap:Installation, Patching and Upgrade
---
ODBC Driver Install Checking

Ensuring the correct installation and functionality of ODBC drivers is pivotal for seamless database connectivity across various applications and systems. This guide aims to assist you in verifying the successful installation of your ODBC drivers, ensuring they are correctly configured to facilitate smooth data access and management.

In this topic, we work backwards from the ODBC Administrator to show where the settings are kept.

ODBC administrator and Sample ODBC Connection Strings
There are two copies of the ODBC Administrator on 64-bit systems, one for 64-bit applications and one for 32-bit applications:

Start | Run | ODBCAD32.EXE                              or C:\WINDOWS\SYSTEM32\ODBCAD32.EXE
Start | Run | C:\WINDOWS\SYSWOW64\ODBCAD32.EXE          32-bit driver test on 64-bit Windows

:::image type="content" source="media/odbc-driver-install-checking/Picture1.png" alt-text=".":::

ODBC connections can use Data Source Names (DSNs) or they can be DSN-less, as the examples below show:

driver={sql server};server=sqlprod01;database=northwind;trusted_connection=yes
dsn=userdsn1
dsn=test;uid=sa;pwd=xxxx

The first connection string explicitly specifies the driver name, the server name, the database name, and whether using integrated security (trusted_connection). This is a DSN-less connection. The second and third connection strings use a DSN, which is an encapsulation of these items that are stored in the registry. The user name and password cannot be stored in the DSN and must be specified explicitly.

A Data Source Name is a short-cut for applications to load the driver, providing a level of indirection. By using a DSN, you could change the server or database or even database type the application connects to without changing the application.

ODBC Administrator Drivers and Registry

A good first test is to see if the driver shows in the ODBC Administrator. Here are some 64-bit and 32-bit drivers:

:::image type="content" source="media/odbc-driver-install-checking/Picture2.png" alt-text=".":::

:::image type="content" source="media/odbc-driver-install-checking/Picture3.png" alt-text=".":::

Driver and DSN information are stored in the registry:

:::image type="content" source="media/odbc-driver-install-checking/Picture4.png" alt-text=".":::

Note: on 64-bit machines, 32-bit DSN and driver information is stored under the Wow6432Node. System DSNs are stored under HKEY_LOCAL_MACHINE and User DSNs are stored under
HKEY_CURRENT_USER.

HKEY_LOCAL_MACHINE\SOFTWARE\ODBC
HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\ODBC
HKEY_CURRENT_USER\Software\ODBC
HKEY_CURRENT_USER\Software\Wow6432Node\ODBC

The ODBC.INI subkey contains a list of all the Data Source Names (DSNs) and a subkey for each DSN. The ODBCINST.INI subkey lists all the drivers.

:::image type="content" source="media/odbc-driver-install-checking/Picture5.png" alt-text=".":::

If there is a problem loading a driver via DSN, check the ODBC.INI to find out which driver the DSN is using.

:::image type="content" source="media/odbc-driver-install-checking/Picture6.png" alt-text=".":::

Note: The LastUser entry does not affect the connection string. This is only used when testing the DSN in the ODBC Administrator.

Validate the server name, database name, and whether the driver is installed. If the driver cannot be loaded, you will get an error message:

     ERROR [IM002] [Microsoft][ODBC Driver Manager] Data source name not found and no default driver specified.

Even if the Driver path in the DSN is incorrect, the driver manager can still locate it in the ODBCINST.INI subkey from the driver name listed in the ODBC Data Sources registry key.
Supporting 3rd-Party Driver Installation

For 3rd-party ODBC drivers, Microsoft support is limited to:

•	Checking that the driver registry keys are present. If not, reinstall or consult the vendor.
•	Checking that the paths point to a DLL that actually exists. If not, reinstall or consult the vendor.
•	Creating a test DSN and performing a connection test.
•	Helping capture a PROCMON trace that can be analyzed by the vendor.

See also