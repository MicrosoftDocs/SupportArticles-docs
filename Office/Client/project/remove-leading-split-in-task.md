---
title: How to Remove a Leading Split in a Task
description: Provides the workaround to remove a leading split in a task in Microsoft Project.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: dday
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Microsoft Office Project Professional 2003
  - Microsoft Office Project Standard 2003
  - Project Professional 2010
  - Project Standard 2010
  - Project Professional 2013
  - Project 2013 Standard
ms.date: 05/26/2025
---

# How to Remove a Leading Split in a Task

## Symptoms

In Microsoft Project, you can split a task so that the task is interrupted, and then resumes later in the schedule. If you drag a portion of a split task so that it touches another portion, Microsoft Project removes the split. However, this method does not work if the split is assigned at the beginning of a task (a leading split).

## Workaround

To remove a split at the beginning of a task, use the method appropriate for your situation:

- If no resources are assigned to the task, change the duration to zero, and then change the duration back to the original value.

  -or-

- If a resource is assigned to the task, follow these steps:

1. On the View tab, click Task Usage.

   NOTE: In Microsoft Office Project 2007 and earlier versions, click Task Usage on the View menu.
2. Click to select the value 0 at the beginning of the task's work values under the timescale (the row labeled "Work" in the right pane), and press DELETE. Project removes the leading work value with 0 value.

   **NOTE** The "0" may appear differently depending on how the timescale is formatted, for example "0m," "0d," "0w," or "0y."

3. If more than one work item at the beginning of the task has 0 value, repeat step 2 until there are no more such Work items.

By removing the work items with 0 value at the beginning of the task, Project removes the leading split.
