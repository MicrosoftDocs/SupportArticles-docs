---
title: Slow performance and high CPU usage in Microsoft Entra Connect Health for Sync monitoring agent on a system that has installed .NET Framework
description: Describes an issue that causes slow performance and high CPU usage in Microsoft Entra Connect Health for Sync monitoring agent on a system that has installed .NET Framework 4.7.2 or the July 2018 updates for .NET Framework 4.6, 4.6.1, 4.6.2, 4.7, 4.7.1, or 4.7.2. Provides a resolution.
ms.date: 05/28/2020
ms.reviewer: 
ms.service: active-directory
ms.subservice: enterprise-users
---
# Slow performance and high CPU usage in Microsoft Entra Connect Health for Sync monitoring agent on a system that has installed .NET Framework

This article describes an issue that causes slow performance and high CPU usage in Microsoft Entra Connect Health for Sync monitoring agent on a system that has installed .NET Framework 4.7.2 or the July 2018 updates for .NET Framework 4.6, 4.6.1, 4.6.2, 4.7, 4.7.1, or 4.7.2.

_Original product version:_ &nbsp; Microsoft Entra ID  
_Original KB number:_ &nbsp; 4457331

## Symptoms

Assume that you run the Microsoft Entra Connect Health for Sync monitoring agent on a system that has installed .NET Framework 4.7.2 or the July 2018 updates for .NET Framework 4.6, 4.6.1, 4.6.2, 4.7, 4.7.1, or 4.7.2. In this scenario, the system may experience slow performance and high CPU usage.

To see the high CPU usage, start Task Manager, and view the CPU usage of the **MIcrosoft.Online.Reporting.MonitoringAgent.Startup** process on the **Processes** tab.

## Cause

This issue occurs because the Microsoft Entra Connect Health for Sync monitoring agent does not fully support .NET Framework 4.7.2 or the July 2018 updates for .NET Framework 4.6, 4.6.1, 4.6.2, 4.7, 4.7.1, or 4.7.2.
 The following updates may cause high CPU usage of the monitoring agent.

| **.NET Framework** **update**| **Server version**| **Type of update** |
|---|---|---|
| [KB 4340007](https://support.microsoft.com/help/4340007)| Windows Server 2008| Security |
| [KB 4340556](https://support.microsoft.com/help/4340556)| Windows Server 2008 R2| Security |
| [KB 4340004](https://support.microsoft.com/help/4340004)| Windows Server 2008 R2| Security |
| [KB 4340557](https://support.microsoft.com/help/4340557)| Windows Server 2012| Security |
| [KB 4340005](https://support.microsoft.com/help/4340005)| Windows Server 2012| Security |
| [KB 4340558](https://support.microsoft.com/help/4340558)| Windows Server 2012 R2| Security |
| [KB 4340006](https://support.microsoft.com/help/4340006)| Windows Server 2012 R2| Security |
| [KB 4054542](https://support.microsoft.com/help/4054542)| Windows Server 2012| Nonsecurity |
| [KB 4054566](https://support.microsoft.com/help/4054566)| Windows Server 2012 R2| Nonsecurity |
| [KB 4054590](https://support.microsoft.com/help/4054590)| Windows Server 2016| Nonsecurity |
| [KB 4338814](https://support.microsoft.com/help/4338814)| Windows Server 2016 (build 14393.2363)| Nonsecurity |
| [KB 4345418](https://support.microsoft.com/help/4345418)| Windows Server 2016 (build 14393.2368)| Nonsecurity |
  
## Resolution

To resolve this issue, install the update that is appropriate for your environment.

- For Connect Health for AD DS and AD FS

    Install the Microsoft Entra Connect Health Agent, version 3.1.7.0 that was released in July 2018. This update is available for [download here]/azure/active-directory/hybrid/how-to-connect-health-agent-install#download-and-install-the-azure-ad-connect-health-agent).

- For Microsoft Entra Connect

    Install the latest version of Microsoft Entra Connect that contains the fix for this high CPU usage issue. This version is available for [download here](https://download.microsoft.com/download/B/0/0/B00291D0-5A83-4DE7-86F5-980BC00DE05A/AzureADConnect.msi).

    > [!NOTE]
    > If you have enabled the auto-upgrade feature on your Microsoft Entra Connect server, the latest version will be installed automatically.  

### Virus-scan claim

Microsoft scanned this file for viruses, using the most current virus-detection software that was available on the date that the file was posted. The file is stored on security-enhanced servers that help prevent any unauthorized changes to it.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
