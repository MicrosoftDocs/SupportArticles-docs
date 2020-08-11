---
title: Publisher cannot open the file
description: Provides a workaround for a Publisher cannot open the file error. This problem occurs when you try to open a Publisher file that contains corrupted OLE objects in Windows 7 or Windows 8.
author: lucciz
ms.author: v-zolu
manager: dcscontentpm
audience: ITPro 
ms.topic: article 
ms.prod: office-perpetual-itpro
localization_priority: Normal
ms.reviewer: lisyu
ms.custom: CSSTroubleshoot
search.appverid: 
- MET150
appliesto:
- Publisher 2013
- Publisher 2010
- Microsoft Office Publisher 2007
- Microsoft Office Publisher 2003
---

# "Publisher cannot open the file" error in Windows 7 or Windows 8

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

If you are a Small Business customer, find additional troubleshooting and learning resources at the [Support for Small Business](https://smallbusiness.support.microsoft.com) site.

This issue occurs in a Windows 7 or Windows 8 environment when a Microsoft Publisher file contains corrupted OLE objects. To work around this issue, open the file in another version of Windows, and then do one of the following:

- Delete the OLE objects, and then save the file as a Publisher file.   
- Save the file as a non-Publisher file. For example, save it as a .pdf file.   


##  More Information

Windows 7 and Windows 8 use a new validation process for OLE objects. This process triggers the "Publisher cannot open the file" error message when you try to open a file that contains corrupted OLE objects. 
### What is OLE?
OLE is a program-integration technology that you can use to share information between programs. OLE objects in Publisher can range from an Excel spreadsheet to a PowerPoint presentation to a bitmap image.

Find more tips, tricks, and learning opportunities at [https://smallbusiness.support.microsoft.com](https://smallbusiness.support.microsoft.com/).