---
title: Bug Check 0x0000001A - MEMORY_MANAGEMENT
description: Provides solutions to an issue where an Azure virtual machine (VM) experiences the MEMORY_MANAGEMENT bug check (0x0000001A).
ms.date: 06/30/2025
ms.reviewer: cwhitley
ms.service: azure-virtual-machines
ms.collection: windows
ms.custom: sap:My VM is not booting
---

# Azure Windows VM displays bug check 0x0000001A - MEMORY_MANAGEMENT

**Applies to:** :heavy_check_mark: Windows VMs

This article helps you resolve an issue where a Microsoft Azure virtual machine (VM) experiences the **MEMORY_MANAGEMENT** bug check with the stop code 0x0000001A.

## Symptoms

When you use [Boot diagnostics](./boot-diagnostics.md) to view the screenshot of a VM, the Windows operating system (OS) displays the **MEMORY_MANAGEMENT** bug check (0x0000001A).

:::image type="content" source="media/memory-management/memory-management-screen.png" alt-text="Screenshot of Windows operating system bug check MEMORY_MANAGEMENT (0x0000001A).":::

## Cause

The bug check indicates that a severe memory management error occurred.  A detailed dump analysis is necessary to determine the source or cause of the error.

## Collect a memory dump for troubleshooting

If you experience this issue, [collect an OS memory dump file](./collect-os-memory-dump-file.md) and then [create a support request](https://ms.portal.azure.com/#blade/Microsoft_Azure_Support/HelpAndSupportBlade/overview?DMC=troubleshoot) for Azure support to troubleshoot and diagnose the issue.
