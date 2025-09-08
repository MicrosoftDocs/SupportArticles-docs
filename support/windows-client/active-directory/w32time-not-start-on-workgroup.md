---
title: W32Time doesn't start on a workgroup computer
description: Describes an issue in which the Windows Time service doesn't automatically start in a stand-alone environment for Windows 7, Windows Server 2008 R2, and later versions of Windows. Workarounds are provided.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom:
- sap:active directory\windows time service configuration,accuracy,and synchronization
- pcy:WinComm Directory Services
---
# Windows Time service doesn't start automatically on a workgroup computer

This article provides workarounds for an issue where the Windows Time service doesn't automatically start in a stand-alone environment.

_Applies to:_ &nbsp; Windows Server (All supported versions), Windows client (All supported versions)  
_Original KB number:_ &nbsp; 2385818

## Symptoms

On a workgroup computer that's running Windows client or Windows Server, or a later version, the Windows Time service stops immediately after system startup. This issue occurs even after the Startup Type is changed from **Manual** to **Automatic**.

## Cause

This issue occurs because the Windows Time service is configured as the Trigger-Start service, and it has been implemented as the default setting in Windows 7 and Windows Server 2008 R2.

Services and background processes have a significant effect on the performance of the system. The Trigger-Start service has been implemented in Windows 7 and Windows Service 2008 R2 to reduce the total number of auto-start services on the system. The goal is to improve the stability of the whole system, including improving performance and reducing power consumption. Under this implementation, the Service Control Manager has been enhanced to handle starting and stopping services by using specific system events.

For more information, see [Service trigger events](/windows/win32/services/service-trigger-events).

Whether the Windows Time service starts automatically depends on one of the following conditions:

- Whether the computer is joined to an Active Directory Domain Services (AD DS) domain environment.
- Whether the computer is configured as a workgroup computer.

The Windows Time service on domain-joined computers starts when a trigger event occurs. On workgroup computers that aren't joined to an AD DS domain:

- The startup value for the Windows Time service is **Manual**.
- The service status is **Stopped**.

You can check the Trigger-Start service settings by running the following command:

```console
sc qtriggerinfo w32time  

Service Name: w32time

    Start Service
        DOMAIN JOINED STATUS: 1ce20aba-9851-4421-9430-1ddeb766e809 [DOMAIN JOINED]

    Stop Service
        DOMAIN JOINED STATUS: ddaf516e-58c2-4866-9574-c3b615d42ea1 [NOT DOMAIN JOINED]
```

## Workaround

To start the Windows Time service at system startup, use any of the following methods.

- Method 1  

    Run the `sc triggerinfo w32time delete` command to delete the trigger event that's registered as the default setting and to change the **Startup Type** setting for the Windows Time service from **Manual** to **Automatic**:

- Method 2  

    Run the `sc triggerinfo w32time start/networkon stop/networkoff` command to define a trigger event that suits your environment. In this example, the command determines whether an IP address is given to a host. Then it starts or stops the service.

- Method 3  

    Change the Startup Type of the Windows Time service from **Manual** to **Automatic (Delayed Start)**.

    > [!NOTE]
    > If the Startup Type of the Windows Time service is set to **Automatic (Delayed Start)**, the Windows Time service may be started by the **Time Synchronization before the Service Control Manager starts the Windows Time service** task. It depends on the startup timing of the Windows operating system in question.

    In this situation, the service triggers an automatic stop after the success of the Time Synchronization task. If you use Method 3, you must disable the **Time Synchronization to avoid the task to start the Windows Time service** task. To do so, follow these steps:

    1. Start the Task Scheduler.
    2. Under **Task Scheduler Library** > **Microsoft** > **Windows** > **Time Synchronization**, select **Synchronize Time**.
    3. Right-click, and then select **Disabled** on the shortcut menu.

## More information

The Windows Time service on a workgroup computer isn't started automatically at system startup by the Trigger-Start service. However, the Windows Time service is started by the Time Synchronization setting. The setting is registered on the Task Scheduler Library at 01:00 a.m. every Sunday for Time Synchronization. So the default setting can be kept as is.
