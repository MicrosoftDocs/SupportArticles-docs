---
title: Can't Connect to Hyper-V Shared Storage on Windows Server 2016
description: Provides guidance for troubleshooting connection issues that involve shared storage in a Windows Server 2016 Hyper-V environment.
ms.date: 02/12/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, simonw, v-appelgate
ms.custom:
- sap:virtualization and hyper-v\storage configuration
- pcy:WinComm Storage High Avail
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# Can't connect to Hyper-V shared storage on Windows Server 2016

This article provides guidance for troubleshooting connection issues that involve shared storage in a Windows Server 2016 Hyper-V environment.

## Symptoms

You experience connection issues such as in the following scenarios:

- You can't use Hyper-V virtual machines (VMs) to access or connect to shared storage.
- VMs that rely on shared storage don't function correctly.

These scenarios are especially difficult to diagnose because they don't generate specific error codes.

## Cause

Such connection issues most likely have one or more of the following causes:

- Shared storage settings aren't correctly configured within the Hyper-V environment.
- Virtualization-specific settings aren't correctly configured in Windows Server 2016.
- Network settings, such as storage paths, aren't correctly configured.
- Network connectivity is interrupted.

## Resolution

> [!IMPORTANT]  
> Before you start troubleshooting, make sure that the following conditions are true:
>
> - You have Administrator-level permissions for the Windows Server 2016 computer.
> - The Hyper-V role is correctly configured on the computer.
> - The computer meets all relevant hardware and software requirements for shared storage. For more information, see [Windows Server storage architectures with Hyper-V](/windows-server/virtualization/hyper-v/storage-architecture).
> - You're familiar with the procedure to configure Hyper-V and shared storage environments.

To resolve the connection issue, follow these steps:

1. Check your shared storage configuration. Make sure that the shared storage is correctly configured and accessible within your Windows Server 2016 environment.
1. In Hyper-V, check the storage path settings.
1. Check the network interfaces and switches between the computer and the shared storage devices. Make sure that they're correctly configured.
1. Make sure that the computer successfully connects to the shared storage devices.
1. In Hyper-V Manager, check the configuration of the VMs. Verify that the VMs correctly map to the shared storage.
1. Make sure that the shared storage is online, and that the computer can access it.

If the issue persists, collect the following information, and then contact Microsoft Support:

- Notes that describe any adjustments that you made to the configuration and any observed changes in behavior.
- Any events from the event log that might relate to the issue.
- The results of any other diagnostic tests that you used on the system.
