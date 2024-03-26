---
title: Error 25090 when you start an Office program
description: Describes an error message that you may receive when you try to start an Office program.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Microsoft Office 2007
  - Microsoft Office 2003
ms.date: 03/31/2022
---

# "Error 25090" error message when you start an Office program

## Symptoms

When you try to start a Microsoft Office 2007 or Microsoft Office 2003 program, you may receive the following error message or an error message that is similar to the following:

```asciidoc
Error 25090. Office Setup encountered a problem with the Office Source Engine, system error: -2147023836. Please open SETUP.CHM and look for "Office Source Engine" for information on how to resolve this problem.
```

## Cause

This behavior occurs when the following conditions are true:

- Two people installed Office on the same computer.
- Both installations were completed by using the *AllUsers*="" parameter to set the installation for the installing user account only.
- When both people were prompted to remove files that were copied locally at the end of Setup, both people did not remove the files.
- One of the two people removed Office.

## Resolution

To resolve this behavior, start the Setup program for Office. To do this, follow these steps:

1. Insert the Microsoft Office 2003 CD in your CD drive or DVD drive.
2. If the Setup program does not start automatically, locate the Setup.exe file on the CD, and then double-click the file to start Setup.
3. After the Setup window appears, cancel Setup, and then respond to the prompts to exit Setup.

> [!NOTE]
> You do not have to complete the Setup program. Setup fixes the error condition when it is first invoked.