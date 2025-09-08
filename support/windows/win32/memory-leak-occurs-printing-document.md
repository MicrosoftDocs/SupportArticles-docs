---
title: Memory leak occurs when printing documents in Windows 10 and 11
description: Works around a memory leak issue that occurs when printing documents in Windows 10 and Windows 11.
ms.date: 06/11/2025
ms.reviewer: hirotoh, davean, v-sidong
ms.custom: sap:Graphics and Multimedia development\Printing and the Print Spooler API
---

# Memory leak occurs when printing documents in Windows 10 and Windows 11

_Applies to:_ &nbsp; Windows 10, Windows 11

## Symptoms

When an application uses the [OpenPrinter](/windows/win32/printdocs/openprinter), [StartDocPrinter](/windows/win32/printdocs/startdocprinter), [EndDocPrinter](/windows/win32/printdocs/enddocprinter), and [ClosePrinter](/windows/win32/printdocs/closeprinter) functions to print documents, a small memory leak might occur. In addition, you might see increased memory usage in applications that print many documents.

## Cause

`Print.PrintSupport.Source.dll` is a system printing component that might leak approximately 300 bytes for each printed document.

## Workaround

To mitigate this issue, use one of the following methods:

- As a customer or IT audience, you can periodically restart long-running processes that print many documents.

- As an application developer, you can design the application to print each document in a separate process.
