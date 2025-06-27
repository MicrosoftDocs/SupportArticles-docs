---
title: Something went wrong 30016-4 error
description: Describes an issue that occurs when you try to remove Microsoft 365 Apps for enterprise from your computer. This triggers a 30016-4 error. A resolution is provided.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: jalalb
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Installation, Update, Deployment,  Activation
  - DownloadInstall\InstallErrors\ErrorCodes
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Microsoft 365 Apps for enterprise
ms.date: 06/06/2024
---

# "Something went wrong 30016-4" error when you try to uninstall Microsoft 365 Apps for enterprise

## Symptoms

When you try to uninstall Microsoft 365 Apps for enterprise from a computer, you receive the following error message:

> Something went wrong 30016-4

## Cause

This issue occurs if the %temp% drive is mapped to a drive other than %ProgramFiles%.

## Resolution

To fix this issue, completely remove Office from the computer. For the easiest way to do this, follow the guidance at [Uninstall Office from a PC](https://support.microsoft.com/office/uninstall-office-from-a-pc-9dd49b83-264a-477a-8fcc-2fdf5dbf61d8).
