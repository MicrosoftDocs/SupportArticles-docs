---
title: SQL Server services using domain credentials fail to start 
description: This article provides a workaround to troubleshoot an issue when SQL Server fails to start when the startup account doesn't have the right permissions.
ms.date: 12/12/2022
ms.custom: sap:Administration and Management
ms.reviewer: ramakoni, v-jayaramanp
---

# SQL Server services using domain credentials fail to start

This article discusses an issue wherein SQL Server fails to start when the startup account doesn't have the required permissions.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 3006856

## Symptoms

When you try to start or restart a SQL Server service, it fails to do so, and the following messages are logged in the SQL Server error log:

```output
<Time stamp> spid9s Error: 17182, Severity: 16, State: 1.

<Time stamp> spid9s TDSSNIClient initialization failed with error 0xffffffff, status code 0x80. Reason: Unable to initialize SSL support.

<Time stamp> spid9s Error: 17182, Severity: 16, State: 1.

<Time stamp> spid9s TDSSNIClient initialization failed with error 0xffffffff, status code 0x1. Reason: Initialization failed with an infrastructure error. Check for previous errors.

<Time stamp> spid9s Error: 17826, Severity: 18, State: 3. Time stamp spid9s Could not start the network library because of an internal error in the network library. To determine the cause, review the errors immediately preceding this one in the error log.

<Time stamp> spid9s Error: 17120, Severity: 16, State: 1. Time stamp spid9s SQL Server could not spawn FRunCommunicationsManager thread. Check the SQL Server error log and the Windows event logs for information about possible related problems.
```

> [!NOTE]
> This issue only occurs on a SQL Server instance that runs under a domain account.

## Cause

The issue occurs because the usual permissions granted to a SQL Service account are missing. The user rights for the SQL Server startup account that must be present are as follows:

- **Adjust memory quotas for a process** (SeIncreaseQuotaPrivilege).

- **Bypass traverse checking** (SeChangeNotifyPrivilege).

- **Log on as a service** (SeServiceLogonRight).

- **Replace a process-level token** (SeAssignPrimaryTokenPrivilege).

For more information, see [Service Permissions](/sql/database-engine/configure-windows/configure-windows-service-accounts-and-permissions#Serv_Perm).

## Resolution

To resolve the issue, grant the missing permissions to the SQL Service domain account by using the **User Rights Assignment** pane in the [Local Security Policy](/windows/security/threat-protection/security-policy-settings/how-to-configure-security-policy-settings) MMC snap-in.

