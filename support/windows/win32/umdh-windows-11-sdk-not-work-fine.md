---
title: UMDH in Windows 11 SDK doesn't work fine
description: Provides a workaround for an issue where umdh.exe in Windows 11 SDK doesn't work fine.
ms.date: 02/18/2025
ms.reviewer: hirotoh, v-sidong
ms.custom: sap:Component Development\COM, DCOM, and COM+ Programming and Runtime
---
# UMDH in Windows 11 SDK doesn't work fine

## Symptoms

When you use the [User-Mode Dump Heap (UMDH)](/windows-hardware/drivers/debugger/umdh) tool (also known as **umdh.exe**) in the Windows 11 SDK, the following error message occurs:

```output
Warning:
Warning: UMDH didn't find any allocations that have stacks collected.
Warning: Traces could not be collected because the Stack Trace Database is full.
Warning: Increase the size of the Stack Trace Database using GFLAGS.
Warning:
```

## Cause

This behavior is a bug.

## Workaround

To work around the issue, use UMDH in the Windows 10 SDK.
