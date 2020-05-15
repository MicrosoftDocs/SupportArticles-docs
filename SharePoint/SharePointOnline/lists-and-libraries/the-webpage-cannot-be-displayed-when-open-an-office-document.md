﻿---
title: The webpage cannot be displayed when you try to open an Office document in the client application from inside SharePoint Online
description: Describes an issue in which you receive The webpage cannot be displayed error message when you try to open an Office document in the client application from inside SharePoint Online.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: sharepoint-online
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- SharePoint Online
---

# "The webpage cannot be displayed" error message when you try to open an Office document in the client application

## Problem

Consider the following scenarios.

### Scenario 1

- You have 2007 Microsoft Office installed on a computer.

- On the same computer, you also have a Microsoft Office 2013 application installed, such as Microsoft Lync 2013 or Microsoft Word 2013.

In this scenario, when you try to open a document from Microsoft SharePoint Online by using the 2007 Office client application, you receive the following error message:

**The webpage cannot be displayed.**

**Most likely cause: Some content or files on this webpage require a program that you don't have installed.**

### Scenario 2

- You have Microsoft Office 2010 installed on a computer.

- On the same computer, you also have an Office 2013 application installed, such as Lync 2013 or Word 2013.

In this scenario, when you try to open a document from SharePoint Online by using the Office 2010 client application, you receive the same error message that is mentioned in Scenario 1.

## Solution

### Scenario 1

To work around this issue, remove the Microsoft SharePoint Foundation Support program component from the Office 2013 installation on the affected computer or computers. To do this, follow the "Install or remove individual Office program components" section of [Install or remove individual Office programs and components](https://support.office.com/article/1b8f3c9b-bdd2-4a4f-8c88-aa756546529d).

After you complete these steps, repair 2007 Office. For more information about how to repair the installation, click the following article number to go to [How to install the individual 2007 Office features or to repair the installed 2007 Office programs](https://support.microsoft.com/help/924611).

> [!NOTE]
> When you follow these steps, set the **Microsoft SharePoint Foundation Support** component within Office Tools to **Not Available**. This solution doesn't apply to scenarios in which SharePoint Designer 2013 is installed on the affected computer.

### Scenario 2

To resolve this issue, install Service Pack 2 for Microsoft Office 2010 (KB2687455) on the affected computer. For more information about Service Pack 2 for Microsoft Office 2010 (KB2687455), go to [Service Pack 2 for Microsoft Office 2010 (KB2687455) 32-Bit Edition](https://www.microsoft.com/download/details.aspx?id=39667).

## More information

This issue occurs if you have either Office 2010 or 2007 Office installed on the same computer as Office 2013.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
