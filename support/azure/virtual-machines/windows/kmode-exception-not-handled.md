---
title: Bug Check 0x0000001E - KMODE_EXCEPTION_NOT_HANDLED
description: Describes an issue where an Azure virtual machine (VM) experiences the KMODE_EXCEPTION_NOT_HANDLED bug check (0x0000001E).
ms.date: 07/08/2025
ms.reviewer: cwhitley
ms.service: azure-virtual-machines
ms.collection: windows
ms.custom: sap:My VM is not booting
---

# Azure Windows VM displays bug check 0x0000001E - KMODE_EXCEPTION_NOT_HANDLED

**Applies to:** :heavy_check_mark: Windows VMs

This article helps you resolve an issue where a Microsoft Azure virtual machine (VM) experiences the **KMODE_EXCEPTION_NOT_HANDLED** bug check with the stop code 0x0000001E.

## Symptoms

When you use [Boot diagnostics](./boot-diagnostics.md) to view the screenshot of a VM, the Windows operating system (OS) displays the **KMODE_EXCEPTION_NOT_HANDLED** bug check (0x0000001E).

:::image type="content" source="media/kmode-exception-not-handled/kmode-exception-not-handled-screen.png" alt-text="Screenshot of Windows operating system bug check KMODE_EXCEPTION_NOT_HANDLED (0x0000001E).":::

## Cause

This indicates that a kernel-mode program generated an exception which the error handler did not catch. To interpret it, you must identify which exception was generated with a memory dump.

## Collect a memory dump for troubleshooting

If you experience this issue, [collect an OS memory dump file](./collect-os-memory-dump-file.md) and then [create a support request](https://ms.portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/overview?DMC=troubleshoot) for Azure support to troubleshoot and diagnose the issue.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
