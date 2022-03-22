---
title: Printing a range of pages may fail when you use a WPF application
description: This article discusses a problem where the process of printing pages fails when a Windows Presentation Foundation (WPF) application is in use.
ms.date: 03/22/2022
ms.reviewer: hiroakii
ms.technology: dotnet-general
---
# Printing a range of pages may fail when you use a WPF application

This article discusses a problem where the process of printing pages fails when a Windows Presentation Foundation (WPF) application is in use.

## Symptoms

Consider the following scenario:

1. You're using a Windows Presentation Foundation (WPF) application in Windows 10 to print a range of pages.
1. You're running the `XpsDocument` object to process the print by using `VisualsToXpsDocument`, `DocumentPaginator`, or other method.

In this scenario, the print process may fail after printing some pages.

## Cause

When you print pages by using a WPF application on Windows 10, the font information allocates on a page-by-page basis. If you're using this method to print a range of pages in a runtime, the process may increase memory usage of the operating system.

For example, if you're printing more than 8000 pages, the process may not continue due to a temporary increase in memory. This issue signals that IOException occurred due to a failed access to the font file.

When all of the pages finish printing, memory can be free for allocation.

## Workaround

If you want to print more than 1000 pages for a document, reduce the number of pages to print at a time.
