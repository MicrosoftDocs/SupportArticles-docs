---
title: Clients send multiple Topic ID 611 state messages
description: Describes an issue in which clients send multiple Topic ID 611 state messages when you try to service a server group on a child primary site. Provides a workaround.
ms.date: 12/05/2023
ms.reviewer: kaushika, kerwinm, yuexia, cmkbreview
ms.custom: sap:Software Update Management (SUM)\Orchestration Groups
---
# Clients send multiple Topic ID 611 state messages when you service a server group on a child primary site

This article helps you work around an issue in which clients send multiple **Topic ID 611** state messages when you try to service a server group on a child primary site in Configuration Manager.

_Original product version:_ &nbsp; Configuration Manager (current branch), Configuration Manager (Long-Term Servicing Branch)  
_Original KB number:_ &nbsp; 4018656

## Symptoms

In Configuration Manager, you experience errors when you try to service a server group (cluster patching) on a child primary site that has a remote management point. Error messages that resemble the following are logged in the MP_ClientID.log file:

> CMPDBConnection::ExecuteSQL(): ICommandText::Execute() failed with 0x80040E09  
> MPDB ERROR - EXTENDED INFORMATION  
> MPDB Method : ExecuteSP()  
> MPDB Method HRESULT : 0x80040E09  
> Error Description : The EXECUTE permission was denied on the object 'spGetLockState', database '\<dbname>', schema 'dbo'.

Additionally, clients may send multiple **Topic ID 611, Type 611** state messages (.smx files).This causes a backlog in state message processing.

> [!NOTE]
> This problem was listed as resolved in [Update Rollup 1](https://support.microsoft.com/help/3186654) for Configuration Manager current branch, version 1606. However, the problem was not completely fixed.

## Cause

When the current [Service a server group](/mem/configmgr/sum/deploy-use/service-a-server-group) feature is enabled, the required Execute permissions for remote management points aren't applied correctly to the `spGetLockState` stored procedure.

## Workaround 1

Disable the [Service a server group](/mem/configmgr/sum/deploy-use/service-a-server-group) feature if you don't use it.

## Workaround 2

Manually grant Execute rights for the management points to the `spGetLockState` stored procedure by using the following SQL script:

```sql
IF OBJECT_ID(N'spGetLockState') IS NOT NULL AND dbo.fnIsPrimary() = 1
BEGIN
    GRANT EXECUTE ON [spGetLockState] TO [smsdbrole_MP]
END
```
