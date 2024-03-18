---
title: Error messages when you try to uninstall Microsoft Office 2013
description: Provides steps to restart the computer and uninstall Office 2013 or Microsoft 365 suite if you see error messages such as We're sorry, Office couldn't be uninstalled.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.reviewer: mmaxey
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - office 2013
ms.date: 03/31/2022
---

# Error messages when you try to uninstall Microsoft Office 2013

## Symptoms

You receive one of the following error messages when you try to uninstall Microsoft Office 2013 or Microsoft 365 suite.

> Couldn't uninstall Office  
> We're sorry, Office couldn't be uninstalled. Please try uninstalling Office again.

:::image type="content" source="media/error-when-uninstall-office/could-not-uninstall-office.png" alt-text="Screenshot of the error message, showing couldn't uninstall Office.":::

> Office is busy.  
> Office can't do that right now because your product is busy with another task. Please wait for this task to complete and try again.

:::image type="content" source="media/error-when-uninstall-office/office-is-busy.png" alt-text="Screenshot of the error message, showing Office is busy.":::

##  Resolution

Restart Windows and try to uninstall Office again to fix the problem. 

If restarting Windows doesn't help, use the automated troubleshooter or follow the manual uninstall steps in this article: [Uninstall Microsoft Office 2013 or Microsoft 365 suites](https://support.microsoft.com/help/2739501).

##  More Information

This error can occur when another program has control of certain files Microsoft Office needs to access and doesn't release them. When programs take control of files and keeps them open, the most effective way of releasing these files is to restart the computer. This shuts down all programs and closes all files. After a restart, Microsoft Office can then access these files and uninstall successfully.