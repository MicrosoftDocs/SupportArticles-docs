---
title: Virtual machines lose network connectivity
description: Addresses an issue that occurs with Broadcom NetXtreme network adapters when you use them on a Hyper-V server.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:tcp/ip-communications, csstroubleshoot
---
# Virtual machines lose network connectivity when you use Broadcom NetXtreme 1-gigabit network adapters

This article provides a solution to an issue where virtual machines lose network connectivity when you use Broadcom NetXtreme 1-gigabit network adapters.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2986895

## Symptoms

When you have Hyper-V running on Microsoft Windows Server 2012 or Windows Server 2012 R2 together with Broadcom NetXtreme 1-gigabit network adapters (but not NetXtreme II network adapters), you may notice one or more of the following symptoms:

- Virtual machines may randomly lose network connectivity. The network adapter seems to be working in the virtual machine. However, you can't ping or access network resources from the virtual machine. Restarting the virtual machine doesn't resolve the issue.

- You can't ping or connect to a virtual machine from a remote computer. These symptoms may occur on some or all virtual machines on the server that's running Hyper-V. Restarting the server immediately resolves network connectivity to all the virtual machines.

## Cause

It's a known issue with Broadcom NetXtreme 1-gigabit network adapters that use the b57nd60a.sys driver. This issue will occur when virtual machine queue (VMQ) is enabled on the network adapter. (By default, VMQ is enabled by the Broadcom network driver.)

Broadcom names these network adapters as 57xx based chipsets. They include 5714, 5715, 5717, 5718, 5719, 5720, 5721, 5722, 5723, and 5780.

These network adapters are also sold under different model numbers by some server OEMs. HP sells these drivers under model numbers NC1xx, NC3xx, and NC7xx. You may be using driver version 16.2, 16.4, or 16.6, depending on which OEM version you're using or whether you're using the Broadcom driver version.

## Resolution

This issue is resolved in Broadcom driver b57nd60a.sys version 16.8 and newer. In March 2015, Broadcom published driver version 17.0 for download. In April 2015, HP published version 16.8 of the driver for their affected network adapters. Contact your server OEM if you need a driver that's specific to your server.

If you can't update your network adapter driver to resolve the issue, you can work around the issue by disabling VMQ on each affected Broadcom network adapter by using the `Set-NetAdapterVmq` PowerShell command.

Consider the following scenario:

- You have a dual-port network adapter.
- The ports are named NIC 1 and NIC 2 in Windows.

In this scenario, you can disable VMQ on each adapter by using the following commands:

```powershell
Set-NetAdapterVmq -Name "NIC 1" -Enabled $False
Set-NetAdapterVmq -Name "NIC 2" -Enabled $False
```

You can confirm that VMQ is disabled on the correct network adapters by using the [Get-NetAdapterVmq](/powershell/module/netadapter/get-netadaptervmq?view=win10-ps&preserve-view=true) PowerShell command.

> [!NOTE]
> By default, VMQ is disabled on the Hyper-V virtual switch for virtual machines that are using 1-gigabit network adapters. VMQ is enabled on a Hyper-V virtual switch only when the system is using 10-gigabit or faster network adapters. This means that by disabling VMQ on the Broadcom network adapter, you aren't losing network performance or any other benefits because this is the default. However, you need to do this to work around the driver issue.

`Get-NetAdapterVmqQueue` shows the virtual machine queues (VMQs) that are allocated on network adapters. You won't see any VMQs that are allocated to 1-gigabit network adapters by default.
