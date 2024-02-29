---
title: Site system installation account is incorrectly used for database connection
description: Describes a problem in which Configuration Manager may incorrectly try to use the site system installation account for a remote site system to connect to the SQL Server database.
ms.date: 12/05/2023
ms.reviewer: kaushika, erinwi, prakask, keiththo
---
# Site system installation account is incorrectly used for a remote site system to connect to SQL Server database

This article provides a workaround for the issue that the site system installation account is incorrectly used to update the SQL Server database for a remote site server.

_Original product version:_ &nbsp; Microsoft System Center 2012 Configuration Manager  
_Original KB number:_ &nbsp; 2689646

## Symptoms

Consider the following scenario:

- You install Configuration Manager together with a remote Microsoft SQL Server in the same domain as the site server.
- You have a remote site system that is in an untrusted domain (a perimeter network, also known as DMZ, demilitarized zone, and screened subnet).
- You select the **Use another account for installing this site system** option for the remote site system, and you specify an account that has local administrative rights on that server.
- You deploy roles to the remote site system such as the Distribution Point role.

In this scenario, Configuration Manager may incorrectly try to use the site system installation account that is configured for the remote site server to update the SQL Server database. When this occurs, the update fails, and the following messages are logged.

In the remote SQL Server log:

> MSSQLSERVER,18452,Logon,Login failed. The login is from an untrusted domain and cannot be used with Windows authentication. [CLIENT: primary_site_server_IP_address]

In Distrmg.log:

> [28000][18452][Microsoft][ODBC SQL Server Driver][SQL Server]Login failed. The login is from an untrusted domain and cannot be used with Windows authentication.  
> Failed to connect to the SQL Server. Cannot save the package status to the data source...

## Resolution

To fix this issue, update to [Configuration Manager current branch version 2010](/mem/configmgr/core/plan-design/changes/whats-new-in-version-2010).

## Workaround

To work around this issue without updating, on the SQL Server, create a local account that has the same name as the site system installation account that is configured for the remote site server, and grant the account access to the Configuration Managers database. Then, pass through authentication works around Configuration Manager's use of the site system installation account.
