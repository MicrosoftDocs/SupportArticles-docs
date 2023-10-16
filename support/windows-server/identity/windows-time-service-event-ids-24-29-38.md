---
title: You receive Windows Time Service event IDs 24, 29, and 38 on a virtualized domain controller that is running on a Windows Server 2008-based host server with Hyper-V
description: Describes an issue in which you receive the Windows Time Service event IDs 24, 29, and 38 on a host server.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:virtualized-domain-controller-errors-and-questions, csstroubleshoot
ms.technology: windows-server-active-directory
---
# You receive Windows Time Service event IDs 24, 29, and 38 on a virtualized domain controller

This article provides a solution to an issue where you receive the Windows Time Service event IDs 24, 29, and 38 on a host server.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 976924

> [!NOTE]  
> If you are a Small Business customer, find additional troubleshooting and learning resources at the [Support for Small Business](https://smallbusiness.support.microsoft.com) site.

## Symptoms

When a virtualized domain controller is running in a guest operating system on a host server that is running Windows Server 2008 with Hyper-V, and the Windows Time Service (W32Time) synchronizes with a primary domain controller, Windows Time Service event IDs 24, 29, and 38 may be logged in the System log on the virtualized domain controller.

If you enable Windows Time Services Debug logging on the domain controller, information that resembles the following is logged in the Debug log:

> 149040 14:15:14.2970940s - Logging information: The time service is now synchronizing the system time with the time source VM IC Time Synchronization provider.

## Cause

On a host server that is running Windows Server 2008 with Hyper-V, virtualized domain controllers that are running on a guest operating system are allowed to synchronize their system clocks with the clock of the host operating system. The events that are listed in the [Symptoms](#symptoms) section are recorded in the System log because domain controllers have their own time synchronization mechanism. If domain controllers synchronize time from their own source and synchronize time from the host, the domain controller time can change frequently. Because many domain controller tasks are tied to the system time, a jump in the system time can cause lingering objects to be left in caches, and may cause replication to stop.  

## Resolution

To resolve this issue, disable time synchronization on the host by using Integration Services, and then configure the virtualized domain controller to accept the default Windows Time Service (W32time) domain hierarchy time synchronization.

To do this, follow these steps:

1. Open Hyper-V Manager.
2. Click **Settings**.
3. Click **Integration services**.
4. Clear the **Time Synchronization** option.
5. Exit Hyper-V Manager.
6. Restart the server.

## References

For more information about virtualized domain controllers, see Microsoft TechNet article [Deployment Considerations for Virtualized Domain Controllers](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd348449(v=ws.10)).
