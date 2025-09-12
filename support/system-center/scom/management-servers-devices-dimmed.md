---
title: Management servers and managed devices are dimmed
description: Fixes a problem where some Operations Manager roles are dimmed in the Operations console and event 623 is logged on the affected computers.
ms.date: 04/15/2024
ms.reviewer: cliveea, jarrettr, shannonw
---
# Management servers and their managed devices are dimmed in the Operations Manager console

This article fixes a problem in which some Operations Manager roles are dimmed in the Operations console and event 623 is logged on the affected computers.

_Original product version:_ &nbsp; Microsoft System Center 2012 Operations Manager  
_Original KB number:_ &nbsp; 975057

## Symptoms

In a Microsoft System Center Operations Manager environment, one or more management servers that host the following roles, together with those management servers' managed devices, may appear dimmed or grayed out in the Operations console:

- Management server
- Gateway server
- Agent

Additionally, an event that resembles the following is logged in the Operations Manager log on these computers:

> Event Source: ESE  
> Event Category: Transaction Manager  
> Event ID: 623  
> Description: HealthService (\<PID>) The version store for instance \<instance>("\<name>") has reached its maximum size of \<value> Mb. It is likely that a long-running transaction is preventing cleanup of the version store and causing it to build up in size. Updates will be rejected until the long-running transaction has been completely committed or rolled back. Possible long-running transaction:  
> SessionId: \<value>  
> Session-context: \<value>  
> Session-context ThreadId: \<value>.  
> Cleanup: \<value>

> [!NOTE]
> This event may report the issue with other Operations Manager processes, depending on the affected role.

## Cause

This problem typically occurs in a large Operations Manager environment in which a management server or an agent computer is managing many workflows. This situation may occur for one of the following reasons:

- Many management packs are installed.
- A management server or an agent is acting as a proxy for many devices.

The Operations Manager Health Service stores records of transactions that are not finished in something called **version store**. The version store enables the Extensible Storage Engine (ESE) to track and to manage current transactions. The version store has a list of operations that are performed by active transactions that are maintained by the HealthService service. This list is an in-memory list of modifications that are made to the HealthService store database. There is a default size optimized for a typical installation of each Operations Manager role. However, the default size may be insufficient for certain Operations Manager environments.

## Resolution

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To resolve the problem, apply the following registry setting on the computers that host the affected roles:

- Subkey: `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\HealthService\Parameters`
- Type: **REG_DWORD**
- Name: **Persistence Version Store Maximum**
- Value: Number of 16-kilobyte pages
- Base: **Decimal**

The default size of the version store depends on the Operations Manager role and is defined as the number of 16-kilobyte pages to allocate in memory. The default values are as follows:

- Agent (workstation operating systems): **640** (10 megabytes)
- Agent (server operating systems): **1920** (30 megabytes)
- Management server: **5120** (80 megabytes)

If you experience this problem, we recommend that you set the version store size to double its default size. For example, if you set the version store size on a computer that hosts a Management Server role, set the registry value to **10240** (decimal).

After you apply the registry change, restart the HealthService service.

> [!NOTE]
>
> - A larger version store size requires additional memory to be allocated.
> - If the HealthService is running lots of workflows, this registry value must be set even larger than the recommended size.
> - For other issues where some of these symptoms are similar, see [Troubleshoot gray agent states in System Center Operations Manager](troubleshoot-gray-agent-states.md).
