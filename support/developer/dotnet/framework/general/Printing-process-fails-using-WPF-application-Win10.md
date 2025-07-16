---
title: Printing a Range of Pages Fails When You Use a WPF Application
description: This article discusses a problem in which the process of printing pages fails when you use a Windows Presentation Foundation (WPF) application.
ms.date: 07/08/2025
ms.reviewer: hiroakii
ms.custom: sap:Class Library Namespaces
ms.topic: troubleshooting-problem-resolution

#customer intent: As a user of a WPF application, I want to work around failures when I print a range of pages so that I can print documents that contain more than 1,000 pages.
---
# Printing a range of pages fails when you use a WPF application

This article discusses a problem in which you can't successfully print large documents when you use a Windows Presentation Foundation (WPF) application.

## Symptoms

Consider the following scenario:

1. You use a WPF application in Windows 10 to print a range of pages.
1. You run the `XpsDocument` object to process the print job by using `VisualsToXpsDocument`, `DocumentPaginator`, or another method.

In this scenario, the print process fails after you print some pages.

## Cause

When you print pages by using a WPF application in Windows 10, the font information is allocated on a page-by-page basis. If you're using this method to print a range of pages in a runtime, the process may increase memory usage by the operating system.

For example, if you're printing more than 8,000 pages, the process may stop because of a temporary increase in memory usage. This error indicates that an `IOException` occurred because of failed access to the font file.

After all the pages finish printing, memory can be freed for allocation.

## Solution

For documents that contain more than 1,000 pages, reduce the number of pages for a print process in a runtime.
