---
title: Importing a Task Outline Structure into Project
description: Introduces how to import a task outline structure into Project.
author: Cloud-Writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: Plammer
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Microsoft Office Project Professional 2003
  - Microsoft Office Project Standard 2003
  - Project Standard 2010
  - Project Professional 2010
  - Project Professional 2013
  - Project 2013 Standard
ms.date: 05/26/2025
---

# Importing a Task Outline Structure into Project

## Summary

When you import files from a different application to Microsoft Project, you can include information that will allow Microsoft Project to generate a project outline structure for the imported file.

## More Information

You cannot directly import the Outline Number field from a file saved in a format other than the standard Microsoft Project format. However, it is possible to import a different field that will correctly generate the same outline structure.

Microsoft Project uses a task field called "Outline Level", in conjunction with the order tasks are imported, to determine where tasks fall in a project outline structure. Tasks with Outline Level=1 are at the highest level in the project outline. Tasks with Outline Level=2 are subordinate to level 1 tasks, level 3 tasks are subordinate to level 2 tasks, and so on, for example:

A comma-separated values (CSV) file contains the following text:

 1, Summary Task 1

 2, Task A

 2, Task B

 2, Summary Task 2

 3, Task C

 3, Task D

 1, Summary Task 3

 2, Task E

 2, Task F

 If this file is imported into Microsoft Project using a task table with Outline Level and Name as its first two fields, the tasks will be imported with the following outline structure:

|Outline Level|Name|
|--|--|
|1| 1 Summary Task 1|
|2|1.1 Task A|
|2|1.2 Task B|
|2| 1.3 Summary Task 2|
|3| 1.3.1 Task C|
|3| 1.3.2 Task D|
|1| 2 Summary Task 3|
|2| 2.1 Task E|
|2| 2.2 Task F|

**NOTE** The Outline Number and name indentation are shown to clearly illustrate the structure.
