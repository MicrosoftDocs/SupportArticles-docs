---
title: Memory leak occurs when printing a document in Windows 10 and Windows 11
description: Works around an issue where memory leak occurs when printing a document in Windows 10 and Windows 11.
ms.date: 12/19/2023
ms.reviewer: hirotoh, davean
ms.custom: sap:Component Development\COM, DCOM, and COM+ Programming and Runtime
---
# Memory leak occurs when printing a document in Windows 10 and Windows 11

## Symptoms

Applications that print documents using the [OpenPrinter](/windows/win32/printdocs/openprinter), [StartDocPrinter](/windows/win32/printdocs/startdocprinter), [EndDocPrinter](/windows/win32/printdocs/enddocprinter), and [ClosePrinter](/windows/win32/printdocs/closeprinter) functions might experience a small memory leak on Windows 10 and Windows 11. Applications that print a large number of documents might see increased memory usage.

## Cause

`Print.PrintSupport.Source.dll` is a system printing component that might leak approximately 300 bytes for each document printed.

## Workaround

To mitigate this issue, use one of the following methods:

- Restart long running processes that print a large number of documents periodically.

- Print each document in a separate process.
