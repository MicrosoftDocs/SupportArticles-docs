---
title: CoInitializeEx fails after calling HtmlHelp on the same thread
description: Provides a workaround for an issue where CoInitializeEx function fails after calling HtmlHelp function on the same thread beforehand.
ms.date: 04/17/2023
ms.reviewer: hihayak
author: hihayak
ms.author: v-sidong
ms.technology: 
ms.custom: sap:
---
# CoInitializeEx function fails after calling HtmlHelp function on the same thread

This article discusses an issue where [CoInitializeEx function](/windows/win32/api/combaseapi/nf-combaseapi-coinitializeex) fails after calling `HtmlHelp` function on the same thread beforehand.

_Applies to:_ &nbsp; All Supported OS

## Symptoms

If an application calls `HtmlHelp` function before calling `CoInitializeEx` function with the `COINIT_MULTITHREADED` value specified, the `CoInitializeEx` function can return `RPC_E_CHANGED_MODE (0x80010106)`. As a result, the application may crash, hang, or exhibit unexpected behaviors.

## Cause

If a thread that calls `HtmlHelp` has not been initialized with `CoInitialize` or `CoInitializeEx` functions, the `HtmlHelp` function initializes the thread as apartment-threaded with `COINIT_APARTMENTTHREADED`.

## Workaround

To work around the issue and avoid the conflict of COM initialization on a single thread, create a new thread and call `HtmlHelp` function on that thread.
