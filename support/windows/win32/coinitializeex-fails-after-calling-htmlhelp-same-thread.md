---
title: CoInitializeEx fails after calling HtmlHelp on the same thread
description: Provides a workaround for an issue where the CoInitializeEx function fails after calling the HtmlHelp function on the same thread.
ms.date: 12/19/2023
ms.reviewer: v-sidong
author: hihayak
ms.author: hihayak
ms.custom: sap:Component Development\COM, DCOM, and COM+ Programming and Runtime
ms.subservice: component-dev
---
# CoInitializeEx function fails after calling the HtmlHelp function on the same thread

This article discusses an issue where the [CoInitializeEx function](/windows/win32/api/combaseapi/nf-combaseapi-coinitializeex) fails after calling the `HtmlHelp` function on the same thread.

_Applies to:_ &nbsp; All supported operating system

## Symptoms

If an application calls `HtmlHelp` before calling `CoInitializeEx` with the specified `COINIT_MULTITHREADED` value, `CoInitializeEx` can return `RPC_E_CHANGED_MODE (0x80010106)`. As a result, the application may crash, hang, or display unexpected behavior.

## Cause

If a thread that calls `HtmlHelp` hasn't been initialized with `CoInitialize` or `CoInitializeEx`, `HtmlHelp` initializes the thread as apartment-threaded with `COINIT_APARTMENTTHREADED`.

## Workaround

To work around the issue and avoid the conflict of COM initialization on a single thread, create a new thread and call `HtmlHelp` on that thread.
