---
title: The UMDH Tool Generates Warnings
description: Provides a workaround for an issue where umdh.exe in Windows 11 SDK doesn't work fine.
ms.date: 02/19/2025
ms.reviewer: hirotoh, v-sidong
ms.custom: sap:Component Development\COM, DCOM, and COM+ Programming and Runtime
---
# The UMDH tool generates warnings

This article describes a known issue with the [User-Mode Dump Heap (UMDH)](/windows-hardware/drivers/debugger/umdh) tool that is installed with the [Debugging Tools for Windows](/windows-hardware/drivers/debugger/extra-tools). The issue applies to the tool included in the Windows SDK for Windows 11, Windows Driver Kit for Windows 11, and standalone toolset.

## Symptoms

When the [UMDH](/windows-hardware/drivers/debugger/umdh) (also known as **umdh.exe**) tool executes, it displays the following messages and fails to capture the memory allocations.

```output
Warning:
Warning: UMDH didn't find any allocations that have stacks collected.
Warning: Traces could not be collected because the Stack Trace Database is full.
Warning: Increase the size of the Stack Trace Database using GFLAGS.
Warning:
```

## Cause

This is a bug in the UMDH tool included in the Windows SDK for Windows 11 and Windows Driver Kit for Windows 11.

## Workaround

To work around the issue, install the [latest version of Windows SDK for Windows 10](https://developer.microsoft.com/windows/downloads/sdk-archive/) or [Windows Driver Kit for Windows 10}(/windows-hardware/drivers/other-wdk-downloads) and use the UMDH in it.
