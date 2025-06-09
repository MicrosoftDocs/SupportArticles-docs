---
title: Bug check 0x0000001A - IRQL_NOT_LESS_OR_EQUAL
description: Provides troubleshooting steps for an Azure virtual machine (VM) that is experiencing the IRQL_NOT_LESS_OR_EQUAL bug check (0x0000001A).
ms.date: 06/07/2025
author: cwhitley-MSFT 
ms.author: cwhitley
ms.service: azure-virtual-machines
ms.collection: windows
ms.custom: sap:My VM is not booting
---

# Bug check 0x0000001A - IRQL_NOT_LESS_OR_EQUAL

**Applies to:** :heavy_check_mark: Windows VMs

This article discusses an issue that causes a Microsoft Azure virtual machine (VM) to experience the **IRQL_NOT_LESS_OR_EQUAL** bug check with stop code **0x0000001A**.

## Symptoms

When you use [Boot diagnostics](./boot-diagnostics.md) to view the screenshot of the VM, you see that the Windows operating system displays the **IRQL_NOT_LESS_OR_EQUAL** bug check (0x0000001A).

:::image type="content" source="media/irql-not-less-or-equal/irql-not-less-or-equal-bugcheck-screen.png" alt-text="Screenshot of Windows operating system bugcheck 0x0000001A IRQL_NOT_LESS_OR_EQUAL.":::

## Cause

This bug check indicates that Microsoft Windows or a kernel-mode driver attempted to access paged memory at an invalid address while operating at a raised interrupt request level (IRQL).

One common cause of this issue is running an operating system that does not support more than 64 virtual CPUs (vCPUs) on a VM configured with a higher vCPU count. For instance, Windows Server 2012 R2 supports a maximum of 64 vCPUs. If a VM is provisioned with more than 64 vCPUs on such an OS, it may fail to start and trigger the IRQL_NOT_LESS_OR_EQUAL bug check.

## Resolution

To resolve this issue:

- option 1: Reduce the number of vCPUs assigned to the VM to 64 or fewer.
- option 2: Rebuild the VM using an operating system that supports more than 64 vCPUs, such as Windows Server 2016 or later.

If your VM is already running a supported OS version, or you're using 64 or fewer vCPUs, further investigation is required to determine the specific cause of this issue.

## Collect memory dump for troubleshooting

To assist with further diagnosis, [collect an OS memory dump file](./collect-os-memory-dump-file.md) and then [create a support request](https://ms.portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/overview?DMC=troubleshoot) so that Azure support can investigate and help resolve the issue.


[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
