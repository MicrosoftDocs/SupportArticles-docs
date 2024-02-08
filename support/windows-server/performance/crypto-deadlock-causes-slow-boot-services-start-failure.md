---
title: Slow boot and services start failure
description: provides a workaround for an issue that causes slow boot and services fail to start.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, tode
ms.custom: sap:boot-is-slow, csstroubleshoot
ms.subservice: performance
---
# Http <-> Crypto deadlock causes slow boot and service start failure on SSL-enabled

This article provides a workaround for an issue that causes slow boot and services fail to start.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2004121

## Symptoms

The following symptoms may occur:

- Windows Server hangs after boot at Applying Computer Settings or Applying Security Policy.
- Once the server finishes booting, a user attempting to log on may hang at Applying User Settings.
- You may notice that services that are set to a **Start Type** of "Automatic" may not start.  

Certain Services that are set to "Automatic" may start without problems - for example:

- Dcom Process Launcher
- Remote Procedure Call
- Event log
- Group Policy Client
- Plug and Play
- DHCP Client
- DNS Client
- Task Scheduler
- Base Filtering Engine
- Workstation Service
- Netlogon

Other services set to "Automatic" may fail - for example:

- Print Spooler
- Terminal Services
- Server service
- Remote Registry
- WMI
- Distributed Transaction Coordinator
- Any Services related to Applications

Trying to manually start services with a Startup type of "Automatic" may result in an Error 1053 indicating that "The service did not respond to the start or control request in a timely fashion."  

## Cause

The problems described in the symptoms section occur because of a lock on the Service Control Manager (SCM) database. As a result of the lock, none of the services can access the SCM database to initialize their service start requests. To verify that a Windows computer is affected by the problem discussed in this article, run the `sc querylock` command from the command Prompt.

The output below would indicate that the SCM database is locked:
> QueryServiceLockstatus - Success  
IsLocked: True  
LockOwner: .\NT Service Control Manager  
LockDuration: 1090 (seconds since acquired)  
There is no additional information in the Event Logs beyond those from the Service Control Manager indicating that Service startup requests have timed out. The underlying root cause is a deadlock between the Service Control Manager and HTTP.SYS.

## Resolution

To work around this issue, you can modify the behavior of HTTP.SYS to depend on another service being started first. To do this, perform the following steps:

1. Open **Registry Editor**.
2. Navigate to `HKLM\SYSTEM\CurrentControlSet\Services\HTTP` and create the following Multi-string value: DependOnService.
3. Double-click the new **DependOnService** entry.
4. Type **CRYPTSVC** in the Value Data field and click **OK**.  
5. Reboot the server.  

> [!NOTE]
> Ensure that you make a backup of the registry / affected keys before making any changes to your system.

## More information

Beginning with Windows Server 2008, Windows does not wait on all of the Automatic Services startup to load Explorer.exe.  Services may be set to Delayed Automatic Start to increase boot performance.
