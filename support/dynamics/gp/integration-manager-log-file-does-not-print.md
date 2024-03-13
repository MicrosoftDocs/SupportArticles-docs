---
title: Integration Manager log file doesn't print
description: Provides a solution to an error that occurs when you print the Integration Manager log file.
ms.reviewer: dlanglie
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Integration Manager log file doesn't print and errors occur in Integration Manager for Microsoft Dynamics GP

This article provides a solution to an error that occurs when you print the Integration Manager log file.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2428506

## Symptoms

When you print the Integration Manager log file, you receive one or more of the following errors:

Error message 1

> Could not load file or assembly 'Microsoft.ReportViewer.WinForms, Version =9.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a' or one of its dependencies. The system cannot find the file specified.

Error message 2

> The Microsoft.ACE.OLEDB.12.0 provider is not registered on the local machine.

## Cause

A shared component is missing on the computer.

## Resolution

Install the Report Viewer Redistributable using [Microsoft Report Viewer Redistributable 2008](https://www.microsoft.com/download/search.aspx?q=reportviewer).
