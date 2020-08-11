---
title: Error messages when you try to uninstall Microsoft Office 2013
description: Provides steps to restart the computer and uninstall Office 2013 or Office 365 suite if you see error messages such as "We're sorry, Office couldn't be uninstalled."
author: lucciz
ms.author: v-zolu
manager: dcscontentpm
audience: ITPro 
ms.topic: article 
ms.prod: office-perpetual-itpro
localization_priority: Normal
ms.reviewer: mmaxey
ms.custom: CSSTroubleshoot
search.appverid: 
- MET150
appliesto:
- office 2013
---

# Error messages when you try to uninstall Microsoft Office 2013

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Symptoms

You receive one of the following error messages when you try to uninstall Microsoft Office 2013 or Office 365 suite.

    Couldn't uninstall Office
    We're sorry, Office couldn't be uninstalled. Please try uninstalling Office again.

![could not uninstall office](./media/error-when-uninstall-office/could-not-uninstall-office.PNG)

    Office is busy.
    Office can't do that right now because your product is busy with another task. Please wait for this task to complete and try again.

![office is busy](./media/error-when-uninstall-office/office-is-busy.png)

##  Resolution

Restart Windows and try to uninstall Office again to fix the problem. 

If restarting Windows doesn't help, use the automated troubleshooter or follow the manual uninstall steps in this article: [Uninstall Microsoft Office 2013 or Office 365 suites](https://support.microsoft.com/help/2739501).

##  More Information

This error can occur when another program has control of certain files Microsoft Office needs to access and doesn't release them. When programs take control of files and keeps them open, the most effective way of releasing these files is to restart the computer. This shuts down all programs and closes all files. After a restart, Microsoft Office can then access these files and uninstall successfully.