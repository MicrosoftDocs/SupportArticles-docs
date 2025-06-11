---
title: The UMDH Tool Generates Warnings
description: Works around an issue where umdh.exe in the Windows SDK for Windows 11, the Windows Driver Kit for Windows 11, and the standalone toolsets doesn't work fine.
ms.date: 06/11/2025
ms.reviewer: hirotoh, v-sidong
ms.custom: sap:System Services Development
---
# The UMDH tool generates warnings

This article describes a known issue with the [User-Mode Dump Heap (UMDH)](/windows-hardware/drivers/debugger/umdh) tool that is installed with the [Debugging Tools for Windows](/windows-hardware/drivers/debugger/debugger-download-tools). The issue affects the UMDH tool included in the Windows SDK for Windows 11, the Windows Driver Kit for Windows 11, and the standalone toolsets.

## Symptoms

When the [UMDH](/windows-hardware/drivers/debugger/umdh) tool (also known as **umdh.exe**) executes, it displays the following messages and fails to capture memory allocations:

```output
Warning:
Warning: UMDH didn't find any allocations that have stacks collected.
Warning: Traces could not be collected because the Stack Trace Database is full.
Warning: Increase the size of the Stack Trace Database using GFLAGS.
Warning:
```

## Cause

This is a bug in the UMDH tool included in the Windows SDK for Windows 11 and the Windows Driver Kit for Windows 11.

## Workaround

To work around the issue, install the [latest version of the Windows SDK for Windows 10](https://developer.microsoft.com/windows/downloads/sdk-archive/) or the [Windows Driver Kit for Windows 10](/windows-hardware/drivers/other-wdk-downloads) and use the UMDH tool in it.
