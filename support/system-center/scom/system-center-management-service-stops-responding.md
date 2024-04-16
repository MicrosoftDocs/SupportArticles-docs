---
title: The System Center Management service stops responding
description: Fixes an issue where the System Center Management service stops responding after an instance of SQL Server disconnects, restarts, or fails.
ms.date: 04/15/2024
ms.reviewer: rajatm
---
# The System Center Management service stops responding after an instance of SQL Server goes offline

This article helps you fix an issue where the System Center Management service stops responding after an instance of Microsoft SQL Server goes offline.

_Original product version:_ &nbsp; Microsoft System Center Service Manager 2010, System Center 2012 Service Manager, Microsoft System Center 2012 Service Manager Service Pack 1, Microsoft System Center 2012 Operations Manager, Microsoft System Center 2012 Operations Manager Service Pack 1, System Center 2012 R2 Operations Manager, System Center 2012 R2 Service Manager  
_Original KB number:_ &nbsp; 2913046

## Symptoms

After an instance of SQL Server that hosts the `OperationsManager` database goes offline, the System Center Management service of the Microsoft System Center 2012 Operations Manager Service Pack 1 (SP1) management server stops responding.

For example, the System Center Management service stops responding after the instance of SQL Server disconnects, restarts, or fails. To recover from this issue after the instance of SQL Server is available again, you must restart the System Center Management service.

## Resolution

> [!IMPORTANT]
> Before you modify the registry, follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify the registry, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

To resolve this issue, you can enable the automatic recovery feature in System Center 2012 Operations Manager SP1. By default, this automatic recovery feature is disabled.

To enable the automatic recovery feature on the management server, follow these steps:

1. Start Registry Editor.
2. Locate and then click the following registry subkey:

    `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\System Center\2010\Common\DAL`

3. Create the following two registry entries:

   - `DALInitiateClearPool`

     Type: **DWORD**  
     Decimal value: **1**

   - `DALInitiateClearPoolSeconds`

     Type: **DWORD**  
     Decimal value: **60**

     > [!NOTE]
     > The `DALInitiateClearPoolSeconds` setting controls when the management server drops the current connection pool and when the management server tries to reestablish an SQL Server connection. We recommend that you set this setting to **60** seconds or more to avoid performance issues.

4. Restart the System Center Management service on the management server.
