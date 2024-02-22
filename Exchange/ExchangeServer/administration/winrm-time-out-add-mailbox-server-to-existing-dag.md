---
title: WinRM times out and error occurs when you add a Mailbox server to an existing DAG
description: Main KB template.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: mhendric, charray, v-six
appliesto: 
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
search.appverid: MET150
ms.date: 01/24/2024
---
# Error when you add a Mailbox server to an existing DAG: The WinRM client cannot complete the operation within the time specified

_Original KB number:_ &nbsp;2294243

## Symptoms

When you try to add a new Microsoft Exchange Server 2010 Mailbox server to an existing Database Availability Group (DAG), the operation times out when it tries to install the Failover Clustering component. Additionally, you receive the following status message:

> The task is installing the Windows Failover Cluster component on the server \<SERVERNAME>.

When the time-out occurs, you receive the following error message:

```console
Processing data for a remote command failed with the following error message: The WinRM client cannot complete the operation within the time specified. Check if the machine name is valid and is reachable over the network and firewall exception for Windows Remote Management service is enabled. For more information, see the about_Remote_Troubleshooting Help topic.

+ CategoryInfo : OperationStopped: (System.Manageme...pressionSyncJob:PSInvokeExpressionSyncJob) [], PSRemotingTransportException

+ FullyQualifiedErrorId : JobFailure
```

However, the installation of the Failover Clustering component continues and succeeds after several minutes. If you run the `Add-DatabaseAvailabilityGroupServer` task again, the task completes successfully.

## Cause

When the `Add-DatabaseAvailabilityGroupServer` task runs, Exchange checks whether the target server already has the Failover Clustering component installed. If the Failover Clustering component isn't installed, Exchange starts the installation of this component. During this process, the Microsoft Failover Cluster Virtual Driver (netft.sys) is also installed.

If Symantec Endpoint Protection is running on this computer, a driver named Teefer2 Miniport (teefer2.sys) is also installed. The installation of this third-party driver causes the network connection to drop out for a few minutes. This outage causes the connection between PowerShell.exe and the PowerShell application pool in Internet Information Services to be dropped. When the PowerShell application pool completes the Failover Clustering installation, it can't notify PowerShell.exe that the installation is successful. Eventually, PowerShell.exe reaches the WinRM time-out value and fails.

## Resolution

To resolve this problem, use one of the following methods before you add the server to the DAG:

- Install the Failover Clustering component manually.
- Ask the third-party vendor to help remove and reinstall Symantec Endpoint Protection.

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-information-disclaimer.md)]
