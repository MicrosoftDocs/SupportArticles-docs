---
title: Printing a range of pages fails when you use a WPF application
description: This article discusses a problem where the process of printing pages fails when a Windows Presentation Foundation (WPF) application is in use.
ms.date: 03/22/2022
ms.reviewer: hiroakii
ms.technology: dotnet-general
---
# Printing a range of pages fails when you use a WPF application

This article discusses a problem in which the process of printing pages fails when you use a Windows Presentation Foundation (WPF) application.

## Symptoms

Consider the following scenario:

- You're using a WPF application in Windows 10 to print a range of pages.
- You're running the `XpsDocument` object to process the print job by using `VisualsToXpsDocument`, `DocumentPaginator`, or another method.

In this scenario, the print process fails after printing some pages.

## Cause

When you print pages by using a WPF application on Windows 10, the font information is allocated on a page-by-page basis. If you're using this method to print a range of pages in a runtime, the process may increase memory usage by the operating system.

For example, if you're printing more than 8,000 pages, the process may stop because of a temporary increase in memory usage. This error indicates that an IOException occurred because of failed access to the font file.

When all the pages finish printing, memory can be freed for allocation.

## Workaround

For a document that contains more than 1,000 pages, print the job in batches to reduce the number of pages that you print at one time.
