---
title: Circular Relationship Error when indenting Task
description: Fixes an error that occurs when you indent tasks that are linked in a predecessor or successor relationship.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.reviewer: plammer
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
ms.date: 03/31/2022
---

# Circular Relationship error When indenting task

## Symptoms

In Microsoft Project, if two tasks are linked in a predecessor/successor relationship and you indent the successor to make it a subtask and the predecessor of a summary task, you may receive the following error message:

> This outline change would create a circular relationship.
>
> Indenting these tasks would create an illogical relationship with other tasks.
>
> Check the task dependencies for the tasks from which you are indenting, and then try again.

## Cause

This problem occurs when the predecessor task has a cross-project link as a predecessor and the task you are trying to subordinate is its successor. For example, let's say you have two tasks (A and B). They are linked by a Finish to Start relationship and Task A has a cross-project link to a task in another project. If you indent task B under Task A, you will receive this error message.

## Workaround

To work around this problem, remove the predecessor and successor link between the tasks and then indent the task.