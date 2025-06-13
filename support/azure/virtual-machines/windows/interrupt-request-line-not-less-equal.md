---
title: Bug Check 0x0000001A - IRQL_NOT_LESS_OR_EQUAL
description: Provides solutions to an issue where an Azure virtual machine (VM) experiences the IRQL_NOT_LESS_OR_EQUAL bug check (0x0000001A).
ms.date: 06/13/2025
ms.reviewer: cwhitley, v-weizhu
ms.service: azure-virtual-machines
ms.collection: windows
ms.custom: sap:My VM is not booting
---

# VM startup is stuck on bug check 0x0000001A - IRQL_NOT_LESS_OR_EQUAL

**Applies to:** :heavy_check_mark: Windows VMs

This article helps you resolve an issue where a Microsoft Azure virtual machine (VM) experiences the **IRQL_NOT_LESS_OR_EQUAL** bug check with the stop code 0x0000001A.

## Symptoms

When you use [Boot diagnostics](./boot-diagnostics.md) to view the screenshot of a VM, the Windows operating system (OS) displays the **IRQL_NOT_LESS_OR_EQUAL** bug check (0x0000001A).

:::image type="content" source="/media/interrupt-request-line-not-less-equal/interrupt-request-line-not-less-equal-bugcheck-screen.png" alt-text="Screenshot of Windows operating system bug check IRQL_NOT_LESS_OR_EQUAL (0x0000001A).":::

## Cause

This bug check indicates that Windows or a kernel-mode driver tries to access paged memory at an invalid address while operating at a raised interrupt request level (IRQL).

This issue often occurs when the OS of a VM doesn't support more than 64 virtual CPUs (vCPUs), but the VM is configured with a higher vCPU count. For instance, Windows Server 2012 R2 supports a maximum of 64 vCPUs. If a VM running such an OS is provisioned with more than 64 vCPUs, the VM might fail to start and trigger the IRQL_NOT_LESS_OR_EQUAL bug check.

## Resolution

To resolve this issue, use one of the following methods:

- Reduce the number of vCPUs assigned to the VM to 64 or fewer.
- Rebuild the VM using an OS that supports more than 64 vCPUs, such as Windows Server 2016 or later.

If your VM is already running a supported OS version or is configured with 64 or fewer vCPUs, further investigation is required to determine the specific cause of this issue.

## Collect a memory dump for troubleshooting

To assist with further diagnosis, [collect an OS memory dump file](./collect-os-memory-dump-file.md) and then [create a support request](https://ms.portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/overview?DMC=troubleshoot) so that Azure support can investigate and help resolve the issue.


[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
