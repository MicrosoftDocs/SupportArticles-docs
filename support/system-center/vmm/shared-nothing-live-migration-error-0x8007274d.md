---
title: A shared nothing live migration fails with error 0x8007274D
description: Fixes an issue where a live migration of a virtual machine fails with error 0x8007274D in System Center 2012 Virtual Machine Manager SP1.
ms.date: 08/18/2020
ms.reviewer: msadoff, dewitth
---
# A VM live migration fails with error 0x8007274D in System Center 2012 Virtual Machine Manager SP1

This article helps you fix an issue where a live migration of a virtual machine fails with error 0x8007274D in System Center 2012 Virtual Machine Manager (VMM) Service Pack 1 (SP1).

_Original product version:_ &nbsp; System Center 2012 Virtual Machine Manager Service Pack 1  
_Original KB number:_ &nbsp; 2853203

## Symptoms

Consider the following scenario:

- You are using Microsoft System Center 2012 Virtual Machine Manager SP1.
- Live migration settings are configured to use a specific network.
- VMM is not connected to the selected network. However, the networks are available to the Hyper-V computers.

In this scenario, an attempt to perform a shared nothing live migration of a virtual machine from one host to another will show a zero rating for the desired host and will display the following text in the **Rating Explanation** field:

> Migration check for virtual machine \<*serverName*> failed to create a planned virtual machine in the target host. Detailed error message: The Virtual Machine Management Service failed to establish a connection for a Virtual Machine migration with host *serverName.contoso.com*: No connection could be made because the target machine actively refused it. (Ox8007274D).

## Cause

The connection error occurs when the VMM service tries to stage a virtual machine on the target host. If the host is configured to use a specific subnet for live migration, and if the VMM service doesn't use that subnet during the virtual machine staging, the host refuses the `WSMan` invoke command. VMM interprets the failure to mean that the host will not accept an incoming migration.

The placement helper in VMM does this intentionally to increase the likelihood of success during live migration. If VMM cannot validate that a given host will accept an incoming live migration, it does let the user select the host in the wizard.

## Resolution

To resolve this issue, make sure that VMM has the host migration settings configured to **Use any available network**.

To configure this setting, follow these steps:

1. From the VMM console, open the properties dialog box for the desired host.
2. Select **Migration settings**, and then, under **Incoming live migration settings**, select **Use any available network**.
3. Repeat the process for any additional hosts.  

This issue was resolved in System Center 2012 R2 Virtual Machine Manager.

## More information

For more information about how to perform a live migration on non-cluster virtual machines (also known as a shared nothing live migration), see the following resources:

- [Virtual Machine Live Migration Overview](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831435(v=ws.11)?redirectedfrom=MSDN)
- [Use live migration without Failover Clustering to move a virtual machine](/windows-server/virtualization/hyper-v/manage/Use-live-migration-without-Failover-Clustering-to-move-a-virtual-machine)
