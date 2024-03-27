---
title: Memory leak occurs when printing a document in Windows 10 and 11
description: Works around a memory leak issue that occurs when printing a document in Windows 10 and Windows 11.
ms.date: 03/27/2024
ms.reviewer: hirotoh, davean, v-sidong
ms.custom: sap:Component Development\COM, DCOM, and COM+ Programming and Runtime
---

# Memory leak occurs when printing a document in Windows 10 and Windows 11

## Symptoms

Applications that print documents using the [OpenPrinter](/windows/win32/printdocs/openprinter), [StartDocPrinter](/windows/win32/printdocs/startdocprinter), [EndDocPrinter](/windows/win32/printdocs/enddocprinter), and [ClosePrinter](/windows/win32/printdocs/closeprinter) functions might experience a small memory leak on Windows 10 and Windows 11. Applications that print many documents might cause increased memory usage.

## Cause

`Print.PrintSupport.Source.dll` is a system printing component that might leak approximately 300 bytes for each printed document.

## Workaround

To mitigate this issue, use one of the following methods:

- Periodically restart long-running processes that print many documents.

- Print each document in a separate process.
