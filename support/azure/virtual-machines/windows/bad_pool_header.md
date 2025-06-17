---
title: Bug Check 0x00000019 - BAD_POOL_HEADER
description: Provides solutions to an issue where an Azure virtual machine (VM) experiences the BAD_POOL_HEADER bug check (0x00000019).
ms.date: 06/17/2025
ms.reviewer: cwhitley
ms.service: azure-virtual-machines
ms.collection: windows
ms.custom: sap:My VM is not booting
---

# Bug check 0x00000019 - BAD_POOL_HEADER

**Applies to:** :heavy_check_mark: Windows VMs

This article helps you resolve an issue where a Microsoft Azure virtual machine (VM) experiences the **BAD_POOL_HEADER** bug check with the stop code 0x00000019.

## Symptoms

When you use [Boot diagnostics](./boot-diagnostics.md) to view the screenshot of a VM, the Windows operating system (OS) displays the **BAD_POOL_HEADER** bug check (0x00000019).

:::image type="content" source="media/bad-pool-header/bad-pool-header-screen.png" alt-text="Screenshot of Windows operating system bug check BAD_POOL_HEADER (0x00000019).":::

## Cause

The pool is already corrupted at the time of the current request.

This may or may not be due to the caller.

A dump analysis is required to identify from where or what is causing the pool corruption.

## Collect a memory dump for troubleshooting

If you experience this error, [collect an OS memory dump file](./collect-os-memory-dump-file.md) and then [create a support request](https://ms.portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/overview?DMC=troubleshoot) for Azure support to troubleshoot and diagnose the issue.


[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
