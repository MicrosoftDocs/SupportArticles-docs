---
title: Excel 2013 crashes when you scroll down
description: Describes a problem in whcin Excel 2013 crashes when you scroll down by using the mouse wheel or the worksheet scrollbar. Provides a resolution.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
ms.reviewer: anitao, xlkbpre, v-matham
ms.custom: CSSTroubleshoot
search.appverid: 
- MET150
appliesto:
- Excel 2013
---

# Excel 2013 crashes when you scroll down by using the mouse wheel or the worksheet scrollbar

## Symptoms

When you scroll down in a workbook in Microsoft Excel 2013, Excel may crash. If you review the Application log, you see that the crash occurred in OSF.dll.

For example, this problem may occur if you scroll down by using the mouse wheel or the worksheet scrollbar. This problem occurs only after you log in to Microsoft Office 365 by using your Microsoft Account (previously known as Windows Live ID). 

## Cause

This problem occurs because of a conflict with Avast! Antivirus software.

> [!NOTE]
> This problem is known to occur when you have Avast! Antivirus installed on your computer. However, there may be additional causes. Microsoft is currently investigating these additional causes.

## Resolution

[Avast!](https://www.avast.com) has released an update to resolve this conflict. This update is version 2014.9.0.2008 and was released on November 11, 2013. If you use Avast! Antivirus, you must have this update or a later version installed. 

To resolve this issue, follow these steps:

1. Install the Avast! update, and then restart the computer.    
2. Start Excel 2013.   
3. On the **File** tab, click **Options**.   
4. Click **Trust Center**, and then click **Trust Center Settings**.   
5. Click **Trusted App Catalogs**, and then click **Clear**.   

> [!NOTE]
> If you experience these symptoms but do not have Avast! Antivirus installed, follow steps 2 though 5 to resolve the problem.

## References

Third-party information disclaimerThe third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.
