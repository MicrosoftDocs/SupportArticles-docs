---
title: High CPU usage in Microsoft Entra Connect Health for Sync
description: Resolves an issue in which high CPU usage occurs in Microsoft Entra Connect Health for Sync.
ms.date: 05/11/2020
ms.reviewer: 
ms.service: active-directory
ms.subservice: enterprise-users
---
# High CPU usage in Microsoft Entra Connect Health for Sync

This article provides information about resolving an issue in which high CPU usage occurs in Microsoft Entra Connect Health for Sync.

_Original product version:_ &nbsp; Microsoft Entra ID  
_Original KB number:_ &nbsp; 4346822

## Symptoms

You experience slow performance and high CPU usage (up to 100 percent) on a computer that runs the Microsoft Entra Connect Health for Sync monitoring agent. In Task Manager, you notice that the **Microsoft.Online.Reporting.MonitoringAgent.Startup**  process is causing the high CPU usage.

> [!NOTE]
> This issue is not limited to any specific Microsoft Entra Connect Health versions or operating system versions.

## Cause

This issue occurs because the June 2018 update for .NET Framework 4.7.2 is installed on the computer, and the Microsoft Entra Connect Health for Sync monitoring agent does not fully support this update.

The following .NET Framework update would cause the high CPU issue by the monitoring agent.

| .NET Framework update| System version|
|---|---|
| KB4338420| Windows Server 2008 |
| KB4338606| Windows Server 2008 R2 |
| KB4054542| Windows Server 2012 |
| KB4054566| Windows Server 2012 R2 |
| KB4054590 KB4338814 KB4338419 KB4338605 KB4345418| General |
  
## Resolution

### For Connect Health for AD DS and AD FS

To resolve this issue for Active Directory Domain Services (AD DS) and Active Directory Federation Services (AD FS), install the new Microsoft Entra Connect Health agent version, 3.1.7.0, that was released in July 2018. The agent can be downloaded from [Connect Health public documentation](/azure/active-directory/connect-health/active-directory-aadconnect-health-agent-install#download-and-install-the-azure-ad-connect-health-agent).

<a name='for-azure-ad-connect'></a>

### For Microsoft Entra Connect

To resolve this issue for Microsoft Entra Connect, install the [latest version of Microsoft Entra Connect](https://go.microsoft.com/fwlink/?LinkId=615771).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
