---
title: A log with a line exceeding 8000 characters is truncated in CMTrace log viewer
description: Fixes an issue in which a line of a log that exceeds 8000 characters causes the log to be truncated in the CMTrace log viewer.
ms.date: 12/05/2023
ms.reviewer: kaushika, erinwi, mansee, jarrettr, clintk
ms.custom: sap:Admin Console, Role-Based Access and Reporting\Console Extensions
---
# A log that has a line exceeding 8000 characters is truncated in the CMTrace log viewer

This article provides workarounds for the issue that a line of a log that exceeds 8000 characters causes the log to be truncated in the CMTrace log viewer.

_Original product version:_ &nbsp; Microsoft System Center 2012 Configuration Manager  
_Original KB number:_ &nbsp; 2716956

## Symptoms

In Microsoft System Center 2012 Configuration Manager, when you use the CMTrace log viewer to review any log that contains a line exceeding 8000 characters, the log is truncated at that line.

## Workaround

There are two workarounds to this issue. First, you can view the log file in Notepad. Viewing the log file in Notepad will allow you to see all of the content. Second, if you prefer to view the log in CMTrace you can edit the offending lines in Notepad (making them less than 8000 characters long) and then view the edited log in CMTrace.
